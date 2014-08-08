From: akpm@linux-foundation.org (Andrew Morton)
Date: Fri, 8 Aug 2014 15:40:08 -0700
Subject: [PATCHv6 2/5] lib/genalloc.c: Add genpool range check function
In-Reply-To: <1407529397-6642-2-git-send-email-lauraa@codeaurora.org>
References: <1407529397-6642-1-git-send-email-lauraa@codeaurora.org>
 <1407529397-6642-2-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140808154008.4e5183b67d29159a83ffcf25@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  8 Aug 2014 13:23:14 -0700 Laura Abbott <lauraa@codeaurora.org> wrote:

> 
> After allocating an address from a particular genpool,
> there is no good way to verify if that address actually
> belongs to a genpool. Introduce addr_in_gen_pool which
> will return if an address plus size falls completely
> within the genpool range.
> 
> ...
>
>  /**
> + * addr_in_gen_pool - checks if an address falls within the range of a pool
> + * @pool:	the generic memory pool
> + * @start:	start address
> + * @size:	size of the region
> + *
> + * Check if the range of addresses falls within the specified pool.

This description should make it clear that the entire range must be
within the pool - that an overlap is "no".

>     Takes
> + * the rcu_read_lock for the duration of the check.

I don't think this part is worth including.

> + */
> +bool addr_in_gen_pool(struct gen_pool *pool, unsigned long start,
> +			size_t size)
> +{
> +	bool found = false;
> +	unsigned long end = start + size;
> +	struct gen_pool_chunk *chunk;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(chunk, &(pool)->chunks, next_chunk) {
> +		if (start >= chunk->start_addr && start <= chunk->end_addr) {
> +			if (end <= chunk->end_addr) {
> +				found = true;
> +				break;
> +			}
> +		}
> +	}
> +	rcu_read_unlock();
> +	return found;
> +}
