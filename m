From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 26 Nov 2015 17:25:59 +0000
Subject: [PATCH v2 2/5] irqdomain: introduce irq_of_phandle_args_to_fwspec
In-Reply-To: <1448273816-11290-3-git-send-email-carlo@caione.org>
References: <1448273816-11290-1-git-send-email-carlo@caione.org>
 <1448273816-11290-3-git-send-email-carlo@caione.org>
Message-ID: <20151126172559.4e3cb76c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 Nov 2015 11:16:53 +0100
Carlo Caione <carlo@caione.org> wrote:

> From: Carlo Caione <carlo@endlessm.com>
> 
> Export of_phandle_args_to_fwspec with a new compliant name.
> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
>  include/linux/of_irq.h | 2 ++
>  kernel/irq/irqdomain.c | 5 +++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
> index 6f879c6..66bd92e 100644
> --- a/include/linux/of_irq.h
> +++ b/include/linux/of_irq.h
> @@ -34,6 +34,8 @@ static inline int of_irq_parse_oldworld(struct device_node *device, int index,
>  extern int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq);
>  extern int of_irq_parse_one(struct device_node *device, int index,
>  			  struct of_phandle_args *out_irq);
> +extern void irq_of_phandle_args_to_fwspec(struct of_phandle_args *irq_data,
> +					  struct irq_fwspec *fwspec);
>  extern unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data);
>  extern int of_irq_to_resource(struct device_node *dev, int index,
>  			      struct resource *r);
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 22aa961..b2ff223 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -554,7 +554,7 @@ static int irq_domain_translate(struct irq_domain *d,
>  	return 0;
>  }
>  
> -static void of_phandle_args_to_fwspec(struct of_phandle_args *irq_data,
> +void irq_of_phandle_args_to_fwspec(struct of_phandle_args *irq_data,
>  				      struct irq_fwspec *fwspec)
>  {
>  	int i;
> @@ -565,6 +565,7 @@ static void of_phandle_args_to_fwspec(struct of_phandle_args *irq_data,
>  	for (i = 0; i < irq_data->args_count; i++)
>  		fwspec->param[i] = irq_data->args[i];
>  }
> +EXPORT_SYMBOL_GPL(irq_of_phandle_args_to_fwspec);
>  
>  unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
>  {
> @@ -618,7 +619,7 @@ unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data)
>  {
>  	struct irq_fwspec fwspec;
>  
> -	of_phandle_args_to_fwspec(irq_data, &fwspec);
> +	irq_of_phandle_args_to_fwspec(irq_data, &fwspec);
>  	return irq_create_fwspec_mapping(&fwspec);
>  }
>  EXPORT_SYMBOL_GPL(irq_create_of_mapping);

Given what I've said earlier about keeping fwspec structures around,
you can probably discard that patch.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
