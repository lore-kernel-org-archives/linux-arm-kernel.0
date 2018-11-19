From: sibis@codeaurora.org (Sibi Sankar)
Date: Mon, 19 Nov 2018 11:01:41 +0530
Subject: [PATCH v5 14/18] arm64: dts: qcom: qcs404: Add remoteproc nodes
In-Reply-To: <20181109094417.12109-15-vkoul@kernel.org>
References: <20181109094417.12109-1-vkoul@kernel.org>
 <20181109094417.12109-15-vkoul@kernel.org>
Message-ID: <718e105af9caeba834281dcab4aed499@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn/Vinod,

On 2018-11-09 15:14, Vinod Koul wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Add the TrustZone based remoteproc nodes and their glink edges for
> adsp, cdsp and wcss. Enable them for EVB common DTS.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 12 +++++
>  arch/arm64/boot/dts/qcom/qcs404.dtsi     | 93 
> ++++++++++++++++++++++++++++++++
>  2 files changed, 105 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> index db035fef67d9..a39924efebe4 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> @@ -21,6 +21,18 @@
>  	};
>  };
> 
> +&remoteproc_adsp {
> +	status = "ok";
> +};
> +
> +&remoteproc_cdsp {
> +	status = "ok";
> +};
> +
> +&remoteproc_wcss {
> +	status = "ok";
> +};
> +
>  &rpm_requests {
>  	pms405-regulators {
>  		compatible = "qcom,rpm-pms405-regulators";
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index 46fce264c8fe..06607419c9d6 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -80,6 +80,99 @@
>  		method = "smc";
>  	};
> 
> +	remoteproc_adsp: remoteproc-adsp {
> +		compatible = "qcom,qcs404-adsp-pas";
> +
> +		interrupts-extended = <&intc GIC_SPI 293 IRQ_TYPE_EDGE_RISING>,
> +				      <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +				      <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +				      <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +				      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> +		interrupt-names = "wdog", "fatal", "ready",
> +				  "handover", "stop-ack";
> +
> +		clocks = <&xo_board>;
> +		clock-names = "xo";
> +
> +		memory-region = <&adsp_fw_mem>;
> +
> +		qcom,smem-states = <&adsp_smp2p_out 0>;
> +		qcom,smem-state-names = "stop";
> +
> +		status = "disabled";
> +
> +		glink-edge {
> +			interrupts = <GIC_SPI 289 IRQ_TYPE_EDGE_RISING>;
> +
> +			qcom,remote-pid = <2>;
> +			mboxes = <&apcs_glb 8>;
> +
> +			label = "adsp";
> +		};
> +	};
> +
> +	remoteproc_cdsp: remoteproc-cdsp {
> +		compatible = "qcom,qcs404-cdsp-pas";
> +
> +		interrupts-extended = <&intc GIC_SPI 229 IRQ_TYPE_EDGE_RISING>,
> +				      <&cdsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +				      <&cdsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +				      <&cdsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +				      <&cdsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> +		interrupt-names = "wdog", "fatal", "ready",
> +				  "handover", "stop-ack";
> +
> +		clocks = <&xo_board>;
> +		clock-names = "xo";
> +
> +		memory-region = <&cdsp_fw_mem>;
> +
> +		qcom,smem-states = <&cdsp_smp2p_out 0>;
> +		qcom,smem-state-names = "stop";
> +
> +		status = "disabled";
> +
> +		glink-edge {
> +			interrupts = <GIC_SPI 141 IRQ_TYPE_EDGE_RISING>;
> +
> +			qcom,remote-pid = <5>;
> +			mboxes = <&apcs_glb 12>;
> +
> +			label = "cdsp";
> +		};
> +	};
> +
> +	remoteproc_wcss: remoteproc-wcss {
> +		compatible = "qcom,qcs404-wcss-pas";
> +
> +		interrupts-extended = <&intc GIC_SPI 153 IRQ_TYPE_EDGE_RISING>,
> +				      <&wcss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +				      <&wcss_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +				      <&wcss_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +				      <&wcss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> +		interrupt-names = "wdog", "fatal", "ready",
> +				  "handover", "stop-ack";

I can see that wcss remoteproc uses an additional smp2p interrupt called 
shutdown-ack
downstream you may want to skip wcss entry for now till the shutdown-ack 
gets posted,
reviewed and merged.

> +
> +		clocks = <&xo_board>;
> +		clock-names = "xo";
> +
> +		memory-region = <&wlan_fw_mem>;
> +
> +		qcom,smem-states = <&wcss_smp2p_out 0>;
> +		qcom,smem-state-names = "stop";
> +
> +		status = "disabled";
> +
> +		glink-edge {
> +			interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
> +
> +			qcom,remote-pid = <1>;
> +			mboxes = <&apcs_glb 16>;
> +
> +			label = "wcss";
> +		};
> +	};
> +
>  	reserved-memory {
>  		#address-cells = <2>;
>  		#size-cells = <2>;

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
