From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 27 Nov 2016 14:10:43 +0000
Subject: [PATCH v2 1/7] MFD: add bindings for stm32 general purpose timer
 driver
In-Reply-To: <1480000463-9625-2-git-send-email-benjamin.gaignard@st.com>
References: <1480000463-9625-1-git-send-email-benjamin.gaignard@st.com>
 <1480000463-9625-2-git-send-email-benjamin.gaignard@st.com>
Message-ID: <2b751c4a-3038-4220-05d8-d745c51a3691@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/11/16 15:14, Benjamin Gaignard wrote:
> Add bindings information for stm32 general purpose timer
> 
> version 2:
> - rename stm32-mfd-timer to stm32-gptimer
> - only keep one compatible string
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../bindings/mfd/stm32-general-purpose-timer.txt   | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/stm32-general-purpose-timer.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/stm32-general-purpose-timer.txt b/Documentation/devicetree/bindings/mfd/stm32-general-purpose-timer.txt
> new file mode 100644
> index 0000000..2f10e67
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/stm32-general-purpose-timer.txt
> @@ -0,0 +1,43 @@
> +STM32 general purpose timer driver
> +
> +Required parameters:
> +- compatible: must be "st,stm32-gptimer"
> +
> +- reg:			Physical base address and length of the controller's
> +			registers.
> +- clock-names: 		Set to "clk_int".
> +- clocks: 		Phandle to the clock used by the timer module.
> +			For Clk properties, please refer to ../clock/clock-bindings.txt
> +
> +Optional parameters:
> +- resets:		Phandle to the parent reset controller.
> +			See ..reset/st,stm32-rcc.txt
> +
> +Optional subnodes:
> +- pwm:			See ../pwm/pwm-stm32.txt
> +- iiotimer:		See ../iio/timer/stm32-iio-timer.txt
Naming issue here.  Can't mention IIO as that's a linux subsystem and all
bindings must be independent of OS. 

Perhaps adc-trigger-timer?
> +
> +Example:
> +	gptimer1: gptimer1 at 40010000 {
> +		compatible = "st,stm32-gptimer";
> +		reg = <0x40010000 0x400>;
> +		clocks = <&rcc 0 160>;
> +		clock-names = "clk_int";
> +
> +		pwm1 at 0 {
> +			compatible = "st,stm32-pwm";
> +			st,pwm-num-chan = <4>;
> +			st,breakinput;
> +			st,complementary;
> +		};
> +
> +		iiotimer1 at 0 {
> +			compatible = "st,stm32-iio-timer";
Again, avoid the use of iio in here (same issue you had with mfd in the previous
version).
> +			interrupts = <27>;
> +			st,input-triggers-names = TIM5_TRGO,
Docs for these should be introduced before they are used in an example.
Same for the PWM ones above.  Expand the detail fo the example as you add
the other elements.
> +						  TIM2_TRGO,
> +						  TIM4_TRGO,
> +						  TIM3_TRGO;
> +			st,output-triggers-names = TIM1_TRGO;
> +		};
> +	};
> 
