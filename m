From: B16395@freescale.com (Sethi Varun-B16395)
Date: Thu, 25 Apr 2013 17:42:12 +0000
Subject: [PATCH 13/21] iommu: tegra: print dma_addr_t using %lld
In-Reply-To: <1366910944-3033663-14-git-send-email-arnd@arndb.de>
References: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
 <1366910944-3033663-14-git-send-email-arnd@arndb.de>
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D4BD243@039-SN2MPN1-011.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
I already submitted a patch to fix this.
http://permalink.gmane.org/gmane.linux.kernel.iommu/2036

Regards
Varun

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Thursday, April 25, 2013 10:59 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org; Arnd Bergmann; Sethi Varun-B16395;
> Joerg Roedel
> Subject: [PATCH 13/21] iommu: tegra: print dma_addr_t using %lld
> 
> The code was recently changed to work for builds with a 64 bit
> dma_addr_t, but the printk unconditionally uses a format string for an
> "long" variable, which is always wrong as the dma_add_t is now either
> 'unsigned int' or 'unsigned long long'
> depending on configuration.
> 
> The easiest solution is to cast the variable to u64 and print it as a 64
> bit value.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Varun Sethi <Varun.Sethi@freescale.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> ---
>  drivers/iommu/tegra-gart.c | 3 ++-
>  drivers/iommu/tegra-smmu.c | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> index 4aec8be..ebbdd82 100644
> --- a/drivers/iommu/tegra-gart.c
> +++ b/drivers/iommu/tegra-gart.c
> @@ -295,7 +295,8 @@ static phys_addr_t gart_iommu_iova_to_phys(struct
> iommu_domain *domain,
> 
>  	pa = (pte & GART_PAGE_MASK);
>  	if (!pfn_valid(__phys_to_pfn(pa))) {
> -		dev_err(gart->dev, "No entry for %08lx:%08x\n", iova, pa);
> +		dev_err(gart->dev, "No entry for %08llx:%pa\n",
> +				(u64)iova, &pa);
>  		gart_dump_table(gart);
>  		return -EINVAL;
>  	}
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index bc9b599..ef2a120 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -772,7 +772,7 @@ static phys_addr_t smmu_iommu_iova_to_phys(struct
> iommu_domain *domain,
>  	pfn = *pte & SMMU_PFN_MASK;
>  	WARN_ON(!pfn_valid(pfn));
>  	dev_dbg(as->smmu->dev,
> -		"iova:%08lx pfn:%08lx asid:%d\n", iova, pfn, as->asid);
> +		"iova:%08llx pfn:%08lx asid:%d\n", (u64)iova, pfn, as->asid);
> 
>  	spin_unlock_irqrestore(&as->lock, flags);
>  	return PFN_PHYS(pfn);
> --
> 1.8.1.2
> 
