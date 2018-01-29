From: robh@kernel.org (Rob Herring)
Date: Mon, 29 Jan 2018 12:45:08 -0600
Subject: [PATCHv2 1/2] arm64: dts: stratix10: add clock bindings for the
 Stratix10 platform
In-Reply-To: <1516228333-13033-1-git-send-email-dinguyen@kernel.org>
References: <1516228333-13033-1-git-send-email-dinguyen@kernel.org>
Message-ID: <20180129184508.znymdltqodpci4n3@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 04:32:12PM -0600, Dinh Nguyen wrote:
> Add the clock bindings for the Stratix10 SoC.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v2: use a single clock binding
> ---
>  .../devicetree/bindings/clock/intc_stratix10.txt   |   20 +++++
>  arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |   50 +++++++++++-
>  .../boot/dts/altera/socfpga_stratix10_socdk.dts    |   10 +++
>  include/dt-bindings/clock/stratix10-clock.h        |   85 ++++++++++++++++++++

The dts files should be 1 patch and the binding and header 1 patch.

>  4 files changed, 163 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/intc_stratix10.txt
>  create mode 100644 include/dt-bindings/clock/stratix10-clock.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/intc_stratix10.txt b/Documentation/devicetree/bindings/clock/intc_stratix10.txt
> new file mode 100644
> index 0000000..56c61d1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/intc_stratix10.txt
> @@ -0,0 +1,20 @@
> +Device Tree Clock bindings for Intel's SoCFPGA Stratix10 platform
> +
> +This binding uses the common clock binding[1].
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required properties:
> +- compatible : shall be
> +	"intc,clk-s10-mgr"

intel is the documented vendor prefix. <chip>-<ip block> is the normal 
ordering.

