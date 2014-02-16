From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 16 Feb 2014 18:56:38 +0800
Subject: [PATCH v3] bus: imx-weim: support CS GPR config for imx6q-weim
In-Reply-To: <1392539924-23583-1-git-send-email-shawn.guo@linaro.org>
References: <1392539924-23583-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20140216105636.GE2946@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 16, 2014 at 04:38:44PM +0800, Shawn Guo wrote:
> @@ -56,6 +59,55 @@ static const struct of_device_id weim_id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(of, weim_id_table);
>  
> +static int __init imx6q_weim_gpr_setup(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct property *prop;
> +	const __be32 *p;
> +	struct regmap *gpr;
> +	u32 gprvals[4] = {
> +		05,	/* CS0(128M) CS1(0M)  CS2(0M)  CS3(0M) */
> +		033,	/* CS0(64M)  CS1(64M) CS2(0M)  CS3(0M) */
> +		0113,	/* CS0(64M)  CS1(32M) CS2(32M) CS3(0M) */
> +		01111,	/* CS0(64M)  CS1(32M) CS2(32M) CS3(0M) */
> +	};
> +	u32 gprval = 0;
> +	u32 val;
> +	int cs = 0;
> +	int i = 0;
> +
> +	gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");

When trying to improve the bindings doc imx-weim.txt, I checked hardware
manuals and found that SoCs imx50, imx53, imx6q, imx6dl and imx6sl all
need the same CS GPR setup.  It's inappropriate to look up by hard-coded
compatible "fsl,imx6q-iomuxc-gpr" then.  So I'm going to add the
property fsl,weim-cs-gpr back, and update bindings doc accordingly.

Shawn

> +	if (IS_ERR(gpr)) {
> +		dev_err(&pdev->dev, "failed to find fsl,imx6q-iomuxc-gpr\n");
> +		return -ENOENT;
> +	}
> +
> +	of_property_for_each_u32(np, "ranges", prop, p, val) {
> +		if (i % 4 == 0) {
> +			cs = val;
> +		} else if (i % 4 == 3 && val) {
> +			val = (val / SZ_32M) | 1;
> +			gprval |= val << cs * 3;
> +		}
> +		i++;
> +	}
> +
> +	if (i == 0 || i % 4)
> +		goto err;
> +
> +	for (i = 0; i < ARRAY_SIZE(gprvals); i++) {
> +		if (gprval == gprvals[i]) {
> +			/* Found it. Set up IOMUXC_GPR1[11:0] with it. */
> +			regmap_update_bits(gpr, IOMUXC_GPR1, 0xfff, gprval);
> +			return 0;
> +		}
> +	}
> +
> +err:
> +	dev_err(&pdev->dev, "Invalid 'ranges' configuration\n");
> +	return -EINVAL;
> +}
> +
>  /* Parse and set the timing for this device. */
>  static int __init weim_timing_setup(struct device_node *np, void __iomem *base,
>  				    const struct imx_weim_devtype *devtype)
> @@ -92,6 +144,9 @@ static int __init weim_parse_dt(struct platform_device *pdev,
>  	struct device_node *child;
>  	int ret;
>  
> +	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx6q-weim"))
> +		imx6q_weim_gpr_setup(pdev);
> +
>  	for_each_child_of_node(pdev->dev.of_node, child) {
>  		if (!child->name)
>  			continue;
> -- 
> 1.7.9.5
> 
> 
