From: sricharan@codeaurora.org (Sricharan)
Date: Tue, 24 Jan 2017 20:42:23 +0530
Subject: [PATCH 0/5] Implement SMMU passthrough using the default domain
In-Reply-To: <1484849955-1871-1-git-send-email-will.deacon@arm.com>
References: <1484849955-1871-1-git-send-email-will.deacon@arm.com>
Message-ID: <010801d27654$47b7e450$d727acf0$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

>Hi all,
>
>A number of people have expressed interest in having the SMMU come up in
>a passthrough configuration, and then allow subsequent translation for
>things such as VFIO. Rather than do this in each SMMU driver, it's much
>cleaner to allow the default domain to be configured to be something other
>than DMA.
>
>This patch series implements a command-line option to configure the
>default domain type. Currently, it supports "dma" and "identity" which
>is sufficient for the passthrough use-case.
>
>Tested on an ARM fastmodel.
>
>All feedback welcome,
>

Thanks for this series. We had a case with the GPU.
The GPU's iommu was setup by kernel and the GPU
also does dynamic updates for on-the-fly switching between
process pagetables.  GPU driver was not using DMA domain and
the GPU's firmware was always expecting to run out  of contextbank
 '0' (although not correct) , which was not the case after the DMA domain
was made default  as '0' was getting allocated for DMA domain and
there were concerns about reusing the DMA domain as well.
Now with this series, looks there is an way out of that that can be tried.

So should the default domain not be per device specific selectable ?

Regards,
 Sricharan



>Will
>
>--->8
>
>Will Deacon (5):
>  iommu/arm-smmu: Restrict domain attributes to UNMANAGED domains
>  iommu/arm-smmu: Install bypass S2CRs for IOMMU_DOMAIN_IDENTITY domains
>  iommu/arm-smmu-v3: Install bypass STEs for IOMMU_DOMAIN_IDENTITY
>    domains
>  arm64: dma-mapping: Only swizzle DMA ops for IOMMU_DOMAIN_DMA
>  iommu: Allow default domain type to be set on the kernel command line
>
> arch/arm64/mm/dma-mapping.c | 17 ++++++++++++-----
> drivers/iommu/arm-smmu-v3.c | 20 ++++++++++++++++++--
> drivers/iommu/arm-smmu.c    | 26 +++++++++++++++++++++++---
> drivers/iommu/iommu.c       | 19 +++++++++++++++++--
> 4 files changed, 70 insertions(+), 12 deletions(-)
>
>--
>2.1.4
>
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel at lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
