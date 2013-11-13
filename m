From: galak@codeaurora.org (Kumar Gala)
Date: Wed, 13 Nov 2013 05:15:04 -0600
Subject: [PATCHv4 5/7] iommu/tegra: smmu: Support "mmu-masters" binding
In-Reply-To: <1384158718-4756-6-git-send-email-hdoyu@nvidia.com>
References: <1384158718-4756-1-git-send-email-hdoyu@nvidia.com>
 <1384158718-4756-6-git-send-email-hdoyu@nvidia.com>
Message-ID: <A52C6E6B-9776-4408-83C5-066551D76896@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Nov 11, 2013, at 2:31 AM, Hiroshi Doyu <hdoyu@nvidia.com> wrote:

> Follow arm,smmu's "mmu-masters" binding.
> 
> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> ---
> Update:
> Newly added for v4. In v3, I used "nvidia,swgroups" and
> "nvidia,memory-clients" bindings.
> ---
> .../bindings/iommu/nvidia,tegra30-smmu.txt         |  28 ++++-
> drivers/iommu/tegra-smmu.c                         | 138 +++++++++++++++++----
> 2 files changed, 141 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
> index 89fb543..51884e9 100644
> --- a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
> @@ -8,9 +8,16 @@ Required properties:
> - nvidia,#asids : # of ASIDs
> - dma-window : IOVA start address and length.
> - nvidia,ahb : phandle to the ahb bus connected to SMMU.
> +- mmu-masters   : A list of phandles to device nodes representing bus
> +                  masters for which the SMMU can provide a translation
> +                  and their corresponding StreamIDs (see example below).
> +                  Each device node linked from this list must have a
> +                  "#stream-id-cells" property, indicating the number of
> +                  StreamIDs(swgroup ID) associated with it, which is defined
> +		  in "include/dt-bindings/memory/tegra-swgroup.h".
> 
> Example:
> -	smmu {
> +	iommu {
> 		compatible = "nvidia,tegra30-smmu";
> 		reg = <0x7000f010 0x02c
> 		       0x7000f1f0 0x010
> @@ -18,4 +25,23 @@ Example:
> 		nvidia,#asids = <4>;		/* # of ASIDs */
> 		dma-window = <0 0x40000000>;	/* IOVA start & length */
> 		nvidia,ahb = <&ahb>;
> +
> +		mmu-masters = <&host1x TEGRA_SWGROUP_HC>,
> +			      <&mpe TEGRA_SWGROUP_MPE>,
> +			      <&vi TEGRA_SWGROUP_VI>,
> +			      <&epp TEGRA_SWGROUP_EPP>,
> +			      <&isp TEGRA_SWGROUP_ISP>,
> +			      <&gr2d TEGRA_SWGROUP_G2>,
> +			      <&gr3d TEGRA_SWGROUP_NV TEGRA_SWGROUP_NV2>,
> +			      <&dc TEGRA_SWGROUP_DC>,
> +			      <&dcb TEGRA_SWGROUP_DCB>,
> +			      <&uarta TEGRA_SWGROUP_PPCS>,
> +			      <&uartb TEGRA_SWGROUP_PPCS>,
> +			      <&uartc TEGRA_SWGROUP_PPCS>,
> +			      <&uartd TEGRA_SWGROUP_PPCS>,
> +			      <&uarte TEGRA_SWGROUP_PPCS>,
> +			      <&sdhci0 TEGRA_SWGROUP_PPCS>,
> +			      <&sdhci1 TEGRA_SWGROUP_PPCS>,
> +			      <&sdhci2 TEGRA_SWGROUP_PPCS>,
> +			      <&sdhci3 TEGRA_SWGROUP_PPCS>;
> 	};

At first glance this seems backward from all other cases we have in which we usually have the device have a property that points back, like interrupt-parent.

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
