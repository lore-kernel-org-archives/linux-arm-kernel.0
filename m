From: jeremy.linton@arm.com (Jeremy Linton)
Date: Thu, 2 Aug 2018 22:12:52 -0500
Subject: [RFC 1/2] slub: Avoid trying to allocate memory on offline nodes
In-Reply-To: <01000164fb05bba7-1804e794-a08d-4ee0-b842-c44c89647716-000000@email.amazonses.com>
References: <20180801200418.1325826-1-jeremy.linton@arm.com>
 <20180801200418.1325826-2-jeremy.linton@arm.com>
 <01000164fb05bba7-1804e794-a08d-4ee0-b842-c44c89647716-000000@email.amazonses.com>
Message-ID: <fdcb2cd2-579f-8f90-1e2d-d144bb2768e1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/02/2018 09:23 AM, Christopher Lameter wrote:
> On Wed, 1 Aug 2018, Jeremy Linton wrote:
> 
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 51258eff4178..e03719bac1e2 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -2519,6 +2519,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>>   		if (unlikely(!node_match(page, searchnode))) {
>>   			stat(s, ALLOC_NODE_MISMATCH);
>>   			deactivate_slab(s, page, c->freelist, c);
>> +			if (!node_online(searchnode))
>> +				node = NUMA_NO_NODE;
>>   			goto new_slab;
>>   		}
>>   	}
>>
> 
> Would it not be better to implement this check in the page allocator?
> There is also the issue of how to fallback to the nearest node.

Possibly? Falling back to the nearest node though, should be handled if 
memory-less nodes is enabled, which in the problematic case isn't.

> 
> NUMA_NO_NODE should fallback to the current memory allocation policy but
> it seems by inserting it here you would end up just with the default node
> for the processor.

I picked this spot (compared to 2/2) because a number of paths are 
funneling through here, and in this case it shouldn't be a very hot path.
