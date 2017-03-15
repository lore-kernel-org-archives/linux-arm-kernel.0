From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 15 Mar 2017 11:23:09 +0000
Subject: [Resend PATCH 4/4] dt-bindings: mfd: Add STM32F7 RCC numeric
 constants into DT include file
In-Reply-To: <1489066231-4627-1-git-send-email-gabriel.fernandez@st.com>
References: <1489066231-4627-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20170315112309.xkw2hpwqthy5ia2v@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 09 Mar 2017, gabriel.fernandez at st.com wrote:

> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch lists STM32F7's RCC numeric constants.
> It will be used by clock and reset drivers, and DT bindings.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  arch/arm/boot/dts/stm32f746.dtsi      |  51 ++++++++--------

>  include/dt-bindings/mfd/stm32f7-rcc.h | 112 ++++++++++++++++++++++++++++++++++

For the MFD changes:

Acked-by: Lee Jones <lee.jones@linaro.org>

>  2 files changed, 138 insertions(+), 25 deletions(-)
>  create mode 100644 include/dt-bindings/mfd/stm32f7-rcc.h
> 
> diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
> index e05e131..09d6649 100644
> --- a/arch/arm/boot/dts/stm32f746.dtsi
> +++ b/arch/arm/boot/dts/stm32f746.dtsi
> @@ -44,6 +44,7 @@
>  #include "armv7-m.dtsi"
>  #include <dt-bindings/pinctrl/stm32f746-pinfunc.h>
>  #include <dt-bindings/clock/stm32fx-clock.h>
> +#include <dt-bindings/mfd/stm32f7-rcc.h>
>  
>  / {
>  	clocks {
> @@ -77,7 +78,7 @@
>  			compatible = "st,stm32-timer";
>  			reg = <0x40000000 0x400>;
>  			interrupts = <28>;
> -			clocks = <&rcc 0 128>;
> +			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM2)>;
>  			status = "disabled";
>  		};
>  
> @@ -85,7 +86,7 @@
>  			compatible = "st,stm32-timer";
>  			reg = <0x40000400 0x400>;
>  			interrupts = <29>;
> -			clocks = <&rcc 0 129>;
> +			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM3)>;
>  			status = "disabled";
>  		};
>  
> @@ -93,7 +94,7 @@
>  			compatible = "st,stm32-timer";
>  			reg = <0x40000800 0x400>;
>  			interrupts = <30>;
> -			clocks = <&rcc 0 130>;
> +			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM4)>;
>  			status = "disabled";
>  		};
>  
> @@ -101,14 +102,14 @@
>  			compatible = "st,stm32-timer";
>  			reg = <0x40000c00 0x400>;
>  			interrupts = <50>;
> -			clocks = <&rcc 0 131>;
> +			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM5)>;
>  		};
>  
>  		timer6: timer at 40001000 {
>  			compatible = "st,stm32-timer";
>  			reg = <0x40001000 0x400>;
>  			interrupts = <54>;
> -			clocks = <&rcc 0 132>;
> +			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM6)>;
>  			status = "disabled";
>  		};
>  
> @@ -116,7 +117,7 @@
>  			compatible = "st,stm32-timer";
>  			reg = <0x40001400 0x400>;
>  			interrupts = <55>;
> -			clocks = <&rcc 0 133>;
> +			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM7)>;
>  			status = "disabled";
>  		};
>  
> @@ -124,7 +125,7 @@
>  			compatible = "st,stm32f7-usart", "st,stm32f7-uart";
>  			reg = <0x40004400 0x400>;
>  			interrupts = <38>;
> -			clocks =  <&rcc 0 145>;
> +			clocks = <&rcc 1 CLK_USART2>;
>  			status = "disabled";
>  		};
>  
> @@ -132,7 +133,7 @@
>  			compatible = "st,stm32f7-usart", "st,stm32f7-uart";
>  			reg = <0x40004800 0x400>;
>  			interrupts = <39>;
> -			clocks = <&rcc 0 146>;
> +			clocks = <&rcc 1 CLK_USART3>;
>  			status = "disabled";
>  		};
>  
> @@ -140,7 +141,7 @@
>  			compatible = "st,stm32f7-uart";
>  			reg = <0x40004c00 0x400>;
>  			interrupts = <52>;
> -			clocks = <&rcc 0 147>;
> +			clocks = <&rcc 1 CLK_UART4>;
>  			status = "disabled";
>  		};
>  
> @@ -148,7 +149,7 @@
>  			compatible = "st,stm32f7-uart";
>  			reg = <0x40005000 0x400>;
>  			interrupts = <53>;
> -			clocks = <&rcc 0 148>;
> +			clocks = <&rcc 1 CLK_UART5>;
>  			status = "disabled";
>  		};
>  
> @@ -156,7 +157,7 @@
>  			compatible = "st,stm32f7-usart", "st,stm32f7-uart";
>  			reg = <0x40007800 0x400>;
>  			interrupts = <82>;
> -			clocks = <&rcc 0 158>;
> +			clocks = <&rcc 1 CLK_UART7>;
>  			status = "disabled";
>  		};
>  
> @@ -164,7 +165,7 @@
>  			compatible = "st,stm32f7-usart", "st,stm32f7-uart";
>  			reg = <0x40007c00 0x400>;
>  			interrupts = <83>;
> -			clocks = <&rcc 0 159>;
> +			clocks = <&rcc 1 CLK_UART8>;
>  			status = "disabled";
>  		};
>  
> @@ -172,7 +173,7 @@
>  			compatible = "st,stm32f7-usart", "st,stm32f7-uart";
>  			reg = <0x40011000 0x400>;
>  			interrupts = <37>;
> -			clocks = <&rcc 0 164>;
> +			clocks = <&rcc 1 CLK_USART1>;
>  			status = "disabled";
>  		};
>  
> @@ -180,7 +181,7 @@
>  			compatible = "st,stm32f7-usart", "st,stm32f7-uart";
>  			reg = <0x40011400 0x400>;
>  			interrupts = <71>;
> -			clocks = <&rcc 0 165>;
> +			clocks = <&rcc 1 CLK_USART6>;
>  			status = "disabled";
>  		};
>  
> @@ -215,7 +216,7 @@
>  				gpio-controller;
>  				#gpio-cells = <2>;
>  				reg = <0x0 0x400>;
> -				clocks = <&rcc 0 256>;
> +				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOA)>;
>  				st,bank-name = "GPIOA";
>  			};
>  
> @@ -223,7 +224,7 @@
>  				gpio-controller;
>  				#gpio-cells = <2>;
>  				reg = <0x400 0x400>;
> -				clocks = <&rcc 0 257>;
> +				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOB)>;
>  				st,bank-name = "GPIOB";
>  			};
>  
> @@ -231,7 +232,7 @@
>  				gpio-controller;
>  				#gpio-cells = <2>;
>  				reg = <0x800 0x400>;
> -				clocks = <&rcc 0 258>;
> +				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOC)>;
>  				st,bank-name = "GPIOC";
>  			};
>  
> @@ -239,7 +240,7 @@
>  				gpio-controller;
>  				#gpio-cells = <2>;
>  				reg = <0xc00 0x400>;
> -				clocks = <&rcc 0 259>;
> +				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOD)>;
>  				st,bank-name = "GPIOD";
>  			};
>  
> @@ -247,7 +248,7 @@
>  				gpio-controller;
>  				#gpio-cells = <2>;
>  				reg = <0x1000 0x400>;
> -				clocks = <&rcc 0 260>;
> +				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOE)>;
>  				st,bank-name = "GPIOE";
>  			};
>  
> @@ -255,7 +256,7 @@
>  				gpio-controller;
>  				#gpio-cells = <2>;
>  				reg = <0x1400 0x400>;
> -				clocks = <&rcc 0 261>;
> +				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOF)>;
>  				st,bank-name = "GPIOF";
>  			};
>  
> @@ -263,7 +264,7 @@
>  				gpio-controller;
>  				#gpio-cells = <2>;
>  				reg = <0x1800 0x400>;
> -				clocks = <&rcc 0 262>;
> +				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOG)>;
>  				st,bank-name = "GPIOG";
>  			};
>  
> @@ -271,7 +272,7 @@
>  				gpio-controller;
>  				#gpio-cells = <2>;
>  				reg = <0x1c00 0x400>;
> -				clocks = <&rcc 0 263>;
> +				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOH)>;
>  				st,bank-name = "GPIOH";
>  			};
>  
> @@ -279,7 +280,7 @@
>  				gpio-controller;
>  				#gpio-cells = <2>;
>  				reg = <0x2000 0x400>;
> -				clocks = <&rcc 0 264>;
> +				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOI)>;
>  				st,bank-name = "GPIOI";
>  			};
>  
> @@ -287,7 +288,7 @@
>  				gpio-controller;
>  				#gpio-cells = <2>;
>  				reg = <0x2400 0x400>;
> -				clocks = <&rcc 0 265>;
> +				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOJ)>;
>  				st,bank-name = "GPIOJ";
>  			};
>  
> @@ -295,7 +296,7 @@
>  				gpio-controller;
>  				#gpio-cells = <2>;
>  				reg = <0x2800 0x400>;
> -				clocks = <&rcc 0 266>;
> +				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOK)>;
>  				st,bank-name = "GPIOK";
>  			};
>  
> diff --git a/include/dt-bindings/mfd/stm32f7-rcc.h b/include/dt-bindings/mfd/stm32f7-rcc.h
> new file mode 100644
> index 0000000..e36cc69
> --- /dev/null
> +++ b/include/dt-bindings/mfd/stm32f7-rcc.h
> @@ -0,0 +1,112 @@
> +/*
> + * This header provides constants for the STM32F7 RCC IP
> + */
> +
> +#ifndef _DT_BINDINGS_MFD_STM32F7_RCC_H
> +#define _DT_BINDINGS_MFD_STM32F7_RCC_H
> +
> +/* AHB1 */
> +#define STM32F7_RCC_AHB1_GPIOA		0
> +#define STM32F7_RCC_AHB1_GPIOB		1
> +#define STM32F7_RCC_AHB1_GPIOC		2
> +#define STM32F7_RCC_AHB1_GPIOD		3
> +#define STM32F7_RCC_AHB1_GPIOE		4
> +#define STM32F7_RCC_AHB1_GPIOF		5
> +#define STM32F7_RCC_AHB1_GPIOG		6
> +#define STM32F7_RCC_AHB1_GPIOH		7
> +#define STM32F7_RCC_AHB1_GPIOI		8
> +#define STM32F7_RCC_AHB1_GPIOJ		9
> +#define STM32F7_RCC_AHB1_GPIOK		10
> +#define STM32F7_RCC_AHB1_CRC		12
> +#define STM32F7_RCC_AHB1_BKPSRAM	18
> +#define STM32F7_RCC_AHB1_DTCMRAM	20
> +#define STM32F7_RCC_AHB1_DMA1		21
> +#define STM32F7_RCC_AHB1_DMA2		22
> +#define STM32F7_RCC_AHB1_DMA2D		23
> +#define STM32F7_RCC_AHB1_ETHMAC		25
> +#define STM32F7_RCC_AHB1_ETHMACTX	26
> +#define STM32F7_RCC_AHB1_ETHMACRX	27
> +#define STM32FF_RCC_AHB1_ETHMACPTP	28
> +#define STM32F7_RCC_AHB1_OTGHS		29
> +#define STM32F7_RCC_AHB1_OTGHSULPI	30
> +
> +#define STM32F7_AHB1_RESET(bit) (STM32F7_RCC_AHB1_##bit + (0x10 * 8))
> +#define STM32F7_AHB1_CLOCK(bit) (STM32F7_RCC_AHB1_##bit)
> +
> +
> +/* AHB2 */
> +#define STM32F7_RCC_AHB2_DCMI		0
> +#define STM32F7_RCC_AHB2_CRYP		4
> +#define STM32F7_RCC_AHB2_HASH		5
> +#define STM32F7_RCC_AHB2_RNG		6
> +#define STM32F7_RCC_AHB2_OTGFS		7
> +
> +#define STM32F7_AHB2_RESET(bit)	(STM32F7_RCC_AHB2_##bit + (0x14 * 8))
> +#define STM32F7_AHB2_CLOCK(bit)	(STM32F7_RCC_AHB2_##bit + 0x20)
> +
> +/* AHB3 */
> +#define STM32F7_RCC_AHB3_FMC		0
> +#define STM32F7_RCC_AHB3_QSPI		1
> +
> +#define STM32F7_AHB3_RESET(bit)	(STM32F7_RCC_AHB3_##bit + (0x18 * 8))
> +#define STM32F7_AHB3_CLOCK(bit)	(STM32F7_RCC_AHB3_##bit + 0x40)
> +
> +/* APB1 */
> +#define STM32F7_RCC_APB1_TIM2		0
> +#define STM32F7_RCC_APB1_TIM3		1
> +#define STM32F7_RCC_APB1_TIM4		2
> +#define STM32F7_RCC_APB1_TIM5		3
> +#define STM32F7_RCC_APB1_TIM6		4
> +#define STM32F7_RCC_APB1_TIM7		5
> +#define STM32F7_RCC_APB1_TIM12		6
> +#define STM32F7_RCC_APB1_TIM13		7
> +#define STM32F7_RCC_APB1_TIM14		8
> +#define STM32F7_RCC_APB1_LPTIM1		9
> +#define STM32F7_RCC_APB1_WWDG		11
> +#define STM32F7_RCC_APB1_SPI2		14
> +#define STM32F7_RCC_APB1_SPI3		15
> +#define STM32F7_RCC_APB1_SPDIFRX	16
> +#define STM32F7_RCC_APB1_UART2		17
> +#define STM32F7_RCC_APB1_UART3		18
> +#define STM32F7_RCC_APB1_UART4		19
> +#define STM32F7_RCC_APB1_UART5		20
> +#define STM32F7_RCC_APB1_I2C1		21
> +#define STM32F7_RCC_APB1_I2C2		22
> +#define STM32F7_RCC_APB1_I2C3		23
> +#define STM32F7_RCC_APB1_I2C4		24
> +#define STM32F7_RCC_APB1_CAN1		25
> +#define STM32F7_RCC_APB1_CAN2		26
> +#define STM32F7_RCC_APB1_CEC		27
> +#define STM32F7_RCC_APB1_PWR		28
> +#define STM32F7_RCC_APB1_DAC		29
> +#define STM32F7_RCC_APB1_UART7		30
> +#define STM32F7_RCC_APB1_UART8		31
> +
> +#define STM32F7_APB1_RESET(bit)	(STM32F7_RCC_APB1_##bit + (0x20 * 8))
> +#define STM32F7_APB1_CLOCK(bit)	(STM32F7_RCC_APB1_##bit + 0x80)
> +
> +/* APB2 */
> +#define STM32F7_RCC_APB2_TIM1		0
> +#define STM32F7_RCC_APB2_TIM8		1
> +#define STM32F7_RCC_APB2_USART1		4
> +#define STM32F7_RCC_APB2_USART6		5
> +#define STM32F7_RCC_APB2_ADC1		8
> +#define STM32F7_RCC_APB2_ADC2		9
> +#define STM32F7_RCC_APB2_ADC3		10
> +#define STM32F7_RCC_APB2_SDMMC1		11
> +#define STM32F7_RCC_APB2_SPI1		12
> +#define STM32F7_RCC_APB2_SPI4		13
> +#define STM32F7_RCC_APB2_SYSCFG		14
> +#define STM32F7_RCC_APB2_TIM9		16
> +#define STM32F7_RCC_APB2_TIM10		17
> +#define STM32F7_RCC_APB2_TIM11		18
> +#define STM32F7_RCC_APB2_SPI5		20
> +#define STM32F7_RCC_APB2_SPI6		21
> +#define STM32F7_RCC_APB2_SAI1		22
> +#define STM32F7_RCC_APB2_SAI2		23
> +#define STM32F7_RCC_APB2_LTDC		26
> +
> +#define STM32F7_APB2_RESET(bit)	(STM32F7_RCC_APB2_##bit + (0x24 * 8))
> +#define STM32F7_APB2_CLOCK(bit)	(STM32F7_RCC_APB2_##bit + 0xA0)
> +
> +#endif /* _DT_BINDINGS_MFD_STM32F7_RCC_H */

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
