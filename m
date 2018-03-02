From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Fri, 2 Mar 2018 12:27:58 +0000
Subject: [PATCH 04/14] iommu: sva: Add support for pasid allocation
In-Reply-To: <20180221225924.30737-5-jcrouse@codeaurora.org>
References: <20180221225924.30737-1-jcrouse@codeaurora.org>
 <20180221225924.30737-5-jcrouse@codeaurora.org>
Message-ID: <b71fefa1-2fdf-f14f-9e7a-0e525a103049@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/02/18 22:59, Jordan Crouse wrote:
[...]
> +int iommu_sva_alloc_pasid(struct iommu_domain *domain, struct device *dev)
> +{
> +	int ret, pasid;
> +	struct io_pasid *io_pasid;
> +
> +	if (!domain->ops->pasid_alloc || !domain->ops->pasid_free)
> +		return -ENODEV;
> +
> +	io_pasid = kzalloc(sizeof(*io_pasid), GFP_KERNEL);
> +	if (!io_pasid)
> +		return -ENOMEM;
> +
> +	io_pasid->domain = domain;
> +	io_pasid->base.type = IO_TYPE_PASID;
> +
> +	idr_preload(GFP_KERNEL);
> +	spin_lock(&iommu_sva_lock);
> +	pasid = idr_alloc_cyclic(&iommu_pasid_idr, &io_pasid->base,
> +		1, (1 << 31), GFP_ATOMIC);

To be usable by other IOMMUs, this should restrict the PASID range to what
the IOMMU and the device support like io_mm_alloc(). In your case 31 bits,
but with PCI PASID it depends on the PASID capability and the SMMU
SubstreamID range.

For this reason I think device drivers should call iommu_sva_device_init()
once, even for the alloc_pasid() API. For SMMUv2 I guess it will be a NOP,
but other IOMMUs will allocate PASID tables and enable features in the
device. In addition, knowing that all users of the API call
iommu_sva_device_init()/shutdown() could allow us to allocate and enable
stuff lazily in the future.

It would also allow a given device driver to use both
iommu_sva_pasid_alloc() and iommu_sva_bind()@the same time. So that the
driver can assigns contexts to userspace and still use some of them for
management.

[...]
> +int iommu_sva_map(int pasid, unsigned long iova,
> +	      phys_addr_t paddr, size_t size, int prot)

It would be nice to factor iommu_map(), since this logic for map, map_sg
and unmap should be the same regardless of the PASID argument.

For example
- iommu_sva_map(domain, pasid, ...)
- iommu_map(domain, ...)

both call
- __iommu_map(domain, pasid, ...)

which calls either
- ops->map(domain, ...)
- ops->sva_map(domain, pasid, ...)

[...]
> @@ -347,6 +353,15 @@ struct iommu_ops {
>  	int (*page_response)(struct iommu_domain *domain, struct device *dev,
>  			     struct page_response_msg *msg);
>  
> +	int (*pasid_alloc)(struct iommu_domain *domain, struct device *dev,
> +		int pasid);
> +	int (*sva_map)(struct iommu_domain *domain, int pasid,
> +		       unsigned long iova, phys_addr_t paddr, size_t size,
> +		       int prot);
> +	size_t (*sva_unmap)(struct iommu_domain *domain, int pasid,
> +			    unsigned long iova, size_t size);
> +	void (*pasid_free)(struct iommu_domain *domain, int pasid);
> +

Hmm, now IOMMU has the following ops:

* mm_alloc(): allocates a shared mm structure
* mm_attach(): writes the entry in the PASID table
* mm_detach(): removes the entry from the PASID table and invalidates it
* mm_free(): free shared mm
* pasid_alloc(): allocates a pasid structure (which I usually call
"private mm") and write the entry in the PASID table (or call
install_pasid() for SMMUv2)
* pasid_free(): remove from the PASID table (or call remove_pasid()) and
free the pasid structure.

Splitting mm_alloc and mm_attach is necessary because the io_mm in my case
can be shared between devices (allocated once, attached multiple times).
In your case a PASID is private to one device so only one callback is
needed. However mm_alloc+mm_attach will do roughly the same as
pasid_alloc, so to reduce redundancy in iommu_ops, maybe we could reuse
mm_alloc and mm_attach for the private PASID case?

Thanks,
Jean
