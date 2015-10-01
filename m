From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 1 Oct 2015 22:14:28 +0200
Subject: [PATCH 1/2] irqchip: sunxi-nmi: Use driver name instead of DT
 node name for identification
In-Reply-To: <1443713629-17415-2-git-send-email-wens@csie.org>
References: <1443713629-17415-1-git-send-email-wens@csie.org>
 <1443713629-17415-2-git-send-email-wens@csie.org>
Message-ID: <20151001201428.GO7104@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 01, 2015 at 11:33:48PM +0800, Chen-Yu Tsai wrote:
> The device tree node name is typically "interrupt-controller", which is
> rather useless when used in printk messages and irq chip names for
> identification purposes. Use the driver name "sunxi-nmi" instead.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/irqchip/irq-sunxi-nmi.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
> index c143dd58410c..57e009917d2d 100644
> --- a/drivers/irqchip/irq-sunxi-nmi.c
> +++ b/drivers/irqchip/irq-sunxi-nmi.c
> @@ -21,6 +21,7 @@
>  #include <linux/irqchip/chained_irq.h>
>  
>  #define SUNXI_NMI_SRC_TYPE_MASK	0x00000003
> +#define DRV_NAME "sunxi-nmi"
>  
>  enum {
>  	SUNXI_SRC_TYPE_LEVEL_LOW = 0,
> @@ -130,22 +131,22 @@ static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
>  
>  	domain = irq_domain_add_linear(node, 1, &irq_generic_chip_ops, NULL);
>  	if (!domain) {
> -		pr_err("%s: Could not register interrupt domain.\n", node->name);
> +		pr_err("%s: Could not register interrupt domain.\n", DRV_NAME);
>  		return -ENOMEM;
>  	}
>  
> -	ret = irq_alloc_domain_generic_chips(domain, 1, 2, node->name,
> +	ret = irq_alloc_domain_generic_chips(domain, 1, 2, DRV_NAME,
>  					     handle_fasteoi_irq, clr, 0,
>  					     IRQ_GC_INIT_MASK_CACHE);
>  	if (ret) {
>  		 pr_err("%s: Could not allocate generic interrupt chip.\n",
> -			 node->name);
> +			 DRV_NAME);
>  		 goto fail_irqd_remove;
>  	}
>  
>  	irq = irq_of_parse_and_map(node, 0);
>  	if (irq <= 0) {
> -		pr_err("%s: unable to parse irq\n", node->name);
> +		pr_err("%s: unable to parse irq\n", DRV_NAME);
>  		ret = -EINVAL;
>  		goto fail_irqd_remove;
>  	}
> @@ -153,7 +154,7 @@ static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
>  	gc = irq_get_domain_generic_chip(domain, 0);
>  	gc->reg_base = of_iomap(node, 0);
>  	if (!gc->reg_base) {
> -		pr_err("%s: unable to map resource\n", node->name);
> +		pr_err("%s: unable to map resource\n", DRV_NAME);

All the pr_err changes can even be replaced by defining pr_fmt.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151001/1d0115dc/attachment-0001.sig>
