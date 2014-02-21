From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 21 Feb 2014 09:36:23 +0800
Subject: [PATCH v5] bus: imx-weim: support CS GPR configuration
In-Reply-To: <1392705666-10995-1-git-send-email-shawn.guo@linaro.org>
References: <1392705666-10995-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20140221013621.GO3010@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 02:41:06PM +0800, Shawn Guo wrote:
> For imx50-weim and imx6q-weim type of devices, there might a WEIM CS
> space configuration register in General Purpose Register controller,
> e.g. IOMUXC_GPR1 on i.MX6Q.
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
> The patch creates a function for such type of devices, which scans
> 'ranges' property of WEIM node and build the GPR value incrementally.
> Thus the WEIM CS GPR can be set up automatically at boot time.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> Changes since v4:
>  - Fix a typo in comment
>  - Add fsl,weim-cs-gpr in the binding example
>  - Check return of imx_weim_gpr_setup()
> 
>  Documentation/devicetree/bindings/bus/imx-weim.txt |   28 +++++++++-

Rob, Mark,

Any objections on this binding update?  Otherwise, I will queue this
patch for 3.15.

Shawn

>  drivers/bus/imx-weim.c                             |   58 ++++++++++++++++++++
>  2 files changed, 85 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/bus/imx-weim.txt b/Documentation/devicetree/bindings/bus/imx-weim.txt
> index 0fd76c4..6630d84 100644
> --- a/Documentation/devicetree/bindings/bus/imx-weim.txt
> +++ b/Documentation/devicetree/bindings/bus/imx-weim.txt
> @@ -8,7 +8,12 @@ The actual devices are instantiated from the child nodes of a WEIM node.
>  
>  Required properties:
>  
> - - compatible:		Should be set to "fsl,<soc>-weim"
> + - compatible:		Should contain one of the following:
> +			  "fsl,imx1-weim"
> +			  "fsl,imx27-weim"
> +			  "fsl,imx51-weim"
> +			  "fsl,imx50-weim"
> +			  "fsl,imx6q-weim"
>   - reg:			A resource specifier for the register space
>  			(see the example below)
>   - clocks:		the clock, see the example below.
> @@ -19,6 +24,26 @@ Required properties:
>  
>  			   <cs-number> 0 <physical address of mapping> <size>
>  
> +Optional properties:
> +
> + - fsl,weim-cs-gpr:	For "fsl,imx50-weim" and "fsl,imx6q-weim" type of
> +			devices, it should be the phandle to the system General
> +			Purpose Register controller that contains WEIM CS GPR
> +			register, e.g. IOMUXC_GPR1 on i.MX6Q.  IOMUXC_GPR1[11:0]
> +			should be set up as one of the following 4 possible
> +			values depending on the CS space configuration.
> +
> +			IOMUXC_GPR1[11:0]    CS0    CS1    CS2    CS3
> +			---------------------------------------------
> +				05	    128M     0M     0M     0M
> +				033          64M    64M     0M     0M
> +				0113         64M    32M    32M     0M
> +				01111        32M    32M    32M    32M
> +
> +			In case that the property is absent, the reset value or
> +			what bootloader sets up in IOMUXC_GPR1[11:0] will be
> +			used.
> +
>  Timing property for child nodes. It is mandatory, not optional.
>  
>   - fsl,weim-cs-timing:	The timing array, contains timing values for the
> @@ -43,6 +68,7 @@ Example for an imx6q-sabreauto board, the NOR flash connected to the WEIM:
>  		#address-cells = <2>;
>  		#size-cells = <1>;
>  		ranges = <0 0 0x08000000 0x08000000>;
> +		fsl,weim-cs-gpr = <&gpr>;
>  
>  		nor at 0,0 {
>  			compatible = "cfi-flash";
> diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
> index 3ef58c8..f8ee13c 100644
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
> @@ -56,6 +59,55 @@ static const struct of_device_id weim_id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(of, weim_id_table);
>  
> +static int __init imx_weim_gpr_setup(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct property *prop;
> +	const __be32 *p;
> +	struct regmap *gpr;
> +	u32 gprvals[4] = {
> +		05,	/* CS0(128M) CS1(0M)  CS2(0M)  CS3(0M)  */
> +		033,	/* CS0(64M)  CS1(64M) CS2(0M)  CS3(0M)  */
> +		0113,	/* CS0(64M)  CS1(32M) CS2(32M) CS3(0M)  */
> +		01111,	/* CS0(32M)  CS1(32M) CS2(32M) CS3(32M) */
> +	};
> +	u32 gprval = 0;
> +	u32 val;
> +	int cs = 0;
> +	int i = 0;
> +
> +	gpr = syscon_regmap_lookup_by_phandle(np, "fsl,weim-cs-gpr");
> +	if (IS_ERR(gpr)) {
> +		dev_dbg(&pdev->dev, "failed to find weim-cs-gpr\n");
> +		return 0;
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
> @@ -92,6 +144,12 @@ static int __init weim_parse_dt(struct platform_device *pdev,
>  	struct device_node *child;
>  	int ret;
>  
> +	if (devtype == &imx50_weim_devtype) {
> +		ret = imx_weim_gpr_setup(pdev);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	for_each_child_of_node(pdev->dev.of_node, child) {
>  		if (!child->name)
>  			continue;
> -- 
> 1.7.9.5
> 
> 
