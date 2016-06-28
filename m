From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 27 Jun 2016 21:51:37 -0700
Subject: [PATCH 15/21] usb: chipidea: msm: Mux over secondary phy at the
 right time
In-Reply-To: <20160626072838.28082-16-stephen.boyd@linaro.org>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-16-stephen.boyd@linaro.org>
Message-ID: <20160628045137.GB1190@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun 26 Jun 00:28 PDT 2016, Stephen Boyd wrote:

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
>  drivers/usb/chipidea/ci_hdrc_msm.c | 78 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 73 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
[..]
>  
> +static int ci_hdrc_msm_mux_phy(struct ci_hdrc_msm *ci,
> +			       struct platform_device *pdev)
> +{
> +	struct regmap *regmap;
> +	struct device_node *syscon;
> +	struct device *dev = &pdev->dev;
> +	u32 off, val;
> +	int ret;
> +
> +	syscon = of_parse_phandle(dev->of_node, "phy-select", 0);
> +	if (!syscon)
> +		return 0;
> +
> +	regmap = syscon_node_to_regmap(syscon);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	ret = of_property_read_u32_index(dev->of_node, "phy-select", 1, &off);
> +	if (ret < 0) {
> +		dev_err(dev, "no offset in syscon\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = of_property_read_u32_index(dev->of_node, "phy-select", 2, &val);
> +	if (ret < 0) {
> +		dev_err(dev, "no value in syscon\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_write(regmap, off, val);

I recently found out (thanks to a comment from Srinivas) that you can
drop the last two error checks by using
of_parse_phandle_with_fixed_args() as in:

  struct of_phandle_args args;

  ret = of_parse_phandle_with_fixed_args(dev->of_node, "phy-select", 2, 0, &args);
  if (ret < 0)
	...

  regmap = syscon_node_to_regmap(args.np);
  of_node_put(args.np);
  if (IS_ERR(regmap))
	...

  ret = regmap_write(regmap, args.args[0], args.args[1]);

> +	if (ret)
> +		return ret;
> +
> +	ci->secondary_phy = !!val;
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
>  	struct platform_device *plat_ci;
>  	struct clk *clk;
>  	struct reset_control *reset;
> +	struct resource *res;
> +	void __iomem *base;

Doesn't look like you need "base".

> +	resource_size_t size;
>  	int ret;
>  
>  	dev_dbg(&pdev->dev, "ci_hdrc_msm_probe\n");
> @@ -76,6 +132,15 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
>  	if (IS_ERR(clk))
>  		return PTR_ERR(clk);
>  
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +
> +	size = resource_size(res);
> +	ci->base = base = devm_ioremap(&pdev->dev, res->start, size);
> +	if (!base)
> +		return -ENOMEM;

Replace these two snippets with:

  res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
  ci->base = devm_ioremap_resource(&pdev->dev, res);
  if (IS_ERR(ci->base))
	return PTR_ERR(ci->base);

> +
>  	reset_control_assert(reset);
>  	usleep_range(10000, 12000);
>  	reset_control_deassert(reset);

Regards,
Bjorn
