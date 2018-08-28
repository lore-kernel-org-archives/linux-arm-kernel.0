From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Tue, 28 Aug 2018 16:00:32 +0530
Subject: [PATCH 5/9] arm64: dts: sdm845: Add gpu and gmu device nodes
In-Reply-To: <20180827151112.25211-6-jcrouse@codeaurora.org>
References: <20180827151112.25211-1-jcrouse@codeaurora.org>
 <20180827151112.25211-6-jcrouse@codeaurora.org>
Message-ID: <CAFp+6iHFB1Z9zQ4Uitt=4xCh+G+bfK3Xsjo=iMSPTveuTxwWsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jordan,

On Mon, Aug 27, 2018 at 8:42 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> Add the nodes to describe the Adreno GPU and GMU devices.
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 121 +++++++++++++++++++++++++++
>  1 file changed, 121 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index cdaabeb3c995..10db0ceb3699 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -192,6 +192,59 @@
>                 method = "smc";
>         };
>
> +gpu_opp_table: adreno-opp-table {
> +               compatible = "operating-points-v2-qcom-level";
> +
> +               opp-710000000 {
> +                       opp-hz = /bits/ 64 <710000000>;
> +                       qcom,level = <416>;
> +               };
> +
> +               opp-675000000 {
> +                       opp-hz = /bits/ 64 <675000000>;
> +                       qcom,level = <384>;
> +               };
> +
> +               opp-596000000 {
> +                       opp-hz = /bits/ 64 <596000000>;
> +                       qcom,level = <320>;
> +               };
> +
> +               opp-520000000 {
> +                       opp-hz = /bits/ 64 <520000000>;
> +                       qcom,level = <256>;
> +               };
> +
> +               opp-414000000 {
> +                       opp-hz = /bits/ 64 <414000000>;
> +                       qcom,level = <192>;
> +               };
> +
> +               opp-342000000 {
> +                       opp-hz = /bits/ 64 <342000000>;
> +                       qcom,level = <128>;
> +               };
> +
> +               opp-257000000 {
> +                       opp-hz = /bits/ 64 <257000000>;
> +                       qcom,level = <64>;
> +               };
> +       };
> +
> +       gmu_opp_table: adreno-gmu-opp-table {
> +               compatible = "operating-points-v2-qcom-level";
> +
> +               opp-400000000 {
> +                       opp-hz = /bits/ 64 <400000000>;
> +                       qcom,level = <128>;
> +               };
> +
> +               opp-200000000 {
> +                       opp-hz = /bits/ 64 <200000000>;
> +                       qcom,level = <48>;
> +               };
> +       };
> +
>         soc: soc {
>                 #address-cells = <1>;
>                 #size-cells = <1>;
> @@ -323,5 +376,73 @@
>                                 status = "disabled";
>                         };
>                 };
> +
> +               adreno_smmu: adreno-smmu at 5040000 {

iommu at 5040000 as pointed out by Rob in [1]

> +                       compatible = "qcom,sdm845-smmu-v2", "qcom,smmu-v2";
> +                       reg = <0x5040000 0x10000>;
> +                       #iommu-cells = <1>;
> +                       #global-interrupts = <2>;
> +                       interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <GIC_SPI 364 IRQ_TYPE_EDGE_RISING>,
> +                                       <GIC_SPI 365 IRQ_TYPE_EDGE_RISING>,
> +                                       <GIC_SPI 366 IRQ_TYPE_EDGE_RISING>,
> +                                       <GIC_SPI 367 IRQ_TYPE_EDGE_RISING>,
> +                                       <GIC_SPI 368 IRQ_TYPE_EDGE_RISING>,
> +                                       <GIC_SPI 369 IRQ_TYPE_EDGE_RISING>,
> +                                       <GIC_SPI 370 IRQ_TYPE_EDGE_RISING>,
> +                                       <GIC_SPI 371 IRQ_TYPE_EDGE_RISING>;
> +                       clocks = <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
> +                               <&gcc GCC_GPU_CFG_AHB_CLK>;
> +                       clock-names = "bus", "iface";
> +
> +                       power-domains = <&gpucc GPU_CX_GDSC>;

and for this you need to include the gpucc dt-bindings header which is coming
from Amit's gpucc driver patch.

[1] https://patchwork.kernel.org/patch/10534999/

Best regards
Vivek

[snip]

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
