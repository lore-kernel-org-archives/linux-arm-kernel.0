From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 30 Jun 2014 21:42:10 +0200
Subject: [RFC/PATCH 2/7] iommu-api: Add map_range/unmap_range functions
In-Reply-To: <1404147116-4598-3-git-send-email-ohaugan@codeaurora.org>
References: <1404147116-4598-1-git-send-email-ohaugan@codeaurora.org>
 <1404147116-4598-3-git-send-email-ohaugan@codeaurora.org>
Message-ID: <20140630194209.GC32594@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 09:51:51AM -0700, Olav Haugan wrote:
[...]
> +int iommu_map_range(struct iommu_domain *domain, unsigned int iova,
> +		    struct scatterlist *sg, unsigned int len, int prot)
> +{
> +	if (unlikely(domain->ops->map_range == NULL))
> +		return -ENODEV;

Should we perhaps make this mandatory? For drivers that don't provide it
we could implement a generic helper that wraps iommu_{map,unmap}().

> +
> +	BUG_ON(iova & (~PAGE_MASK));
> +
> +	return domain->ops->map_range(domain, iova, sg, len, prot);
> +}
> +EXPORT_SYMBOL_GPL(iommu_map_range);
> +
> +int iommu_unmap_range(struct iommu_domain *domain, unsigned int iova,
> +		      unsigned int len)
> +{
> +	if (unlikely(domain->ops->unmap_range == NULL))
> +		return -ENODEV;
> +
> +	BUG_ON(iova & (~PAGE_MASK));
> +
> +	return domain->ops->unmap_range(domain, iova, len);
> +}
> +EXPORT_SYMBOL_GPL(iommu_unmap_range);

Could these be renamed iommu_{map,unmap}_sg() instead to make it more
obvious what exactly they map? And perhaps this could take an sg_table
instead, which already provides a count and is a very common structure
used in drivers (and the DMA mapping API).

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140630/40852b16/attachment-0001.sig>
