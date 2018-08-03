From: jeremy.linton@arm.com (Jeremy Linton)
Date: Thu, 2 Aug 2018 22:21:53 -0500
Subject: [RFC 1/2] slub: Avoid trying to allocate memory on offline nodes
In-Reply-To: <20180802091554.GE10808@dhcp22.suse.cz>
References: <20180801200418.1325826-1-jeremy.linton@arm.com>
 <20180801200418.1325826-2-jeremy.linton@arm.com>
 <20180802091554.GE10808@dhcp22.suse.cz>
Message-ID: <c6caddbf-e275-219e-12b6-538a53ced17d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/02/2018 04:15 AM, Michal Hocko wrote:
> On Wed 01-08-18 15:04:17, Jeremy Linton wrote:
> [...]
>> @@ -2519,6 +2519,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>>   		if (unlikely(!node_match(page, searchnode))) {
>>   			stat(s, ALLOC_NODE_MISMATCH);
>>   			deactivate_slab(s, page, c->freelist, c);
>> +			if (!node_online(searchnode))
>> +				node = NUMA_NO_NODE;
>>   			goto new_slab;
> 
> This is inherently racy. Numa node can get offline at any point after
> you check it here. Making it race free would involve some sort of
> locking and I am not really convinced this is a good idea.

I spent some time looking/thinking about this, and i'm pretty sure its 
not creating any new problems. But OTOH, I think the node_online() check 
is probably a bit misleading as what we really want to assure is that 
node<MAX_NUMNODES and that there is going to be a valid entry in 
NODE_DATA() so we don't deference null.


> 
>>   		}
>>   	}
>> -- 
>> 2.14.3
>>
> 
