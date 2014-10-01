From: yingjoe.chen@mediatek.com (Joe.C)
Date: Wed, 1 Oct 2014 22:23:38 +0800
Subject: [RFT v2 01/24] irqdomain: Introduce new interfaces to support
 hierarchy irqdomains
In-Reply-To: <1411740145-30626-2-git-send-email-jiang.liu@linux.intel.com>
References: <1411740145-30626-1-git-send-email-jiang.liu@linux.intel.com>
 <1411740145-30626-2-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <1412173418.24931.3514.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-09-26 at 22:02 +0800, Jiang Liu wrote:
> @@ -480,6 +478,11 @@ unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data)
>  		return 0;
>  	}
>  
> +	if (irq_domain_is_hierarchy(domain)) {
> +		virq = irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, irq_data);
> +		return virq <= 0 ? 0 : virq;
> +	}
> +
>  	/* If domain has no translation, then we assume interrupt line */
>  	if (domain->ops->xlate == NULL)
>  		hwirq = irq_data->args[0];

Hi Jiang,

You'll need this change, otherwise <0 part of the check will always be
false.

@@ -467,7 +467,7 @@ unsigned int irq_create_of_mapping(struct
of_phandle_args *irq_data)
 	struct irq_domain *domain;
 	irq_hw_number_t hwirq;
 	unsigned int type = IRQ_TYPE_NONE;
-	unsigned int virq;
+	int virq;
 
 	domain = irq_data->np ? irq_find_host(irq_data->np) :
irq_default_domain;
 	if (!domain) {

Joe.C
