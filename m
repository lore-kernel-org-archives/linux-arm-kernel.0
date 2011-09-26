From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 26 Sep 2011 20:57:04 +0100
Subject: [PATCH 3/3] ARM: gic: add OF based initialization
In-Reply-To: <1316550244-3655-4-git-send-email-robherring2@gmail.com>
References: <1316550244-3655-1-git-send-email-robherring2@gmail.com>
	<1316550244-3655-4-git-send-email-robherring2@gmail.com>
Message-ID: <20110926195704.GD9194@gallagher>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Tue, Sep 20, 2011 at 03:24:04PM -0500, Rob Herring wrote:
[...]
> +int __init gic_of_init(struct device_node *node, struct device_node *parent)
> +{
> +	void __iomem *cpu_base;
> +	void __iomem *dist_base;
> +	int irq;
> +	struct irq_domain *domain = &gic_data[gic_cnt].domain;
> +
> +	if (WARN_ON(!node))
> +		return -ENODEV;
> +
> +	dist_base = of_iomap(node, 0);
> +	WARN(!dist_base, "unable to map gic dist registers\n");
> +
> +	cpu_base = of_iomap(node, 1);
> +	WARN(!cpu_base, "unable to map gic cpu registers\n");
> +
> +	domain->nr_irq = gic_irq_count(dist_base);
> +	/* subtract off SGIs. Also subtract off PPIs for secondary GICs */
> +	if (parent)
> +		domain->nr_irq -= 32;
> +	else
> +		domain->nr_irq -= 16;
> +
> +	domain->irq_base = irq_alloc_descs(-1, 16, domain->nr_irq, numa_node_id());

The way I understand irq_alloc_descs() (probably not very well) is that 
having the irq parameter < 0 and the from parameter 16 means that it 
needs to find domain->nr_irq descs starting from at least 16.  But if 
the base is greater than 16, does this still work with the gic entry 
macros as they are?

Jamie
