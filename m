From: jeremy.linton@arm.com (Jeremy Linton)
Date: Thu, 2 Aug 2018 22:17:49 -0500
Subject: [RFC 2/2] mm: harden alloc_pages code paths against bogus nodes
In-Reply-To: <20180802073147.GA10808@dhcp22.suse.cz>
References: <20180801200418.1325826-1-jeremy.linton@arm.com>
 <20180801200418.1325826-3-jeremy.linton@arm.com>
 <20180802073147.GA10808@dhcp22.suse.cz>
Message-ID: <5ed35dfa-5f02-55cb-9b84-b944394e1a5a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/02/2018 02:31 AM, Michal Hocko wrote:
> On Wed 01-08-18 15:04:18, Jeremy Linton wrote:
>> Its possible to crash __alloc_pages_nodemask by passing it
>> bogus node ids. This is caused by NODE_DATA() returning null
>> (hopefully) when the requested node is offline. We can
>> harded against the basic case of a mostly valid node, that
>> isn't online by checking for null and failing prepare_alloc_pages.
>>
>> But this then suggests we should also harden NODE_DATA() like this
>>
>> #define NODE_DATA(nid)         ( (nid) < MAX_NUMNODES ? node_data[(nid)] : NULL)
>>
>> eventually this starts to add a bunch of generally uneeded checks
>> in some code paths that are called quite frequently.
> 
> But the page allocator is really a hot path and people will not be happy
> to have yet another branch there. No code should really use invalid numa
> node ids in the first place.
> 
> If I remember those bugs correctly then it was the arch code which was
> doing something wrong. I would prefer that code to be fixed instead.

Yes, I think the consensus is that 2/2 should be dropped.

The arch code is being fixed (both cases) this patch set is just an 
attempt to harden this code path against future failures like that so 
that we get some warnings/ugly messages rather than early boot failures.

Thanks,



>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   include/linux/gfp.h | 2 ++
>>   mm/page_alloc.c     | 2 ++
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
>> index a6afcec53795..17d70271c42e 100644
>> --- a/include/linux/gfp.h
>> +++ b/include/linux/gfp.h
>> @@ -436,6 +436,8 @@ static inline int gfp_zonelist(gfp_t flags)
>>    */
>>   static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
>>   {
>> +	if (unlikely(!NODE_DATA(nid))) //VM_WARN_ON?
>> +		return NULL;
>>   	return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
>>   }
>>   
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index a790ef4be74e..3a3d9ac2662a 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -4306,6 +4306,8 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
>>   {
>>   	ac->high_zoneidx = gfp_zone(gfp_mask);
>>   	ac->zonelist = node_zonelist(preferred_nid, gfp_mask);
>> +	if (!ac->zonelist)
>> +		return false;
>>   	ac->nodemask = nodemask;
>>   	ac->migratetype = gfpflags_to_migratetype(gfp_mask);
>>   
>> -- 
>> 2.14.3
>>
> 
