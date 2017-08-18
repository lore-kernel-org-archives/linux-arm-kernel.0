From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 18 Aug 2017 15:35:05 -0500
Subject: [RESEND PATCH 1/1] arm64: dts: Add Variscite DART-SD410
 Evaluation board dts
In-Reply-To: <014701d31418$8e419670$aac4c350$@variscite.com>
References: <014701d31418$8e419670$aac4c350$@variscite.com>
Message-ID: <20170818203505.GB4042@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 13, 2017 at 12:42:59PM +0300, Leonid Segal wrote:
> Add initial device tree support for Variscite DART-SD410 Evalueation board.
> This board is also known as VAR-SD410CustomBoard.
> 
> Signed-off-by: Leonid Segal <leonid.s@variscite.com>
> ---

A few comments, mainly about your documentation on the Variscite
website.  Specifically the schematics.  Please tell your hardware
people to be consistent in your naming conventions for pins.

MPP_GPIO/PM_GPIO appear to be interchangeable.  And it's usually
best to split out the PMIC pins from the non-pmic.  That's my 2
cents at least.


>  arch/arm64/boot/dts/qcom/Makefile                  |   1 +
>  .../boot/dts/qcom/apq8016-var-dart-pmic-pins.dtsi  |  53 +++
>  .../boot/dts/qcom/apq8016-var-dart-soc-pins.dtsi   |  88 ++++
>  arch/arm64/boot/dts/qcom/apq8016-var-dart.dts      |  21 +
>  arch/arm64/boot/dts/qcom/apq8016-var-dart.dtsi     | 525

<snip>

> +			pins = "gpio32";
> +		};
> +		pinconf {
> +			pins = "gpio32";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +	};
> +
> +	msm_key_volp_n_default: msm_key_volp_n_default {

Schematics show this to be a Home button.  If so this needs to be
updated to reflect that.

> +		pinmux {
> +			function = "gpio";
> +			pins = "gpio107";
> +		};
> +		pinconf {
> +			pins = "gpio107";
> +			drive-strength = <8>;
> +			input-enable;
> +			bias-pull-up;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/qcom/apq8016-var-dart.dts

<snip>

> +/dts-v1/;
> +
> +#include "apq8016-var-dart.dtsi"
> +
> +/ {
> +	model = "Variscite LTD. VAR-DART410";
> +	compatible = "qcom,apq8016-dart", "qcom,apq8016", "qcom,dart";

qcom isnt making this board.  Please use something like "variscite,dart",
"qcom,apq8016"

> +};
> diff --git a/arch/arm64/boot/dts/qcom/apq8016-var-dart.dtsi
> b/arch/arm64/boot/dts/qcom/apq8016-var-dart.dtsi
> new file mode 100644
> index 000000000000..f214d0b101a4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/apq8016-var-dart.dtsi

<snip>
> +
> +		usb at 78d9000 {
> +			extcon = <&usb_id>, <&usb_id>;
> +			status = "okay";
> +		};
> +
> +		ehci at 78d9000 {
> +			status = "okay";

Can you try removing the echi and using the chipidea instead.  Take a
look at the current db410c in -next.  Try it out and see if that works
for you.  If it does, modify your nodes to match up.

> +		};
> +
> +		phy at 78d9000 {
> +			v1p8-supply = <&pm8916_l7>;
> +			v3p3-supply = <&pm8916_l13>;
> +			vddcx-supply = <&pm8916_s1>;
> +			extcon = <&usb_id>, <&usb_id>;
> +			dr_mode = "otg";
> +			status = "okay";
> +			switch-gpio = <&pm8916_gpios 4 GPIO_ACTIVE_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&usb_sw_sel_pm>;

Same here, I think some things changed here.  Need to update.
switch-gpio went away.

> +		};
> +
> +		lpass at 07708000 {
> +			status = "okay";
> +		};
> +

<snip>


Regards,

Andy Gross
