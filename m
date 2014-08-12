From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Mon, 11 Aug 2014 21:35:59 -0400
Subject: [PATCH v5 1/1] iommu-api: Add map_sg/unmap_sg functions
In-Reply-To: <1407797150-515-2-git-send-email-ohaugan@codeaurora.org>
References: <1407797150-515-1-git-send-email-ohaugan@codeaurora.org>
 <1407797150-515-2-git-send-email-ohaugan@codeaurora.org>
Message-ID: <20140812013559.GA25121@laptop.dumpdata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 11, 2014 at 03:45:50PM -0700, Olav Haugan wrote:
> Mapping and unmapping are more often than not in the critical path.
> map_sg and unmap_sg allows IOMMU driver implementations to optimize
> the process of mapping and unmapping buffers into the IOMMU page tables.
> 
> Instead of mapping a buffer one page at a time and requiring potentially
> expensive TLB operations for each page, this function allows the driver
> to map all pages in one go and defer TLB maintenance until after all
> pages have been mapped.
> 
> Additionally, the mapping operation would be faster in general since
> clients does not have to keep calling map API over and over again for
> each physically contiguous chunk of memory that needs to be mapped to a
> virtually contiguous region.
> 
> Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>

Thank you for changing it this way.


.. snip..
> +	for_each_sg(sg, s, nents, i) {
> +		phys_addr_t phys = page_to_phys(sg_page(s));
> +		size_t page_len = s->offset + s->length;
> +
> +		ret = iommu_map(domain, iova + offset, phys, page_len,
> +				prot);
> +		if (ret) {
> +			/* undo mappings already done */
> +			iommu_unmap(domain, iova, offset);

Don't we want then to unmap all of the scatter list instead of just
the last one?

> +			break;
> +		}
> +		offset += page_len;
> +	}
> +
> +	return ret;
> +}
