From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 23 May 2013 11:23:44 +0200
Subject: [PATCH V2 1/6] drivers: bus: add a new driver for WEIM
In-Reply-To: <1369296978-7669-2-git-send-email-b32955@freescale.com>
References: <1369296978-7669-1-git-send-email-b32955@freescale.com>
 <1369296978-7669-2-git-send-email-b32955@freescale.com>
Message-ID: <20130523092344.GF32299@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 04:16:13PM +0800, Huang Shijie wrote:
> The WEIM(Wireless External Interface Module) works like a bus.
> You can attach many different devices on it, such as NOR, onenand.
> 
> In the case of i.MX6q-sabreauto, the NOR is connected to WEIM.
> 
> This patch also adds the devicetree binding document.
> The driver only works when the devicetree is enabled.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  Documentation/devicetree/bindings/bus/imx-weim.txt |   50 +++++++
>  drivers/bus/Kconfig                                |    9 ++
>  drivers/bus/Makefile                               |    1 +
>  drivers/bus/imx-weim.c                             |  146 ++++++++++++++++++++
>  4 files changed, 206 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/bus/imx-weim.txt
>  create mode 100644 drivers/bus/imx-weim.c
> 
> diff --git a/Documentation/devicetree/bindings/bus/imx-weim.txt b/Documentation/devicetree/bindings/bus/imx-weim.txt
> new file mode 100644
> index 0000000..3db588e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/imx-weim.txt
> @@ -0,0 +1,50 @@
> +Device tree bindings for i.MX Wireless External Interface Module (WEIM)
> +
> +The term "wireless" does not imply that the WEIM is literally an interface
> +without wires. It simply means that this module was originally designed for
> +wireless and mobile applications that use low-power technology.
> +
> +The actual devices are instantiated from the child nodes of a WEIM node.
> +
> +
> + - compatible:		Should be set to "fsl,imx6q-weim"
> + - reg:			A resource specifier for the register space
> +			(see the example below)
> + - interrupts:		the interrupt number, see the example below.
> + - clocks:		the clock, see the example below.
> + - #address-cells:	Must be set to 2 to allow memory address translation
> + - #size-cells:		Must be set to 1 to allow CS address passing
> + - ranges:		Must be set up to reflect the memory layout with four
> +			integer values for each chip-select line in use:
> +
> +			   <cs-number> 0 <physical address of mapping> <size>
> +
> +Timing property for child nodes. It is mandatory, not optional.
> +
> + - fsl,weim-cs-timing:	The timing array, contains 6 timing values for the
> +			child node. We can get the CS index from the child
> +			node's "reg" property.

This should be more detailed, something like:

This contains the values for the registers EIM_CSnGCR1, EIM_CSnGCR2,
EIM_CSnRCR1, EIM_CSnRCR2, EIM_CSnWCR1, EIM_CSnWCR2 in this order.

> +static int weim_parse_dt(struct platform_device *pdev)
> +{
> +	struct device_node *child;
> +	int ret;
> +
> +	for_each_child_of_node(pdev->dev.of_node, child) {
> +		if (!child->name)
> +			continue;
> +
> +		ret = weim_timing_setup(pdev, child);
> +		if (ret)
> +			goto parse_fail;
> +
> +		if (!of_platform_device_create(child, NULL, &pdev->dev)) {
> +			ret = -EINVAL;
> +			goto parse_fail;
> +		}

I would print some warning here for the failures in this loop, but I
don't think it's necessary to bail out. No need to make all WEIM devices
fail if one has an erroneous device node.

> +
> +	/* get the resource */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	weim->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(weim->base)) {
> +		ret = PTR_ERR(weim->base);
> +		goto weim_err;
> +	}
> +
> +	/* get the clock */
> +	weim->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(weim->clk))
> +		goto weim_err;
> +
> +	clk_prepare_enable(weim->clk);
> +
> +	/* parse the device node */
> +	ret = weim_parse_dt(pdev);
> +	if (ret) {
> +		clk_disable_unprepare(weim->clk);
> +		goto weim_err;
> +	}
> +
> +	dev_info(&pdev->dev, "WEIM driver registered.\n");
> +	return 0;
> +
> +weim_err:
> +	return ret;
> +}
> +
> +static int weim_remove(struct platform_device *pdev)
> +{
> +	struct imx_weim *weim = platform_get_drvdata(pdev);
> +
> +	clk_disable_unprepare(weim->clk);

Once again: Is this clock needed for the child devices? If yes, you
can't disable it here and leave the child devices registered.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
