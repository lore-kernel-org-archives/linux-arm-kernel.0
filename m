From: phdm@macq.eu (Philippe De Muyter)
Date: Thu, 13 Feb 2014 23:38:25 +0100
Subject: [PATCH v2] bus: imx-weim: support CS GPR config for imx6q-weim
In-Reply-To: <1392296342-21115-1-git-send-email-shawn.guo@linaro.org>
References: <1392296342-21115-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20140213223825.GA31996@frolo.macqel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Thu, Feb 13, 2014 at 08:59:02PM +0800, Shawn Guo wrote:
> For imx6q-weim type of device, there might a WEIM CS space configuration
> register in General Purpose Register controller, e.g. IOMUXC_GPR1 on
> i.MX6Q.
> 
> Depending on which configuration of the following 4 is chosen for given
> system, IOMUXC_GPR1[11:0] should be set up as 05, 033, 0113 or 01111
> correspondingly.
> 
> 	CS0(128M) CS1(0M)  CS2(0M)  CS3(0M)
> 	CS0(64M)  CS1(64M) CS2(0M)  CS3(0M)
> 	CS0(64M)  CS1(32M) CS2(32M) CS3(0M)
> 	CS0(32M)  CS1(32M) CS2(32M) CS3(32M)
> 
> The patch creates a function for imx6q-weim type of device, which scans
> 'ranges' property of WEIM node and build the GPR value incrementally.
> Thus the WEIM CS GPR can be set up automatically at boot time.

Please add that text to Documentation/devicetree/bindings/bus/imx-weim.txt.

> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> Changes since v1:
>  - Drop device tree property fsl,weim-cs-gpr
>  - Use octal value for IOMUXC_GPR1[11:0] bit field
>  - Use of_property_for_each_u32() to build gprval incrementally
> 
>  drivers/bus/imx-weim.c |   59 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
> index 3ef58c8..a120c93 100644
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
> @@ -56,6 +59,59 @@ static const struct of_device_id weim_id_table[] = {
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
> +		0111,	/* CS0(64M)  CS1(32M) CS2(32M) CS3(0M) */

		01111,	/* CS0(32M)  CS1(32M) CS2(32M) CS3(32M) */

> +	};
> +	u32 gprval = 0;
> +	u32 val;
> +	int len;
> +	int cs = 0;
> +	int i = 0;
> +
> +	gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
> +	if (IS_ERR(gpr)) {
> +		dev_err(&pdev->dev, "failed to find fsl,imx6q-iomuxc-gpr\n");
> +		return -ENOENT;
> +	}
> +
> +	prop = of_find_property(np, "ranges", &len);
> +	if (prop == NULL)
> +		return -ENOENT;
> +	if (len % (sizeof(u32) * 4))
> +		return -EINVAL;
> +
> +	of_property_for_each_u32(np, "ranges", prop, p, val) {
> +		if (i % 4 == 0) {
> +			cs = val;
> +		} else if (i % 4 == 3 && val) {
> +			val /= SZ_64M;
> +			val = (val << 1) | 1;

or
			val = (val / SZ_32M) | 1;

> +			gprval |= val << cs * 3;
> +		}
> +		i++;
> +	}

You may replace the tests above (from "prop = of_find_property" to "EINVAL;")
by :
	if (i == 0 || (i % 4))
		goto err;
> +
> +	for (i = 0; i < ARRAY_SIZE(gprvals); i++) {
> +		if (gprval == gprvals[i]) {
> +			/* Found it. Set up IOMUXC_GPR1[11:0] with it. */
> +			regmap_update_bits(gpr, IOMUXC_GPR1, 0xfff, gprval);
> +			return 0;
> +		}
> +	}
> +

   err:

> +	dev_err(&pdev->dev, "Invalid 'ranges' configuration\n");
> +	return -EINVAL;
> +}
> +
>  /* Parse and set the timing for this device. */
>  static int __init weim_timing_setup(struct device_node *np, void __iomem *base,
>  				    const struct imx_weim_devtype *devtype)
> @@ -92,6 +148,9 @@ static int __init weim_parse_dt(struct platform_device *pdev,
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

I have tested this v2 patch, and, except for the typo (0111 instead of 01111),
it works perfectly.

Thanks

Philippe

-- 
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles
