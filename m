From: robherring2@gmail.com (Rob Herring)
Date: Tue, 24 Jan 2012 15:38:37 -0600
Subject: [RFCv2 03/14] irq_domain: Make irq_domain structure match
 powerpc's irq_host
In-Reply-To: <1327352870-14687-4-git-send-email-grant.likely@secretlab.ca>
References: <1327352870-14687-1-git-send-email-grant.likely@secretlab.ca>
 <1327352870-14687-4-git-send-email-grant.likely@secretlab.ca>
Message-ID: <4F1F24DD.5030904@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/23/2012 03:07 PM, Grant Likely wrote:
> Part of the series to unify the irq remapping mechanisms in the
> kernel.  A follow up patch will copy the powerpc implementation into
> kernel/irq/irqdomain.c, which will be a lot easier if the structures
> are identical.
> 
> Where they differ, I've chose to use the powerpc names since there is
> a lot more code using those names.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>  arch/arm/common/gic.c     |   14 ++++----
>  include/linux/irqdomain.h |   84 ++++++++++++++++++++++++++++++++++-----------
>  kernel/irq/irqdomain.c    |   14 ++++----
>  3 files changed, 78 insertions(+), 34 deletions(-)
> 

snip...

> @@ -126,7 +126,7 @@ void irq_dispose_mapping(unsigned int irq)
>  }
>  EXPORT_SYMBOL_GPL(irq_dispose_mapping);
>  
> -int irq_domain_simple_dt_translate(struct irq_domain *d,
> +int irq_domain_simple_xlate(struct irq_domain *d,
>  			    struct device_node *controller,
>  			    const u32 *intspec, unsigned int intsize,
>  			    unsigned long *out_hwirq, unsigned int *out_type)

This needs a declaration in irqdomain.h (as well as EXPORT?). There
could be others as well, but this is the one I'm using for generic irq chip.

Rob

> @@ -181,7 +181,7 @@ EXPORT_SYMBOL_GPL(irq_domain_generate_simple);
>  
>  struct irq_domain_ops irq_domain_simple_ops = {
>  #ifdef CONFIG_OF_IRQ
> -	.dt_translate = irq_domain_simple_dt_translate,
> +	.xlate = irq_domain_simple_xlate,
>  #endif /* CONFIG_OF_IRQ */
>  };
>  EXPORT_SYMBOL_GPL(irq_domain_simple_ops);
