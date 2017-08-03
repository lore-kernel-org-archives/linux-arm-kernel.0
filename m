From: robh@kernel.org (Rob Herring)
Date: Thu, 3 Aug 2017 15:21:34 -0500
Subject: [PATCH v3] ARM: dts: stm32: change pinctrl bindings definition
In-Reply-To: <1501163393-28884-2-git-send-email-alexandre.torgue@st.com>
References: <1501163393-28884-1-git-send-email-alexandre.torgue@st.com>
 <1501163393-28884-2-git-send-email-alexandre.torgue@st.com>
Message-ID: <20170803202134.ne3wkzremxf5mbuw@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 27, 2017 at 03:49:53PM +0200, Alexandre Torgue wrote:
> Initially each pin was declared in "include/dt-bindings/stm32<SOC>-pinfunc.h"
> and each definition contained SOC names (ex: STM32F429_PA9_FUNC_USART1_TX).
> Since this approach was approved, the number of supported MCU has
> increased (STM32F429/STM32F469/STM32f746/STM32H743). To avoid to add a new
> file in "include/dt-bindings" each time a new STM32 SOC arrives I propose
> a new approach which consist to use a macro to define pin muxing in device
> tree. All STM32 will use the common macro to define pinmux. Furthermore, it
> will make STM32 maintenance and integration of new SOC easier .
> 
> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>
> Reviewed-by: Vikas MANOCHA <vikas.manocha@st.com>
> Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
> index d907a74..567aa72 100644
> --- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
> @@ -126,22 +126,27 @@ configuration, pullups, drive, output high/low and output speed.
>      };
>  
>  Required properties:
> -- pinmux: integer array, represents gpio pin number and mux setting.
> -  Supported pin number and mux varies for different SoCs, and are defined in
> -  dt-bindings/pinctrl/<soc>-pinfunc.h directly.
> -  These defines are calculated as:
> -    ((port * 16 + line) << 8) | function
> +- pinmux: integer array, represents gpio pin number and mux setting. Use
> +  following macro: STM32_PINMUX(PIN_NO(port_name, line), mode) to declare it.

I would keep the above formula. It can't change because that is the ABI. 
The macro is just convenience.

Is there any reason to have 2 macros? I'd just do STM32_PINMUX(port, 
line, mode) and make port names defines (PA, PB, PC, etc.).

> +
>    With:
> -    - port: The gpio port index (PA = 0, PB = 1, ..., PK = 11)
> -    - line: The line offset within the port (PA0 = 0, PA1 = 1, ..., PA15 = 15)
> -    - function: The function number, can be:
> -      * 0 : GPIO
> -      * 1 : Alternate Function 0
> -      * 2 : Alternate Function 1
> -      * 3 : Alternate Function 2
> +    - port_name: The gpio port name ('A', 'B', ..., 'K')
> +    - line: The line offset within the port (0, 1, ..., 15)
> +    - mode: The mode can be:
> +      * GPIO
> +      * AF0 : Alternate Function 0
> +      * AF1 : Alternate Function 1
> +      * AF2 : Alternate Function 2
>        * ...
> -      * 16 : Alternate Function 15
> -      * 17 : Analog
> +      * AF15 : Alternate Function 15
> +      * ANALOG

Here too, keeping the numbers is important.

Perhaps the macro description should either be its own additional 
section or document it inline with the macro definition.

Overall, it does seem like a nice shrinking of the header files.

> +
> +  Example:
> +    To declare pin PA7 in mode "alternate function 7" you have to
> +    declare:
> +      pinmux = <STM32_PINMUX(PIN_NO('A', 9), AF7)>;
> +
> +  This macro is defined in dt-bindings/pinctrl/stm32-pinfunc.h
>  
>  Optional properties:
>  - GENERIC_PINCONFIG: is the generic pinconfig options to use.
> @@ -165,13 +170,13 @@ pin-controller {
>  ...
>  	usart1_pins_a: usart1 at 0 {
>  		pins1 {
> -			pinmux = <STM32F429_PA9_FUNC_USART1_TX>;
> +			pinmux = <STM32_PINMUX(PIN_NO('A', 9), AF7)>; /* USART1_TX */
>  			bias-disable;
>  			drive-push-pull;
>  			slew-rate = <0>;
>  		};
>  		pins2 {
> -			pinmux = <STM32F429_PA10_FUNC_USART1_RX>;
> +			pinmux = <STM32_PINMUX(PIN_NO('A', 10), AF7)>; /* USART1_RX */
>  			bias-disable;
>  		};
>  	};
