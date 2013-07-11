From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 11 Jul 2013 19:37:47 +0200
Subject: [PATCH v7 3/9] iommu/exynos: fix page table maintenance
In-Reply-To: <002b01ce797b$44d4ad10$ce7e0730$@samsung.com>
References: <002b01ce797b$44d4ad10$ce7e0730$@samsung.com>
Message-ID: <1933986.4vddYccClk@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Some minor nitpicks below.

On Friday, July 05, 2013 09:29:18 PM Cho KyongHo wrote:
> This prevents allocating lv2 page table for the lv1 page table entry
> that already has 1MB page mapping. In addition some BUG_ON() is
> changed to WARN_ON().
> 
> Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
> ---
>  drivers/iommu/exynos-iommu.c |   34 ++++++++++++++++++++++++++--------
>  1 files changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index e3be3e5..2bfe9fa 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -862,12 +862,14 @@ static unsigned long *alloc_lv2entry(unsigned long *sent, unsigned long iova,
>  		pent = kzalloc(LV2TABLE_SIZE, GFP_ATOMIC);
>  		BUG_ON((unsigned long)pent & (LV2TABLE_SIZE - 1));
>  		if (!pent)
> -			return NULL;
> +			return ERR_PTR(-ENOMEM);
>  
>  		*sent = mk_lv1ent_page(__pa(pent));
>  		*pgcounter = NUM_LV2ENTRIES;
>  		pgtable_flush(pent, pent + NUM_LV2ENTRIES);
>  		pgtable_flush(sent, sent + 1);
> +	} else if (lv1ent_section(sent)) {
> +		return ERR_PTR(-EADDRINUSE);
>  	}
>  
>  	return page_entry(sent, iova);
> @@ -944,16 +946,16 @@ static int exynos_iommu_map(struct iommu_domain *domain, unsigned long iova,
>  		pent = alloc_lv2entry(entry, iova,
>  					&priv->lv2entcnt[lv1ent_offset(iova)]);
>  
> -		if (!pent)
> -			ret = -ENOMEM;
> +		if (IS_ERR(pent))
> +			ret = PTR_ERR(pent);
>  		else
>  			ret = lv2set_page(pent, paddr, size,
>  					&priv->lv2entcnt[lv1ent_offset(iova)]);
>  	}
>  
>  	if (ret) {
> -		pr_debug("%s: Failed to map iova 0x%lx/0x%x bytes\n",
> -							__func__, iova, size);
> +		pr_err("%s: Failed(%d) to map iova 0x%#x bytes @ %#lx\n",
> +						__func__, ret, size, iova);
>  	}

Intendation is a bit weird, it should be more like:

		pr_err("%s: Failed(%d) to map iova 0x%#x bytes @ %#lx\n",
			__func__, ret, size, iova);

to be consistent with the rest of the driver.

You could have also removed superfluous braces while at it.

>  	spin_unlock_irqrestore(&priv->pgtablelock, flags);
> @@ -968,6 +970,7 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
>  	struct sysmmu_drvdata *data;
>  	unsigned long flags;
>  	unsigned long *ent;
> +	size_t err_page;
>  
>  	BUG_ON(priv->pgtable == NULL);
>  
> @@ -976,7 +979,8 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
>  	ent = section_entry(priv->pgtable, iova);
>  
>  	if (lv1ent_section(ent)) {
> -		BUG_ON(size < SECT_SIZE);
> +		if (WARN_ON(size < SECT_SIZE))
> +			goto err;
>  
>  		*ent = 0;
>  		pgtable_flush(ent, ent + 1);
> @@ -1008,7 +1012,8 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
>  	}
>  
>  	/* lv1ent_large(ent) == true here */
> -	BUG_ON(size < LPAGE_SIZE);
> +	if (WARN_ON(size < LPAGE_SIZE))
> +		goto err;
>  
>  	memset(ent, 0, sizeof(*ent) * SPAGES_PER_LPAGE);
>  	pgtable_flush(ent, ent + SPAGES_PER_LPAGE);
> @@ -1023,8 +1028,21 @@ done:
>  		sysmmu_tlb_invalidate_entry(data->dev, iova);
>  	spin_unlock_irqrestore(&priv->lock, flags);
>  
> -
>  	return size;
> +err:
> +	spin_unlock_irqrestore(&priv->pgtablelock, flags);
> +
> +	err_page = (
> +		((unsigned long)ent - (unsigned long)priv->pgtable)
> +			< (NUM_LV1ENTRIES * sizeof(long))

Maybe you could add LV1TABLE_SIZE define and use it here (there is
already a LV2TABLE_SIZE define)?

> +			   ) ?  SECT_SIZE : LPAGE_SIZE;

It also seems that err_page should be of unsigned long type, no need
to make it size_t one.

The above code is quite ugly currently, it could be rewritten into
something prettier, i.e.:

	err_page = (unsigned long)ent - (unsigned long)priv->pgtable;
	err_page = (err_page < LV1TABLE_SIZE) ? SECT_SIZE : LPAGE_SIZE;

> +	pr_err("%s: Failed due to size(%#lx) @ %#x is"\
> +		" smaller than page size %#x\n",
> +		__func__, iova, size, err_page);

Aren't iova and size arguments interchanged here?

> +
> +	       return 0;

There is an intendation issue here (extra whitespaces).

> +
>  }
>  
>  static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *domain,

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
