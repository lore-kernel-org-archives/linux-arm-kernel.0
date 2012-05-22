From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 22 May 2012 19:51:24 +0400
Subject: [PATCH v4 1/7] ARM: davinci, intc: Add irq domain support
In-Reply-To: <1337694920-8925-2-git-send-email-hs@denx.de>
References: <1337694920-8925-1-git-send-email-hs@denx.de>
 <1337694920-8925-2-git-send-email-hs@denx.de>
Message-ID: <4FBBB5FC.5060901@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2012 05:55 PM, Heiko Schocher wrote:

> Signed-off-by: Heiko Schocher<hs@denx.de>
> Cc: davinci-linux-open-source at linux.davincidsp.com
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: Grant Likely<grant.likely@secretlab.ca>
> Cc: Sekhar Nori<nsekhar@ti.com>
> Cc: Wolfgang Denk<wd@denx.de>
> Cc: Sergei Shtylyov<sshtylyov@mvista.com>

    In the patch subject, you'd better specify cp_intc, to avoid any confusion. 
Same comment for the next patch...

> diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
> index f83152d..bb52807 100644
> --- a/arch/arm/mach-davinci/cp_intc.c
> +++ b/arch/arm/mach-davinci/cp_intc.c
[...]
> @@ -99,18 +101,37 @@ static struct irq_chip cp_intc_irq_chip = {
[...]
> +int __init __cp_intc_init(struct device_node *node)
> +{
> +	u32 num_irq		= davinci_soc_info.intc_irq_num;
>   	u8 *irq_prio		= davinci_soc_info.intc_irq_prios;
>   	u32 *host_map		= davinci_soc_info.intc_host_map;
>   	unsigned num_reg	= BITS_TO_LONGS(num_irq);
> -	int i;
> +	int i, irq_base;
>
>   	davinci_intc_type = DAVINCI_INTC_TYPE_CP_INTC;
>   	davinci_intc_base = ioremap(davinci_soc_info.intc_base, SZ_8K);
> +

    Empty line not needed.

>   	if (WARN_ON(!davinci_intc_base))
[...]
> @@ -165,13 +186,28 @@ void __init cp_intc_init(void)
>   		for (i = 0; host_map[i] != -1; i++)
>   			cp_intc_write(host_map[i], CP_INTC_HOST_MAP(i));
>
> -	/* Set up genirq dispatching for cp_intc */
> -	for (i = 0; i<  num_irq; i++) {
> -		irq_set_chip(i,&cp_intc_irq_chip);
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
> +					irq_base, 0,&cp_intc_host_ops, NULL);
> +
> +	if (cp_intc_domain == NULL) {

    'if (!cp_int_domain)' please -- to keep the style consistent.

> +		pr_err("CP INTC: failed to allocate irq host!\n");

   s/CP_INTC/cp_intc/

WBR, Sergei
