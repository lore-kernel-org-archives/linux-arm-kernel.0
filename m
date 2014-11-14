From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 14 Nov 2014 18:30:10 +0000
Subject: [PATCH v6 3/6] irqchip: gic: Support hierarchy irq domain.
In-Reply-To: <1415893029-2971-4-git-send-email-yingjoe.chen@mediatek.com>
References: <1415893029-2971-1-git-send-email-yingjoe.chen@mediatek.com>
 <1415893029-2971-4-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <54664A32.5070200@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/11/14 15:37, Yingjoe Chen wrote:
> Add support to use gic as a parent for stacked irq domain.
> 
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> ---
>  drivers/irqchip/Kconfig   |  1 +
>  drivers/irqchip/irq-gic.c | 80 ++++++++++++++++++++++++++++++++---------------
>  2 files changed, 55 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index b21f12f..7f34138 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -5,6 +5,7 @@ config IRQCHIP
>  config ARM_GIC
>  	bool
>  	select IRQ_DOMAIN
> +	select IRQ_DOMAIN_HIERARCHY
>  	select MULTI_IRQ_HANDLER
>  
>  config GIC_NON_BANKED
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 38493ff..fe9ab93 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -788,17 +788,16 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
>  {
>  	if (hw < 32) {
>  		irq_set_percpu_devid(irq);
> -		irq_set_chip_and_handler(irq, &gic_chip,
> -					 handle_percpu_devid_irq);
> +		irq_domain_set_info(d, irq, hw, &gic_chip, d->host_data,
> +				    handle_percpu_devid_irq, NULL, NULL);
>  		set_irq_flags(irq, IRQF_VALID | IRQF_NOAUTOEN);
>  	} else {
> -		irq_set_chip_and_handler(irq, &gic_chip,
> -					 handle_fasteoi_irq);
> +		irq_domain_set_info(d, irq, hw, &gic_chip, d->host_data,
> +				    handle_fasteoi_irq, NULL, NULL);
>  		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
>  
>  		gic_routable_irq_domain_ops->map(d, irq, hw);
>  	}
> -	irq_set_chip_data(irq, d->host_data);
>  	return 0;
>  }
>  
> @@ -814,8 +813,6 @@ static int gic_irq_domain_xlate(struct irq_domain *d,
>  {
>  	unsigned long ret = 0;
>  
> -	if (d->of_node != controller)
> -		return -EINVAL;

I'm not sure if removing that check is the right thing to do. You had to
remove it because your sysirq driver passes its own of_phandle_args
directly to the GIC code. I think that's a bad idea, and you should fix
the sysirq layer instead.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
