From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 6 Jun 2016 09:37:01 +0100
Subject: [PATCH V4 1/5] irqchip/gicv3-its: Introduce two helper functions
 for accessing BASERn
In-Reply-To: <1465191636-6823-2-git-send-email-shankerd@codeaurora.org>
References: <1465191636-6823-1-git-send-email-shankerd@codeaurora.org>
 <1465191636-6823-2-git-send-email-shankerd@codeaurora.org>
Message-ID: <5755362D.60600@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shanker,

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

It is worth realizing that we always end-up with baser being a pointer 
to one of the its->tables entries. We can easily simplify the whole 
thing and drop the idx field:

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 271c7f3..520d171 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -63,7 +63,6 @@ struct its_baser {
 	void		*base;
 	u64		val;
 	u32		order;
-	u32		idx;
 	u32		psz;
 };
 
@@ -828,13 +827,15 @@ static const char *its_base_type_string[] = {
 
 static u64 its_read_baser(struct its_node *its, struct its_baser *baser)
 {
-	return readq_relaxed(its->base + GITS_BASER + (baser->idx << 3));
+	int idx = baser - its->tables;
+	return readq_relaxed(its->base + GITS_BASER + (idx << 3));
 }
 
 static void its_write_baser(struct its_node *its, struct its_baser *baser,
 			    u64 val)
 {
-	writeq_relaxed(val, its->base + GITS_BASER + (baser->idx << 3));
+	int idx = baser - its->tables;
+	writeq_relaxed(val, its->base + GITS_BASER + (idx << 3));
 }
 
 static int its_setup_baser(struct its_node *its, struct its_baser *baser,
@@ -1042,8 +1043,7 @@ static int its_alloc_tables(struct its_node *its)
 		bool indirect = false;
 		u64 type;
 
-		/* Record the register index and set preferred settings */
-		baser->idx = i;
+		/* Record the preferred settings */
 		baser->val = cache | shr;
 		baser->psz = psz;
 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
