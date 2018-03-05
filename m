From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Mar 2018 13:38:59 -0600
Subject: [PATCH 1/2] dt-bindings: Document qcom,adreno-gmu
In-Reply-To: <20180302215638.6145-2-jcrouse@codeaurora.org>
References: <20180302215638.6145-1-jcrouse@codeaurora.org>
 <20180302215638.6145-2-jcrouse@codeaurora.org>
Message-ID: <CAL_Jsq+OJ0jon2uFb6oMKjZuw4iPQxkxfBrbDyMN-BrNZfTRzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 2, 2018 at 3:56 PM, Jordan Crouse <jcrouse@codeaurora.org> wrote:
> Document the device tree bindings for the Adreno GMU device
> available on Adreno a6xx targets.
>
> Change-Id: I3cfd5fb35ab0045e39905ff12393006e60f1a124

Gerrit!

> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>  .../devicetree/bindings/display/msm/gmu.txt        | 54 ++++++++++++++++++++++
>  .../devicetree/bindings/display/msm/gpu.txt        | 10 +++-
>  2 files changed, 62 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/msm/gmu.txt
>
> diff --git a/Documentation/devicetree/bindings/display/msm/gmu.txt b/Documentation/devicetree/bindings/display/msm/gmu.txt
> new file mode 100644
> index 000000000000..f65bb49fff36
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/msm/gmu.txt
> @@ -0,0 +1,54 @@
> +Qualcomm adreno/snapdragon GMU (Graphics management unit)
> +
> +The GMU is a programmable power controller for the GPU. the CPU controls the
> +GMU which in turn handles power controls for the GPU.
> +
> +Required properties:
> +- compatible:
> +  * "qcom,adreno-gmu"

Kind of generic. All the features are discoverable?

> +- reg: Physical base address and length of the GMU registers.
> +- reg-names: Matching names for the register regions
> +  * "gmu"
> +  * "gmu_pdc"
> +- interrupts: The interrupt signals from the GMU.
> +- interrupt-names: Matching names for the interrupts
> +  * "hfi"
> +  * "gmu"
> +- clocks: phandles to the device clocks
> +- clock-names: Matching names for the clocks
> +   * "gmu"
> +   * "cxo"
> +   * "axi"
> +   * "mnoc"
> +- power-domains: should be <&clock_gpucc GPU_CX_GDSC>
> +- iommus: phandle to the adreno iommu
> +- operating-points-v2: phandle to the OPP operating points
> +
> +Example:
> +
> +/ {
> +       ...
> +
> +       gmu: gmu at 506a000 {
> +               compatible="qcom,adreno-gmu";
> +
> +               reg = <0x506a000 0x30000>,
> +                       <0xb200000 0x300000>;
> +               reg-names = "gmu", "gmu_pdc";
> +
> +               interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
> +                       <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
> +               interrupt-names = "hfi", "gmu";
> +
> +               clocks = <&clock_gpucc GPU_CC_CX_GMU_CLK>,
> +                       <&clock_gpucc GPU_CC_CXO_CLK>,
> +                       <&clock_gcc GCC_DDRSS_GPU_AXI_CLK>,
> +                       <&clock_gcc GCC_GPU_MEMNOC_GFX_CLK>;
> +               clock-names = "gmu", "cxo", "axi", "memnoc";
> +
> +               power-domains = <&clock_gpucc GPU_CX_GDSC>;
> +               iommus = <&adreno_smmu 5>;
> +
> +       i       operating-points-v2 = <&gmu_opp_table>;
> +       };
> +};
> diff --git a/Documentation/devicetree/bindings/display/msm/gpu.txt b/Documentation/devicetree/bindings/display/msm/gpu.txt
> index 43fac0fe09bb..0e207498edd3 100644
> --- a/Documentation/devicetree/bindings/display/msm/gpu.txt
> +++ b/Documentation/devicetree/bindings/display/msm/gpu.txt
> @@ -8,12 +8,18 @@ Required properties:
>    with the chip-id.
>  - reg: Physical base address and length of the controller's registers.
>  - interrupts: The interrupt signal from the gpu.
> -- clocks: device clocks
> +
> +Optional properties.
> +- clocks: device clocks. Required for a3xx, a4xx and a5xx targets. a6xx and
> +  newer with a GMU attached do not have direct clock control from the CPU and
> +  do not need to provide clock properties.
>    See ../clocks/clock-bindings.txt for details.
> -- clock-names: the following clocks are required:
> +- clock-names: the following clocks can be provided:
>    * "core"
>    * "iface"
>    * "mem_iface"
> +- gmu: For a6xx and newer targets a phandle to the GMU device that will

qcom,gmu

> +  control the power for the GPU
>
>  Example:
>
> --
> 2.16.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
