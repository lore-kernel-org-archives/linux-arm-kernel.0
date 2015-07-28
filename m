From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Tue, 28 Jul 2015 19:50:20 +0200
Subject: [PATCH v1 7/7] ARM: dts: ifc6410: add inforce LVDS panel support
In-Reply-To: <1438088076-17606-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1438087956-17307-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1438088076-17606-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <55B7C0DC.2010501@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 28.07.2015 um 14:54 schrieb Srinivas Kandagatla:
> This patch adds LVDS panel for IFC6410.
> 
> Signed-off-by: Rob Clark <robdclark@gmail.com>
> [Rob Clark: WIP patch]
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-apq8064-ifc6410.dts | 66 ++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
> index 1ab71f1..3bdac02 100644
> --- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
> +++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
> @@ -63,6 +63,12 @@
>  					qcom,switch-mode-frequency = <3200000>;
>  				};
>  
> +				pm8921_l2: l2 {
> +					regulator-min-microvolt = <1200000>;
> +					regulator-max-microvolt = <1200000>;
> +					bias-pull-down;
> +				};
> +
>  				pm8921_l3: l3 {
>  					regulator-min-microvolt = <3050000>;
>  					regulator-max-microvolt = <3300000>;
> @@ -96,6 +102,10 @@
>  				pm8921_lvs1: lvs1 {
>  					bias-pull-down;
>  				};
> +
> +				pm8921_lvs7: lvs7 {
> +					bias-pull-down;
> +				};
>  			};
>  		};
>  
> @@ -119,6 +129,41 @@
>  
>  		mdp: qcom,mdp at 5100000 {
>  			status = "okay";
> +			qcom,lvds-panel = <&panel>;

In my testing this broke/uglified HDMI output. Since not everyone has
that LVDS panel attached, or might have a different panel type, I don't
think the panel node belongs in the generic -ifc6410.dts file.
I suggest you add an -ifc6410+inforce-lvds.dts or so for that.

> +			lvds-vccs-3p3v-supply = <&ext_3p3v>;
> +			lvds-pll-vdda-supply = <&pm8921_l2>;
> +			lvds-vdda-supply = <&pm8921_lvs7>;
> +		};
> +
> +		panel_3p3v: panel_3p3v {

s/_/-/ ?

> +			compatible = "regulator-fixed";
> +			pinctrl-0 = <&disp_en_gpios>;
> +			pinctrl-names = "default";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-name = "panel_en_3p3v";
> +			regulator-type = "voltage";
> +			startup-delay-us = <0>;
> +			gpio = <&pm8921_gpio 36 GPIO_ACTIVE_HIGH>;
> +			enable-active-high;
> +			regulator-boot-on;
> +		};
> +
> +		backlight: backlight{
> +			pinctrl-0 = <&pwm_bl_gpios>;
> +			pinctrl-names = "default";
> +			compatible = "gpio-backlight";
> +			gpios = <&pm8921_gpio 26 GPIO_ACTIVE_HIGH>;
> +			default-on;
> +		};
> +
> +		panel: auo,b101xtn01 {

panel: panel { ?

Regards,
Andreas

> +			status = "okay";
> +			compatible = "auo,b101xtn01";
> +
> +			ddc-i2c-bus = <&i2c3>;
> +			backlight = <&backlight>;
> +			power-supply = <&panel_3p3v>;
>  		};
>  
>  		gsbi3: gsbi at 16200000 {
> @@ -235,6 +280,27 @@
>  				pm8921_gpio: gpio at 150 {
>  					pinctrl-names = "default";
>  					pinctrl-0 = <&wlan_default_gpios>;
> +
> +					pwm_bl_gpios: pwm-bl-gpios {
> +						pios {
> +							pins = "gpio26";
> +							bias-disable;
> +							function = "normal";
> +							qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
> +							power-source = <PM8921_GPIO_S4>;
> +						};
> +					};
> +
> +					disp_en_gpios: disp-en-gpios {
> +						pios {
> +							pins = "gpio36";
> +							bias-disable;
> +							function = "normal";
> +							qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
> +							power-source = <PM8921_GPIO_S4>;
> +						};
> +					};
> +
>  					wlan_default_gpios: wlan-gpios {
>  						pios {
>  							pins = "gpio43";
> 


-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Dilip Upmanyu, Graham Norton; HRB
21284 (AG N?rnberg)
