From: hzpeterchen@gmail.com (Peter Chen)
Date: Wed, 29 Jun 2016 16:26:48 +0800
Subject: [PATCH 16/21] usb: chipidea: msm: Restore wrapper settings after
 reset
In-Reply-To: <20160626072838.28082-17-stephen.boyd@linaro.org>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-17-stephen.boyd@linaro.org>
Message-ID: <20160629082648.GK25236@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 26, 2016 at 12:28:33AM -0700, Stephen Boyd wrote:
> When the RESET bit is set in the USBCMD register it resets quite
> a few of the wrapper's registers to their reset state. This
> includes the GENCONFIG and GENCONFIG2 registers. Currently this
> is done by the usb phy and ehci-msm drivers writing into the
> controller wrapper's MMIO address space. Let's consolidate the
> register writes into the wrapper driver instead so that we
> clearly split the wrapper from the phys.
> 
> Cc: Peter Chen <peter.chen@nxp.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  drivers/usb/chipidea/ci_hdrc_msm.c | 46 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
> index df0f8b31db4f..cc6f9b0df9d5 100644
> --- a/drivers/usb/chipidea/ci_hdrc_msm.c
> +++ b/drivers/usb/chipidea/ci_hdrc_msm.c
> @@ -14,6 +14,8 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
>  #include <linux/io.h>
> +#include <linux/extcon.h>
> +#include <linux/of.h>
>  
>  #include "ci.h"
>  
> @@ -21,11 +23,22 @@
>  #define HS_PHY_SEC_CTRL			0x0278
>  # define HS_PHY_DIG_CLAMP_N		BIT(16)
>  
> +#define HS_PHY_GENCONFIG		0x009c
> +# define HS_PHY_TXFIFO_IDLE_FORCE_DIS	BIT(4)
> +
> +#define HS_PHY_GENCONFIG_2		0x00a0
> +# define HS_PHY_SESS_VLD_CTRL_EN	BIT(7)
> +# define HS_PHY_ULPI_TX_PKT_EN_CLR_FIX	BIT(19)
> +
> +#define HSPHY_SESS_VLD_CTRL		BIT(25)
> +

Keep alignment please.

>  struct ci_hdrc_msm {
>  	struct platform_device *ci;
>  	struct clk *core_clk;
>  	struct clk *iface_clk;
> +	struct extcon_dev *vbus_edev;
>  	bool secondary_phy;
> +	bool hsic;
>  	void __iomem *base;
>  };
>  
> @@ -39,9 +52,26 @@ static void ci_hdrc_msm_notify_event(struct ci_hdrc *ci, unsigned event)
>  		dev_dbg(dev, "CI_HDRC_CONTROLLER_RESET_EVENT received\n");
>  		/* use AHB transactor, allow posted data writes */
>  		hw_write_id_reg(ci, HS_PHY_AHB_MODE, 0xffffffff, 0x8);
> +		/* workaround for rx buffer collision issue */
> +		hw_write_id_reg(ci, HS_PHY_GENCONFIG,
> +				HS_PHY_TXFIFO_IDLE_FORCE_DIS, 0);
> +
>  		if (msm_ci->secondary_phy)
>  			hw_write_id_reg(ci, HS_PHY_SEC_CTRL, HS_PHY_DIG_CLAMP_N,
>  					HS_PHY_DIG_CLAMP_N);
> +
> +		if (!msm_ci->hsic)
> +			hw_write_id_reg(ci, HS_PHY_GENCONFIG_2,
> +					HS_PHY_ULPI_TX_PKT_EN_CLR_FIX, 0);
> +
> +		if (msm_ci->vbus_edev) {
> +			hw_write_id_reg(ci, HS_PHY_GENCONFIG_2,
> +					HS_PHY_SESS_VLD_CTRL_EN,
> +					HS_PHY_SESS_VLD_CTRL_EN);
> +			hw_write(ci, OP_USBCMD, HSPHY_SESS_VLD_CTRL,
> +				 HSPHY_SESS_VLD_CTRL);
> +
> +		}
>  		break;
>  	default:
>  		dev_dbg(dev, "unknown ci_hdrc event\n");
> @@ -112,6 +142,7 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
>  	void __iomem *base;
>  	resource_size_t size;
>  	int ret;
> +	struct device_node *ulpi_node, *phy_node;
>  
>  	dev_dbg(&pdev->dev, "ci_hdrc_msm_probe\n");
>  
> @@ -141,6 +172,13 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
>  	if (!base)
>  		return -ENOMEM;
>  
> +	ci->vbus_edev = extcon_get_edev_by_phandle(&pdev->dev, 0);
> +	if (IS_ERR(ci->vbus_edev)) {
> +		if (PTR_ERR(ci->vbus_edev) != -ENODEV)
> +			return PTR_ERR(ci->vbus_edev);
> +		ci->vbus_edev = NULL;
> +	}
> +

Why not using ci->platdata->vbus_extcon directly?

>  	reset_control_assert(reset);
>  	usleep_range(10000, 12000);
>  	reset_control_deassert(reset);
> @@ -157,6 +195,14 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_mux;
>  
> +	ulpi_node = of_find_node_by_name(pdev->dev.of_node, "ulpi");
> +	if (ulpi_node) {
> +		phy_node = of_get_next_available_child(ulpi_node, NULL);
> +		ci->hsic = of_device_is_compatible(phy_node, "qcom,usb-hsic-phy");
> +		of_node_put(phy_node);
> +	}
> +	of_node_put(ulpi_node);
> +

Just confirm with you that ci->platdata->phy_mode is not enough?

>  	plat_ci = ci_hdrc_add_device(&pdev->dev, pdev->resource,
>  				     pdev->num_resources, &ci_hdrc_msm_platdata);
>  	if (IS_ERR(plat_ci)) {
> -- 
> 2.9.0.rc2.8.ga28705d
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 

Best Regards,
Peter Chen
