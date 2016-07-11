From: hzpeterchen@gmail.com (Peter Chen)
Date: Mon, 11 Jul 2016 13:32:28 +0800
Subject: [PATCH v2 18/22] usb: chipidea: msm: Add reset controller for
 PHY POR bit
In-Reply-To: <20160707222114.1673-19-stephen.boyd@linaro.org>
References: <20160707222114.1673-1-stephen.boyd@linaro.org>
 <20160707222114.1673-19-stephen.boyd@linaro.org>
Message-ID: <20160711053228.GB31647@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2016 at 03:21:09PM -0700, Stephen Boyd wrote:
> The MSM chipidea wrapper has two bits that are used to reset the
> first or second phy. Add support for these bits via the reset
> controller framework, so that phy drivers can reset their
> hardware at the right time during initialization.
> 
> Cc: Peter Chen <peter.chen@nxp.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  drivers/usb/chipidea/Kconfig       |  1 +
>  drivers/usb/chipidea/ci_hdrc_msm.c | 45 ++++++++++++++++++++++++++++++++++++--
>  2 files changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/Kconfig b/drivers/usb/chipidea/Kconfig
> index 4f8c342a8865..488ecdf56bdd 100644
> --- a/drivers/usb/chipidea/Kconfig
> +++ b/drivers/usb/chipidea/Kconfig
> @@ -2,6 +2,7 @@ config USB_CHIPIDEA
>  	tristate "ChipIdea Highspeed Dual Role Controller"
>  	depends on ((USB_EHCI_HCD && USB_GADGET) || (USB_EHCI_HCD && !USB_GADGET) || (!USB_EHCI_HCD && USB_GADGET)) && HAS_DMA
>  	select EXTCON
> +	select RESET_CONTROLLER
>  	help
>  	  Say Y here if your system has a dual role high speed USB
>  	  controller based on ChipIdea silicon IP. Currently, only the
> diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
> index da2d399acdd2..ab6a7713ee5c 100644
> --- a/drivers/usb/chipidea/ci_hdrc_msm.c
> +++ b/drivers/usb/chipidea/ci_hdrc_msm.c
> @@ -14,6 +14,7 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
>  #include <linux/io.h>
> +#include <linux/reset-controller.h>
>  #include <linux/extcon.h>
>  #include <linux/of.h>
>  
> @@ -31,8 +32,10 @@
>  #define HSPHY_SESS_VLD_CTRL		BIT(25)
>  
>  /* Vendor base starts at 0x200 beyond CI base */
> +#define HS_PHY_CTRL			0x0040
>  #define HS_PHY_SEC_CTRL			0x0078
>  #define HS_PHY_DIG_CLAMP_N		BIT(16)
> +#define HS_PHY_POR_ASSERT		BIT(0)
>  
>  struct ci_hdrc_msm {
>  	struct platform_device *ci;
> @@ -40,11 +43,38 @@ struct ci_hdrc_msm {
>  	struct clk *iface_clk;
>  	struct clk *fs_clk;
>  	struct ci_hdrc_platform_data pdata;
> +	struct reset_controller_dev rcdev;
>  	bool secondary_phy;
>  	bool hsic;
>  	void __iomem *base;
>  };
>  
> +static int
> +ci_hdrc_msm_por_reset(struct reset_controller_dev *r, unsigned long id)
> +{
> +	struct ci_hdrc_msm *ci_msm = container_of(r, struct ci_hdrc_msm, rcdev);
> +	void __iomem *addr = ci_msm->base;
> +	u32 val;
> +
> +	if (id)
> +		addr += HS_PHY_SEC_CTRL;
> +	else
> +		addr += HS_PHY_CTRL;
> +
> +	val = readl_relaxed(addr);
> +	val |= HS_PHY_POR_ASSERT;
> +	writel(val, addr);
> +	udelay(12);

Does this delay is reference manual defines or experienced value?
Do you need to comment it?

Peter
> +	val &= ~HS_PHY_POR_ASSERT;
> +	writel(val, addr);
> +
> +	return 0;
> +}
> +
> +static const struct reset_control_ops ci_hdrc_msm_reset_ops = {
> +	.reset = ci_hdrc_msm_por_reset,
> +};
> +
>  static void ci_hdrc_msm_notify_event(struct ci_hdrc *ci, unsigned event)
>  {
>  	struct device *dev = ci->dev->parent;
> @@ -186,10 +216,18 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
>  	if (!ci->base)
>  		return -ENOMEM;
>  
> -	ret = clk_prepare_enable(ci->fs_clk);
> +	ci->rcdev.owner = THIS_MODULE;
> +	ci->rcdev.ops = &ci_hdrc_msm_reset_ops;
> +	ci->rcdev.of_node = pdev->dev.of_node;
> +	ci->rcdev.nr_resets = 2;
> +	ret = reset_controller_register(&ci->rcdev);
>  	if (ret)
>  		return ret;
>  
> +	ret = clk_prepare_enable(ci->fs_clk);
> +	if (ret)
> +		goto err_fs;
> +
>  	reset_control_assert(reset);
>  	usleep_range(10000, 12000);
>  	reset_control_deassert(reset);
> @@ -198,7 +236,7 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
>  
>  	ret = clk_prepare_enable(ci->core_clk);
>  	if (ret)
> -		return ret;
> +		goto err_fs;
>  
>  	ret = clk_prepare_enable(ci->iface_clk);
>  	if (ret)
> @@ -236,6 +274,8 @@ err_mux:
>  	clk_disable_unprepare(ci->iface_clk);
>  err_iface:
>  	clk_disable_unprepare(ci->core_clk);
> +err_fs:
> +	reset_controller_unregister(&ci->rcdev);
>  	return ret;
>  }
>  
> @@ -247,6 +287,7 @@ static int ci_hdrc_msm_remove(struct platform_device *pdev)
>  	ci_hdrc_remove_device(ci->ci);
>  	clk_disable_unprepare(ci->iface_clk);
>  	clk_disable_unprepare(ci->core_clk);
> +	reset_controller_unregister(&ci->rcdev);
>  
>  	return 0;
>  }
> -- 
> 2.9.0.rc2.8.ga28705d
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 

Best Regards,
Peter Chen
