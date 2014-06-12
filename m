From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 12 Jun 2014 08:51:34 -0400
Subject: [PATCH V2 03/19] irqchip: crossbar: Skip some irqs from
 getting mapped to crossbar
In-Reply-To: <1402574007-13987-4-git-send-email-r.sricharan@ti.com>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
 <1402574007-13987-4-git-send-email-r.sricharan@ti.com>
Message-ID: <20140612125134.GS8664@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12, 2014 at 05:23:11PM +0530, Sricharan R wrote:
> From: Nishanth Menon <nm@ti.com>
> 
> When, in the system due to varied reasons, interrupts might be unusable
> due to hardware behavior, but register maps do exist, then those interrupts
> should be skipped while mapping irq to crossbars.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Sricharan R <r.sricharan@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Tony, have you applied these somewhere already?

> ---
>  drivers/irqchip/irq-crossbar.c |   47 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 43 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
> index 51d4b87..847f6e3 100644
> --- a/drivers/irqchip/irq-crossbar.c
> +++ b/drivers/irqchip/irq-crossbar.c
> @@ -13,11 +13,13 @@
>  #include <linux/io.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> +#include <linux/of_device.h>
>  #include <linux/slab.h>
>  #include <linux/irqchip/arm-gic.h>
>  
>  #define IRQ_FREE	-1
>  #define IRQ_RESERVED	-2
> +#define IRQ_SKIP	-3
>  #define GIC_IRQ_START	32
>  
>  /*
> @@ -34,6 +36,16 @@ struct crossbar_device {
>  	void (*write) (int, int);
>  };
>  
> +/**
> + * struct crossbar_data: Platform specific data
> + * @irqs_unused: array of irqs that cannot be used because of hw erratas
> + * @size: size of the irqs_unused array
> + */
> +struct crossbar_data {
> +	const uint *irqs_unused;
> +	const uint size;
> +};
> +
>  static struct crossbar_device *cb;
>  
>  static inline void crossbar_writel(int irq_no, int cb_no)
> @@ -119,10 +131,12 @@ const struct irq_domain_ops routable_irq_domain_ops = {
>  	.xlate = crossbar_domain_xlate
>  };
>  
> -static int __init crossbar_of_init(struct device_node *node)
> +static int __init crossbar_of_init(struct device_node *node,
> +				   const struct crossbar_data *data)
>  {
>  	int i, size, max, reserved = 0, entry;
>  	const __be32 *irqsr;
> +	const int *irqsk = NULL;
>  
>  	cb = kzalloc(sizeof(*cb), GFP_KERNEL);
>  
> @@ -194,6 +208,22 @@ static int __init crossbar_of_init(struct device_node *node)
>  		reserved += size;
>  	}
>  
> +	/* Skip the ones marked as unused */
> +	if (data) {
> +		irqsk = data->irqs_unused;
> +		size = data->size;
> +
> +		for (i = 0; i < size; i++) {
> +			entry = irqsk[i];
> +
> +			if (entry > max) {
> +				pr_err("Invalid skip entry\n");
> +				goto err3;
> +			}
> +			cb->irq_map[entry] = IRQ_SKIP;
> +		}
> +	}
> +
>  	register_routable_domain_ops(&routable_irq_domain_ops);
>  	return 0;
>  
> @@ -208,18 +238,27 @@ err1:
>  	return -ENOMEM;
>  }
>  
> +/* irq number 10 cannot be used because of hw bug */
> +int dra_irqs_unused[] = { 10 };
> +struct crossbar_data cb_dra_data = { dra_irqs_unused,
> +				     ARRAY_SIZE(dra_irqs_unused) };
> +
>  static const struct of_device_id crossbar_match[] __initconst = {
> -	{ .compatible = "ti,irq-crossbar" },
> +	{ .compatible = "ti,irq-crossbar", .data = &cb_dra_data },
>  	{}
>  };

This is a bug in all implementations of this IP?  Or, a specific
SoC's implementation?  Would this be better expressed in the dts via a
property?  Can we expect future implementations to be fixed?

thx,

Jason.
