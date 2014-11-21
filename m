From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 21 Nov 2014 11:48:33 +0000
Subject: [RFC] add a struct page* parameter to dma_map_ops.unmap_page
In-Reply-To: <alpine.DEB.2.02.1411111644490.26318@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1411111644490.26318@kaball.uk.xensource.com>
Message-ID: <alpine.DEB.2.02.1411211147450.12596@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Nov 2014, Stefano Stabellini wrote:
> Hi all,
> I am writing this email to ask for your advice.
> 
> On architectures where dma addresses are different from physical
> addresses, it can be difficult to retrieve the physical address of a
> page from its dma address.
> 
> Specifically this is the case for Xen on arm and arm64 but I think that
> other architectures might have the same issue.
> 
> Knowing the physical address is necessary to be able to issue any
> required cache maintenance operations when unmap_page,
> sync_single_for_cpu and sync_single_for_device are called.
> 
> Adding a struct page* parameter to unmap_page, sync_single_for_cpu and
> sync_single_for_device would make Linux dma handling on Xen on arm and
> arm64 much easier and quicker.
> 
> I think that other drivers have similar problems, such as the Intel
> IOMMU driver having to call find_iova and walking down an rbtree to get
> the physical address in its implementation of unmap_page.
> 
> Callers have the struct page* in their hands already from the previous
> map_page call so it shouldn't be an issue for them.  A problem does
> exist however: there are about 280 callers of dma_unmap_page and
> pci_unmap_page. We have even more callers of the dma_sync_single_for_*
> functions.
> 
> 
> 
> Is such a change even conceivable? How would one go about it?
> 
> I think that Xen would not be the only one to gain from it, but I would
> like to have a confirmation from others: given the magnitude of the
> changes involved I would actually prefer to avoid them unless multiple
> drivers/archs/subsystems could really benefit from them.

Given the lack of interest from the community, I am going to drop this
idea.




> Cheers,
> 
> Stefano
> 
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index d5d3881..158a765 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -31,8 +31,9 @@ struct dma_map_ops {
>  			       unsigned long offset, size_t size,
>  			       enum dma_data_direction dir,
>  			       struct dma_attrs *attrs);
> -	void (*unmap_page)(struct device *dev, dma_addr_t dma_handle,
> -			   size_t size, enum dma_data_direction dir,
> +	void (*unmap_page)(struct device *dev, struct page *page,
> +			   dma_addr_t dma_handle, size_t size,
> +			   enum dma_data_direction dir,
>  			   struct dma_attrs *attrs);
>  	int (*map_sg)(struct device *dev, struct scatterlist *sg,
>  		      int nents, enum dma_data_direction dir,
> @@ -41,10 +42,10 @@ struct dma_map_ops {
>  			 struct scatterlist *sg, int nents,
>  			 enum dma_data_direction dir,
>  			 struct dma_attrs *attrs);
> -	void (*sync_single_for_cpu)(struct device *dev,
> +	void (*sync_single_for_cpu)(struct device *dev, struct page *page,
>  				    dma_addr_t dma_handle, size_t size,
>  				    enum dma_data_direction dir);
> -	void (*sync_single_for_device)(struct device *dev,
> +	void (*sync_single_for_device)(struct device *dev, struct page *page,
>  				       dma_addr_t dma_handle, size_t size,
>  				       enum dma_data_direction dir);
>  	void (*sync_sg_for_cpu)(struct device *dev,
> 
