From: robh@kernel.org (Rob Herring)
Date: Mon, 19 Feb 2018 08:56:17 -0600
Subject: [PATCH v2 1/1] clk: npcm750: update text with fixed clocks
In-Reply-To: <1518701959-22899-2-git-send-email-tali.perry1@gmail.com>
References: <1518701959-22899-1-git-send-email-tali.perry1@gmail.com>
 <1518701959-22899-2-git-send-email-tali.perry1@gmail.com>
Message-ID: <20180219145617.66qjtafuuy2odgak@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 03:39:19PM +0200, Tali Perry wrote:
> 
> Signed-off-by: Tali Perry <tali.perry1@gmail.com>
> 
> ---
>  .../bindings/clock/nuvoton,npcm750-clk.txt         | 103 +++++++++++++++++++++
>  include/dt-bindings/clock/nuvoton,npcm7xx-clock.h  |  51 ++++++++++
>  2 files changed, 154 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,npcm750-clk.txt
>  create mode 100644 include/dt-bindings/clock/nuvoton,npcm7xx-clock.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/nuvoton,npcm750-clk.txt b/Documentation/devicetree/bindings/clock/nuvoton,npcm750-clk.txt
> new file mode 100644
> index 000000000000..5d14a8358e76
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/nuvoton,npcm750-clk.txt
> @@ -0,0 +1,103 @@
> +* Nuvoton NPCM7XX Clock Controller
> +
> +Nuvoton Poleg BMC NPCM7XX contains an integrated clock controller, which
> +generates and supplies clocks to all modules within the BMC.
> +
> +External clocks:
> +
> +There are six fixed clocks that are generated outside the BMC. All clocks are of
> +a known fixed value that cannot be changed. clk_refclk, clk_mcbypck and
> +clk_sysbypck are inputs to the clock controller.
> +clk_rg1refck, clk_rg2refck and clk_xin are external clocks suppling the
> +network. They are set on the device tree, but not used by the clock module. The
> +network devices use them directly.
> +Example can be found below.
> +
> +All available clocks are defined as preprocessor macros in:
> +dt-bindings/clock/nuvoton,npcm7xx-clock.h
> +and can be reused as DT sources.
> +
> +Required Properties of clock controller:
> +
> +Clock controller node requirements:

This line is redundant.

> +	- compatible: "nuvoton,npcm750-clk" : for clock controller of Nuvoton
> +		  Poleg BMC NPCM750
> +
> +	- reg: physical base address of the clock controller and length of
> +		memory mapped region.
> +
> +	- #clock-cells: should be 1.
> +
> +Example: Clock controller node:
> +
> +	clk: clock-controller at f0801000 {
> +		compatible = "nuvoton,npcm750-clk";
> +		#clock-cells = <1>;
> +		clock-controller;

That's not a defined property.

> +		reg = <0xf0801000 0x1000>;

No input clocks for the clock controller?

> +	};
> +
> +Example: Required external clocks for network:
> +
> +	/* external reference clock */
> +	clk_refclk: clk-refclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <25000000>;
> +		clock-output-names = "refclk";
> +	};
> +
> +	/* external reference clock for cpu. float in normal operation */
> +	clk_sysbypck: clk-sysbypck {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <800000000>;
> +		clock-output-names = "sysbypck";
> +	};
> +
> +	/* external reference clock for MC. float in normal operation */
> +	clk_mcbypck: clk-mcbypck {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <800000000>;
> +		clock-output-names = "mcbypck";
> +	};
> +
> +	 /* external clock signal rg1refck, supplied by the phy */
> +	clk_rg1refck: clk-rg1refck {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <125000000>;
> +		clock-output-names = "clk_rg1refck";
> +	};
> +
> +	 /* external clock signal rg2refck, supplied by the phy */
> +	clk_rg2refck: clk-rg2refck {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <125000000>;
> +		clock-output-names = "clk_rg2refck";
> +	};
> +
> +	clk_xin: clk-xin {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <50000000>;
> +		clock-output-names = "clk_xin";
> +	};
> +
> +
> +Example: GMAC controller node that consumes two clocks: a generated clk by the
> +clock controller and a fixed clock from DT (clk_rg1refck).
> +
> +	gmac0: eth at f0802000 {

ethernet at ...

> +		device_type = "network";

device_type is deprecated (except in a few places).

> +		compatible = "snps,dwmac";
> +		reg = <0xf0802000 0x2000>;
> +		interrupts = <0 14 4>;
> +		interrupt-names = "macirq";
> +		ethernet = <0>;

Not a standard property.

> +		clocks	= <&clk_rg1refck>, <&clk NPCM7XX_CLK_AHB>;
> +		clock-names = "stmmaceth", "clk_gmac";
> +		status = "disabled";

Don't show status in examples.

> +	};
> diff --git a/include/dt-bindings/clock/nuvoton,npcm7xx-clock.h b/include/dt-bindings/clock/nuvoton,npcm7xx-clock.h
> new file mode 100644
> index 000000000000..5499783649d6
> --- /dev/null
> +++ b/include/dt-bindings/clock/nuvoton,npcm7xx-clock.h
> @@ -0,0 +1,51 @@
> +/*
> + * Nuvoton NPCM7xx Clock Generator
> + * All the clocks are initialized by the bootloader, so this driver allow only
> + * reading of current settings directly from the hardware.

This comment doesn't really match what the file is.

> + *
> + * Copyright (C) 2018 Nuvoton Technologies tali.perry at nuvoton.com
> + *
> + * Released under the GPLv2 only.
> + * SPDX-License-Identifier: GPL-2.0

Goes on first line as a separate comment.

> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html

Don't need these.

> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_NPCM7XX_H
> +#define __DT_BINDINGS_CLOCK_NPCM7XX_H
> +
> +
> +#define NPCM7XX_CLK_CPU 0
> +#define NPCM7XX_CLK_GFX_PIXEL 1
> +#define NPCM7XX_CLK_MC 2
> +#define NPCM7XX_CLK_ADC 3
> +#define NPCM7XX_CLK_AHB 4
> +#define NPCM7XX_CLK_TIMER 5
> +#define NPCM7XX_CLK_UART 6
> +#define NPCM7XX_CLK_MMC  7
> +#define NPCM7XX_CLK_SPI3 8
> +#define NPCM7XX_CLK_PCI  9
> +#define NPCM7XX_CLK_AXI 10
> +#define NPCM7XX_CLK_APB4 11
> +#define NPCM7XX_CLK_APB3 12
> +#define NPCM7XX_CLK_APB2 13
> +#define NPCM7XX_CLK_APB1 14
> +#define NPCM7XX_CLK_APB5 15
> +#define NPCM7XX_CLK_CLKOUT 16
> +#define NPCM7XX_CLK_GFX  17
> +#define NPCM7XX_CLK_SU   18
> +#define NPCM7XX_CLK_SU48 19
> +#define NPCM7XX_CLK_SDHC 20
> +#define NPCM7XX_CLK_SPI0 21
> +#define NPCM7XX_CLK_SPIX 22
> +
> +#define NPCM7XX_CLK_REFCLK 23
> +#define NPCM7XX_CLK_SYSBYPCK 24
> +#define NPCM7XX_CLK_MCBYPCK 25
> +
> +
> +#define NPCM7XX_NUM_CLOCKS	 (NPCM7XX_CLK_MCBYPCK+1)
> +
> +
> +
> +#endif
> -- 
> 2.14.1
> 
