From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 10 Jan 2017 11:14:30 +0100
Subject: [PATCH 3/4] ARM: dts: stm32: stm32f7: Enable clocks for STM32F746
 boards
In-Reply-To: <1483711165-17149-4-git-send-email-gabriel.fernandez@st.com>
References: <1483711165-17149-1-git-send-email-gabriel.fernandez@st.com>
 <1483711165-17149-4-git-send-email-gabriel.fernandez@st.com>
Message-ID: <2c699f28-f554-e48a-34a0-e356f0bf7e2c@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gabriel

On 01/06/2017 02:59 PM, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>
> This patch enables clocks for STM32F746 boards.
>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---

In commit header, "stm32f7" is not usefull.


>  arch/arm/boot/dts/stm32f746.dtsi | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
> index f321ffe..e05e131 100644
> --- a/arch/arm/boot/dts/stm32f746.dtsi
> +++ b/arch/arm/boot/dts/stm32f746.dtsi
> @@ -43,6 +43,7 @@
>  #include "skeleton.dtsi"
>  #include "armv7-m.dtsi"
>  #include <dt-bindings/pinctrl/stm32f746-pinfunc.h>
> +#include <dt-bindings/clock/stm32fx-clock.h>

This patch depends on another series not yet merged (maybe "[PATCH-next 
... is a better header ?

>
>  / {
>  	clocks {
> @@ -51,6 +52,24 @@
>  			compatible = "fixed-clock";
>  			clock-frequency = <0>;
>  		};
> +
> +		clk-lse {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <32768>;
> +		};
> +
> +		clk-lsi {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <32000>;
> +		};
> +
> +		clk_i2s_ckin: clk-i2s-ckin {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <48000000>;
> +		};
>  	};
>
>  	soc {
> @@ -178,6 +197,11 @@
>  			interrupts = <1>, <2>, <3>, <6>, <7>, <8>, <9>, <10>, <23>, <40>, <41>, <42>, <62>, <76>;
>  		};
>
> +		pwrcfg: power-config at 40007000 {
> +			compatible = "syscon";
> +			reg = <0x40007000 0x400>;
> +		};
> +
>  		pin-controller {
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> @@ -291,9 +315,10 @@
>
>  		rcc: rcc at 40023800 {
>  			#clock-cells = <2>;
> -			compatible = "st,stm32f42xx-rcc", "st,stm32-rcc";
> +			compatible = "st,stm32f746-rcc", "st,stm32-rcc";
>  			reg = <0x40023800 0x400>;
> -			clocks = <&clk_hse>;
> +			clocks = <&clk_hse>, <&clk_i2s_ckin>;
> +			st,syscfg = <&pwrcfg>;
>  		};
>  	};
>  };
>
