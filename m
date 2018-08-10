From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 10 Aug 2018 12:49:21 -0700
Subject: [PATCH 2/2] arm64: dts: sdm845: Add gpu and gmu device nodes
In-Reply-To: <20180808224701.7527-3-jcrouse@codeaurora.org>
References: <20180808224701.7527-1-jcrouse@codeaurora.org>
 <20180808224701.7527-3-jcrouse@codeaurora.org>
Message-ID: <153393056178.37448.16084112653118820084@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jordan Crouse (2018-08-08 15:47:01)
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index cdaabeb3c995..9fb90bb4ea1f 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -323,5 +323,126 @@
>                                 status = "disabled";
>                         };
>                 };
> +
> +               adreno_smmu: arm,smmu-adreno at 5040000 {
> +                       compatible = "qcom,msm8996-smmu-v2";
> +                       reg = <0x5040000 0x10000>;
> +                       #iommu-cells = <1>;
> +               #global-interrupts = <2>;
> +                       interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 364 IRQ_TYPE_EDGE_RISING>,
> +                            <GIC_SPI 365 IRQ_TYPE_EDGE_RISING>,
> +                            <GIC_SPI 366 IRQ_TYPE_EDGE_RISING>,
> +                            <GIC_SPI 367 IRQ_TYPE_EDGE_RISING>,
> +                            <GIC_SPI 368 IRQ_TYPE_EDGE_RISING>,
> +                            <GIC_SPI 369 IRQ_TYPE_EDGE_RISING>,
> +                            <GIC_SPI 370 IRQ_TYPE_EDGE_RISING>,
> +                            <GIC_SPI 371 IRQ_TYPE_EDGE_RISING>;
> +                       clocks = <&clock_gcc GCC_GPU_MEMNOC_GFX_CLK>,
> +                               <&clock_gcc GCC_GPU_CFG_AHB_CLK>;
> +                       clock-names = "bus", "iface";
> +
> +                       power-domains = <&clock_gpucc GPU_CX_GDSC>;
> +               };
> +
> +               gpu_opp_table: adreno-opp-table {

The OPP tables should be moved into the root of the tree. Nothing should
be under the SoC node without a reg property.

> +                       compatible = "operating-points-v2";
> +
> +                       opp-710000000 {
> +                               opp-hz = /bits/ 64 <710000000>;
> +                               qcom,level = <416>;
