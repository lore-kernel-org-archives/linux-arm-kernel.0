From: roger.pau@citrix.com (=?UTF-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?=)
Date: Thu, 20 Aug 2015 10:14:11 +0200
Subject: [PATCH v3 16/20] block/xen-blkback: Make it running on 64KB page
 granularity
In-Reply-To: <1438966019-19322-17-git-send-email-julien.grall@citrix.com>
References: <1438966019-19322-1-git-send-email-julien.grall@citrix.com>
 <1438966019-19322-17-git-send-email-julien.grall@citrix.com>
Message-ID: <55D58C53.1020601@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El 07/08/15 a les 18.46, Julien Grall ha escrit:
> The PV block protocol is using 4KB page granularity. The goal of this
> patch is to allow a Linux using 64KB page granularity behaving as a
> block backend on a non-modified Xen.
> 
> It's only necessary to adapt the ring size and the number of request per
> indirect frames. The rest of the code is relying on the grant table
> code.
> 
> Note that the grant table code is allocating a Linux page per grant
> which will result to waste 6OKB for every grant when Linux is using 64KB
> page granularity. This could be improved by sharing the page between
> multiple grants.
> 
> Signed-off-by: Julien Grall <julien.grall@citrix.com>

LGTM:

Acked-by: Roger Pau Monn? <roger.pau@citrix.com>

> ---
> 
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: "Roger Pau Monn?" <roger.pau@citrix.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: David Vrabel <david.vrabel@citrix.com>
> 
> Improvement such as support of 64KB grant is not taken into
> consideration in this patch because we have the requirement to run a
> Linux using 64KB pages on a non-modified Xen.
> 
> This has been tested only with a loop device. I plan to test passing
> hard drive partition but I didn't yet convert the swiotlb code.
> 
>     Changes in v3:
>         - Use DIV_ROUND_UP in INDIRECT_PAGES to avoid a line over 80
>         characters
> ---
>  drivers/block/xen-blkback/blkback.c |  5 +++--
>  drivers/block/xen-blkback/common.h  | 17 +++++++++++++----
>  drivers/block/xen-blkback/xenbus.c  |  9 ++++++---
>  3 files changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
> index ced9677..d5cce8c 100644
> --- a/drivers/block/xen-blkback/blkback.c
> +++ b/drivers/block/xen-blkback/blkback.c
> @@ -961,7 +961,7 @@ static int xen_blkbk_parse_indirect(struct blkif_request *req,
>  		seg[n].nsec = segments[i].last_sect -
>  			segments[i].first_sect + 1;
>  		seg[n].offset = (segments[i].first_sect << 9);
> -		if ((segments[i].last_sect >= (PAGE_SIZE >> 9)) ||
> +		if ((segments[i].last_sect >= (XEN_PAGE_SIZE >> 9)) ||
>  		    (segments[i].last_sect < segments[i].first_sect)) {
>  			rc = -EINVAL;
>  			goto unmap;
> @@ -1210,6 +1210,7 @@ static int dispatch_rw_block_io(struct xen_blkif *blkif,
>  
>  	req_operation = req->operation == BLKIF_OP_INDIRECT ?
>  			req->u.indirect.indirect_op : req->operation;
> +
>  	if ((req->operation == BLKIF_OP_INDIRECT) &&
>  	    (req_operation != BLKIF_OP_READ) &&
>  	    (req_operation != BLKIF_OP_WRITE)) {
> @@ -1268,7 +1269,7 @@ static int dispatch_rw_block_io(struct xen_blkif *blkif,
>  			seg[i].nsec = req->u.rw.seg[i].last_sect -
>  				req->u.rw.seg[i].first_sect + 1;
>  			seg[i].offset = (req->u.rw.seg[i].first_sect << 9);
> -			if ((req->u.rw.seg[i].last_sect >= (PAGE_SIZE >> 9)) ||
> +			if ((req->u.rw.seg[i].last_sect >= (XEN_PAGE_SIZE >> 9)) ||
>  			    (req->u.rw.seg[i].last_sect <
>  			     req->u.rw.seg[i].first_sect))
>  				goto fail_response;
> diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
> index 45a044a..68e87a0 100644
> --- a/drivers/block/xen-blkback/common.h
> +++ b/drivers/block/xen-blkback/common.h
> @@ -39,6 +39,7 @@
>  #include <asm/pgalloc.h>
>  #include <asm/hypervisor.h>
>  #include <xen/grant_table.h>
> +#include <xen/page.h>
>  #include <xen/xenbus.h>
>  #include <xen/interface/io/ring.h>
>  #include <xen/interface/io/blkif.h>
> @@ -51,12 +52,20 @@ extern unsigned int xen_blkif_max_ring_order;
>   */
>  #define MAX_INDIRECT_SEGMENTS 256
>  
> -#define SEGS_PER_INDIRECT_FRAME \
> -	(PAGE_SIZE/sizeof(struct blkif_request_segment))
> +/*
> + * Xen use 4K pages. The guest may use different page size (4K or 64K)

Please expand this comment to mention that it only applies to ARM, for
now on x86 the backend and the frontend always use the same page size.

Roger.
