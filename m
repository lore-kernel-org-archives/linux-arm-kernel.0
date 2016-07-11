From: hzpeterchen@gmail.com (Peter Chen)
Date: Mon, 11 Jul 2016 12:43:27 +0800
Subject: [PATCH v2 15/22] usb: chipidea: msm: Mux over secondary phy at
 the right time
In-Reply-To: <20160707222114.1673-16-stephen.boyd@linaro.org>
References: <20160707222114.1673-1-stephen.boyd@linaro.org>
 <20160707222114.1673-16-stephen.boyd@linaro.org>
Message-ID: <20160711044327.GG30448@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2016 at 03:21:06PM -0700, Stephen Boyd wrote:
> We need to pick the correct phy at runtime based on how the SoC
> has been wired onto the board. If the secondary phy is used, take
> it out of reset and mux over to it by writing into the TCSR
> register. Make sure to do this on reset too, because this
> register is reset to the default value (primary phy) after the
> RESET bit is set in USBCMD.
> 
> Cc: Peter Chen <peter.chen@nxp.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  drivers/usb/chipidea/ci_hdrc_msm.c | 67 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 62 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
> index 7e870a253f55..7708bee3ff3e 100644
> --- a/drivers/usb/chipidea/ci_hdrc_msm.c
> +++ b/drivers/usb/chipidea/ci_hdrc_msm.c
> @@ -8,29 +8,44 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> -#include <linux/usb/gadget.h>
>  #include <linux/usb/chipidea.h>
>  #include <linux/clk.h>
>  #include <linux/reset.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +#include <linux/io.h>
>  
>  #include "ci.h"
>  
>  #define HS_PHY_AHB_MODE			0x0098
>  
> +/* Vendor base starts at 0x200 beyond CI base */
> +#define HS_PHY_SEC_CTRL			0x0078
> +#define HS_PHY_DIG_CLAMP_N		BIT(16)
> +

Keep alignment

>  struct ci_hdrc_msm {
>  	struct platform_device *ci;
>  	struct clk *core_clk;
>  	struct clk *iface_clk;
>  	struct clk *fs_clk;
> +	bool secondary_phy;
> +	void __iomem *base;
>  };
>  
>  static void ci_hdrc_msm_notify_event(struct ci_hdrc *ci, unsigned event)
>  {
> -	struct device *dev = ci->gadget.dev.parent;
> +	struct device *dev = ci->dev->parent;
> +	struct ci_hdrc_msm *msm_ci = dev_get_drvdata(dev);
>  
>  	switch (event) {
>  	case CI_HDRC_CONTROLLER_RESET_EVENT:
>  		dev_dbg(dev, "CI_HDRC_CONTROLLER_RESET_EVENT received\n");
> +		if (msm_ci->secondary_phy) {
> +			u32 val = readl_relaxed(msm_ci->base + HS_PHY_SEC_CTRL);
> +			val |= HS_PHY_DIG_CLAMP_N;
> +			writel_relaxed(val, msm_ci->base + HS_PHY_SEC_CTRL);
> +		}
> +
>  		/* use AHB transactor, allow posted data writes */
>  		hw_write_id_reg(ci, HS_PHY_AHB_MODE, 0xffffffff, 0x8);
>  		usb_phy_init(ci->usb_phy);
> @@ -59,6 +74,39 @@ static struct ci_hdrc_platform_data ci_hdrc_msm_platdata = {
>  	.notify_event		= ci_hdrc_msm_notify_event,
>  };
>  
> +static int ci_hdrc_msm_mux_phy(struct ci_hdrc_msm *ci,
> +			       struct platform_device *pdev)
> +{
> +	struct regmap *regmap;
> +	struct device *dev = &pdev->dev;
> +	struct of_phandle_args args;
> +	u32 val;
> +	int ret;
> +
> +	ret = of_parse_phandle_with_fixed_args(dev->of_node, "phy-select", 2, 0,
> +					       &args);
> +	if (ret)
> +		return 0;
> +
> +	regmap = syscon_node_to_regmap(args.np);
> +	of_node_put(args.np);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	ret = regmap_write(regmap, args.args[0], args.args[1]);
> +	if (ret)
> +		return ret;
> +
> +	ci->secondary_phy = !!args.args[1];
> +	if (ci->secondary_phy) {
> +		val = readl_relaxed(ci->base + HS_PHY_SEC_CTRL);
> +		val |= HS_PHY_DIG_CLAMP_N;
> +		writel_relaxed(val, ci->base + HS_PHY_SEC_CTRL);
> +	}
> +
> +	return 0;
> +}
> +
>  static int ci_hdrc_msm_probe(struct platform_device *pdev)
>  {
>  	struct ci_hdrc_msm *ci;
> @@ -66,6 +114,7 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
>  	struct usb_phy *phy;
>  	struct clk *clk;
>  	struct reset_control *reset;
> +	struct resource *res;
>  	int ret;
>  
>  	dev_dbg(&pdev->dev, "ci_hdrc_msm_probe\n");
> @@ -105,6 +154,11 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
>  		ci->fs_clk = NULL;
>  	}
>  
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	ci->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (!ci->base)
> +		return -ENOMEM;
> +
>  	ret = clk_prepare_enable(ci->fs_clk);
>  	if (ret)
>  		return ret;
> @@ -123,9 +177,12 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_iface;
>  
> -	plat_ci = ci_hdrc_add_device(&pdev->dev,
> -				pdev->resource, pdev->num_resources,
> -				&ci_hdrc_msm_platdata);
> +	ret = ci_hdrc_msm_mux_phy(ci, pdev);
> +	if (ret)
> +		goto err_mux;
> +
> +	plat_ci = ci_hdrc_add_device(&pdev->dev, pdev->resource,
> +				     pdev->num_resources, &ci_hdrc_msm_platdata);

The above line has not changed.

After fixing above, you can add my ack.

Acked-by: Peter Chen <peter.chen@nxp.com>

-- 

Best Regards,
Peter Chen
