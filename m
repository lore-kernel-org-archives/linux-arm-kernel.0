From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 20 Oct 2015 11:06:49 +0100
Subject: [PATCH v2 3/9] includes: dt-bindings: Add STM32F429 pinctrl DT
 bindings
In-Reply-To: <1445102604-11502-4-git-send-email-mcoquelin.stm32@gmail.com>
References: <1445102604-11502-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1445102604-11502-4-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <56261239.5030007@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/10/15 18:23, Maxime Coquelin wrote:
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> ---
>   include/dt-bindings/pinctrl/pinctrl-stm32.h     |   12 +
>   include/dt-bindings/pinctrl/stm32f429-pinfunc.h | 1241 +++++++++++++++++++++++
>   2 files changed, 1253 insertions(+)
>   create mode 100644 include/dt-bindings/pinctrl/pinctrl-stm32.h
>   create mode 100644 include/dt-bindings/pinctrl/stm32f429-pinfunc.h
>
> diff --git a/include/dt-bindings/pinctrl/pinctrl-stm32.h b/include/dt-bindings/pinctrl/pinctrl-stm32.h
> new file mode 100644
> index 0000000..a2e7222
> --- /dev/null
> +++ b/include/dt-bindings/pinctrl/pinctrl-stm32.h
> @@ -0,0 +1,12 @@
> +#ifndef _DT_BINDINGS_PINCTRL_STM32_H
> +#define _DT_BINDINGS_PINCTRL_STM32_H
> +
> +#define STM32_PIN_NO(x) ((x) << 8)
> +#define STM32_GET_PIN_NO(x) ((x) >> 8)
> +#define STM32_GET_PIN_FUNC(x) ((x) & 0xff)
> +
> +#define STM32_PIN_GPIO		0
> +#define STM32_PIN_AF(x)		((x) + 1)
> +#define STM32_PIN_ANALOG	(STM32_PIN_AF(15) + 1)
> +
> +#endif /* _DT_BINDINGS_PINCTRL_STM32_H */
> diff --git a/include/dt-bindings/pinctrl/stm32f429-pinfunc.h b/include/dt-bindings/pinctrl/stm32f429-pinfunc.h
> new file mode 100644
> index 0000000..9dd5fd0
> --- /dev/null
> +++ b/include/dt-bindings/pinctrl/stm32f429-pinfunc.h
> @@ -0,0 +1,1241 @@
> +#ifndef _DT_BINDINGS_STM32F429_PINFUNC_H
> +#define _DT_BINDINGS_STM32F429_PINFUNC_H
> +
> +#include <dt-bindings/pinctrl/pinctrl-stm32.h>
> +
> +#define STM32F429_PA0_FUNC_GPIO 0x0
> +#define STM32F429_PA0_FUNC_TIM2_CH1_TIM2_ETR 0x2

Did you expand these out after my feedback (instead of things like: 
STM32_PIN_NO(0) | STM32_PIN_AF(1) )?

If so I must have been somewhat unclear.

I suggesting that, like with the clock driver, there is no need to the 
STM32F429_PAXX_FUNC_YYY macros at all.

Given the way you can enumerate pin config options in stm32f429.dtsi 
then I think stm32f429.dtsi is the only file that will ever include this 
header? If so then why not just plug the values directly into the pinmux 
fields. Its not duplicative and is easier to map back to data sheets.

~~~
#define PIN_NO(x) ...
#define PIN_AF(x) ...

usart1_pins_a: usart1 at 0 {
				pins1 {
					pinmux = PIN_NO(9) | PIN_AF(7);
					bias-disable;
					drive-push-pull;
					slew-rate = <0>;
				};
                                 ...
			};
~~~
