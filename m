From: roger.pau@citrix.com (=?UTF-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?=)
Date: Thu, 20 Aug 2015 10:10:23 +0200
Subject: [PATCH v3 15/20] block/xen-blkfront: Make it running on 64KB
 page granularity
In-Reply-To: <1438966019-19322-16-git-send-email-julien.grall@citrix.com>
References: <1438966019-19322-1-git-send-email-julien.grall@citrix.com>
 <1438966019-19322-16-git-send-email-julien.grall@citrix.com>
Message-ID: <55D58B6F.8010904@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I have some comments regarding the commit message, IMHO it would be good
that a native English speaker reviews it too.

El 07/08/15 a les 18.46, Julien Grall ha escrit:
> The PV block protocol is using 4KB page granularity. The goal of this
> patch is to allow a Linux using 64KB page granularity using block
> device on a non-modified Xen.
> 
> The block API is using segment which should at least be the size of a
> Linux page. Therefore, the driver will have to break the page in chunk
> of 4K before giving the page to the backend.
> 
> Breaking a 64KB segment in 4KB chunk will result to have some chunk with
> no data.

I would rewrite the above line as:

When breaking a 64KB segment into 4KB chunks it is possible that some
chunks are empty.

> As the PV protocol always require to have data in the chunk, we
> have to count the number of Xen page which will be in use and avoid to
                                  ^pages
> sent empty chunk.
  ^and avoid sending empty chunks.
> 
> Note that, a pre-defined number of grant is reserved before preparing
                                     ^grants are
> the request. This pre-defined number is based on the number and the
> maximum size of the segments. If each segment contain a very small
                                                ^contains
> amount of data, the driver may reserve too much grant (16 grant is
                                             ^many grants   ^grants are
> reserved per segment with 64KB page granularity).
> 
> Futhermore, in the case of persistent grant we allocate one Linux page
                                        ^grants
> per grant although only the 4KB of the page will be effectively use.
                             ^first                              ^in
> This could be improved by share the page with multiple grants.
                            ^sharing
> 
> Signed-off-by: Julien Grall <julien.grall@citrix.com>

LGTM:

Acked-by: Roger Pau Monn? <roger.pau@citrix.com>

Just one question.

[...]
> @@ -559,73 +669,30 @@ static int blkif_queue_rw_req(struct request *req)
>  				ring_req->operation = 0;
>  			}
>  		}
> -		ring_req->u.rw.nr_segments = nseg;
> -	}
> -	for_each_sg(info->shadow[id].sg, sg, nseg, i) {
> -		fsect = sg->offset >> 9;
> -		lsect = fsect + (sg->length >> 9) - 1;
> -
> -		if ((ring_req->operation == BLKIF_OP_INDIRECT) &&
> -		    (i % SEGS_PER_INDIRECT_FRAME == 0)) {
> -			if (segments)
> -				kunmap_atomic(segments);
> -
> -			n = i / SEGS_PER_INDIRECT_FRAME;
> -			gnt_list_entry = get_indirect_grant(&gref_head, info);
> -			info->shadow[id].indirect_grants[n] = gnt_list_entry;
> -			segments = kmap_atomic(gnt_list_entry->page);
> -			ring_req->u.indirect.indirect_grefs[n] = gnt_list_entry->gref;
> -		}
> -
> -		gnt_list_entry = get_grant(&gref_head,
> -					   xen_page_to_gfn(sg_page(sg)),
> -					   info);
> -		ref = gnt_list_entry->gref;
> -
> -		info->shadow[id].grants_used[i] = gnt_list_entry;
> -
> -		if (rq_data_dir(req) && info->feature_persistent) {
> -			char *bvec_data;
> -			void *shared_data;
> +		ring_req->u.rw.nr_segments = num_grant;
> +	}
>  
> -			BUG_ON(sg->offset + sg->length > PAGE_SIZE);
> +	setup.ring_req = ring_req;
> +	setup.id = id;
> +	for_each_sg(info->shadow[id].sg, sg, num_sg, i) {
> +		BUG_ON(sg->offset + sg->length > PAGE_SIZE);
>  
> -			shared_data = kmap_atomic(gnt_list_entry->page);
> -			bvec_data = kmap_atomic(sg_page(sg));
> +		if (setup.need_copy) {
> +			setup.bvec_off = sg->offset;
> +			setup.bvec_data = kmap_atomic(sg_page(sg));
> +		}
>  
> -			/*
> -			 * this does not wipe data stored outside the
> -			 * range sg->offset..sg->offset+sg->length.
> -			 * Therefore, blkback *could* see data from
> -			 * previous requests. This is OK as long as
> -			 * persistent grants are shared with just one
> -			 * domain. It may need refactoring if this
> -			 * changes
> -			 */
> -			memcpy(shared_data + sg->offset,
> -			       bvec_data   + sg->offset,
> -			       sg->length);
> +		gnttab_foreach_grant_in_range(sg_page(sg),
> +					      sg->offset,
> +					      sg->length,
> +					      blkif_setup_rw_req_grant,
> +					      &setup);

If I'm understanding this right, on x86 gnttab_foreach_grant_in_range is
only going to perform one iteration, since XEN_PAGE_SIZE == PAGE_SIZE.

Roger.
