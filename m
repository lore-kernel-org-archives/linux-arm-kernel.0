From: robh@kernel.org (Rob Herring)
Date: Fri, 29 Jul 2016 15:13:26 -0500
Subject: [PATCH v5 2/2] clk: uniphier: add clock data for UniPhier SoCs
In-Reply-To: <1469556593-11369-3-git-send-email-yamada.masahiro@socionext.com>
References: <1469556593-11369-1-git-send-email-yamada.masahiro@socionext.com>
 <1469556593-11369-3-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160729201326.GA462@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 27, 2016 at 03:09:53AM +0900, Masahiro Yamada wrote:
> Add clock data arrays for all UniPhier SoCs.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  .../devicetree/bindings/clock/uniphier-clock.txt   | 123 ++++
>  drivers/clk/uniphier/Makefile                      |   3 +
>  drivers/clk/uniphier/clk-uniphier-core.c           |  91 +++
>  drivers/clk/uniphier/clk-uniphier-mio.c            | 195 +++++++
>  drivers/clk/uniphier/clk-uniphier-peri.c           |  95 ++++
>  drivers/clk/uniphier/clk-uniphier-sys.c            | 626 +++++++++++++++++++++
>  drivers/clk/uniphier/clk-uniphier.h                |  13 +
>  7 files changed, 1146 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/uniphier-clock.txt
>  create mode 100644 drivers/clk/uniphier/clk-uniphier-mio.c
>  create mode 100644 drivers/clk/uniphier/clk-uniphier-peri.c
>  create mode 100644 drivers/clk/uniphier/clk-uniphier-sys.c
> 
> diff --git a/Documentation/devicetree/bindings/clock/uniphier-clock.txt b/Documentation/devicetree/bindings/clock/uniphier-clock.txt
> new file mode 100644
> index 0000000..1a4fee1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/uniphier-clock.txt
> @@ -0,0 +1,123 @@
> +UniPhier clock controller
> +
> +
> +System clock
> +------------
> +
> +Required properties:
> +- compatible: should be one of the following:
> +    "socionext,uniphier-sld3-clock" - for PH1-sLD3 SoC.
> +    "socionext,uniphier-ld4-clock"  - for PH1-LD4 SoC.
> +    "socionext,uniphier-pro4-clock" - for PH1-Pro4 SoC.
> +    "socionext,uniphier-sld8-clock" - for PH1-sLD8 SoC.
> +    "socionext,uniphier-pro5-clock" - for PH1-Pro5 SoC.
> +    "socionext,uniphier-pxs2-clock" - for ProXstream2/PH1-LD6b SoC.
> +    "socionext,uniphier-ld11-clock" - for PH1-LD11 SoC.
> +    "socionext,uniphier-ld20-clock" - for PH1-LD20 SoC.
> +- #clock-cells: should be 1.

What are the provided clocks for this one?

> +
> +Note:
> +The clock node should be a child of a syscon node.

Of which syscon node?

> +
> +Example:
> +
> +	sysctrl at 61840000 {
> +		compatible = "simple-mfd", "syscon";

This needs a specific compatible...

> +		reg = <0x61840000 0x4000>;
> +
> +		clock {
> +			compatible = "socionext,uniphier-ld20-clock";
> +			#clock-cells = <1>;
> +		};
> +
> +		other nodes ...
> +	};
> +
> +
> +Media I/O (MIO) clock
> +---------------------
> +
> +Required properties:
> +- compatible: should be one of the following:
> +    "socionext,uniphier-sld3-mio-clock" - for PH1-sLD3 SoC.
> +    "socionext,uniphier-ld4-mio-clock"  - for PH1-LD4 SoC.
> +    "socionext,uniphier-pro4-mio-clock" - for PH1-Pro4 SoC.
> +    "socionext,uniphier-sld8-mio-clock" - for PH1-sLD8 SoC.
> +    "socionext,uniphier-pro5-mio-clock" - for PH1-Pro5 SoC.
> +    "socionext,uniphier-pxs2-mio-clock" - for ProXstream2/PH1-LD6b SoC.
> +    "socionext,uniphier-ld11-mio-clock" - for PH1-LD11 SoC.
> +    "socionext,uniphier-ld20-mio-clock" - for PH1-LD20 SoC.
> +- #clock-cells: should be 1.
> +
> +Note:
> +The clock node should be a child of a syscon node.

Same issue here.

> +
> +Example:
> +
> +	mioctrl at 59810000 {
> +		compatible = "simple-mfd", "syscon";
> +		reg = <0x59810000 0x800>;
> +
> +		clock {
> +			compatible = "socionext,uniphier-ld20-mio-clock";
> +			#clock-cells = <1>;
> +		};
> +
> +		other nodes ...
> +	};
> +
> +Provided clocks:
> +
> +0: SD host ch0
> +1: eMMC host
> +2: SD host ch1
> +3: MIO DMAC
> +4: USB2 host ch0
> +5: USB2 host ch1
> +6: USB2 host ch2
> +7: USB2 host ch3
> +
> +
> +Peripheral clock
> +----------------
> +
> +Required properties:
> +- compatible: should be one of the following:
> +    "socionext,uniphier-sld3-peri-clock" - for PH1-sLD3 SoC.
> +    "socionext,uniphier-ld4-peri-clock"  - for PH1-LD4 SoC.
> +    "socionext,uniphier-pro4-peri-clock" - for PH1-Pro4 SoC.
> +    "socionext,uniphier-sld8-peri-clock" - for PH1-sLD8 SoC.
> +    "socionext,uniphier-pro5-peri-clock" - for PH1-Pro5 SoC.
> +    "socionext,uniphier-pxs2-peri-clock" - for ProXstream2/PH1-LD6b SoC.
> +    "socionext,uniphier-ld11-peri-clock" - for PH1-LD11 SoC.
> +    "socionext,uniphier-ld20-peri-clock" - for PH1-LD20 SoC.
> +- #clock-cells: should be 1.
> +
> +Note:
> +The clock node should be a child of a syscon node.
> +
> +Example:
> +
> +	perictrl at 59820000 {
> +		compatible = "simple-mfd", "syscon";
> +		reg = <0x59820000 0x200>;
> +
> +		clock {
> +			compatible = "socionext,uniphier-ld20-peri-clock";
> +			#clock-cells = <1>;
> +		};
> +
> +		other nodes ...
> +	};
> +
> + 0: UART ch0
> + 1: UART ch1
> + 2: UART ch2
> + 3: UART ch3
> + 4: I2C ch0
> + 5: I2C ch1
> + 6: I2C ch2
> + 7: I2C ch3
> + 8: I2C ch4
> + 9: I2C ch5
> +10: I2C ch6
