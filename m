From: robherring2@gmail.com (Rob Herring)
Date: Thu, 27 Sep 2012 08:41:53 -0500
Subject: [PATCH 2/4] irqdomain: augment add_simple() to allocate descs
In-Reply-To: <1348751625-17420-1-git-send-email-linus.walleij@stericsson.com>
References: <1348751625-17420-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <506457A1.8050404@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/27/2012 08:13 AM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> Currently we rely on all IRQ chip instances to dynamically
> allocate their IRQ descriptors unless they use the linear
> IRQ domain. So for irqdomain_add_legacy() and
> irqdomain_add_simple() the caller need to make sure that
> descriptors are allocated.
> 
> Let's slightly augment the yet unused irqdomain_add_simple()
> to also allocate descriptors as a means to simplify usage
> and avoid code duplication throughout the kernel.
> 
> We warn if descriptors cannot be allocated, e.g. if a
> platform has the bad habit of hogging descriptors at boot
> time.
> 
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Rob/Grant/Thomas if you ACK this I will take it through the
> pinctrl tree since I introduce its only user right there.

You really should have Grant's ack here.

> ---
>  kernel/irq/irqdomain.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 49a7772..a0655b6 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -148,7 +148,8 @@ static unsigned int irq_domain_legacy_revmap(struct irq_domain *domain,
>   * @host_data: Controller private data pointer
>   *
>   * Allocates a legacy irq_domain if irq_base is positive or a linear
> - * domain otherwise.
> + * domain otherwise. For the legacy domain, IRQ descriptors will also
> + * be allocated.
>   *
>   * This is intended to implement the expected behaviour for most
>   * interrupt controllers which is that a linear mapping should
> @@ -162,11 +163,21 @@ struct irq_domain *irq_domain_add_simple(struct device_node *of_node,
>  					 const struct irq_domain_ops *ops,
>  					 void *host_data)
>  {
> -	if (first_irq > 0)
> -		return irq_domain_add_legacy(of_node, size, first_irq, 0,
> +	if (first_irq > 0) {
> +		int irq_base;
> +
> +		irq_base = irq_alloc_descs(first_irq, 0, size, numa_node_id());

This will always fail for !SPARSE_IRQ, so we probably don't want warn in
that case. So perhaps something like this:

int irq_base = first_irq;

if (is_enabled(CONFIG_SPARSE_IRQ)) {
	irq_base = irq_alloc_descs(first_irq, 0, size, numa_node_id());
	if (irq_base < 0) {
		WARN(1, "Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
		     first_irq);
		irq_base = first_irq;
	}
}

> +		if (irq_base < 0) {
> +			WARN(1, "Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
> +			     first_irq);
> +			irq_base = first_irq;
> +		}
> +		return irq_domain_add_legacy(of_node, size, irq_base, 0,
>  					     ops, host_data);
> -	else
> -		return irq_domain_add_linear(of_node, size, ops, host_data);
> +	}
> +
> +	/* A linear domain is the default */
> +	return irq_domain_add_linear(of_node, size, ops, host_data);
>  }
>  
>  /**
> 
