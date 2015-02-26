From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 26 Feb 2015 12:27:59 -0600
Subject: [PATCH 03/12] ARM: dts: apq8064: Add USB OTG support
In-Reply-To: <1424678108-13052-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <424678035-12862-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1424678108-13052-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1C851112-EDEB-41D3-BFA4-47840BF34017@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Feb 23, 2015, at 1:55 AM, Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:

> This patch adds USB OTG support on USB1 of APQ8064 SOC.
> Tested on IFC6410 with ethernet gadget.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> arch/arm/boot/dts/qcom-apq8064-ifc6410.dts | 22 ++++++++++++++++++++
> arch/arm/boot/dts/qcom-apq8064.dtsi        | 32 ++++++++++++++++++++++++++++++
> 2 files changed, 54 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
> index 40657a4..1723cdf 100644
> --- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
> +++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
> @@ -61,12 +61,25 @@
> 				regulator-max-microvolt = <3300000>;
> 			};
> 
> +			pm8921_l4: pm8921-l4 {
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <1800000>;
> +			};
> +
> 			pm8921_l23: pm8921-l23 {
> 				regulator-min-microvolt = <1700000>;
> 				regulator-max-microvolt = <1900000>;
> 			};
> 		};
> 
> +		/* OTG */
> +		usb1_phy: phy at 12500000 {
> +			status		= "okay";
> +			vddcx-supply	= <&pm8921_s3>;
> +			v3p3-supply	= <&pm8921_l3>;
> +			v1p8-supply	= <&pm8921_l4>;
> +		};
> +
> 		usb3_phy: phy at 12520000 {
> 			status		= "okay";
> 			vddcx-supply	= <&pm8921_s3>;
> @@ -81,6 +94,15 @@
> 			v1p8-supply	= <&pm8921_l23>;
> 		};
> 
> +		gadget1: gadget at 12500000 {
> +			status = "okay";
> +		};
> +
> +		/* OTG */
> +		usb1: usb at 12500000 {
> +			status = "okay";
> +		};
> +
> 		usb3: usb at 12520000 {
> 			status = "okay";
> 		};
> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
> index e33eb03..c251c72 100644
> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
> @@ -488,6 +488,21 @@
> 			};
> 		};
> 
> +		usb1_phy: phy at 12500000 {
> +			compatible	= "qcom,usb-otg-ci";
> +			reg		= <0x12500000 0x400>;
> +			interrupts	= <0 100 IRQ_TYPE_NONE>;

Same comments about 0 -> GIC_SPI, and IRQ_TYPE_NONE -> IRQ_TYPE_LEVEL_HIGH

> +			status		= "disabled";
> +			dr_mode		= "host";
> +
> +			clocks		= <&gcc USB_HS1_XCVR_CLK>,
> +					  <&gcc USB_HS1_H_CLK>;
> +			clock-names	= "core", "iface";
> +
> +			resets		= <&gcc USB_HS1_RESET>;
> +			reset-names	= "link";
> +		};
> +
> 		usb3_phy: phy at 12520000 {
> 			compatible	= "qcom,usb-otg-ci";
> 			reg		= <0x12520000 0x400>;
> @@ -518,6 +533,23 @@
> 			reset-names	= "link";
> 		};
> 
> +		gadget1: gadget at 12500000 {
> +			compatible	= "qcom,ci-hdrc";
> +			reg		= <0x12500000 0x400>;
> +			status		= "disabled";
> +			dr_mode		= "peripheral";
> +			interrupts	= <0 100 IRQ_TYPE_NONE>;
> +			usb-phy		= <&usb1_phy>;
> +		};
> +
> +		usb1: usb at 12500000 {
> +			compatible	= "qcom,ehci-host";
> +			reg		= <0x12500000 0x400>;
> +			interrupts	= <0 100 IRQ_TYPE_NONE>;
> +			status		= "disabled";
> +			usb-phy		= <&usb1_phy>;
> +		};
> +
> 		usb3: usb at 12520000 {
> 			compatible	= "qcom,ehci-host";
> 			reg		= <0x12520000 0x400>;
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
