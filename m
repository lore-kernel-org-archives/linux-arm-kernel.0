From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 6 Jul 2012 17:18:04 +0800
Subject: [RFC PATCH 2/2] irq: add irq_desc_initialize to remove some
 duplicated lines
In-Reply-To: <1340182831-10477-2-git-send-email-b29396@freescale.com>
References: <1340182831-10477-1-git-send-email-b29396@freescale.com>
 <1340182831-10477-2-git-send-email-b29396@freescale.com>
Message-ID: <20120706091803.GA12558@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 05:00:31PM +0800, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> There're two copies of irq_desc initialization code, reform them into
> an irq_desc_initialize function to call.
> 
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> ---
>  kernel/irq/irqdesc.c |   51 +++++++++++++++++++++++++++----------------------
>  1 files changed, 28 insertions(+), 23 deletions(-)
> 
Ping...

Regards
Dong Aisheng

> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index 192a302..e29db67 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -131,34 +131,43 @@ static void free_masks(struct irq_desc *desc)
>  static inline void free_masks(struct irq_desc *desc) { }
>  #endif
>  
> -static struct irq_desc *alloc_desc(int irq, int node, struct module *owner)
> +static inline int irq_desc_initialize(struct irq_desc *desc,
> +					int irq, int node, struct module *owner)
>  {
> -	struct irq_desc *desc;
> -	gfp_t gfp = GFP_KERNEL;
> -
> -	desc = kzalloc_node(sizeof(*desc), gfp, node);
> -	if (!desc)
> -		return NULL;
>  	/* allocate based on nr_cpu_ids */
>  	desc->kstat_irqs = alloc_percpu(unsigned int);
>  	if (!desc->kstat_irqs)
> -		goto err_desc;
> +		return -ENOMEM;
>  
> -	if (alloc_masks(desc, gfp, node))
> -		goto err_kstat;
> +	if (alloc_masks(desc, GFP_KERNEL, node)) {
> +		kfree(desc->kstat_irqs);
> +		return -ENOMEM;
> +	}
>  
>  	raw_spin_lock_init(&desc->lock);
>  	lockdep_set_class(&desc->lock, &irq_desc_lock_class);
>  
>  	desc_set_defaults(irq, desc, node, owner);
>  
> -	return desc;
> +	return 0;
> +}
>  
> -err_kstat:
> -	free_percpu(desc->kstat_irqs);
> -err_desc:
> -	kfree(desc);
> -	return NULL;
> +static struct irq_desc *alloc_desc(int irq, int node, struct module *owner)
> +{
> +	struct irq_desc *desc;
> +	int ret;
> +
> +	desc = kzalloc_node(sizeof(*desc), GFP_KERNEL, node);
> +	if (!desc)
> +		return NULL;
> +
> +	ret = irq_desc_initialize(desc, irq, node, owner);
> +	if (ret) {
> +		kfree(desc);
> +		return NULL;
> +	}
> +
> +	return desc;
>  }
>  
>  static void free_desc(unsigned int irq)
> @@ -260,13 +269,9 @@ int __init early_irq_init(void)
>  	desc = irq_desc;
>  	count = ARRAY_SIZE(irq_desc);
>  
> -	for (i = 0; i < count; i++) {
> -		desc[i].kstat_irqs = alloc_percpu(unsigned int);
> -		alloc_masks(&desc[i], GFP_KERNEL, node);
> -		raw_spin_lock_init(&desc[i].lock);
> -		lockdep_set_class(&desc[i].lock, &irq_desc_lock_class);
> -		desc_set_defaults(i, &desc[i], node, NULL);
> -	}
> +	for (i = 0; i < count; i++)
> +		irq_desc_initialize(desc, irq, node, NULL);
> +
>  	return arch_early_irq_init();
>  }
>  
> -- 
> 1.7.0.4
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
