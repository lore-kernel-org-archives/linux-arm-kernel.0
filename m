From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 27 May 2018 18:20:25 +0100
Subject: [PATCH v2]irqchip/irq-gic-v3:Avoid a waste of LPI resource
In-Reply-To: <8898674D84E3B24BA3A2D289B872026A69F1300F@G01JPEXMBKW03>
References: <8898674D84E3B24BA3A2D289B872026A69F1300F@G01JPEXMBKW03>
Message-ID: <86d0xhaucm.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 25 May 2018 13:45:24 +0100,
Zhang, Lei wrote:

Hi Lei,

> 
> The current implementation of irq-gic-v3-its driver allocates at least 32 LPIs (interrupt numbers) 
> for each Device ID even if the number of requested LPIs is only one.
> I think it is a waste for LPI resource.
> And if we use many devices over ITS, this implementation may cause a shortage of LPI .
> 
> I have a patch to avoid this problem by changing method of lpis management.
> For detail, I use free list instead of chunk method to manage lpis.
> 
> The points of this patch are as follows.
> Point1:Not always allocates at least 32 LPIs.
> Round numbers of lpi requested up to nearest power of two.
> Point2: Guarantee base lpi number is aligned a power of two.
> For example if you want 2 lpis, you will get 2 lpis, and base lpi number will be aligned by 2.
> If you want 15 lpis, you will get 16 lpis, and base lpi number will be aligned by 16.
> Point3: Lpis be allocated as a contiguous range,

