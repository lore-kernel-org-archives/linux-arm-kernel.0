From: roger.pau@citrix.com (=?UTF-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?=)
Date: Tue, 21 Jul 2015 13:06:42 +0200
Subject: [PATCH v2 15/20] block/xen-blkfront: Make it running on 64KB
 page granularity
In-Reply-To: <1436474552-31789-16-git-send-email-julien.grall@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-16-git-send-email-julien.grall@citrix.com>
Message-ID: <55AE27C2.8090803@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El 09/07/15 a les 22.42, Julien Grall ha escrit:
> From: Julien Grall <julien.grall@linaro.org>
> 
> The PV block protocol is using 4KB page granularity. The goal of this
> patch is to allow a Linux using 64KB page granularity using block
> device on a non-modified Xen.
> 
> The block API is using segment which should at least be the size of a
                         ^ segments
> Linux page. Therefore, the driver will have to break the page in chunk
                                                            chunks ^
> of 4K before giving the page to the backend.
> 
> Breaking a 64KB segment in 4KB chunk will result to have some chunk with
> no data.

I would rewrite this as:

Breaking a 64KB page into 4KB chunks can result in chunks with no data.

> As the PV protocol always require to have data in the chunk, we
> have to count the number of Xen page which will be in use and avoid to
                                  ^ pages             remove the "to" ^
> sent empty chunk.
  ^ sending empty chunks
> 
> Note that, a pre-defined number of grant is reserved before preparing
           ^ no coma                 ^ grants are
> the request. This pre-defined number is based on the number and the
> maximum size of the segments. If each segment contain a very small
                                                ^ contains
> amount of data, the driver may reserve too much grant (16 grant is
                                             ^ many grants? ^ grants are
> reserved per segment with 64KB page granularity).
> 
> Futhermore, in the case of persistent grant we allocate one Linux page
  ^ Furthermore  ^ case of using persistent grants
> per grant although only the 4KB of the page will be effectively use.
                             ^ initial                ^ used.
> This could be improved by share the page with multiple grants.
                            ^ sharing the page between
> 
> Signed-off-by: Julien Grall <julien.grall@citrix.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Roger Pau Monn? <roger.pau@citrix.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: David Vrabel <david.vrabel@citrix.com>

This looks much better now, thanks.

Acked-by: Roger Pau Monn? <roger.pau@citrix.com>

