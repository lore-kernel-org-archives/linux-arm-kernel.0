From: david@lechnology.com (David Lechner)
Date: Sun, 31 Dec 2017 18:23:54 -0600
Subject: [PATCH v4 5/7] clk: Introduce davinci clocks
In-Reply-To: <1514763588-31560-6-git-send-email-david@lechnology.com>
References: <1514763588-31560-1-git-send-email-david@lechnology.com>
 <1514763588-31560-6-git-send-email-david@lechnology.com>
Message-ID: <1a85abb2-e4c3-a80a-915d-09269617e90e@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/31/2017 05:39 PM, David Lechner wrote:
> This introduces new drivers for arch/arm/mach-davinci. The code is based
> on the clock drivers from there and adapted to use the common clock
> framework.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---

...

> diff --git a/drivers/clk/davinci/da8xx-cfgchip-clk.c b/drivers/clk/davinci/da8xx-cfgchip-clk.c
> new file mode 100644
> index 0000000..780bb25
> --- /dev/null
> +++ b/drivers/clk/davinci/da8xx-cfgchip-clk.c
> @@ -0,0 +1,380 @@

...

> +static int da8xx_cfgchip_clk_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct da8xx_cfgchip_clk_data *pdata = dev->platform_data;
> +	struct da8xx_cfgchip_clk *phy_clk;
> +	const char *parent_name;
> +	struct clk *parent;
> +	int ret;
> +
> +	if (!pdata)
> +		return -EINVAL;
> +
> +	phy_clk = devm_kzalloc(dev, sizeof(*phy_clk), GFP_KERNEL);
> +	if (!phy_clk)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, phy_clk);
> +
> +	phy_clk->regmap = syscon_regmap_lookup_by_pdevname("syscon");

There is a mistake here. Device tree boards will fail to find "syscon".

It should be:

	/* try device tree, then fall back to platform device */
	phy_clk->regmap = syscon_regmap_lookup_by_compatible("ti,da830-cfgchip");
	if (IS_ERR(phy_clk->regmap))
		phy_clk->regmap = syscon_regmap_lookup_by_pdevname("syscon");


> +	if (IS_ERR(phy_clk->regmap)) {
> +		dev_err(dev, "Failed to get syscon\n");
> +		return PTR_ERR(phy_clk->regmap);
> +	}
