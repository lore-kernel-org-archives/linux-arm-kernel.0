From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 6 Jun 2016 13:59:52 +0100
Subject: [PATCH V4 1/5] irqchip/gicv3-its: Introduce two helper functions
 for accessing BASERn
In-Reply-To: <1465191636-6823-2-git-send-email-shankerd@codeaurora.org>
References: <1465191636-6823-1-git-send-email-shankerd@codeaurora.org>
 <1465191636-6823-2-git-send-email-shankerd@codeaurora.org>
Message-ID: <575573C8.6050409@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/16 06:40, Shanker Donthineni wrote:
> This patch adds the two handy helper functions for reading and writing
> ITS BASERn register.
> 
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 5eb1f9e..6392c82 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -56,13 +56,14 @@ struct its_collection {
>  };
>  
>  /*
> - * The ITS_BASER structure - contains memory information and cached
> - * value of BASER register configuration.
> + * The ITS_BASER structure - contains memory information, cached value
> + * of BASER register configuration and register idx.
>   */
>  struct its_baser {
>  	void		*base;
>  	u64		val;
>  	u32		order;
> +	u32		idx;
>  };
>  
>  /*
> @@ -824,6 +825,17 @@ static const char *its_base_type_string[] = {
>  	[GITS_BASER_TYPE_RESERVED7] 	= "Reserved (7)",
>  };
>  
> +static u64 its_read_baser(struct its_node *its, struct its_baser *baser)
> +{
> +	return readq_relaxed(its->base + GITS_BASER + (baser->idx << 3));
> +}
> +
> +static void its_write_baser(struct its_node *its, struct its_baser *baser,
> +			    u64 val)
> +{
> +	writeq_relaxed(val, its->base + GITS_BASER + (baser->idx << 3));
> +}
> +
>  static void its_free_tables(struct its_node *its)
>  {
>  	int i;
> @@ -863,14 +875,20 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
>  	its->device_ids = ids;
>  
>  	for (i = 0; i < GITS_BASER_NR_REGS; i++) {
> -		u64 val = readq_relaxed(its->base + GITS_BASER + i * 8);
> -		u64 type = GITS_BASER_TYPE(val);
> -		u64 entry_size = GITS_BASER_ENTRY_SIZE(val);
> +		struct its_baser *baser = its->tables + i;
>  		int order = get_order(psz);
> +		u64 val, type, entry_size;
>  		int alloc_pages;
>  		u64 tmp;
>  		void *base;
>  
> +		/* Record the register index */
> +		baser->idx = i;
> +
> +		val = its_read_baser(its, baser);
> +		type = GITS_BASER_TYPE(val);
> +		entry_size = GITS_BASER_ENTRY_SIZE(val);
> +
>  		if (type == GITS_BASER_TYPE_NONE)
>  			continue;
>  
> @@ -939,8 +957,8 @@ retry_baser:
>  		val |= alloc_pages - 1;
>  		its->tables[i].val = val;
>  
> -		writeq_relaxed(val, its->base + GITS_BASER + i * 8);
> -		tmp = readq_relaxed(its->base + GITS_BASER + i * 8);
> +		its_write_baser(its, baser, val);
> +		tmp = its_read_baser(its, baser);
>  
>  		if ((val ^ tmp) & GITS_BASER_SHAREABILITY_MASK) {
>  			/*
> 

Thanks to this abstraction, I now realize what I really hate about this
idea of caching stuff in the its_baser structure: you end up with
inconsistent data: 

- You store something in baser->val
- You write something else using its_write_baser
- You read something else using its_read_baser

We have 3 sets of inconsistent data, and what they mean depends on
the context.

What I'm proposing is that its_write_baser always performs a read back, 
and stores that read in baser->val. This gives us a more consistent 
view of what's going on (the value we wanted, and what the HW is 
actually capable of).

How about something like this, on top of my previous suggestion:

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 520d171..5591441 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -836,6 +836,7 @@ static void its_write_baser(struct its_node *its, struct its_baser *baser,
 {
 	int idx = baser - its->tables;
 	writeq_relaxed(val, its->base + GITS_BASER + (idx << 3));
+	baser->val = its_read_baser(its, baser);
 }
 
 static int its_setup_baser(struct its_node *its, struct its_baser *baser,
@@ -891,7 +892,7 @@ retry_baser:
 	}
 
 	its_write_baser(its, baser, val);
-	tmp = its_read_baser(its, baser);
+	tmp = baser->val;
 
 	if ((val ^ tmp) & GITS_BASER_SHAREABILITY_MASK) {
 		/*
@@ -939,7 +940,6 @@ retry_baser:
 	baser->order = order;
 	baser->base = base;
 	baser->psz = psz;
-	baser->val = val;
 	tmp = indirect ? GITS_LVL1_ENTRY_SIZE : esz;
 
 	pr_info("ITS@%pa: allocated %d %s @%lx (%s, esz %d, psz %dK, shr %d)\n",
@@ -968,7 +968,7 @@ static bool its_parse_baser_device(struct its_node *its, struct its_baser *baser
 		 * table by reading bit at offset '62' after writing '1' to it.
 		 */
 		its_write_baser(its, baser, val | GITS_BASER_INDIRECT);
-		val = its_read_baser(its, baser);
+		val = baser->val;
 		indirect = !!(val & GITS_BASER_INDIRECT);
 
 		if (indirect) {

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
