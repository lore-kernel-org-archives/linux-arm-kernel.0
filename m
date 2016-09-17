From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Sat, 17 Sep 2016 17:06:08 +0530
Subject: [RFT] arm64 dts: exynos: Fix invalid GIC interrupt flags in
 exynos7
In-Reply-To: <1474056073-8071-1-git-send-email-krzk@kernel.org>
References: <1474056073-8071-1-git-send-email-krzk@kernel.org>
 <CGME20160917113730epcas3p42e26e92f5e72fa42e89967798dbbbecf@epcas3p4.samsung.com>
Message-ID: <57DD2AA8.9060507@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 09/17/2016 01:31 AM, Krzysztof Kozlowski wrote:
> Interrupt of type IRQ_TYPE_NONE is not allowed for GIC interrupts and
> generates an error:
> 	genirq: Setting trigger mode 0 for irq 16 failed (gic_set_type+0x0/0x68)
>
> The GIC requires shared interrupts to be edge rising or level high.
> Platform declares support for both.  Choose level high everywhere.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reported-by: Alban Browaeys <alban.browaeys@gmail.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

This patch does resolve the error reported in commit.
Have booted on exynos7 board, things looks fine (have not done a 
extensive testing though).
With the _Typo_ fixed as pointed by you, feel free to add

Tested-by: Alim Akhtar <alim.akhtar@samsung.com>

On another note, please cc me if case you want to check/verify something 
on exynos7 platform. I almost missed this patch.

Thanks.

