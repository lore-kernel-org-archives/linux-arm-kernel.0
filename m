From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Tue, 12 Nov 2013 09:45:00 -0500
Subject: [Xen-devel] [PATCH 1/2] swiotlb-xen: add missing
 xen_dma_map_page call
In-Reply-To: <1384265520-6833-1-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1311121404590.26077@kaball.uk.xensource.com>
 <1384265520-6833-1-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20131112144500.GB9435@phenom.dumpdata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 12, 2013 at 02:11:59PM +0000, Stefano Stabellini wrote:
> swiotlb-xen is missing a xen_dma_map_page call in
> xen_swiotlb_map_sg_attrs, in the slow path.

s/slow/bounce buffer/ I believe?
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> ---
>  drivers/xen/swiotlb-xen.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index a224bc7..1eac073 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -555,6 +555,11 @@ xen_swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
>  				sg_dma_len(sgl) = 0;
>  				return 0;
>  			}
> +			xen_dma_map_page(hwdev, pfn_to_page(map >> PAGE_SHIFT),
> +						map & ~PAGE_MASK,
> +						sg->length,
> +						dir,
> +						attrs);
>  			sg->dma_address = xen_phys_to_bus(map);
>  		} else {
>  			/* we are not interested in the dma_addr returned by
> -- 
> 1.7.2.5
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel at lists.xen.org
> http://lists.xen.org/xen-devel
