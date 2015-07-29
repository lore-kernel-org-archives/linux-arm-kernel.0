From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 29 Jul 2015 15:46:12 -0700
Subject: [PATCH v1 7/7] ARM: dts: ifc6410: add inforce LVDS panel support
In-Reply-To: <1438088076-17606-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1438087956-17307-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1438088076-17606-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <55B957B4.40501@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/28/2015 05:54 AM, Srinivas Kandagatla wrote:
> +
> +		panel_3p3v: panel_3p3v {
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

We should put gpio regulators into their own container in the root of 
the tree. Similar to what was done for 8960 gpio regulators.

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
> +			status = "okay";
> +			compatible = "auo,b101xtn01";
> +
> +			ddc-i2c-bus = <&i2c3>;
> +			backlight = <&backlight>;
> +			power-supply = <&panel_3p3v>;
>   		};

These two nodes shouldn't be under the SoC node. They don't have 
registers so they should be at the root of the tree. And we don't need 
to put labels twice on nodes. If we're modifying things in board 
specific dtsi files it should be fine to leave the label off if the 
label is in the SoC dtsi file.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
