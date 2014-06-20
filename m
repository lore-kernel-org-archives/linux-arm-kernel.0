From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 Jun 2014 10:38:56 +0100
Subject: [PATCHv3 2/5] lib/genalloc.c: Add genpool range check function
In-Reply-To: <1402969165-7526-3-git-send-email-lauraa@codeaurora.org>
References: <1402969165-7526-1-git-send-email-lauraa@codeaurora.org>
 <1402969165-7526-3-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140620093856.GM25104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 02:39:22AM +0100, Laura Abbott wrote:
> After allocating an address from a particular genpool,
> there is no good way to verify if that address actually
> belongs to a genpool. Introduce addr_in_gen_pool which
> will return if an address plus size falls completely
> within the genpool range.
> 
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---
>  include/linux/genalloc.h |  3 +++
>  lib/genalloc.c           | 29 +++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
> index 3cd0934..1ccaab4 100644
> --- a/include/linux/genalloc.h
> +++ b/include/linux/genalloc.h
> @@ -121,6 +121,9 @@ extern struct gen_pool *devm_gen_pool_create(struct device *dev,
>  		int min_alloc_order, int nid);
>  extern struct gen_pool *dev_get_gen_pool(struct device *dev);
>  
> +bool addr_in_gen_pool(struct gen_pool *pool, unsigned long start,
> +			size_t size);
> +
>  #ifdef CONFIG_OF
>  extern struct gen_pool *of_get_named_gen_pool(struct device_node *np,
>  	const char *propname, int index);
> diff --git a/lib/genalloc.c b/lib/genalloc.c
> index 9758529..66edf93 100644
> --- a/lib/genalloc.c
> +++ b/lib/genalloc.c
> @@ -403,6 +403,35 @@ void gen_pool_for_each_chunk(struct gen_pool *pool,
>  EXPORT_SYMBOL(gen_pool_for_each_chunk);
>  
>  /**
> + * addr_in_gen_pool - checks if an address falls within the range of a pool
> + * @pool:	the generic memory pool
> + * @start:	start address
> + * @size:	size of the region
> + *
> + * Check if the range of addresses falls within the specified pool. Takes
> + * the rcu_read_lock for the duration of the check.
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

Why do you need to check start against the end of the chunk? Is that in case
of overflow?

Will
