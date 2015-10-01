From: lee@kernel.org (Lee Jones)
Date: Thu, 1 Oct 2015 13:25:55 +0100
Subject: [PATCH v3 4/4] ARM: bcm2835: Switch to using the new clock
 driver support.
In-Reply-To: <1443475325-22270-4-git-send-email-eric@anholt.net>
References: <1443475325-22270-1-git-send-email-eric@anholt.net>
 <1443475325-22270-4-git-send-email-eric@anholt.net>
Message-ID: <20151001122555.GV3214@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Sep 2015, Eric Anholt wrote:

> This will give us the ability to set the pixel and HDMI state machine
> clocks for the VC4 KMS driver, change the CPU frequency, and
> potentially gate clocks in the future (once we also write a power
> domain driver).  It also gives the uart an explicit clock reference,
> so that we don't need to change the physical addresses of the old
> fixed clk_bcm2835.c clocks for Raspberry Pi 2 port.
> 
> Two clocks get their frequencies updated as a result of this.  One is
> uart's apb_pclk, which was previously accidentally grabbing the fixed
> uart0_pclk due to the apb_pclk not having clk_register_clkdev()
> called.  The uart doesn't seem to do anything with apb_pclk other than
> make sure it's on, so that appears safe (also, as far as I can see,
> the apb clock is actually the same as the VPU clock).  The other is
> EMMC, which according to the docs was supposed to be in the 50-100Mhz
> range, but it turns out the firmware needed to change to running it at
> the 250Mhz core clock speed to avoid a bug in clock domain crossing.
> 
> Additionally, anything using BCM2835_CLOCK_VPU will now have a correct
> clock rate if the user configures the boot-time core clock speed using
> config.txt.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
> ---
>  arch/arm/boot/dts/bcm2835.dtsi | 52 +++++++++++++++++++++++-------------------
>  1 file changed, 28 insertions(+), 24 deletions(-)

Couple of small nits.

> diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
> index 301c73f..a6a55b7 100644
> --- a/arch/arm/boot/dts/bcm2835.dtsi
> +++ b/arch/arm/boot/dts/bcm2835.dtsi
> @@ -1,4 +1,5 @@
>  #include <dt-bindings/pinctrl/bcm2835.h>
> +#include <dt-bindings/clock/bcm2835.h>
>  #include "skeleton.dtsi"
>  
>  / {
> @@ -21,6 +22,10 @@
>  			compatible = "brcm,bcm2835-system-timer";
>  			reg = <0x7e003000 0x1000>;
>  			interrupts = <1 0>, <1 1>, <1 2>, <1 3>;
> +			/* This could be a reference to BCM2835_CLOCK_TIMER,
> +			 * but we don't have the driver using the common clock
> +			 * support yet.
> +			 */

Nit: Please use correct multi-line comment formatting.

>From Documentation/CodingStyle:

/*
 * This is the preferred style for multi-line
 * comments in the Linux kernel source code.
 * Please use it consistently.
 *
 * Description:  A column of asterisks on the left side,
 * with beginning and ending almost-blank lines.
 */

>  			clock-frequency = <1000000>;
>  		};
>  
> @@ -57,6 +62,17 @@
>  			reg = <0x7e100000 0x28>;
>  		};
>  
> +		clocks: cprman at 7e101000 {
> +			compatible = "brcm,bcm2835-cprman";
> +			#clock-cells = <1>;
> +			reg = <0x7e101000 0x2000>;
> +
> +			/* CPRMAN derives everything from the platform's
> +			 * oscillator.
> +			 */

As above.

> +			clocks = <&clk_osc>;
> +		};
> +
>  		rng at 7e104000 {
>  			compatible = "brcm,bcm2835-rng";
>  			reg = <0x7e104000 0x10>;
> @@ -96,7 +112,9 @@
>  			compatible = "brcm,bcm2835-pl011", "arm,pl011", "arm,primecell";
>  			reg = <0x7e201000 0x1000>;
>  			interrupts = <2 25>;
> -			clock-frequency = <3000000>;
> +			clocks = <&clocks BCM2835_CLOCK_UART>,
> +				 <&clocks BCM2835_CLOCK_VPU>;
> +			clock-names = "uartclk", "apb_pclk";
>  			arm,primecell-periphid = <0x00241011>;
>  		};
>  
> @@ -115,7 +133,7 @@
>  			compatible = "brcm,bcm2835-spi";
>  			reg = <0x7e204000 0x1000>;
>  			interrupts = <2 22>;
> -			clocks = <&clk_spi>;
> +			clocks = <&clocks BCM2835_CLOCK_VPU>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			status = "disabled";
> @@ -125,7 +143,7 @@
>  			compatible = "brcm,bcm2835-i2c";
>  			reg = <0x7e205000 0x1000>;
>  			interrupts = <2 21>;
> -			clocks = <&clk_i2c>;
> +			clocks = <&clocks BCM2835_CLOCK_VPU>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			status = "disabled";
> @@ -135,7 +153,7 @@
>  			compatible = "brcm,bcm2835-sdhci";
>  			reg = <0x7e300000 0x100>;
>  			interrupts = <2 30>;
> -			clocks = <&clk_mmc>;
> +			clocks = <&clocks BCM2835_CLOCK_EMMC>;
>  			status = "disabled";
>  		};
>  
> @@ -143,7 +161,7 @@
>  			compatible = "brcm,bcm2835-i2c";
>  			reg = <0x7e804000 0x1000>;
>  			interrupts = <2 21>;
> -			clocks = <&clk_i2c>;
> +			clocks = <&clocks BCM2835_CLOCK_VPU>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			status = "disabled";
> @@ -165,28 +183,14 @@
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> -		clk_mmc: clock at 0 {
> -			compatible = "fixed-clock";
> -			reg = <0>;
> -			#clock-cells = <0>;
> -			clock-output-names = "mmc";
> -			clock-frequency = <100000000>;
> -		};
> -
> -		clk_i2c: clock at 1 {
> +		/* The oscillator is the root of the clock tree. */
> +		clk_osc: clock at 3 {
>  			compatible = "fixed-clock";
> -			reg = <1>;
> +			reg = <3>;
>  			#clock-cells = <0>;
> -			clock-output-names = "i2c";
> -			clock-frequency = <250000000>;
> +			clock-output-names = "osc";
> +			clock-frequency = <19200000>;
>  		};
>  
> -		clk_spi: clock at 2 {
> -			compatible = "fixed-clock";
> -			reg = <2>;
> -			#clock-cells = <0>;
> -			clock-output-names = "spi";
> -			clock-frequency = <250000000>;
> -		};
>  	};
>  };
