From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 6 Dec 2016 13:00:48 +0000
Subject: [PATCH v4 1/7] MFD: add bindings for STM32 General Purpose Timer
 driver
In-Reply-To: <1481027929-13704-2-git-send-email-benjamin.gaignard@st.com>
References: <1481027929-13704-1-git-send-email-benjamin.gaignard@st.com>
 <1481027929-13704-2-git-send-email-benjamin.gaignard@st.com>
Message-ID: <20161206130048.GH25385@dell.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 06 Dec 2016, Benjamin Gaignard wrote:

> Add bindings information for STM32 General Purpose Timer
> 
> version 2:
> - rename stm32-mfd-timer to stm32-gptimer
> - only keep one compatible string
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../bindings/mfd/stm32-general-purpose-timer.txt   | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/stm32-general-purpose-timer.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/stm32-general-purpose-timer.txt b/Documentation/devicetree/bindings/mfd/stm32-general-purpose-timer.txt
> new file mode 100644
> index 0000000..e92c8be
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/stm32-general-purpose-timer.txt
> @@ -0,0 +1,39 @@
> +STM32 General Purpose Timer driver bindings
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
> +			See ../reset/st,stm32-rcc.txt
> +
> +Optional subnodes:
> +- pwm:			See ../pwm/pwm-stm32.txt
> +- timer:		See ../iio/timer/stm32-timer-trigger.txt
> +
> +Example:
> +	gptimer at 40010000 {

I'm not going to push too hard, but I still thing "advanced-control"
would suit better, since this is not *just* a timer.  In fact, the
parent device (the MFD) doesn't have any timer functionality.  That's
what "timer at 0" does.

The IP is called "Advanced Control" in the datasheet, no?

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "st,stm32-gptimer";
> +		reg = <0x40010000 0x400>;
> +		clocks = <&rcc 0 160>;
> +		clock-names = "clk_int";
> +
> +		pwm at 0 {
> +			compatible = "st,stm32-pwm";
> +			pinctrl-0	= <&pwm1_pins>;
> +			pinctrl-names	= "default";
> +		};
> +
> +		timer at 0 {
> +			compatible = "st,stm32-timer-trigger";
> +			reg = <0>;
> +		};
> +	};

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
