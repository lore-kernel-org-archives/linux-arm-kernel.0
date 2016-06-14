From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 14 Jun 2016 12:11:54 -0700
Subject: [PATCH 5/5] ARM: dts: add Qualcomm APQ8060-based Dragonboard
In-Reply-To: <1465918259-11138-6-git-send-email-linus.walleij@linaro.org>
References: <1465918259-11138-1-git-send-email-linus.walleij@linaro.org>
 <1465918259-11138-6-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160614191154.GK28218@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14, Linus Walleij wrote:
> +/ {
> +	model = "Qualcomm APQ8060 Dragonboard";
> +	compatible = "qcom,apq8060-dragonboard", "qcom,msm8660";
> +
> +	aliases {
> +		serial0 = &gsbi12_serial;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +		/* Main power of the board: 3.7V */
> +		vph: regulator-fixed at 1 {
> +			compatible = "regulator-fixed";
> +			regulator-min-microvolt = <3700000>;
> +			regulator-max-microvolt = <3700000>;
> +			regulator-name = "VPH";
> +			regulator-type = "voltage";
> +			regulator-always-on;
> +			regulator-boot-on;
> +		};
> +	};
> +
> +	/* This is a levelshifter for SDCC5 */
> +	dragon_vio_txb: txb0104rgyr {
> +		compatible = "regulator-fixed";
> +		regulator-name = "Dragon SDCC levelshifter";
> +		vin-supply = <&pm8058_l14>;
> +		regulator-always-on;
> +	};

Why not put this under regulators node as well?

> +
> +	soc {
> +		gsbi at 19c00000 {
> +			status = "ok";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&dragon_serial0_pins>;
> +			qcom,mode = <GSBI_PROT_I2C_UART>;
> +			serial at 19c40000 {
> +				status = "ok";
> +			};
> +		};
> +	};
> +};
> +
> +/* Intenal 3.69 GiB eMMC */
> +&sdcc1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&dragon_sdcc1_pins>;
> +	vmmc-supply = <&pm8901_l5>;
> +	vqmmc-supply = <&pm8901_lvs0>;
> +};

I think we're following a non-phandle approach to filling out
board dts files. We didn't follow it that well on 8660 surf,
probably because it was so basic, but it would be nice to follow
that style here as well and populate board properties in nodes
like how gsbi at 19c00000 has been done. I'll leave this up to Andy
though as he's the maintainer here.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
