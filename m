From: mhocko@kernel.org (Michal Hocko)
Date: Thu, 2 Aug 2018 11:15:54 +0200
Subject: [RFC 1/2] slub: Avoid trying to allocate memory on offline nodes
In-Reply-To: <20180801200418.1325826-2-jeremy.linton@arm.com>
References: <20180801200418.1325826-1-jeremy.linton@arm.com>
 <20180801200418.1325826-2-jeremy.linton@arm.com>
Message-ID: <20180802091554.GE10808@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 01-08-18 15:04:17, Jeremy Linton wrote:
[...]
> @@ -2519,6 +2519,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  		if (unlikely(!node_match(page, searchnode))) {
>  			stat(s, ALLOC_NODE_MISMATCH);
>  			deactivate_slab(s, page, c->freelist, c);
> +			if (!node_online(searchnode))
> +				node = NUMA_NO_NODE;
>  			goto new_slab;

This is inherently racy. Numa node can get offline at any point after
you check it here. Making it race free would involve some sort of
locking and I am not really convinced this is a good idea.

>  		}
>  	}
> -- 
> 2.14.3
> 

-- 
Michal Hocko
SUSE Labs
