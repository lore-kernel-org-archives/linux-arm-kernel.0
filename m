From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 10 Nov 2014 18:41:11 +0000
Subject: [PATCH v8 03/13] xen/arm: if(pfn_valid(pfn)) call native dma_ops
In-Reply-To: <1415636045-24669-3-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1411101607130.22875@kaball.uk.xensource.com>
 <1415636045-24669-3-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20141110184111.GH25609@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 10, 2014 at 04:13:55PM +0000, Stefano Stabellini wrote:
>  void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
>  		size_t size, enum dma_data_direction dir,
> -		struct dma_attrs *attrs);
> +		struct dma_attrs *attrs)
> +{
> +	unsigned long pfn = PFN_DOWN(handle);
> +	/* Dom0 is mapped 1:1, so calling pfn_valid on a foreign mfn will
> +	 * always return false. If the page is local we can safely call the
> +	 * native dma_ops function, otherwise we call the xen specific
> +	 * function. */
> +	if (pfn_valid(pfn)) {
> +		if (__generic_dma_ops(hwdev)->unmap_page)
> +			__generic_dma_ops(hwdev)->unmap_page(hwdev, handle, size, dir, attrs);

Similarly here, do we need the unmap_page check? dma_map_page() does not
do it.

-- 
Catalin