I'm sorry, but this isn't a proper patch (or at least it is not
formatted the way I'd expect it to be). Next time you send a patch,
please make sure you use "git send-email".

Now, from a technical perspective:

- I want to preserve the minimal allocation of 32 for existing
  busses. Feel free to use a different value for your own bus, but the
  current busses will stay the way they are for the foreseeable
  future.

- Having thought about it a bit more, I'm now convinced that we can
  get rid of your requirement number two. The reason is that the
  device never observe the LPI itself, but the event. Given that for
  each device, the event is 0-based, there is no need to also align
  the base LPI number.

> 
> Signed-off-by: Lei Zhang <zhang.lei@jp.fujitsu.com>
> ------------------------------------------------
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 5416f2b..e68fca6 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1405,82 +1405,122 @@ static int its_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
>  	.irq_set_vcpu_affinity	= its_irq_set_vcpu_affinity,
>  };
>  
> -/*
> - * How we allocate LPIs:
> - *
> - * The GIC has id_bits bits for interrupt identifiers. From there, we
> - * must subtract 8192 which are reserved for SGIs/PPIs/SPIs. Then, as
> - * we allocate LPIs by chunks of 32, we can shift the whole thing by 5
> - * bits to the right.
> - *
> - * This gives us (((1UL << id_bits) - 8192) >> 5) possible allocations.
> - */
> -#define IRQS_PER_CHUNK_SHIFT	5
> -#define IRQS_PER_CHUNK		(1UL << IRQS_PER_CHUNK_SHIFT)
> -#define ITS_MAX_LPI_NRBITS	16 /* 64K LPIs */
> +static struct list_head lpi_free_list;
> +static struct list_head lpi_alloc_list; struct lpi_mng {

Why two lists? Why should we care about tracking the allocated LPIs?
They are already tracked at the device level, and all we need is a
list describing the pool of available LPIs.

Also: why isn't this new structure declared on a line of its own?

> +	struct list_head lpi_list;
> +	int base;
> +	int len;
> +};
>  
> -static unsigned long *lpi_bitmap;
> -static u32 lpi_chunks;
> +#define ITS_MAX_LPI_NRBITS	16 /* 64K LPIs */
>  static DEFINE_SPINLOCK(lpi_lock);
>  
> -static int its_lpi_to_chunk(int lpi)
> -{
> -	return (lpi - 8192) >> IRQS_PER_CHUNK_SHIFT;
> -}
> -
> -static int its_chunk_to_lpi(int chunk)
> -{
> -	return (chunk << IRQS_PER_CHUNK_SHIFT) + 8192;
> -}
>  
>  static int __init its_lpi_init(u32 id_bits)  {

That's really weird. The mainline tree doesn't have the opening
bracket here...

> -	lpi_chunks = its_lpi_to_chunk(1UL << id_bits);
> +	u32 nr_irq = 1UL << id_bits;
> +	struct lpi_mng *lpi_free_mng = NULL;
> +	struct lpi_mng *lpi_new = NULL;
> +
> +	INIT_LIST_HEAD(&lpi_free_list);
> +	INIT_LIST_HEAD(&lpi_alloc_list);

Why don't you use the LIST_HEAD() static initializer right at the top?

>  
> -	lpi_bitmap = kzalloc(BITS_TO_LONGS(lpi_chunks) * sizeof(long),
> -			     GFP_KERNEL);
> -	if (!lpi_bitmap) {
> -		lpi_chunks = 0;
> +	lpi_free_mng = kzalloc(sizeof(struct lpi_mng), GFP_KERNEL);
> +	if (!lpi_free_mng)
>  		return -ENOMEM;
> -	}
>  
> -	pr_info("ITS: Allocated %d chunks for LPIs\n", (int)lpi_chunks);
> +	lpi_free_mng->base = 0;
> +	lpi_free_mng->len = nr_irq;
> +	list_add(&lpi_free_mng->lpi_list, &lpi_free_list);

This looks wrong. LPIs start at 8192. Why is base 0 here?

> +
> +	do {
> +		lpi_free_mng = list_first_entry(&lpi_free_list, struct lpi_mng,
> +			lpi_list);
> +		if (lpi_free_mng->len == 8192) {
> +			/*It is not lpi, so we delete */
> +			if (lpi_free_mng->base == 0) {
> +				list_del_init(&lpi_free_mng->lpi_list);
> +				kfree(lpi_free_mng);
> +				continue;
> +			}
> +			if (lpi_free_mng->base == 8192)
> +				goto out;
> +		}
> +		if (lpi_free_mng->len > 8192) {
> +			lpi_new  = kzalloc(sizeof(struct lpi_mng),
> +					 GFP_ATOMIC);
> +			if (!lpi_new)
> +				return -ENOMEM;
> +			lpi_free_mng->len /= 2;
> +			lpi_new->base = lpi_free_mng->base + lpi_free_mng->len;
> +			lpi_new->len = lpi_free_mng->len;
> +			list_add(&lpi_new->lpi_list, &lpi_free_mng->lpi_list);
> +		}
> +	} while (1);

I'm really confused. What is this trying to achieve? Some kind of
power-of-two static allocation? Maybe you should try and describe what
this is doing in the commit message.

> +
> +out:
> +	pr_info("ITS: Allocated %d  LPIs\n", nr_irq - 8192);
>  	return 0;
>  }
>  
> +static struct lpi_mng *its_alloc_lpi(int nr_irqs) {
> +	struct lpi_mng *lpi_alloc_mng = NULL;
> +	struct lpi_mng *lpi_split = NULL;
> +	struct lpi_mng *lpi_new = NULL;
> +	int base;
> +
> +	base = INT_MAX;
> +	do {
> +		list_for_each_entry(lpi_alloc_mng, &lpi_free_list, lpi_list) {
> +			if (nr_irqs > lpi_alloc_mng->len)
> +				continue;
> +			if (nr_irqs == lpi_alloc_mng->len) {
> +				list_del_init(&lpi_alloc_mng->lpi_list);
> +				list_add(&lpi_alloc_mng->lpi_list,
> +					&lpi_alloc_list);
> +				return lpi_alloc_mng;
> +			}
> +			if ((nr_irqs < lpi_alloc_mng->len)
> +				&& (lpi_alloc_mng->base < base)) {
> +				base = lpi_alloc_mng->base;
> +				lpi_split = lpi_alloc_mng;
> +			}
> +		}
> +		lpi_new  = kzalloc(sizeof(struct lpi_mng),
> +				 GFP_ATOMIC);
> +		if (!lpi_new || !lpi_split)
> +			return NULL;
> +
> +		lpi_split->len /= 2;
> +		lpi_new->base = lpi_split->base + lpi_split->len;
> +		lpi_new->len = lpi_split->len;
> +		list_add(&lpi_new->lpi_list, &lpi_split->lpi_list);
> +
> +	} while (1);

Again, your allocation policy seems at best obscure. You need to
explain what you're trying to do.

> +}
> +
>  static unsigned long *its_lpi_alloc_chunks(int nr_irqs, int *base, int *nr_ids)  {
>  	unsigned long *bitmap = NULL;
> -	int chunk_id;
> -	int nr_chunks;
> -	int i;
> -
> -	nr_chunks = DIV_ROUND_UP(nr_irqs, IRQS_PER_CHUNK);
> +	struct lpi_mng *lpi_alloc_mng = NULL;
>  
>  	spin_lock(&lpi_lock);
>  
> -	do {
> -		chunk_id = bitmap_find_next_zero_area(lpi_bitmap, lpi_chunks,
> -						      0, nr_chunks, 0);
> -		if (chunk_id < lpi_chunks)
> -			break;
> -
> -		nr_chunks--;
> -	} while (nr_chunks > 0);
> +	lpi_alloc_mng = its_alloc_lpi(nr_irqs);
>  
> -	if (!nr_chunks)
> +	if (!lpi_alloc_mng)
>  		goto out;
>  
> -	bitmap = kzalloc(BITS_TO_LONGS(nr_chunks * IRQS_PER_CHUNK) * sizeof (long),
> -			 GFP_ATOMIC);
> +	bitmap = kzalloc(BITS_TO_LONGS(nr_irqs) * sizeof(long),
> +		 GFP_ATOMIC);
>  	if (!bitmap)
>  		goto out;
>  
> -	for (i = 0; i < nr_chunks; i++)
> -		set_bit(chunk_id + i, lpi_bitmap);
>  
> -	*base = its_chunk_to_lpi(chunk_id);
> -	*nr_ids = nr_chunks * IRQS_PER_CHUNK;
> +	*base = lpi_alloc_mng->base;
> +	*nr_ids = lpi_alloc_mng->len;
>  
>  out:
>  	spin_unlock(&lpi_lock);
> @@ -1491,23 +1531,53 @@ static unsigned long *its_lpi_alloc_chunks(int nr_irqs, int *base, int *nr_ids)
>  	return bitmap;
>  }
>  
> +static void its_joint_free_list(struct lpi_mng *free, struct lpi_mng 
> +*alloc) {
> +	free->len = free->len * 2;
> +	if (free->base > alloc->base)
> +		free->base = alloc->base;
> +}
> +
>  static void its_lpi_free_chunks(unsigned long *bitmap, int base, int nr_ids)  {
> -	int lpi;
> +	struct lpi_mng *lpi_alloc_mng = NULL;
> +	struct lpi_mng *lpi_free_mng = NULL;
> +	bool first_half;
> +	int pair_base;
>  
>  	spin_lock(&lpi_lock);
>  
> -	for (lpi = base; lpi < (base + nr_ids); lpi += IRQS_PER_CHUNK) {
> -		int chunk = its_lpi_to_chunk(lpi);
> -
> -		BUG_ON(chunk > lpi_chunks);
> -		if (test_bit(chunk, lpi_bitmap)) {
> -			clear_bit(chunk, lpi_bitmap);
> -		} else {
> -			pr_err("Bad LPI chunk %d\n", chunk);
> +	list_for_each_entry(lpi_alloc_mng, &lpi_alloc_list, lpi_list) {
> +		if (lpi_alloc_mng->base == base) {
> +			list_del_init(&lpi_alloc_mng->lpi_list);
> +			break;
>  		}
>  	}
>  
> +	first_half = (lpi_alloc_mng->base % (lpi_alloc_mng->len * 2))
> +			 ? false : true;
> +	if (first_half)
> +		pair_base = lpi_alloc_mng->base + lpi_alloc_mng->len;
> +	else
> +		pair_base = lpi_alloc_mng->base - lpi_alloc_mng->len;
> +
> +	// found the other half
> +	list_for_each_entry(lpi_free_mng, &lpi_free_list, lpi_list) {
> +		if (lpi_free_mng->base == pair_base) {
> +			its_joint_free_list(lpi_free_mng, lpi_alloc_mng);
> +			kfree(lpi_alloc_mng);
> +			goto out;
> +		}
> +	}
> +	// Not found the other half
> +	list_for_each_entry(lpi_free_mng, &lpi_free_list, lpi_list) {
> +		if (lpi_alloc_mng->base  < lpi_free_mng->base) {
> +			list_add_tail(&lpi_alloc_mng->lpi_list,
> +				&lpi_free_mng->lpi_list);
> +			break;
> +		}
> +	}
> +out:
>  	spin_unlock(&lpi_lock);
>  
>  	kfree(bitmap);
> @@ -2117,12 +2187,13 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
>  	 * We allocate at least one chunk worth of LPIs bet device,
>  	 * and thus that many ITEs. The device may require less though.
>  	 */
> -	nr_ites = max(IRQS_PER_CHUNK, roundup_pow_of_two(nvecs));
> +	nr_ites = max(2UL, roundup_pow_of_two(nvecs));
>  	sz = nr_ites * its->ite_size;
>  	sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
>  	itt = kzalloc(sz, GFP_KERNEL);
>  	if (alloc_lpis) {
> -		lpi_map = its_lpi_alloc_chunks(nvecs, &lpi_base, &nr_lpis);
> +		lpi_map = its_lpi_alloc_chunks(roundup_pow_of_two(nvecs),
> +			&lpi_base, &nr_lpis);
>  		if (lpi_map)
>  			col_map = kzalloc(sizeof(*col_map) * nr_lpis,
>  					  GFP_KERNEL);

Overall, this feels way more complex than it should be. The
requirements you impose are too restrictive, you seem to track data
that doesn't need extra tracking, and the complexity seem to be
stemming from that.

I've just prototyped what I had in mind for this at [1] (see the first
patch for the allocator itself). As you can see, the allocator is a
lot simpler, yet it has all the flexibility you would need, The
drawback is of course that freeing LPIs is quite expensive, but that
almost never happens. And if it does, we can switch to a tree or some
more efficient data structure.

Thanks,

	M.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/lpi-allocator

-- 
Jazz is not dead, it just smell funny.
