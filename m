From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 1 Feb 2013 14:54:57 +0100
Subject: [PATCH v6 1/4] iommu/shmobile: Add iommu driver for Renesas
 IPMMU modules
In-Reply-To: <1358765669-14567-2-git-send-email-hdk@igel.co.jp>
References: <1358765669-14567-1-git-send-email-hdk@igel.co.jp>
 <1358765669-14567-2-git-send-email-hdk@igel.co.jp>
Message-ID: <20130201135456.GG25591@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 07:54:26PM +0900, Hideki EIRAKU wrote:
> This is the Renesas IPMMU driver and IOMMU API implementation.
> 
> The IPMMU module supports the MMU function and the PMB function.  The
> MMU function provides address translation by pagetable compatible with
> ARMv6.  The PMB function provides address translation including
> tile-linear translation.  This patch implements the MMU function.
> 
> The iommu driver does not register a platform driver directly because:
> - the register space of the MMU function and the PMB function
>   have a common register (used for settings flush), so they should ideally
>   have a way to appropriately share this register.
> - the MMU function uses the IOMMU API while the PMB function does not.
> - the two functions may be used independently.
> 
> Signed-off-by: Hideki EIRAKU <hdk@igel.co.jp>

The patch looks good in general. Just one question inline.

> +static int pgtable_alloc(struct shmobile_iommu_domain_pgtable *pgtable,
> +			 struct kmem_cache *cache, size_t size)
> +{
> +	pgtable->pgtable = kmem_cache_zalloc(cache, GFP_ATOMIC);
> +	if (!pgtable->pgtable)
> +		return -ENOMEM;
> +	pgtable->handle = dma_map_single(NULL, pgtable->pgtable, size,
> +					 DMA_TO_DEVICE);
> +	return 0;
> +}

Why is it necessary to call dma_map_single() for IOMMU page-tables?
usually the dma_* functions call into IOMMU drivers, so why are they
used inside an IOMMU driver?

Regards,

	Joerg