>   arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi | 20 +++++--
>   arch/arm64/boot/dts/exynos/exynos7.dtsi         | 69 +++++++++++++------------
>   2 files changed, 51 insertions(+), 38 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
> index f77ddaf21d04..983c63ba38c8 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
> @@ -20,8 +20,14 @@
>   		interrupt-controller;
>   		interrupt-parent = <&gic>;
>   		#interrupt-cells = <2>;
> -		interrupts = <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
> -			     <0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>;
> +		interrupts = <0 0 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 1 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 2 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 3 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 4 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 5 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 6 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 7 IRQ_TYPE_LEVEL_HIGH>;
>   	};
>
>   	gpa1: gpa1 {
> @@ -31,8 +37,14 @@
>   		interrupt-controller;
>   		interrupt-parent = <&gic>;
>   		#interrupt-cells = <2>;
> -		interrupts = <0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
> -			     <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>;
> +		interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 9 IRQ_TYPE_LEVEL_HIGH>
> +			     <0 10 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 11 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 12 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 13 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 14 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 15 IRQ_TYPE_LEVEL_HIGH>;
>   	};
>
>   	gpa2: gpa2 {
> diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
> index 6328a66ed97e..0a80dabfbe95 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
> @@ -106,7 +106,7 @@
>   			pdma0: pdma at 10E10000 {
>   				compatible = "arm,pl330", "arm,primecell";
>   				reg = <0x10E10000 0x1000>;
> -				interrupts = <0 225 0>;
> +				interrupts = <0 225 IRQ_TYPE_LEVEL_HIGH>;
>   				clocks = <&clock_fsys0 ACLK_PDMA0>;
>   				clock-names = "apb_pclk";
>   				#dma-cells = <1>;
> @@ -117,7 +117,7 @@
>   			pdma1: pdma at 10EB0000 {
>   				compatible = "arm,pl330", "arm,primecell";
>   				reg = <0x10EB0000 0x1000>;
> -				interrupts = <0 226 0>;
> +				interrupts = <0 226 IRQ_TYPE_LEVEL_HIGH>;
>   				clocks = <&clock_fsys0 ACLK_PDMA1>;
>   				clock-names = "apb_pclk";
>   				#dma-cells = <1>;
> @@ -220,7 +220,7 @@
>   		serial_0: serial at 13630000 {
>   			compatible = "samsung,exynos4210-uart";
>   			reg = <0x13630000 0x100>;
> -			interrupts = <0 440 0>;
> +			interrupts = <0 440 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&clock_peric0 PCLK_UART0>,
>   				 <&clock_peric0 SCLK_UART0>;
>   			clock-names = "uart", "clk_uart_baud0";
> @@ -230,7 +230,7 @@
>   		serial_1: serial at 14c20000 {
>   			compatible = "samsung,exynos4210-uart";
>   			reg = <0x14c20000 0x100>;
> -			interrupts = <0 456 0>;
> +			interrupts = <0 456 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&clock_peric1 PCLK_UART1>,
>   				 <&clock_peric1 SCLK_UART1>;
>   			clock-names = "uart", "clk_uart_baud0";
> @@ -240,7 +240,7 @@
>   		serial_2: serial at 14c30000 {
>   			compatible = "samsung,exynos4210-uart";
>   			reg = <0x14c30000 0x100>;
> -			interrupts = <0 457 0>;
> +			interrupts = <0 457 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&clock_peric1 PCLK_UART2>,
>   				 <&clock_peric1 SCLK_UART2>;
>   			clock-names = "uart", "clk_uart_baud0";
> @@ -250,7 +250,7 @@
>   		serial_3: serial at 14c40000 {
>   			compatible = "samsung,exynos4210-uart";
>   			reg = <0x14c40000 0x100>;
> -			interrupts = <0 458 0>;
> +			interrupts = <0 458 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&clock_peric1 PCLK_UART3>,
>   				 <&clock_peric1 SCLK_UART3>;
>   			clock-names = "uart", "clk_uart_baud0";
> @@ -264,62 +264,62 @@
>   			wakeup-interrupt-controller {
>   				compatible = "samsung,exynos7-wakeup-eint";
>   				interrupt-parent = <&gic>;
> -				interrupts = <0 16 0>;
> +				interrupts = <0 16 IRQ_TYPE_LEVEL_HIGH>;
>   			};
>   		};
>
>   		pinctrl_bus0: pinctrl at 13470000 {
>   			compatible = "samsung,exynos7-pinctrl";
>   			reg = <0x13470000 0x1000>;
> -			interrupts = <0 383 0>;
> +			interrupts = <0 383 IRQ_TYPE_LEVEL_HIGH>;
>   		};
>
>   		pinctrl_nfc: pinctrl at 14cd0000 {
>   			compatible = "samsung,exynos7-pinctrl";
>   			reg = <0x14cd0000 0x1000>;
> -			interrupts = <0 473 0>;
> +			interrupts = <0 473 IRQ_TYPE_LEVEL_HIGH>;
>   		};
>
>   		pinctrl_touch: pinctrl at 14ce0000 {
>   			compatible = "samsung,exynos7-pinctrl";
>   			reg = <0x14ce0000 0x1000>;
> -			interrupts = <0 474 0>;
> +			interrupts = <0 474 IRQ_TYPE_LEVEL_HIGH>;
>   		};
>
>   		pinctrl_ff: pinctrl at 14c90000 {
>   			compatible = "samsung,exynos7-pinctrl";
>   			reg = <0x14c90000 0x1000>;
> -			interrupts = <0 475 0>;
> +			interrupts = <0 475 IRQ_TYPE_LEVEL_HIGH>;
>   		};
>
>   		pinctrl_ese: pinctrl at 14ca0000 {
>   			compatible = "samsung,exynos7-pinctrl";
>   			reg = <0x14ca0000 0x1000>;
> -			interrupts = <0 476 0>;
> +			interrupts = <0 476 IRQ_TYPE_LEVEL_HIGH>;
>   		};
>
>   		pinctrl_fsys0: pinctrl at 10e60000 {
>   			compatible = "samsung,exynos7-pinctrl";
>   			reg = <0x10e60000 0x1000>;
> -			interrupts = <0 221 0>;
> +			interrupts = <0 221 IRQ_TYPE_LEVEL_HIGH>;
>   		};
>
>   		pinctrl_fsys1: pinctrl at 15690000 {
>   			compatible = "samsung,exynos7-pinctrl";
>   			reg = <0x15690000 0x1000>;
> -			interrupts = <0 203 0>;
> +			interrupts = <0 203 IRQ_TYPE_LEVEL_HIGH>;
>   		};
>
>   		pinctrl_bus1: pinctrl at 14870000 {
>   			compatible = "samsung,exynos7-pinctrl";
>   			reg = <0x14870000 0x1000>;
> -			interrupts = <0 384 0>;
> +			interrupts = <0 384 IRQ_TYPE_LEVEL_HIGH>;
>   		};
>
>   		hsi2c_0: hsi2c at 13640000 {
>   			compatible = "samsung,exynos7-hsi2c";
>   			reg = <0x13640000 0x1000>;
> -			interrupts = <0 441 0>;
> +			interrupts = <0 441 IRQ_TYPE_LEVEL_HIGH>;
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			pinctrl-names = "default";
> @@ -332,7 +332,7 @@
>   		hsi2c_1: hsi2c at 13650000 {
>   			compatible = "samsung,exynos7-hsi2c";
>   			reg = <0x13650000 0x1000>;
> -			interrupts = <0 442 0>;
> +			interrupts = <0 442 IRQ_TYPE_LEVEL_HIGH>;
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			pinctrl-names = "default";
> @@ -345,7 +345,7 @@
>   		hsi2c_2: hsi2c at 14e60000 {
>   			compatible = "samsung,exynos7-hsi2c";
>   			reg = <0x14e60000 0x1000>;
> -			interrupts = <0 459 0>;
> +			interrupts = <0 459 IRQ_TYPE_LEVEL_HIGH>;
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			pinctrl-names = "default";
> @@ -358,7 +358,7 @@
>   		hsi2c_3: hsi2c at 14e70000 {
>   			compatible = "samsung,exynos7-hsi2c";
>   			reg = <0x14e70000 0x1000>;
> -			interrupts = <0 460 0>;
> +			interrupts = <0 460 IRQ_TYPE_LEVEL_HIGH>;
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			pinctrl-names = "default";
> @@ -371,7 +371,7 @@
>   		hsi2c_4: hsi2c at 13660000 {
>   			compatible = "samsung,exynos7-hsi2c";
>   			reg = <0x13660000 0x1000>;
> -			interrupts = <0 443 0>;
> +			interrupts = <0 443 IRQ_TYPE_LEVEL_HIGH>;
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			pinctrl-names = "default";
> @@ -384,7 +384,7 @@
>   		hsi2c_5: hsi2c at 13670000 {
>   			compatible = "samsung,exynos7-hsi2c";
>   			reg = <0x13670000 0x1000>;
> -			interrupts = <0 444 0>;
> +			interrupts = <0 444 IRQ_TYPE_LEVEL_HIGH>;
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			pinctrl-names = "default";
> @@ -397,7 +397,7 @@
>   		hsi2c_6: hsi2c at 14e00000 {
>   			compatible = "samsung,exynos7-hsi2c";
>   			reg = <0x14e00000 0x1000>;
> -			interrupts = <0 461 0>;
> +			interrupts = <0 461 IRQ_TYPE_LEVEL_HIGH>;
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			pinctrl-names = "default";
> @@ -410,7 +410,7 @@
>   		hsi2c_7: hsi2c at 13e10000 {
>   			compatible = "samsung,exynos7-hsi2c";
>   			reg = <0x13e10000 0x1000>;
> -			interrupts = <0 462 0>;
> +			interrupts = <0 462 IRQ_TYPE_LEVEL_HIGH>;
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			pinctrl-names = "default";
> @@ -423,7 +423,7 @@
>   		hsi2c_8: hsi2c at 14e20000 {
>   			compatible = "samsung,exynos7-hsi2c";
>   			reg = <0x14e20000 0x1000>;
> -			interrupts = <0 463 0>;
> +			interrupts = <0 463 IRQ_TYPE_LEVEL_HIGH>;
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			pinctrl-names = "default";
> @@ -436,7 +436,7 @@
>   		hsi2c_9: hsi2c at 13680000 {
>   			compatible = "samsung,exynos7-hsi2c";
>   			reg = <0x13680000 0x1000>;
> -			interrupts = <0 445 0>;
> +			interrupts = <0 445 IRQ_TYPE_LEVEL_HIGH>;
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			pinctrl-names = "default";
> @@ -449,7 +449,7 @@
>   		hsi2c_10: hsi2c at 13690000 {
>   			compatible = "samsung,exynos7-hsi2c";
>   			reg = <0x13690000 0x1000>;
> -			interrupts = <0 446 0>;
> +			interrupts = <0 446 IRQ_TYPE_LEVEL_HIGH>;
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			pinctrl-names = "default";
> @@ -462,7 +462,7 @@
>   		hsi2c_11: hsi2c at 136a0000 {
>   			compatible = "samsung,exynos7-hsi2c";
>   			reg = <0x136a0000 0x1000>;
> -			interrupts = <0 447 0>;
> +			interrupts = <0 447 IRQ_TYPE_LEVEL_HIGH>;
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			pinctrl-names = "default";
> @@ -499,7 +499,8 @@
>   		rtc: rtc at 10590000 {
>   			compatible = "samsung,s3c6410-rtc";
>   			reg = <0x10590000 0x100>;
> -			interrupts = <0 355 0>, <0 356 0>;
> +			interrupts = <0 355 IRQ_TYPE_LEVEL_HIGH>,
> +				     <0 356 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&clock_ccore PCLK_RTC>;
>   			clock-names = "rtc";
>   			status = "disabled";
> @@ -508,7 +509,7 @@
>   		watchdog: watchdog at 101d0000 {
>   			compatible = "samsung,exynos7-wdt";
>   			reg = <0x101d0000 0x100>;
> -			interrupts = <0 110 0>;
> +			interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&clock_peris PCLK_WDT>;
>   			clock-names = "watchdog";
>   			samsung,syscon-phandle = <&pmu_system_controller>;
> @@ -517,7 +518,7 @@
>
>   		mmc_0: mmc at 15740000 {
>   			compatible = "samsung,exynos7-dw-mshc-smu";
> -			interrupts = <0 201 0>;
> +			interrupts = <0 201 IRQ_TYPE_LEVEL_HIGH>;
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			reg = <0x15740000 0x2000>;
> @@ -530,7 +531,7 @@
>
>   		mmc_1: mmc at 15750000 {
>   			compatible = "samsung,exynos7-dw-mshc";
> -			interrupts = <0 202 0>;
> +			interrupts = <0 202 IRQ_TYPE_LEVEL_HIGH>;
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			reg = <0x15750000 0x2000>;
> @@ -543,7 +544,7 @@
>
>   		mmc_2: mmc at 15560000 {
>   			compatible = "samsung,exynos7-dw-mshc-smu";
> -			interrupts = <0 216 0>;
> +			interrupts = <0 216 IRQ_TYPE_LEVEL_HIGH>;
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			reg = <0x15560000 0x2000>;
> @@ -557,7 +558,7 @@
>   		adc: adc at 13620000 {
>   			compatible = "samsung,exynos7-adc";
>   			reg = <0x13620000 0x100>;
> -			interrupts = <0 448 0>;
> +			interrupts = <0 448 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&clock_peric0 PCLK_ADCIF>;
>   			clock-names = "adc";
>   			#io-channel-cells = <1>;
> @@ -577,7 +578,7 @@
>   		tmuctrl_0: tmu at 10060000 {
>   			compatible = "samsung,exynos7-tmu";
>   			reg = <0x10060000 0x200>;
> -			interrupts = <0 108 0>;
> +			interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&clock_peris PCLK_TMU>,
>   				 <&clock_peris SCLK_TMU>;
>   			clock-names = "tmu_apbif", "tmu_sclk";
>
