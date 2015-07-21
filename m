From: julien.grall@citrix.com (Julien Grall)
Date: Tue, 21 Jul 2015 14:07:54 +0100
Subject: [Xen-devel] [PATCH v2 15/20] block/xen-blkfront: Make it running
 on 64KB page granularity
In-Reply-To: <55AE27C2.8090803@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-16-git-send-email-julien.grall@citrix.com>
 <55AE27C2.8090803@citrix.com>
Message-ID: <55AE442A.6080506@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roger,

On 21/07/15 12:06, Roger Pau Monn? wrote:
> El 09/07/15 a les 22.42, Julien Grall ha escrit:
>> From: Julien Grall <julien.grall@linaro.org>
>>
>> The PV block protocol is using 4KB page granularity. The goal of this
>> patch is to allow a Linux using 64KB page granularity using block
>> device on a non-modified Xen.
>>
>> The block API is using segment which should at least be the size of a
>                          ^ segments

Will fix it.

>> Linux page. Therefore, the driver will have to break the page in chunk
>                                                             chunks ^
>> of 4K before giving the page to the backend.
>>
>> Breaking a 64KB segment in 4KB chunk will result to have some chunk with
>> no data.
> 
> I would rewrite this as:
> 
> Breaking a 64KB page into 4KB chunks can result in chunks with no data.

Sounds good.

>> As the PV protocol always require to have data in the chunk, we
>> have to count the number of Xen page which will be in use and avoid to
>                                   ^ pages             remove the "to" ^
>> sent empty chunk.
>   ^ sending empty chunks
>>
>> Note that, a pre-defined number of grant is reserved before preparing
>            ^ no coma                 ^ grants are
>> the request. This pre-defined number is based on the number and the
>> maximum size of the segments. If each segment contain a very small
>                                                 ^ contains
>> amount of data, the driver may reserve too much grant (16 grant is
>                                              ^ many grants? ^ grants are
>> reserved per segment with 64KB page granularity).
>>
>> Futhermore, in the case of persistent grant we allocate one Linux page
>   ^ Furthermore  ^ case of using persistent grants
>> per grant although only the 4KB of the page will be effectively use.
>                              ^ initial                ^ used.
>> This could be improved by share the page with multiple grants.
>                             ^ sharing the page between

Will fix all the typoes, grammatical error in the next version.

>>
>> Signed-off-by: Julien Grall <julien.grall@citrix.com>
>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> Cc: Roger Pau Monn? <roger.pau@citrix.com>
>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Cc: David Vrabel <david.vrabel@citrix.com>
> 
> This looks much better now, thanks.
> 
> Acked-by: Roger Pau Monn? <roger.pau@citrix.com>

Thank you!

>>  	BUG_ON(info->max_indirect_segments == 0 &&
>> -	       req->nr_phys_segments > BLKIF_MAX_SEGMENTS_PER_REQUEST);
>> +	       (XEN_PAGES_PER_SEGMENT * req->nr_phys_segments) > BLKIF_MAX_SEGMENTS_PER_REQUEST);
>>  	BUG_ON(info->max_indirect_segments &&
>> -	       req->nr_phys_segments > info->max_indirect_segments);
>> +		(req->nr_phys_segments * XEN_PAGES_PER_SEGMENT) > info->max_indirect_segments);
>>  	nseg = blk_rq_map_sg(req->q, req, info->shadow[id].sg);
>> +	nr_page = 0;
>> +	/* Calculate the number of Xen pages used */
>> +	for_each_sg(info->shadow[id].sg, sg, nseg, i) {
>> +		nr_page += (round_up(sg->offset + sg->length, XEN_PAGE_SIZE) - round_down(sg->offset, XEN_PAGE_SIZE)) >> XEN_PAGE_SHIFT;
> 
> I haven't counted the characters, but this line looks too long, also you
> can get rid of the braces since it's a single line statement.

I was planning to use gnttab_count_grant added in patch #3 but forgot to
do it. I will do in the next version.

Regards,

-- 
Julien Grall
