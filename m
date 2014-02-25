From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 25 Feb 2014 22:26:31 +0100
Subject: [PATCHv2 03/16] Documentation: dt: add OMAP iommu bindings
In-Reply-To: <1392315347-32967-4-git-send-email-s-anna@ti.com>
References: <1392315347-32967-1-git-send-email-s-anna@ti.com>
 <1392315347-32967-4-git-send-email-s-anna@ti.com>
Message-ID: <13151454.2tbkC7YZsi@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suman,

Thank you for the patch.

On Thursday 13 February 2014 12:15:34 Suman Anna wrote:
> From: Florian Vaussard <florian.vaussard@epfl.ch>
> 
> This patch adds the iommu bindings for all OMAP2+ SoCs. Apart from
> the standard bindings used by OMAP peripherals, this patch uses a
> 'dma-window' (already used by Tegra SMMU) and adds two OMAP custom
> bindings - 'ti,#tlb-entries' and 'ti,iommu-bus-err-back'.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> [s-anna at ti.com: split bindings document, add dra7 and bus error back]
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  .../devicetree/bindings/iommu/ti,omap-iommu.txt    | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644
>  Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
> 
> diff --git a/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
> b/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt new file mode
> 100644
> index 0000000..116492d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
> @@ -0,0 +1,28 @@
> +OMAP2+ IOMMU
> +
> +Required properties:
> +- compatible : Should be one of,
> +		"ti,omap2-iommu" for OMAP2/OMAP3 IOMMU instances
> +		"ti,omap4-iommu" for OMAP4/OMAP5 IOMMU instances
> +		"ti,dra7-iommu" for DRA7xx IOMMU instances
> +- ti,hwmods  : Name of the hwmod associated with the IOMMU instance
> +- reg        : Address space for the configuration registers
> +- interrupts : Interrupt specifier for the IOMMU instance
> +- dma-window : IOVA start address and length

Isn't the dma window more of a system configuration property than a hardware 
property ? How do you expect it to be set ?

> +Optional properties:
> +- ti,#tlb-entries : Number of entries in the translation look-aside buffer.
> +                    Should be either 8 or 32 (default: 32)
> +- ti,iommu-bus-err-back : Indicates the IOMMU instance supports throwing
> +		          back a bus error response on MMU faults.

Do these features vary per IOMMU instance or per IOMMU model ? In the latter 
case they could be inferred from the compatible string by the driver without 
requiring them to be explicit in DT (whether you want to do so is left to you 
though).

> +Example:
> +	/* OMAP3 ISP MMU */
> +	mmu_isp: mmu at 480bd400 {
> +		compatible = "ti,omap2-iommu";
> +		reg = <0x480bd400 0x80>;
> +		interrupts = <24>;
> +		ti,hwmods = "mmu_isp";
> +		ti,#tlb-entries = <8>;
> +		dma-window = <0 0xfffff000>;
> +	};

-- 
Regards,

Laurent Pinchart