> ---
> 
> Improvement such as support 64KB grant is not taken into consideration in
> this patch because we have the requirement to run a Linux using 64KB page
> on a non-modified Xen.
> 
>     Changes in v2:
>         - Use gnttab_foreach_grant to split a Linux page into grant
> ---
>  drivers/block/xen-blkfront.c | 304 ++++++++++++++++++++++++++++---------------
>  1 file changed, 198 insertions(+), 106 deletions(-)
> 
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index 95fd067..644ba76 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -77,6 +77,7 @@ struct blk_shadow {
>  	struct grant **grants_used;
>  	struct grant **indirect_grants;
>  	struct scatterlist *sg;
> +	unsigned int num_sg;
>  };
>  
>  struct split_bio {
> @@ -106,8 +107,8 @@ static unsigned int xen_blkif_max_ring_order;
>  module_param_named(max_ring_page_order, xen_blkif_max_ring_order, int, S_IRUGO);
>  MODULE_PARM_DESC(max_ring_page_order, "Maximum order of pages to be used for the shared ring");
>  
> -#define BLK_RING_SIZE(info) __CONST_RING_SIZE(blkif, PAGE_SIZE * (info)->nr_ring_pages)
> -#define BLK_MAX_RING_SIZE __CONST_RING_SIZE(blkif, PAGE_SIZE * XENBUS_MAX_RING_PAGES)
> +#define BLK_RING_SIZE(info) __CONST_RING_SIZE(blkif, XEN_PAGE_SIZE * (info)->nr_ring_pages)
> +#define BLK_MAX_RING_SIZE __CONST_RING_SIZE(blkif, XEN_PAGE_SIZE * XENBUS_MAX_RING_PAGES)
>  /*
>   * ring-ref%i i=(-1UL) would take 11 characters + 'ring-ref' is 8, so 19
>   * characters are enough. Define to 20 to keep consist with backend.
> @@ -146,6 +147,7 @@ struct blkfront_info
>  	unsigned int discard_granularity;
>  	unsigned int discard_alignment;
>  	unsigned int feature_persistent:1;
> +	/* Number of 4K segment handled */
                        ^ segments
>  	unsigned int max_indirect_segments;
>  	int is_ready;
>  };
> @@ -173,10 +175,19 @@ static DEFINE_SPINLOCK(minor_lock);
>  
>  #define DEV_NAME	"xvd"	/* name in /dev */
>  
> -#define SEGS_PER_INDIRECT_FRAME \
> -	(PAGE_SIZE/sizeof(struct blkif_request_segment))
> -#define INDIRECT_GREFS(_segs) \
> -	((_segs + SEGS_PER_INDIRECT_FRAME - 1)/SEGS_PER_INDIRECT_FRAME)
> +/*
> + * Xen use 4K pages. The guest may use different page size (4K or 64K)
> + * Number of Xen pages per segment
> + */
> +#define XEN_PAGES_PER_SEGMENT   (PAGE_SIZE / XEN_PAGE_SIZE)
> +
> +#define SEGS_PER_INDIRECT_FRAME	\
> +	(XEN_PAGE_SIZE/sizeof(struct blkif_request_segment) / XEN_PAGES_PER_SEGMENT)
> +#define XEN_PAGES_PER_INDIRECT_FRAME \
> +	(XEN_PAGE_SIZE/sizeof(struct blkif_request_segment))
> +
> +#define INDIRECT_GREFS(_pages) \
> +	((_pages + XEN_PAGES_PER_INDIRECT_FRAME - 1)/XEN_PAGES_PER_INDIRECT_FRAME)
>  
>  static int blkfront_setup_indirect(struct blkfront_info *info);
>  
> @@ -463,14 +474,100 @@ static int blkif_queue_discard_req(struct request *req)
>  	return 0;
>  }
>  
> +struct setup_rw_req {
> +	unsigned int grant_idx;
> +	struct blkif_request_segment *segments;
> +	struct blkfront_info *info;
> +	struct blkif_request *ring_req;
> +	grant_ref_t gref_head;
> +	unsigned int id;
> +	/* Only used when persistent grant is used and it's a read request */
> +	bool need_copy;
> +	unsigned int bvec_off;
> +	char *bvec_data;
> +};
> +
> +static void blkif_setup_rw_req_grant(unsigned long mfn, unsigned int offset,
> +				     unsigned int *len, void *data)
> +{
> +	struct setup_rw_req *setup = data;
> +	int n, ref;
> +	struct grant *gnt_list_entry;
> +	unsigned int fsect, lsect;
> +	/* Convenient aliases */
> +	unsigned int grant_idx = setup->grant_idx;
> +	struct blkif_request *ring_req = setup->ring_req;
> +	struct blkfront_info *info = setup->info;
> +	struct blk_shadow *shadow = &info->shadow[setup->id];
> +
> +	if ((ring_req->operation == BLKIF_OP_INDIRECT) &&
> +	    (grant_idx % XEN_PAGES_PER_INDIRECT_FRAME == 0)) {
> +		if (setup->segments)
> +			kunmap_atomic(setup->segments);
> +
> +		n = grant_idx / XEN_PAGES_PER_INDIRECT_FRAME;
> +		gnt_list_entry = get_indirect_grant(&setup->gref_head, info);
> +		shadow->indirect_grants[n] = gnt_list_entry;
> +		setup->segments = kmap_atomic(gnt_list_entry->page);
> +		ring_req->u.indirect.indirect_grefs[n] = gnt_list_entry->gref;
> +	}
> +
> +	gnt_list_entry = get_grant(&setup->gref_head, mfn, info);
> +	ref = gnt_list_entry->gref;
> +	shadow->grants_used[grant_idx] = gnt_list_entry;
> +
> +	if (setup->need_copy) {
> +		void *shared_data;
> +
> +		shared_data = kmap_atomic(gnt_list_entry->page);
> +		/*
> +		 * this does not wipe data stored outside the
> +		 * range sg->offset..sg->offset+sg->length.
> +		 * Therefore, blkback *could* see data from
> +		 * previous requests. This is OK as long as
> +		 * persistent grants are shared with just one
> +		 * domain. It may need refactoring if this
> +		 * changes
> +		 */
> +		memcpy(shared_data + offset,
> +		       setup->bvec_data + setup->bvec_off,
> +		       *len);
> +
> +		kunmap_atomic(shared_data);
> +		setup->bvec_off += *len;
> +	}
> +
> +	fsect = offset >> 9;
> +	lsect = fsect + (*len >> 9) - 1;
> +	if (ring_req->operation != BLKIF_OP_INDIRECT) {
> +		ring_req->u.rw.seg[grant_idx] =
> +			(struct blkif_request_segment) {
> +				.gref       = ref,
> +				.first_sect = fsect,
> +				.last_sect  = lsect };
> +	} else {
> +		setup->segments[grant_idx % XEN_PAGES_PER_INDIRECT_FRAME] =
> +			(struct blkif_request_segment) {
> +				.gref       = ref,
> +				.first_sect = fsect,
> +				.last_sect  = lsect };
> +	}
> +
> +	(setup->grant_idx)++;
> +}
> +
>  static int blkif_queue_rw_req(struct request *req)
>  {
>  	struct blkfront_info *info = req->rq_disk->private_data;
>  	struct blkif_request *ring_req;
>  	unsigned long id;
> -	unsigned int fsect, lsect;
> -	int i, ref, n;
> -	struct blkif_request_segment *segments = NULL;
> +	int i;
> +	struct setup_rw_req setup = {
> +		.grant_idx = 0,
> +		.segments = NULL,
> +		.info = info,
> +		.need_copy = rq_data_dir(req) && info->feature_persistent,
> +	};
>  
>  	/*
>  	 * Used to store if we are able to queue the request by just using
> @@ -478,25 +575,23 @@ static int blkif_queue_rw_req(struct request *req)
>  	 * as there are not sufficiently many free.
>  	 */
>  	bool new_persistent_gnts;
> -	grant_ref_t gref_head;
> -	struct grant *gnt_list_entry = NULL;
>  	struct scatterlist *sg;
> -	int nseg, max_grefs;
> +	int nseg, max_grefs, nr_page;
>  
> -	max_grefs = req->nr_phys_segments;
> +	max_grefs = req->nr_phys_segments * XEN_PAGES_PER_SEGMENT;
>  	if (max_grefs > BLKIF_MAX_SEGMENTS_PER_REQUEST)
>  		/*
>  		 * If we are using indirect segments we need to account
>  		 * for the indirect grefs used in the request.
>  		 */
> -		max_grefs += INDIRECT_GREFS(req->nr_phys_segments);
> +		max_grefs += INDIRECT_GREFS(req->nr_phys_segments * XEN_PAGES_PER_SEGMENT);
>  
>  	/* Check if we have enough grants to allocate a requests */
>  	if (info->persistent_gnts_c < max_grefs) {
>  		new_persistent_gnts = 1;
>  		if (gnttab_alloc_grant_references(
>  		    max_grefs - info->persistent_gnts_c,
> -		    &gref_head) < 0) {
> +		    &setup.gref_head) < 0) {
>  			gnttab_request_free_callback(
>  				&info->callback,
>  				blkif_restart_queue_callback,
> @@ -513,12 +608,18 @@ static int blkif_queue_rw_req(struct request *req)
>  	info->shadow[id].request = req;
>  
>  	BUG_ON(info->max_indirect_segments == 0 &&
> -	       req->nr_phys_segments > BLKIF_MAX_SEGMENTS_PER_REQUEST);
> +	       (XEN_PAGES_PER_SEGMENT * req->nr_phys_segments) > BLKIF_MAX_SEGMENTS_PER_REQUEST);
>  	BUG_ON(info->max_indirect_segments &&
> -	       req->nr_phys_segments > info->max_indirect_segments);
> +		(req->nr_phys_segments * XEN_PAGES_PER_SEGMENT) > info->max_indirect_segments);
>  	nseg = blk_rq_map_sg(req->q, req, info->shadow[id].sg);
> +	nr_page = 0;
> +	/* Calculate the number of Xen pages used */
> +	for_each_sg(info->shadow[id].sg, sg, nseg, i) {
> +		nr_page += (round_up(sg->offset + sg->length, XEN_PAGE_SIZE) - round_down(sg->offset, XEN_PAGE_SIZE)) >> XEN_PAGE_SHIFT;

I haven't counted the characters, but this line looks too long, also you
can get rid of the braces since it's a single line statement.

Roger.
