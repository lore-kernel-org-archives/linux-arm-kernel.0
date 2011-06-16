From: robherring2@gmail.com (Rob Herring)
Date: Thu, 16 Jun 2011 09:04:51 -0500
Subject: [RFC PATCH 03/11] dt/irq: add irq_domain_add_simple() helper
In-Reply-To: <20110616044141.29371.76366.stgit@ponder>
References: <20110616042653.29371.2052.stgit@ponder>
	<20110616044141.29371.76366.stgit@ponder>
Message-ID: <4DFA0D83.6070604@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant,

On 06/15/2011 11:41 PM, Grant Likely wrote:
> irq_domain_add_simple() is an easy way to generate an irq translation
> domain for simple irq controllers.  It assumes a flat 1:1 mapping from
> hardware irq number to an offset of the first linux irq number assigned
> to the controller
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>  include/linux/irq.h    |   11 +++++++++
>  kernel/irq/irqdomain.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 68 insertions(+), 1 deletions(-)
> 
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index a103c01..50830fc 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -797,6 +797,17 @@ extern unsigned int irq_domain_map(struct irq_domain *domain,
>  				   irq_hw_number_t hwirq);
>  extern void irq_domain_unmap(struct irq_domain *domain, irq_hw_number_t hw);
>  
> +struct of_device_id;
> +#ifdef CONFIG_OF
> +extern void irq_domain_add_simple(struct device_node *controller, int irq_base);
> +extern void irq_domain_generate_simple(struct of_device_id *match,

match should be const

> +					u64 phys_base, unsigned int irq_start);
> +#else

Empty function for irq_domain_add_simple?

> +static inline void irq_domain_generate_simple(struct of_device_id *match,
> +					u64 phys_base, unsigned int irq_start) { }
> +#endif
> +
> +

Rob
