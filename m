From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 26 May 2012 00:03:12 -0600
Subject: [PATCH v4 1/7] ARM: davinci, intc: Add irq domain support
In-Reply-To: <1337694920-8925-2-git-send-email-hs@denx.de>
References: <1337694920-8925-1-git-send-email-hs@denx.de>
 <1337694920-8925-2-git-send-email-hs@denx.de>
Message-ID: <20120526060312.815A13E2578@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 May 2012 15:55:14 +0200, Heiko Schocher <hs@denx.de> wrote:
> Signed-off-by: Heiko Schocher <hs@denx.de>
> Cc: davinci-linux-open-source at linux.davincidsp.com
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Wolfgang Denk <wd@denx.de>
> Cc: Sergei Shtylyov <sshtylyov@mvista.com>

Hi Heiko,

Earlier today I commented (again) on the previous version of this
patch.  Sorry about that.  I'm happy with the direction this series is
going.  Here's one more comments.

> diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
> index f83152d..bb52807 100644
> --- a/arch/arm/mach-davinci/cp_intc.c
> +++ b/arch/arm/mach-davinci/cp_intc.c
> @@ -9,8 +9,10 @@
>   * kind, whether express or implied.
>   */
>  
> +#include <linux/export.h>
>  #include <linux/init.h>
>  #include <linux/irq.h>
> +#include <linux/irqdomain.h>
>  #include <linux/io.h>
>  
>  #include <mach/common.h>
> @@ -99,18 +101,37 @@ static struct irq_chip cp_intc_irq_chip = {
>  	.irq_set_wake	= cp_intc_set_wake,
>  };

All of the irq_chip hooks need to be switched from using d->irq to
d->hwirq for the hardware irq number.  That sets up to driver to
switch to using dynamic allocation of irq_descs.

>  
> -void __init cp_intc_init(void)
> +static struct irq_domain *cp_intc_domain;
> +
> +static int cp_intc_host_map(struct irq_domain *h, unsigned int virq,
> +			  irq_hw_number_t hw)
>  {
> -	unsigned long num_irq	= davinci_soc_info.intc_irq_num;
> +	pr_debug("cp_intc_host_map(%d, 0x%lx)\n", virq, hw);
> +
> +	irq_set_chip(virq, &cp_intc_irq_chip);
> +	set_irq_flags(virq, IRQF_VALID | IRQF_PROBE);
> +	irq_set_handler(virq, handle_edge_irq);
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops cp_intc_host_ops = {
> +	.map = cp_intc_host_map,
> +	.xlate = irq_domain_xlate_onetwocell,
> +};
> +
> +int __init __cp_intc_init(struct device_node *node)
> +{
> +	u32 num_irq		= davinci_soc_info.intc_irq_num;
>  	u8 *irq_prio		= davinci_soc_info.intc_irq_prios;
>  	u32 *host_map		= davinci_soc_info.intc_host_map;
>  	unsigned num_reg	= BITS_TO_LONGS(num_irq);
> -	int i;
> +	int i, irq_base;
>  
>  	davinci_intc_type = DAVINCI_INTC_TYPE_CP_INTC;
>  	davinci_intc_base = ioremap(davinci_soc_info.intc_base, SZ_8K);
> +
>  	if (WARN_ON(!davinci_intc_base))
> -		return;
> +		return -EINVAL;
>  
>  	cp_intc_write(0, CP_INTC_GLOBAL_ENABLE);
>  
> @@ -165,13 +186,28 @@ void __init cp_intc_init(void)
>  		for (i = 0; host_map[i] != -1; i++)
>  			cp_intc_write(host_map[i], CP_INTC_HOST_MAP(i));
>  
> -	/* Set up genirq dispatching for cp_intc */
> -	for (i = 0; i < num_irq; i++) {
> -		irq_set_chip(i, &cp_intc_irq_chip);
> -		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
> -		irq_set_handler(i, handle_edge_irq);
> +	irq_base = irq_alloc_descs(-1, 0, num_irq, 0);
> +	if (irq_base < 0) {
> +		pr_warn("Couldn't allocate IRQ numbers\n");
> +		irq_base = 0;
> +	}
> +
> +	/* create a legacy host */
> +	cp_intc_domain = irq_domain_add_legacy(node, num_irq,
> +					irq_base, 0, &cp_intc_host_ops, NULL);
> +
> +	if (cp_intc_domain == NULL) {
> +		pr_err("CP INTC: failed to allocate irq host!\n");
> +		return -EINVAL;
>  	}
>  
>  	/* Enable global interrupt */
>  	cp_intc_write(1, CP_INTC_GLOBAL_ENABLE);
> +
> +	return 0;
> +}
> +
> +void __init cp_intc_init(void)
> +{
> +	__cp_intc_init(NULL);
>  }
> -- 
> 1.7.7.6
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
