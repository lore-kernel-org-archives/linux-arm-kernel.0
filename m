From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 23 Mar 2015 00:11:28 +0000
Subject: [PATCH v3 03/12] irqchip: vf610-mscm: support NVIC parent
In-Reply-To: <1426203380-7155-4-git-send-email-stefan@agner.ch>
References: <1426203380-7155-1-git-send-email-stefan@agner.ch>
 <1426203380-7155-4-git-send-email-stefan@agner.ch>
Message-ID: <20150323001128.GL15137@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan,

On Fri, Mar 13, 2015 at 12:36:11AM +0100, Stefan Agner wrote:
> Support the NVIC interrupt controller as node parent of the MSCM
> interrupt router. On the dual-core variants of Vybird (VF6xx), the
> NVIC interrupt controller is used by the Cortex-M4. To support
> running Linux on this core too, MSCM needs NVIC parent support too.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/irqchip/irq-vf610-mscm-ir.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-vf610-mscm-ir.c b/drivers/irqchip/irq-vf610-mscm-ir.c
> index 9521057..bb0e1a3 100644
> --- a/drivers/irqchip/irq-vf610-mscm-ir.c
> +++ b/drivers/irqchip/irq-vf610-mscm-ir.c
...
> @@ -101,17 +103,25 @@ static void vf610_mscm_ir_enable(struct irq_data *data)
>  	writew_relaxed(chip_data->cpu_mask,
>  		       chip_data->mscm_ir_base + MSCM_IRSPRC(hwirq));
>  
> -	irq_chip_unmask_parent(data);
> +	if (parent->chip->irq_enable)
> +		parent->chip->irq_enable(parent);
> +	else
> +		parent->chip->irq_unmask(parent);
> +
>  }
>  
>  static void vf610_mscm_ir_disable(struct irq_data *data)
>  {
>  	irq_hw_number_t hwirq = data->hwirq;
>  	struct vf610_mscm_ir_chip_data *chip_data = data->chip_data;
> +	struct irq_data *parent = data->parent_data;
>  
>  	writew_relaxed(0x0, chip_data->mscm_ir_base + MSCM_IRSPRC(hwirq));
>  
> -	irq_chip_mask_parent(data);
> +	if (parent->chip->irq_enable)
> +		parent->chip->irq_disable(parent);

copy/paste?

> @@ -143,10 +153,17 @@ static int vf610_mscm_ir_domain_alloc(struct irq_domain *domain, unsigned int vi
>  					      domain->host_data);
>  
>  	gic_data.np = domain->parent->of_node;
> -	gic_data.args_count = 3;
> -	gic_data.args[0] = GIC_SPI;
> -	gic_data.args[1] = irq_data->args[0];
> -	gic_data.args[2] = irq_data->args[1];
> +
> +	if (mscm_ir_data->is_nvic) {
> +		gic_data.args_count = 1;
> +		gic_data.args[0] = irq_data->args[0];
> +	} else {
> +		gic_data.args_count = 3;
> +		gic_data.args[0] = GIC_SPI;
> +		gic_data.args[1] = irq_data->args[0];
> +		gic_data.args[2] = irq_data->args[1];
> +	}
> +
>  	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &gic_data);
>  }
>  
> @@ -199,6 +216,9 @@ static int __init vf610_mscm_ir_of_init(struct device_node *node,
>  		goto out_unmap;
>  	}
>  
> +	if (of_device_is_compatible(domain->parent->of_node, "arm,armv7m-nvic"))
> +		mscm_ir_data->is_nvic = true;
> +

Could you walk me through how DT backwards compatibility is being
preserved/broken here?  I'm not saying it's wrong, but every other conversion
to stacked domains involves a compatibility break.  At the very least, I'd like
to see it discussed in the commit log.

thx,

Jason.
