From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 28 Aug 2015 16:33:25 +0100
Subject: [PATCH v3 15/20] block/xen-blkfront: Make it running on 64KB
 page granularity
In-Reply-To: <55D58B6F.8010904@citrix.com>
References: <1438966019-19322-1-git-send-email-julien.grall@citrix.com>
 <1438966019-19322-16-git-send-email-julien.grall@citrix.com>
 <55D58B6F.8010904@citrix.com>
Message-ID: <55E07F45.5020501@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/08/15 09:10, Roger Pau Monn? wrote:
> Hello,

Hi,

> I have some comments regarding the commit message, IMHO it would be good
> that a native English speaker reviews it too.
> 
> El 07/08/15 a les 18.46, Julien Grall ha escrit:
>> The PV block protocol is using 4KB page granularity. The goal of this
>> patch is to allow a Linux using 64KB page granularity using block
>> device on a non-modified Xen.
>>
>> The block API is using segment which should at least be the size of a
>> Linux page. Therefore, the driver will have to break the page in chunk
>> of 4K before giving the page to the backend.
>>
>> Breaking a 64KB segment in 4KB chunk will result to have some chunk with
>> no data.
> 
> I would rewrite the above line as:
> 
> When breaking a 64KB segment into 4KB chunks it is possible that some
Correct,
> chunks are empty.

Sounds good, I will replace with it.

>> As the PV protocol always require to have data in the chunk, we
>> have to count the number of Xen page which will be in use and avoid to
>                                   ^pages
>> sent empty chunk.
>   ^and avoid sending empty chunks.
>>
>> Note that, a pre-defined number of grant is reserved before preparing
>                                      ^grants are
>> the request. This pre-defined number is based on the number and the
>> maximum size of the segments. If each segment contain a very small
>                                                 ^contains
>> amount of data, the driver may reserve too much grant (16 grant is
>                                              ^many grants   ^grants are
>> reserved per segment with 64KB page granularity).
>>
>> Futhermore, in the case of persistent grant we allocate one Linux page
>                                         ^grants
>> per grant although only the 4KB of the page will be effectively use.
>                              ^first                              ^in
>> This could be improved by share the page with multiple grants.
>                             ^sharing
>>
>> Signed-off-by: Julien Grall <julien.grall@citrix.com>
> 
> LGTM:
> 
> Acked-by: Roger Pau Monn? <roger.pau@citrix.com>

Thank you, I will fix all the typos in the next version.

> Just one question.

[..]

>> +		gnttab_foreach_grant_in_range(sg_page(sg),
>> +					      sg->offset,
>> +					      sg->length,
>> +					      blkif_setup_rw_req_grant,
>> +					      &setup);
> 
> If I'm understanding this right, on x86 gnttab_foreach_grant_in_range is
> only going to perform one iteration, since XEN_PAGE_SIZE == PAGE_SIZE.

Correct, it will only perform when iteration for x86 but also for arm32
and arm64 (when 4KB page is in use).

Regards,

-- 
Julien Grall
