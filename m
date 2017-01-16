From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 16 Jan 2017 17:02:05 +0100
Subject: [PATCH v1 6/7] ARM: dts: stm32429i-eval: Enable ltdc & simple
 panel on Eval board
In-Reply-To: <1484573344-11609-7-git-send-email-yannick.fertre@st.com>
References: <1484573344-11609-1-git-send-email-yannick.fertre@st.com>
 <1484573344-11609-7-git-send-email-yannick.fertre@st.com>
Message-ID: <0c00fe15-d926-3359-0e2e-f1c5a8d68cad@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 01/16/2017 02:29 PM, Yannick Fertre wrote:
> Enable ltdc & enable am-480272h3tmqw-t01h panel.
>
> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
> ---

Can you please change commit header with:

"ARM: dts: stm32: Enable ltdc & simple panel on stm32f429-Eval board"

>  arch/arm/boot/dts/stm32429i-eval.dts | 58 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
> index 2de6487..f987ca5 100644
> --- a/arch/arm/boot/dts/stm32429i-eval.dts
> +++ b/arch/arm/boot/dts/stm32429i-eval.dts
> @@ -88,6 +88,52 @@
>  		clocks = <&rcc 0 30>;
>  		clock-names = "main_clk";
>  	};
> +
> +	panel_rgb: panel-rgb {
> +		compatible = "ampire,am-480272h3tmqw-t01h";
> +		status = "okay";
> +		port {
> +			panel_in_rgb: endpoint {
> +				remote-endpoint = <&ltdc_out_rgb>;
> +			};
> +		};
> +	};
> +};
> +
> +&pinctrl {
> +	pinctrl_ltdc: ltdc at 0 {
> +		pins {

Pinmuxing definition is SOC specific. Please move it in stm32f429.dtsi 
file. Note that a development is ongoing to define pinmuxing in a 
dedicated pinctrl-stm32f4.dtsi file.


> +			pinmux = <STM32F429_PI12_FUNC_LCD_HSYNC>,
> +				 <STM32F429_PI13_FUNC_LCD_VSYNC>,
> +				 <STM32F429_PI14_FUNC_LCD_CLK>,
> +				 <STM32F429_PI15_FUNC_LCD_R0>,
> +				 <STM32F429_PJ0_FUNC_LCD_R1>,
> +				 <STM32F429_PJ1_FUNC_LCD_R2>,
> +				 <STM32F429_PJ2_FUNC_LCD_R3>,
> +				 <STM32F429_PJ3_FUNC_LCD_R4>,
> +				 <STM32F429_PJ4_FUNC_LCD_R5>,
> +				 <STM32F429_PJ5_FUNC_LCD_R6>,
> +				 <STM32F429_PJ6_FUNC_LCD_R7>,
> +				 <STM32F429_PJ7_FUNC_LCD_G0>,
> +				 <STM32F429_PJ8_FUNC_LCD_G1>,
> +				 <STM32F429_PJ9_FUNC_LCD_G2>,
> +				 <STM32F429_PJ10_FUNC_LCD_G3>,
> +				 <STM32F429_PJ11_FUNC_LCD_G4>,
> +				 <STM32F429_PJ12_FUNC_LCD_B0>,
> +				 <STM32F429_PJ13_FUNC_LCD_B1>,
> +				 <STM32F429_PJ14_FUNC_LCD_B2>,
> +				 <STM32F429_PJ15_FUNC_LCD_B3>,
> +				 <STM32F429_PK0_FUNC_LCD_G5>,
> +				 <STM32F429_PK1_FUNC_LCD_G6>,
> +				 <STM32F429_PK2_FUNC_LCD_G7>,
> +				 <STM32F429_PK3_FUNC_LCD_B4>,
> +				 <STM32F429_PK4_FUNC_LCD_B5>,
> +				 <STM32F429_PK5_FUNC_LCD_B6>,
> +				 <STM32F429_PK6_FUNC_LCD_B7>,
> +				 <STM32F429_PK7_FUNC_LCD_DE>;
> +			slew-rate = <2>;
> +		};
> +	};
>  };
>
>  &clk_hse {
> @@ -123,3 +169,15 @@
>  	pinctrl-names = "default";
>  	status = "okay";
>  };
> +
> +&ltdc_host{
> +	status = "okay";
> +	pinctrl-0 = <&pinctrl_ltdc>;
> +	pinctrl-names = "default";
> +
> +	port {
> +		ltdc_out_rgb: endpoint {
> +			remote-endpoint = <&panel_in_rgb>;
> +		};
> +	};
> +};
>
