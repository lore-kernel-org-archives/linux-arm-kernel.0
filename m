From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 10 Apr 2015 10:04:54 -0700
Subject: [PATCH v2 06/12] ARM: dts: apq8064: Add MDP support
In-Reply-To: <1428669271-11032-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1428669187-10775-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1428669271-11032-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <552802B6.2040804@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/15 05:34, Srinivas Kandagatla wrote:
> @@ -250,6 +265,18 @@
>  			};
>  		};
>  
> +		ext_3p3v: regulator-fixed at 1 {
> +			compatible = "regulator-fixed";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-name = "ext_3p3v";
> +			regulator-type = "voltage";
> +			startup-delay-us = <0>;
> +			gpio = <&tlmm_pinmux 77 GPIO_ACTIVE_HIGH>;
> +			enable-active-high;
> +			regulator-boot-on;
> +		};

This shouldn't be inside the SoC node because it doesn't have a reg
property. It should be in a 'regulators' node that's in the root of the
tree:

	regulators {
		compatible = "simple-bus";

		ext_3p3v: fixedregulator at 0 {
			compatible = "regulator-fixed";
			...
		};
	};


> +
>  		qcom,ssbi at 500000 {
>  			compatible = "qcom,ssbi";
>  			reg = <0x00500000 0x1000>;
> @@ -522,5 +549,82 @@
>  			compatible = "qcom,tcsr-apq8064", "syscon";
>  			reg = <0x1a400000 0x100>;
>  		};
> +
> +		hdmi: qcom,hdmi-tx at 4a00000 {
> +			compatible = "qcom,hdmi-tx-8960";
> +			reg-names = "core_physical";
> +			reg = <0x04a00000 0x1000>;
> +			interrupts = <GIC_SPI 79 IRQ_TYPE_NONE>;
> +			clock-names =
> +			    "core_clk",
> +			    "master_iface_clk",
> +			    "slave_iface_clk";
> +			clocks =
> +			    <&mmcc HDMI_APP_CLK>,
> +			    <&mmcc HDMI_M_AHB_CLK>,
> +			    <&mmcc HDMI_S_AHB_CLK>;
> +			qcom,hdmi-tx-ddc-clk = <&tlmm_pinmux 70
> +						GPIO_ACTIVE_HIGH>;
> +			qcom,hdmi-tx-ddc-data = <&tlmm_pinmux 71
> +						GPIO_ACTIVE_HIGH>;
> +			qcom,hdmi-tx-hpd = <&tlmm_pinmux 72
> +						GPIO_ACTIVE_HIGH>;

This should be done via the *-gpios method. i.e. hdmi-tx-ddc-clk-gpios,
hdmi-tx-ddc-data-gpios, etc.

> +			core-vdda-supply = <&pm8921_hdmi_switch>;
> +			hdmi-mux-supply = <&ext_3p3v>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&hdmi_pinctrl>;
> +		};
> +
> +		gpu: qcom,adreno-3xx at 4300000 {
> +			compatible = "qcom,adreno-3xx";
> +			reg = <0x04300000 0x20000>;
> +			reg-names = "kgsl_3d0_reg_memory";
> +			interrupts = <GIC_SPI 80 IRQ_TYPE_NONE>;
> +			interrupt-names = "kgsl_3d0_irq";
> +			clock-names =
> +			    "core_clk",
> +			    "iface_clk",
> +			    "mem_clk",
> +			    "mem_iface_clk";
> +			clocks =
> +			    <&mmcc GFX3D_CLK>,
> +			    <&mmcc GFX3D_AHB_CLK>,
> +			    <&mmcc GFX3D_AXI_CLK>,
> +			    <&mmcc MMSS_IMEM_AHB_CLK>;
> +			qcom,chipid = <0x03020002>;
> +			qcom,gpu-pwrlevels {
> +				compatible = "qcom,gpu-pwrlevels";
> +				qcom,gpu-pwrlevel at 0 {
> +					qcom,gpu-freq = <450000000>;
> +				};
> +				qcom,gpu-pwrlevel at 1 {
> +					qcom,gpu-freq = <27000000>;
> +				};
> +			};

This should be an OPP.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
