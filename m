From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Tue, 28 Jul 2015 19:31:37 +0200
Subject: [PATCH v1 4/7] ARM: dts: apq8064: Add MDP support
In-Reply-To: <1438088049-17479-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1438087956-17307-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1438088049-17479-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <55B7BC79.1060504@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 28.07.2015 um 14:54 schrieb Srinivas Kandagatla:
> From: Rob Clark <robdclark@gmail.com>
> 
> This patch adds MDP node to APQ8064 dt.
> 
> Signed-off-by: Rob Clark <robdclark@gmail.com>
> [Srinivas Kandagatla] : updated with new style rpm regulators
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-apq8064.dtsi | 87 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
> index cba4ccb..7d2cc45 100644
> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
[...]
> +		gpu: qcom,adreno-3xx at 4300000 {
> +			compatible = "qcom,adreno-3xx";

I thought that wildcards were forbidden in compatible strings? Then this
should be replaced by the real number, with a fallback to the first
compatible one.

And can't we just name the node qcom,adreno without version suffix?

Regards,
Andreas

> +			reg = <0x04300000 0x20000>;
> +			reg-names = "kgsl_3d0_reg_memory";
> +			interrupts = <GIC_SPI 80 0>;
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
> +		};
> +
> +		mdp: qcom,mdp at 5100000 {
> +			compatible = "qcom,mdp";
> +			reg = <0x05100000 0xf0000>;
> +			interrupts = <GIC_SPI 75 0>;
> +			connectors = <&hdmi>;
> +			gpus = <&gpu>;
> +			clock-names =
> +			    "core_clk",
> +			    "iface_clk",
> +			    "lut_clk",
> +			    "src_clk",
> +			    "hdmi_clk",
> +			    "mdp_clk",
> +			    "mdp_axi_clk";
> +			clocks =
> +			    <&mmcc MDP_CLK>,
> +			    <&mmcc MDP_AHB_CLK>,
> +			    <&mmcc MDP_LUT_CLK>,
> +			    <&mmcc TV_SRC>,
> +			    <&mmcc HDMI_TV_CLK>,
> +			    <&mmcc MDP_TV_CLK>,
> +			    <&mmcc MDP_AXI_CLK>;
> +		};
>  	};
>  };

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Dilip Upmanyu, Graham Norton; HRB
21284 (AG N?rnberg)
