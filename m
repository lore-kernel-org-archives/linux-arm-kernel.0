From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 26 Sep 2013 14:05:09 +0900
Subject: [PATCH v2] irqchip: exynos-combiner: remove hard-coded irq_base
 value
In-Reply-To: <1379937815-21746-1-git-send-email-chander.kashyap@linaro.org>
References: <1379937815-21746-1-git-send-email-chander.kashyap@linaro.org>
Message-ID: <02c701ceba75$f95b1900$ec114b00$@org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chander Kashyap wrote:
> 
> Replace irq_domain_add_simple with "irq_domain_add_linear" in order to use
> linear irq domain, and to remove hardcoded irq_base_value.
> 
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> ---
> Changes since v1:
> 	- Replaced irq_domain_add_simple with irq_domain_add_linear,
> 	  as suggested by Tomasz
> 
>  drivers/irqchip/exynos-combiner.c |   15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/irqchip/exynos-combiner.c b/drivers/irqchip/exynos-
> combiner.c
> index 4c68265..2551046 100644
> --- a/drivers/irqchip/exynos-combiner.c
> +++ b/drivers/irqchip/exynos-combiner.c
> @@ -206,8 +206,7 @@ static unsigned int combiner_lookup_irq(int group)
> 
>  static void __init combiner_init(void __iomem *combiner_base,
>  				 struct device_node *np,
> -				 unsigned int max_nr,
> -				 int irq_base)
> +				 unsigned int max_nr)
>  {
>  	int i, irq;
>  	unsigned int nr_irq;
> @@ -221,7 +220,7 @@ static void __init combiner_init(void __iomem
> *combiner_base,
>  		return;
>  	}
> 
> -	combiner_irq_domain = irq_domain_add_simple(np, nr_irq, irq_base,
> +	combiner_irq_domain = irq_domain_add_linear(np, nr_irq,
>  				&combiner_irq_domain_ops, combiner_data);
>  	if (WARN_ON(!combiner_irq_domain)) {
>  		pr_warning("%s: irq domain init failed\n", __func__);
> @@ -248,7 +247,6 @@ static int __init combiner_of_init(struct device_node
> *np,
>  {
>  	void __iomem *combiner_base;
>  	unsigned int max_nr = 20;
> -	int irq_base = -1;
> 
>  	combiner_base = of_iomap(np, 0);
>  	if (!combiner_base) {
> @@ -262,14 +260,7 @@ static int __init combiner_of_init(struct device_node
> *np,
>  			__func__, max_nr);
>  	}
> 
> -	/*
> -	 * FIXME: This is a hardwired COMBINER_IRQ(0,0). Once all devices
> -	 * get their IRQ from DT, remove this in order to get dynamic
> -	 * allocation.
> -	 */
> -	irq_base = 160;
> -
> -	combiner_init(combiner_base, np, max_nr, irq_base);
> +	combiner_init(combiner_base, np, max_nr);
> 
>  	return 0;
>  }
> --
> 1.7.9.5

Looks nice to me, applied with Tomasz's review.

Thanks,
Kukjin