> +
> +- reg : shall be the control register offset from CLOCK_MANAGER's base for the clock.
> +
> +- #clock-cells : from common clock binding, shall be set to 1.
> +
> +Example:
> +	clkmgr: clkmgr at ffd10000 {

clock-controller at ...

> +		compatible = "intc,clk-s10-mgr";
> +		reg = <0xffd10000 0x1000>;
> +		#clock-cells = <1>;
> +	};
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> index 7366a58..5120f9f 100644
> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> @@ -17,6 +17,7 @@
>  /dts-v1/;
>  #include <dt-bindings/reset/altr,rst-mgr-s10.h>
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/clock/stratix10-clock.h>
>  
>  / {
>  	compatible = "altr,socfpga-stratix10";
> @@ -91,9 +92,35 @@
>  		interrupt-parent = <&intc>;
>  		ranges = <0 0 0 0xffffffff>;
>  
> -		clkmgr at ffd1000 {
> -			compatible = "altr,clk-mgr";
> +		clkmgr: clkmgr at ffd10000 {

clock-controller at ...

> +			compatible = "intc,clk-s10-mgr";

You should state in the commit msg why you are changing this in an 
incompatible way.

>  			reg = <0xffd10000 0x1000>;
> +			#clock-cells = <1>;
> +
> +			clocks {

No mention of a child node in the binding doc.

> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				cb_intosc_hs_div2_clk: cb_intosc_hs_div2_clk {
> +					#clock-cells = <0>;
> +					compatible = "fixed-clock";
> +				};
> +
> +				cb_intosc_ls_clk: cb_intosc_ls_clk {
> +					#clock-cells = <0>;
> +					compatible = "fixed-clock";
> +				};
> +
> +				f2s_free_clk: f2s_free_clk {
> +					#clock-cells = <0>;
> +					compatible = "fixed-clock";
> +				};
> +
> +				osc1: osc1 {
> +					#clock-cells = <0>;
> +					compatible = "fixed-clock";
> +				};
> +			};
>  		};
>  
>  		gmac0: ethernet at ff800000 {
> @@ -104,6 +131,8 @@
>  			mac-address = [00 00 00 00 00 00];
>  			resets = <&rst EMAC0_RESET>;
>  			reset-names = "stmmaceth";
> +			clocks = <&clkmgr STRATIX10_EMAC0_CLK>;
> +			clock-names = "stmmaceth";
>  			status = "disabled";
>  		};
>  
> @@ -115,6 +144,8 @@
>  			mac-address = [00 00 00 00 00 00];
>  			resets = <&rst EMAC1_RESET>;
>  			reset-names = "stmmaceth";
> +			clocks = <&clkmgr STRATIX10_EMAC1_CLK>;
> +			clock-names = "stmmaceth";
>  			status = "disabled";
>  		};
>  
> @@ -126,6 +157,8 @@
>  			mac-address = [00 00 00 00 00 00];
>  			resets = <&rst EMAC2_RESET>;
>  			reset-names = "stmmaceth";
> +			clocks = <&clkmgr STRATIX10_EMAC2_CLK>;
> +			clock-names = "stmmaceth";
>  			status = "disabled";
>  		};
>  
> @@ -228,6 +261,9 @@
>  			fifo-depth = <0x400>;
>  			resets = <&rst SDMMC_RESET>;
>  			reset-names = "reset";
> +			clocks = <&clkmgr STRATIX10_L4_MP_CLK>,
> +				 <&clkmgr STRATIX10_SDMMC_CLK>;
> +			clock-names = "biu", "ciu";
>  			status = "disabled";
>  		};
>  
> @@ -283,24 +319,32 @@
>  			compatible = "snps,dw-apb-timer";
>  			interrupts = <0 113 4>;
>  			reg = <0xffc03000 0x100>;
> +			clocks = <&clkmgr STRATIX10_L4_SP_CLK>;
> +			clock-names = "timer";
>  		};
>  
>  		timer1: timer1 at ffc03100 {
>  			compatible = "snps,dw-apb-timer";
>  			interrupts = <0 114 4>;
>  			reg = <0xffc03100 0x100>;
> +			clocks = <&clkmgr STRATIX10_L4_SP_CLK>;
> +			clock-names = "timer";
>  		};
>  
>  		timer2: timer2 at ffd00000 {
>  			compatible = "snps,dw-apb-timer";
>  			interrupts = <0 115 4>;
>  			reg = <0xffd00000 0x100>;
> +			clocks = <&clkmgr STRATIX10_L4_SP_CLK>;
> +			clock-names = "timer";
>  		};
>  
>  		timer3: timer3 at ffd00100 {
>  			compatible = "snps,dw-apb-timer";
>  			interrupts = <0 116 4>;
>  			reg = <0xffd00100 0x100>;
> +			clocks = <&clkmgr STRATIX10_L4_SP_CLK>;
> +			clock-names = "timer";
>  		};
>  
>  		uart0: serial0 at ffc02000 {
> @@ -310,6 +354,7 @@
>  			reg-shift = <2>;
>  			reg-io-width = <4>;
>  			resets = <&rst UART0_RESET>;
> +			clocks = <&clkmgr STRATIX10_L4_SP_CLK>;
>  			status = "disabled";
>  		};
>  
> @@ -320,6 +365,7 @@
>  			reg-shift = <2>;
>  			reg-io-width = <4>;
>  			resets = <&rst UART1_RESET>;
> +			clocks = <&clkmgr STRATIX10_L4_SP_CLK>;
>  			status = "disabled";
>  		};
>  
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> index 0007564..4d2d471 100644
> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> @@ -50,6 +50,16 @@
>  		/* We expect the bootloader to fill in the reg */
>  		reg = <0 0 0 0>;
>  	};
> +
> +	soc {
> +		clkmgr at ffd10000 {
> +			clocks {
> +				osc1 {
> +					clock-frequency = <25000000>;
> +				};
> +			};
> +		};
> +	};
>  };
>  
>  &gpio1 {
> diff --git a/include/dt-bindings/clock/stratix10-clock.h b/include/dt-bindings/clock/stratix10-clock.h
> new file mode 100644
> index 0000000..faa7ea7
> --- /dev/null
> +++ b/include/dt-bindings/clock/stratix10-clock.h
> @@ -0,0 +1,85 @@
> +/*
> + * Copyright (C) 2017, Intel Corporation
> + *
> + * SPDX-License-Identifier:	GPL-2.0

It's been decreed that this goes on the first line.

> + */
> +
> +#ifndef __STRATIX10_CLOCK_H
> +#define __STRATIX10_CLOCK_H
> +
> +/* fixed rate clocks */
> +#define STRATIX10_OSC1			0
> +#define STRATIX10_CB_INTOSC_HS_DIV2_CLK	1
> +#define STRATIX10_CB_INTOSC_LS_CLK	2
> +#define STRATIX10_F2S_FREE_CLK		3
> +
> +/* fixed factor clocks */
> +#define STRATIX10_L4_SYS_FREE_CLK	4
> +#define STRATIX10_MPU_PERIPH_CLK	5
> +#define STRATIX10_MPU_L2RAM_CLK		6
> +#define STRATIX10_SDMMC_CIU_CLK		7
> +
> +/* PLL clocks */
> +#define STRATIX10_MAIN_PLL_CLK		8
> +#define STRATIX10_PERIPH_PLL_CLK	9
> +#define STRATIX10_BOOT_CLK		10
> +
> +/* Periph clocks */
> +#define STRATIX10_MAIN_MPU_BASE_CLK	11
> +#define STRATIX10_MAIN_NOC_BASE_CLK	12
> +#define STRATIX10_MAIN_EMACA_CLK	13
> +#define STRATIX10_MAIN_EMACB_CLK	14
> +#define STRATIX10_MAIN_EMAC_PTP_CLK	15
> +#define STRATIX10_MAIN_GPIO_DB_CLK	16
> +#define STRATIX10_MAIN_SDMMC_CLK	17
> +#define STRATIX10_MAIN_S2F_USR0_CLK	18
> +#define STRATIX10_MAIN_S2F_USR1_CLK	19
> +#define STRATIX10_MAIN_PSI_REF_CLK	20
> +
> +#define STRATIX10_PERI_MPU_BASE_CLK	21
> +#define STRATIX10_PERI_NOC_BASE_CLK	22
> +#define STRATIX10_PERI_EMACA_CLK	23
> +#define STRATIX10_PERI_EMACB_CLK	24
> +#define STRATIX10_PERI_EMAC_PTP_CLK	25
> +#define STRATIX10_PERI_GPIO_DB_CLK	26
> +#define STRATIX10_PERI_SDMMC_CLK	27
> +#define STRATIX10_PERI_S2F_USR0_CLK	28
> +#define STRATIX10_PERI_S2F_USR1_CLK	29
> +#define STRATIX10_PERI_PSI_REF_CLK	30
> +
> +#define STRATIX10_MPU_FREE_CLK		31
> +#define STRATIX10_NOC_FREE_CLK		32
> +#define STRATIX10_S2F_USR0_CLK		33
> +#define STRATIX10_NOC_CLK		34
> +#define STRATIX10_EMAC_A_FREE_CLK	35
> +#define STRATIX10_EMAC_B_FREE_CLK	36
> +#define STRATIX10_EMAC_PTP_FREE_CLK	37
> +#define STRATIX10_GPIO_DB_FREE_CLK	38
> +#define STRATIX10_SDMMC_FREE_CLK	39
> +#define STRATIX10_S2F_USER1_FREE_CLK	40
> +#define STRATIX10_PSI_REF_FREE_CLK	41
> +
> +/* Gate clocks */
> +#define STRATIX10_MPU_CLK		42
> +#define STRATIX10_L4_MAIN_CLK		43
> +#define	STRATIX10_L4_MP_CLK		44
> +#define STRATIX10_L4_SP_CLK		45
> +#define STRATIX10_CS_AT_CLK		46
> +#define STRATIX10_CS_TRACE_CLK		47
> +#define STRATIX10_CS_PDBG_CLK		48
> +#define STRATIX10_CS_TIMER_CLK		49
> +#define STRATIX10_S2F_USER0_CLK		50
> +#define STRATIX10_S2F_USER1_CLK		51
> +#define STRATIX10_EMAC0_CLK		52
> +#define STRATIX10_EMAC1_CLK		53
> +#define STRATIX10_EMAC2_CLK		54
> +#define STRATIX10_EMAC_PTP_CLK		55
> +#define STRATIX10_GPIO_DB_CLK		56
> +#define STRATIX10_SDMMC_CLK		57
> +#define STRATIX10_PSI_REF_CLK		58
> +#define STRATIX10_USB_CLK		59
> +#define STRATIX10_SPI_M_CLK		60
> +#define STRATIX10_NAND_CLK		61
> +#define STRATIX10_NUM_CLKS		62
> +
> +#endif	/* __STRATIX10_CLOCK_H */
> -- 
> 1.7.1
> 
