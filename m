From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 05 Aug 2015 18:27:29 -0700
Subject: [PATCH v1 4/7] ARM: dts: apq8064: Add MDP support
In-Reply-To: <1438088049-17479-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1438087956-17307-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1438088049-17479-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <55C2B801.1030806@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/28/2015 05:54 AM, Srinivas Kandagatla wrote:
> @@ -618,5 +633,77 @@
>   			compatible = "qcom,tcsr-apq8064", "syscon";
>   			reg = <0x1a400000 0x100>;
>   		};
> +
> +		hdmi: qcom,hdmi-tx at 4a00000 {
> +			compatible = "qcom,hdmi-tx-8960";
> +			reg-names = "core_physical";
> +			reg = <0x04a00000 0x1000>;
> +			interrupts = <GIC_SPI 79 0>;
> +			clock-names =
> +			    "core_clk",
> +			    "master_iface_clk",
> +			    "slave_iface_clk";
> +			clocks =
> +			    <&mmcc HDMI_APP_CLK>,
> +			    <&mmcc HDMI_M_AHB_CLK>,
> +			    <&mmcc HDMI_S_AHB_CLK>;
> +			qcom,hdmi-tx-ddc-clk = <&tlmm_pinmux 70 GPIO_ACTIVE_HIGH>;
> +			qcom,hdmi-tx-ddc-data = <&tlmm_pinmux 71 GPIO_ACTIVE_HIGH>;
> +			qcom,hdmi-tx-hpd = <&tlmm_pinmux 72 GPIO_ACTIVE_HIGH>;

These should use standard "-gpios" syntax. Please fix the binding/driver.

> +			pinctrl-names = "default";
> +			pinctrl-0 = <&hdmi_pinctrl>;
> +		};
> +
> +		gpu: qcom,adreno-3xx at 4300000 {
> +			compatible = "qcom,adreno-3xx";
> +			reg = <0x04300000 0x20000>;
> +			reg-names = "kgsl_3d0_reg_memory";
> +			interrupts = <GIC_SPI 80 0>;
> +			interrupt-names = "kgsl_3d0_irq";
> +			clock-names =
> +			    "core_clk",
> +			    "iface_clk",
> +			    "mem_clk",
> +			    "mem_iface_clk";

Please drop "_clk" and fix driver code as we've done for all other drivers.

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

These should be OPPs. I see in the cover-letter we're asking to ignore 
this part of the binding. When is the binding and driver going to be 
fixed? The dts has been out of tree for quite some time and I assume 
work has been progressing on the driver even without this dts being in 
mainline so it doesn't make sense how pushing half-baked dts upstream is 
going to help. In fact, it's going to make things worse if someone 
complains that we're not maintaining backwards compatibility and then 
have to hack up driver code to work both ways. At which point there's 
practically zero incentive to change anything in the binding or driver. 
It's better to fix the driver now and avoid these sorts of problems 
entirely.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
