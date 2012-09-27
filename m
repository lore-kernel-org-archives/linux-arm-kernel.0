From: lethal@linux-sh.org (Paul Mundt)
Date: Thu, 27 Sep 2012 22:54:21 +0900
Subject: [PATCH 2/4] irqdomain: augment add_simple() to allocate descs
In-Reply-To: <1348751625-17420-1-git-send-email-linus.walleij@stericsson.com>
References: <1348751625-17420-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20120927135420.GM13568@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2012 at 03:13:45PM +0200, Linus Walleij wrote:
> +	if (first_irq > 0) {
> +		int irq_base;
> +
> +		irq_base = irq_alloc_descs(first_irq, 0, size, numa_node_id());
> +		if (irq_base < 0) {
> +			WARN(1, "Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
> +			     first_irq);
> +			irq_base = first_irq;
> +		}
> +		return irq_domain_add_legacy(of_node, size, irq_base, 0,
>  					     ops, host_data);

If first_irq is specified you presumably want irq_alloc_desc_at()
behaviour, so you should use irq_alloc_descs(first_irq, first_irq, ...),
similar to what irq_create_strict_mappings() does.

Also don't use numa_node_id() for this, of_node_to_nid() handles both the
OF and non-OF cases.
