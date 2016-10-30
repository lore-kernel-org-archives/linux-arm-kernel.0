From: robh@kernel.org (Rob Herring)
Date: Sun, 30 Oct 2016 15:41:10 -0500
Subject: [PATCH] net: stmmac: Add OXNAS Glue Driver
In-Reply-To: <20161021084445.24989-1-narmstrong@baylibre.com>
References: <20161021084445.24989-1-narmstrong@baylibre.com>
Message-ID: <20161030204110.otvjlanmi7dv7fox@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2016 at 10:44:45AM +0200, Neil Armstrong wrote:
> Add Synopsys Designware MAC Glue layer for the Oxford Semiconductor OX820.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/net/oxnas-dwmac.txt        |  44 +++++

It's preferred that bindings are a separate patch.

>  drivers/net/ethernet/stmicro/stmmac/Kconfig        |  11 ++
>  drivers/net/ethernet/stmicro/stmmac/Makefile       |   1 +
>  drivers/net/ethernet/stmicro/stmmac/dwmac-oxnas.c  | 219 +++++++++++++++++++++
>  4 files changed, 275 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/oxnas-dwmac.txt
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-oxnas.c
> 
> Changes since RFC at https://patchwork.kernel.org/patch/9387257 :
>  - Drop init/exit callbacks
>  - Implement proper remove and PM callback
>  - Call init from probe
>  - Disable/Unprepare clock if stmmac probe fails
> 
> diff --git a/Documentation/devicetree/bindings/net/oxnas-dwmac.txt b/Documentation/devicetree/bindings/net/oxnas-dwmac.txt
> new file mode 100644
> index 0000000..5d2696c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/oxnas-dwmac.txt
> @@ -0,0 +1,44 @@
> +* Oxford Semiconductor OXNAS DWMAC Ethernet controller
> +
> +The device inherits all the properties of the dwmac/stmmac devices
> +described in the file stmmac.txt in the current directory with the
> +following changes.
> +
> +Required properties on all platforms:
> +
> +- compatible:	Depending on the platform this should be one of:
> +			- "oxsemi,ox820-dwmac"
> +		Additionally "snps,dwmac" and any applicable more
> +		detailed version number described in net/stmmac.txt
> +		should be used.

You should be explicit what version applies to ox820. "snps,dwmac" 
should probably be deprecated IMO. There are so many variations of DW 
h/w.

> +
> +- reg:	The first register range should be the one of the DWMAC
> +	controller.

This is worded like there's a 2nd range?

> +
> +- clocks: Should contain phandles to the following clocks
> +- clock-names:	Should contain the following:
> +		- "stmmaceth" - see stmmac.txt
> +		- "gmac" - peripheral gate clock
> +
> +- oxsemi,sys-ctrl: a phandle to the system controller syscon node
> +
> +Example :
> +
> +etha: ethernet at 40400000 {
> +	compatible = "oxsemi,ox820-dwmac", "snps,dwmac";
> +	reg = <0x40400000 0x2000>;
> +	interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> +	interrupt-names = "macirq", "eth_wake_irq";
> +	mac-address = [000000000000]; /* Filled in by U-Boot */
> +	phy-mode = "rgmii";
> +
> +	clocks = <&stdclk CLK_820_ETHA>, <&gmacclk>;
> +	clock-names = "gmac", "stmmaceth";
> +	resets = <&reset RESET_MAC>;
> +
> +	/* Regmap for sys registers */
> +	oxsemi,sys-ctrl = <&sys>;
> +
> +	status = "disabled";
> +};
