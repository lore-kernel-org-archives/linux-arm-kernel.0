From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 29 Mar 2016 07:34:15 -0700
Subject: [PATCH 03/12] ARM: dts: apq8064: add gsbi7 i2c support
In-Reply-To: <1458762436-9446-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1458762366-9233-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1458762436-9446-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20160329143415.GH8929@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 23 Mar 12:47 PDT 2016, Srinivas Kandagatla wrote:

> This patch adds support to gsbi7 i2c which is used in some of the new
> boards.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-apq8064-pins.dtsi | 25 +++++++++++++++++++++++++
>  arch/arm/boot/dts/qcom-apq8064.dtsi      | 13 +++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8064-pins.dtsi b/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
> index 8bb5e5f..4102a98 100644
> --- a/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
> @@ -219,4 +219,29 @@
>  			function = "gsbi7";
>  		};
>  	};
> +
> +	i2c7_pins: i2c7 {
> +		mux {
> +			pins = "gpio84", "gpio85";
> +			function = "gsbi7";
> +		};
> +
> +		pinconf {
> +			pins = "gpio84", "gpio85";
> +			drive-strength = <16>;
> +			bias-disable;
> +		};
> +	};
> +
> +	i2c7_pins_sleep: i2c7_pins_sleep {
> +		mux {
> +			pins = "gpio84", "gpio85";
> +			function = "gpio";
> +		};
> +		pinconf {
> +			pins = "gpio84", "gpio85";
> +			drive-strength = <2>;
> +			bias-disable = <0>;
> +		};
> +	};

I've been going back and forth about having default pinconfig settings
in the platform dtsi and having devices to override these later.

I do find it cleaner to push this down to the board, as they should
always be verified and tweaked by a hw guy for the specific board.


For some cases this isn't really the case, based on hard design
requirements, but for i2c it is.

>  };
> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
> index 81b4290..f064f59 100644
> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
> @@ -417,6 +417,19 @@
>  				clock-names = "core", "iface";
>  				status = "disabled";
>  			};
> +
> +			gsbi7_i2c: i2c at 16680000 {

We normally don't need to reference the i2c adaptors, so please drop
this label.

> +				compatible = "qcom,i2c-qup-v1.1.1";
> +				pinctrl-0 = <&i2c7_pins>;
> +				pinctrl-1 = <&i2c7_pins_sleep>;
> +				pinctrl-names = "default", "sleep";
> +				reg = <0x16680000 0x1000>;
> +				interrupts = <GIC_SPI 159 IRQ_TYPE_NONE>;
> +				clocks = <&gcc GSBI7_QUP_CLK>,
> +					 <&gcc GSBI7_H_CLK>;
> +				clock-names = "core", "iface";
> +				status = "disabled";
> +			};

Regards,
Bjorn
