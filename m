From: phdm@macq.eu (Philippe De Muyter)
Date: Wed, 12 Feb 2014 17:43:04 +0100
Subject: [PATCH] bus: imx-weim: support weim-cs-gpr for imx6q-weim
In-Reply-To: <1392087011-31629-1-git-send-email-shawn.guo@linaro.org>
References: <1392087011-31629-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20140212164304.GA20251@frolo.macqel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Shawn.

On Tue, Feb 11, 2014 at 10:50:11AM +0800, Shawn Guo wrote:
> For imx6q-weim type of device, there might a WEIM CS space configuration
> register in General Purpose Register controller, e.g. IOMUXC_GPR1 on
> i.MX6Q.
> 
> Depending on which configuration of the following 4 is chosen for given
> system, IOMUXC_GPR1[11:0] should be set up as 0x5, 0x1b, 0x4b or 0x249

As the bits are actually grouped by 3, one could write:
					... as 05, 033, 0113, or 01111
> correspondingly.
> 
> 	CS0(128M) CS1(0M)  CS2(0M)  CS3(0M)
> 	CS0(64M)  CS1(64M) CS2(0M)  CS3(0M)
> 	CS0(64M)  CS1(32M) CS2(32M) CS3(0M)
> 	CS0(32M)  CS1(32M) CS2(32M) CS3(32M)
> 
> The patch creates a table in the driver for above configurations, and
> detects which one is being used for the booting system by looking at
> 'ranges' property of WEIM node.  Thus the WEIM CS GPR can be set up
> automatically at boot time.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  Documentation/devicetree/bindings/bus/imx-weim.txt |    6 ++
>  drivers/bus/imx-weim.c                             |   83 ++++++++++++++++++++
>  2 files changed, 89 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/bus/imx-weim.txt b/Documentation/devicetree/bindings/bus/imx-weim.txt
> index 0fd76c4..d114460f 100644
> --- a/Documentation/devicetree/bindings/bus/imx-weim.txt
> +++ b/Documentation/devicetree/bindings/bus/imx-weim.txt
> @@ -19,6 +19,12 @@ Required properties:
>  
>  			   <cs-number> 0 <physical address of mapping> <size>
>  
> +Optional properties:
> +
> + - fsl,weim-cs-gpr:	Should be the phandle to the General Purpose Register
> +			controller that contains WEIM CS GPR register, e.g.
> +			IOMUXC_GPR1 on i.MX6Q.
> +

Why require that new property ?  It makes things harder to use.

And you could add the body of your commit log here.

>  Timing property for child nodes. It is mandatory, not optional.
>  
>   - fsl,weim-cs-timing:	The timing array, contains timing values for the
> diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
> index 3ef58c8..9c8a522 100644
> --- a/drivers/bus/imx-weim.c
> +++ b/drivers/bus/imx-weim.c
> @@ -11,6 +11,9 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/of_device.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
> +#include <linux/regmap.h>
>  
>  struct imx_weim_devtype {
>  	unsigned int	cs_count;
> @@ -56,6 +59,83 @@ static const struct of_device_id weim_id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(of, weim_id_table);
>  
> +struct imx6q_weim_gpr {
> +	u32 cssize[4];
> +	u32 gprval;
> +};
> +
> +static const struct imx6q_weim_gpr imx6q_weim_gpr_data[] __initconst = {
> +	{
> +		/* CS0(128M) CS1(0M) CS2(0M) CS3(0M) */
> +		.cssize = { 128, 0, 0, 0 },
> +		.gprval = 0x5,
			05
> +	}, {
> +		/* CS0(64M) CS1(64M) CS2(0M) CS3(0M) */
> +		.cssize = { 64, 64, 0, 0 },
> +		.gprval = 0x1b,
			033
> +	}, {
> +		/* CS0(64M) CS1(32M) CS2(32M) CS3(0M) */
> +		.cssize = { 64, 32, 32, 0 },
> +		.gprval = 0x4b,
			0113
> +	}, {
> +		/* CS0(64M) CS1(32M) CS2(32M) CS3(0M) */
		/* CS0(32M) CS1(32M) CS2(32M) CS3(32M) */
> +		.cssize = { 32, 32, 32, 32 },
> +		.gprval = 0x249,
			01111
> +	},
> +};
> +
> +static int __init imx6q_weim_gpr_setup(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	const struct property *prop;
> +	struct regmap *gpr;
> +	u32 cssize[4] = { 0, 0, 0, 0 };
> +	int len;
> +	int ret;
> +	int i;
> +
> +	gpr = syscon_regmap_lookup_by_phandle(np, "fsl,weim-cs-gpr");

	gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");

> +	if (IS_ERR(gpr)) {
> +		dev_dbg(&pdev->dev, "No weim-cs-gpr to set up\n");
> +		return 0;
> +	}
> +
> +	prop = of_find_property(np, "ranges", &len);
> +	if (prop == NULL)
> +		return -ENOENT;
> +	if (len % (sizeof(u32) * 4))
> +		return -EINVAL;
> +
> +	for (i = 0; i < len / (sizeof(u32) * 4); i++) {
> +		int cs;
> +		/* read cs index */
> +		ret = of_property_read_u32_index(np, "ranges", i * 4, &cs);
> +		if (ret)
> +			return ret;
> +		/* read cs size */
> +		ret = of_property_read_u32_index(np, "ranges", i * 4 + 3,
> +						 &cssize[cs]);
> +		if (ret)
> +			return ret;
> +		/* turn to MB */
> +		cssize[cs] >>= 20;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(imx6q_weim_gpr_data); i++) {
> +		ret = memcmp(cssize, imx6q_weim_gpr_data[i].cssize,
> +			     sizeof(cssize));
> +		if (ret == 0) {
> +			/* Find it. Set up IOMUXC_GPR1[11:0] with the gprval. */

			Found it

> +			regmap_update_bits(gpr, IOMUXC_GPR1, 0xfff,
> +					   imx6q_weim_gpr_data[i].gprval);
> +			return 0;
> +		}
> +	}
> +
> +	dev_err(&pdev->dev, "Invalid 'ranges' configuration\n");
> +	return -EINVAL;
> +}
> +
>  /* Parse and set the timing for this device. */
>  static int __init weim_timing_setup(struct device_node *np, void __iomem *base,
>  				    const struct imx_weim_devtype *devtype)
> @@ -92,6 +172,9 @@ static int __init weim_parse_dt(struct platform_device *pdev,
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

Now the most important : it works.  I have tested it successfully for the
4 combinations.

Code could probably be made shorter by using 'of_prop_next_u32' and building
the gprval incrementally, then checking it against the four possible values,
though.

But, again, thanks, Shawn

-- 
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles
