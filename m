From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 30 Aug 2016 08:42:15 +0200
Subject: [PATCH] ARM: dts: exynos: Add entries for sound support on
 Odroid-XU board
In-Reply-To: <1471883654-2113-1-git-send-email-s.nawrocki@samsung.com>
References: <1471883654-2113-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <05c45777-732b-3701-36dc-2448003acd50@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/2016 06:34 PM, Sylwester Nawrocki wrote:
> This patch adds device nodes for the AUDSS clock controller,
> peripheral DMA 0/1 controllers and the Audio Subsystem I2S controller.
> These entries are required for sound support on Odroid-XU board.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> This patch depends on a patch adding clock ID macro definitions.
> I'm going to provide a topic branch containing required changes.
> ---
>  arch/arm/boot/dts/exynos5410-odroidxu.dts | 70 +++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5410-pinctrl.dtsi |  9 ++++
>  arch/arm/boot/dts/exynos5410.dtsi         | 59 ++++++++++++++++++++++++++
>  3 files changed, 138 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
> index d949931..91dd8e7 100644
> --- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
> +++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
> @@ -15,6 +15,7 @@
>  #include <dt-bindings/clock/maxim,max77802.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/sound/samsung-i2s.h>
>  #include "exynos54xx-odroidxu-leds.dtsi"
>  
>  / {
> @@ -56,6 +57,62 @@
>  		compatible = "samsung,secure-firmware";
>  		reg = <0x02073000 0x1000>;
>  	};
> +
> +	sound: sound {
> +		compatible = "simple-audio-card";
> +
> +		simple-audio-card,name = "Odroid-XU";

Except the name and assigned clocks, this looks the same as
exynos5422-odroidxu3-audio.dtsi. How about combining them? The name
could be the same and the assigned-clocks maybe have to be applied to
XU3 as well?


> +		simple-audio-card,widgets =
> +			"Headphone", "Headphone Jack",
> +			"Speakers", "Speakers";
> +		simple-audio-card,routing =
> +			"Headphone Jack", "HPL",
> +			"Headphone Jack", "HPR",
> +			"Headphone Jack", "MICBIAS",
> +			"IN1", "Headphone Jack",
> +			"Speakers", "SPKL",
> +			"Speakers", "SPKR";
> +
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,bitclock-master = <&link0_codec>;
> +		simple-audio-card,frame-master = <&link0_codec>;
> +
> +		assigned-clocks = <&clock_audss EXYNOS_MOUT_AUDSS>,
> +				<&clock_audss EXYNOS_MOUT_I2S>,
> +				<&clock_audss EXYNOS_DOUT_SRP>,
> +				<&clock_audss EXYNOS_DOUT_AUD_BUS>;
> +
> +		assigned-clock-parents = <&clock CLK_FOUT_EPLL>,
> +				<&clock_audss EXYNOS_MOUT_AUDSS>;
> +
> +		assigned-clock-rates =  <0>,
> +					<0>,
> +					<96000000>,
> +					<19200000>;
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&audi2s0 0>;
> +			system-clock-frequency = <19200000>;
> +		};
> +
> +		link0_codec: simple-audio-card,codec {
> +			sound-dai = <&max98090>;
> +			clocks = <&audi2s0 CLK_I2S_CDCLK>;
> +		};
> +	};
> +};
> +
> +&audi2s0 {
> +	status = "okay";
> +};
> +
> +&clock {
> +       clocks = <&fin_pll>;

I dig into it and I have some questions:
1. Missing clock-names?
2. What code parses it?
3. Don't we need it also for other SoC/boards?

> +};
> +
> +&clock_audss {
> +	assigned-clocks = <&clock CLK_FOUT_EPLL>;
> +	assigned-clock-rates = <192000000>;
>  };
>  
>  &cpu0_thermal {
> @@ -439,6 +496,19 @@
>  	};
>  };
>  
> +&i2c_1 {
> +	status = "okay";
> +	max98090: max98090 at 10 {
> +		compatible = "maxim,max98090";
> +		reg = <0x10>;
> +		interrupt-parent = <&gpj3>;
> +		interrupts = <0 0>;
IRQ_TYPE_NONE
> +		clocks = <&audi2s0 CLK_I2S_CDCLK>;
> +		clock-names = "mclk";
> +		#sound-dai-cells = <0>;
> +	};
> +};
> +
>  &mmc_0 {
>  	status = "okay";
>  	mmc-pwrseq = <&emmc_pwrseq>;
> diff --git a/arch/arm/boot/dts/exynos5410-pinctrl.dtsi b/arch/arm/boot/dts/exynos5410-pinctrl.dtsi
> index b58a0f2..31f08a3 100644
> --- a/arch/arm/boot/dts/exynos5410-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/exynos5410-pinctrl.dtsi
> @@ -613,4 +613,13 @@
>  		interrupt-controller;
>  		#interrupt-cells = <2>;
>  	};
> +
> +	audi2s0_bus: audi2s0-bus {
> +		samsung,pins = "gpz-0", "gpz-1", "gpz-2", "gpz-3",
> +				"gpz-4";
> +		samsung,pin-function = <2>;
> +		samsung,pin-pud = <0>;
> +		samsung,pin-drv = <0>;
> +	};
> +
>  };
> diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
> index 137f484..7a4cc0f 100644
> --- a/arch/arm/boot/dts/exynos5410.dtsi
> +++ b/arch/arm/boot/dts/exynos5410.dtsi
> @@ -16,6 +16,7 @@
>  #include "exynos54xx.dtsi"
>  #include "exynos-syscon-restart.dtsi"
>  #include <dt-bindings/clock/exynos5410.h>
> +#include <dt-bindings/clock/exynos-audss-clk.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  
>  / {
> @@ -82,6 +83,14 @@
>  			#clock-cells = <1>;
>  		};
>  
> +		clock_audss: audss-clock-controller at 3810000 {
> +			compatible = "samsung,exynos5410-audss-clock";
> +			reg = <0x03810000 0x0C>;
> +			#clock-cells = <1>;
> +			clocks = <&fin_pll>, <&clock CLK_FOUT_EPLL>;
> +			clock-names = "pll_ref", "pll_in";
> +		};
> +
>  		tmu_cpu0: tmu at 10060000 {
>  			compatible = "samsung,exynos5420-tmu";
>  			reg = <0x10060000 0x100>;
> @@ -183,6 +192,56 @@
>  			reg = <0x03860000 0x1000>;
>  			interrupts = <0 47 0>;
>  		};
> +
> +		amba {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "simple-bus";
> +			interrupt-parent = <&gic>;
> +			ranges;
> +
> +			pdma0: pdma at 12680000 {
> +				compatible = "arm,pl330", "arm,primecell";
> +				reg = <0x121A0000 0x1000>;
> +				interrupts = <0 34 0>;

Could you switch to symbols for IRQ entry? So that would be GIC_SPI and
TYPE_NONE.

> +				clocks = <&clock CLK_PDMA0>;
> +				clock-names = "apb_pclk";
> +				#dma-cells = <1>;
> +				#dma-channels = <8>;
> +				#dma-requests = <32>;
> +			};
> +
> +			pdma1: pdma at 12690000 {
> +				compatible = "arm,pl330", "arm,primecell";
> +				reg = <0x121B0000 0x1000>;
> +				interrupts = <0 35 0>;

Ditto

Best regards,
Krzysztof

> +				clocks = <&clock CLK_PDMA1>;
> +				clock-names = "apb_pclk";
> +				#dma-cells = <1>;
> +				#dma-channels = <8>;
> +				#dma-requests = <32>;
> +			};
> +		};
> +
> +		audi2s0: i2s at 03830000 {
> +			compatible = "samsung,exynos5420-i2s";
> +			reg = <0x03830000 0x100>;
> +			dmas = <&pdma0 10
> +				&pdma0 9
> +				&pdma0 8>;
> +			dma-names = "tx", "rx", "tx-sec";
> +			clocks = <&clock_audss EXYNOS_I2S_BUS>,
> +				<&clock_audss EXYNOS_I2S_BUS>,
> +				<&clock_audss EXYNOS_SCLK_I2S>;
> +			clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
> +			#clock-cells = <1>;
> +			clock-output-names = "i2s_cdclk0";
> +			#sound-dai-cells = <1>;
> +			samsung,idma-addr = <0x03000000>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&audi2s0_bus>;
> +			status = "disabled";
> +		};
>  	};
>  
>  	thermal-zones {
> 
