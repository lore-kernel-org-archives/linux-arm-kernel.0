From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Tue, 17 Jul 2018 12:21:03 +0100
Subject: [PATCH 04/16] iommu: sva: Add support for private PASIDs
In-Reply-To: <20180518213500.31595-5-jcrouse@codeaurora.org>
References: <20180518213500.31595-1-jcrouse@codeaurora.org>
 <20180518213500.31595-5-jcrouse@codeaurora.org>
Message-ID: <c87ae21f-ac02-17fe-6d11-48d2840911e1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jordan,

Thanks for the patches, I finally got around testing them with SMMUv3.
It's an important feature, arguably more than SVA itself. I could pick
this one as part of the SVA series, what do you think?

Although I probably would have done the same, I dislike the interface
because it forces us to duplicate functions and IOMMU ops. The list is
small but growing:

iommu_map
iommu_map_sg
iommu_unmap
iommu_unmap_fast
iommu_iova_to_phys
iommu_tlb_range_add
iommu_flush_tlb_all

Each of these and their associated IOMMU op will have an iommu_sva_X
counterpart that takes one different argument. Modifying these functions
to take both a domain and a PASID argument would be more elegant. Or as
an intermediate solution, perhaps we could only change the IOMMU ops to
take an additional argument, like you did for map_sg?

In any case it requires invasive changes in lots of drivers and we can
always tidy up later, so unless Joerg has a preference I'd keep the
duplicates for now.

However, having to lookup pasid-to-io_mm on every map/unmap call is
cumbersome, especially since map/unmap are supposed to be as fast as
possible. iommu_sva_alloc_pasid should return a structure representing
the PASID instead of the value alone. The io_mm structure seems like a
good fit, and the device driver can access io_mm->pasid directly or via
an io_mm_get_pasid() function.

The new functions would then be:

struct io_mm *iommu_sva_alloc_pasid(domain, dev)
void iommu_sva_free_pasid(domain, io_mm)

int iommu_sva_map(io_mm, iova, paddr, size, prot)
size_t iommu_map_sg(io_mm, iova, sg, nents, prot)
size_t iommu_sva_unmap(io_mm, iova, size)
size_t iommu_sva_unmap_fast(io_mm, iova, size)
phys_addr_t iommu_sva_iova_to_phys(io_mm, iova)
void iommu_sva_flush_tlb_all(io_mm)
void iommu_sva_tlb_range_add(io_mm, iova, size)

A few more comments inline

On 18/05/18 22:34, Jordan Crouse wrote:
> Some older SMMU implementations that do not have a fully featured
> hardware PASID features have alternate workarounds for using multiple
> pagetables. For example, MSM GPUs have logic to automatically switch the
> user pagetable from hardware by writing the context bank directly.

The comment may be a bit too specific, sva_map/sva_unmap is also useful
for PASID-capable IOMMUs

> Support private PASIDs by creating a new io-pgtable instance map it
> to a PASID and provide the APIs for drivers to populate it manually.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
[...]
> +int iommu_sva_alloc_pasid(struct iommu_domain *domain, struct device *dev)
> +{
> +	int ret, pasid;
> +	struct io_mm *io_mm;
> +	struct iommu_sva_param *param = dev->iommu_param->sva_param;

We need a NULL check on the param, to ensure that the driver called
sva_device_init first.

> +
> +	if (!domain->ops->mm_attach || !domain->ops->mm_detach)
> +		return -ENODEV;
> +
> +	if (domain->ops->mm_alloc)

I'd rather make mm_alloc and mm_free mandatory, but if we do make them
optional, then we need to check that both mm_alloc and mm_free are
present, or both absent.

> +		io_mm = domain->ops->mm_alloc(domain, NULL, 0);
> +	else
> +		io_mm = kzalloc(sizeof(*io_mm), GFP_KERNEL);
> +
> +	if (IS_ERR(io_mm))
> +		return PTR_ERR(io_mm);
> +	if (!io_mm)
> +		return -ENOMEM;
> +
> +	io_mm->domain = domain;
> +	io_mm->type = IO_TYPE_PRIVATE;

This could be a IOMMU_SVA_FEAT_PRIVATE flag

> +
> +	idr_preload(GFP_KERNEL);
> +	spin_lock(&iommu_sva_lock);
> +	pasid = idr_alloc_cyclic(&iommu_pasid_idr, io_mm, param->min_pasid,
> +		param->max_pasid + 1, GFP_ATOMIC);
> +	io_mm->pasid = pasid;
> +	spin_unlock(&iommu_sva_lock);
> +	idr_preload_end();
> +
> +	if (pasid < 0) {
> +		kfree(io_mm);
> +		return pasid;
> +	}
> +
> +	ret = domain->ops->mm_attach(domain, dev, io_mm, false);

attach_domain should be true, otherwise the SMMUv3 driver won't write
the PASID table. But we should probably go through io_mm_attach here, to
make sure that PASID contexts are added to the mm list and cleaned up by
unbind_dev_all()

> +size_t iommu_sva_unmap(int pasid, unsigned long iova, size_t size)
> +{
> +	struct io_mm *io_mm = get_io_mm(pasid);
> +
> +	if (!io_mm || io_mm->type != IO_TYPE_PRIVATE)
> +		return -ENODEV;
> +
> +	return __iommu_unmap(io_mm->domain, &pasid, iova, size, false);

sync must be true here, and false in the unmap_fast() variant

> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_unmap);
> +
> +void iommu_sva_free_pasid(int pasid, struct device *dev)
> +{
> +	struct io_mm *io_mm = get_io_mm(pasid);
> +	struct iommu_domain *domain;
> +
> +	if (!io_mm || io_mm->type != IO_TYPE_PRIVATE)
> +		return;
> +
> +	domain = io_mm->domain;
> +
> +	domain->ops->mm_detach(domain, dev, io_mm, false);

Here too detach_domain should be true

> @@ -1841,16 +1854,23 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
>  
>  	/* unroll mapping in case something went wrong */
>  	if (ret)
> -		iommu_unmap(domain, orig_iova, orig_size - size);
> +		__iommu_unmap(domain, pasid, orig_iova, orig_size - size,
> +			pasid ? false : true);

sync should be true

> -	if (unlikely(ops->unmap == NULL ||
> -		     domain->pgsize_bitmap == 0UL))
> -		return 0;
> +	if (unlikely(domain->pgsize_bitmap == 0UL))
> +		return -0;

spurious '-'

Thanks,
Jean
