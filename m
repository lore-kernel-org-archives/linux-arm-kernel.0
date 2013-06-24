From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 24 Jun 2013 13:59:18 +0100
Subject: [PATCH 1/2] staging: drm/imx: use generic irqchip
In-Reply-To: <1371819139-22039-2-git-send-email-p.zabel@pengutronix.de>
References: <1371819139-22039-1-git-send-email-p.zabel@pengutronix.de>
 <1371819139-22039-2-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130624125919.04C693E0A89@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Jun 2013 14:52:17 +0200, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> This depends on the patch "genirq: Generic chip: Add linear irq domain support"
> and removes the custom IPU irq_chip and irq_domain_ops. Instead, the generic
> irq chip implementation is reused.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  drivers/staging/imx-drm/ipu-v3/ipu-common.c | 90 +++++++++--------------------
>  1 file changed, 26 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-common.c b/drivers/staging/imx-drm/ipu-v3/ipu-common.c
> index d629d6d..c135c66 100644
> --- a/drivers/staging/imx-drm/ipu-v3/ipu-common.c
> +++ b/drivers/staging/imx-drm/ipu-v3/ipu-common.c
> @@ -986,53 +986,6 @@ static void ipu_err_irq_handler(unsigned int irq, struct irq_desc *desc)
>  	chained_irq_exit(chip, desc);
>  }
>  
> -static void ipu_ack_irq(struct irq_data *d)
> -{
> -	struct ipu_soc *ipu = irq_data_get_irq_chip_data(d);
> -	irq_hw_number_t irq = d->hwirq;
> -
> -	ipu_cm_write(ipu, 1 << (irq % 32), IPU_INT_STAT(irq / 32));
> -}
> -
> -static void ipu_unmask_irq(struct irq_data *d)
> -{
> -	struct ipu_soc *ipu = irq_data_get_irq_chip_data(d);
> -	irq_hw_number_t irq = d->hwirq;
> -	unsigned long flags;
> -	u32 reg;
> -
> -	spin_lock_irqsave(&ipu->lock, flags);
> -
> -	reg = ipu_cm_read(ipu, IPU_INT_CTRL(irq / 32));
> -	reg |= 1 << (irq % 32);
> -	ipu_cm_write(ipu, reg, IPU_INT_CTRL(irq / 32));
> -
> -	spin_unlock_irqrestore(&ipu->lock, flags);
> -}
> -
> -static void ipu_mask_irq(struct irq_data *d)
> -{
> -	struct ipu_soc *ipu = irq_data_get_irq_chip_data(d);
> -	irq_hw_number_t irq = d->hwirq;
> -	unsigned long flags;
> -	u32 reg;
> -
> -	spin_lock_irqsave(&ipu->lock, flags);
> -
> -	reg = ipu_cm_read(ipu, IPU_INT_CTRL(irq / 32));
> -	reg &= ~(1 << (irq % 32));
> -	ipu_cm_write(ipu, reg, IPU_INT_CTRL(irq / 32));
> -
> -	spin_unlock_irqrestore(&ipu->lock, flags);
> -}
> -
> -static struct irq_chip ipu_irq_chip = {
> -	.name = "IPU",
> -	.irq_ack = ipu_ack_irq,
> -	.irq_mask = ipu_mask_irq,
> -	.irq_unmask = ipu_unmask_irq,
> -};
> -
>  int ipu_idmac_channel_irq(struct ipu_soc *ipu, struct ipuv3_channel *channel,
>  		enum ipu_channel_irq irq_type)
>  {
> @@ -1171,32 +1124,39 @@ err_register:
>  	return ret;
>  }
>  
> -static int ipu_irq_map(struct irq_domain *h, unsigned int irq,
> -		       irq_hw_number_t hw)
> -{
> -	struct ipu_soc *ipu = h->host_data;
> -
> -	irq_set_chip_and_handler(irq, &ipu_irq_chip, handle_level_irq);
> -	set_irq_flags(irq, IRQF_VALID);
> -	irq_set_chip_data(irq, ipu);
> -
> -	return 0;
> -}
> -
> -const struct irq_domain_ops ipu_irq_domain_ops = {
> -	.map = ipu_irq_map,
> -	.xlate = irq_domain_xlate_onecell,
> -};
>  
>  static int ipu_irq_init(struct ipu_soc *ipu)
>  {
> +	struct irq_chip_generic *gc;
> +	struct irq_chip_type *ct;
> +	int ret, i;
> +
>  	ipu->domain = irq_domain_add_linear(ipu->dev->of_node, IPU_NUM_IRQS,
> -					    &ipu_irq_domain_ops, ipu);
> +					    &irq_generic_chip_ops, ipu);
>  	if (!ipu->domain) {
>  		dev_err(ipu->dev, "failed to add irq domain\n");
>  		return -ENODEV;
>  	}
>  
> +	ret = irq_alloc_domain_generic_chips(ipu->domain, 32, 1, "IPU",
> +					     handle_level_irq, 0, IRQF_VALID, 0);
> +	if (ret < 0) {
> +		dev_err(ipu->dev, "failed to alloc generic irq chips\n");
> +		irq_domain_remove(ipu->domain);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < IPU_NUM_IRQS; i += 32) {
> +		gc = irq_get_domain_generic_chip(ipu->domain, i);
> +		gc->reg_base = ipu->cm_reg;
> +		ct = gc->chip_types;
> +		ct->chip.irq_ack = irq_gc_ack_set_bit;
> +		ct->chip.irq_mask = irq_gc_mask_clr_bit;
> +		ct->chip.irq_unmask = irq_gc_mask_set_bit;
> +		ct->regs.ack = IPU_INT_STAT(i / 32);
> +		ct->regs.mask = IPU_INT_CTRL(i / 32);
> +	}
> +
>  	irq_set_chained_handler(ipu->irq_sync, ipu_irq_handler);
>  	irq_set_handler_data(ipu->irq_sync, ipu);
>  	irq_set_chained_handler(ipu->irq_err, ipu_err_irq_handler);
> @@ -1214,6 +1174,8 @@ static void ipu_irq_exit(struct ipu_soc *ipu)
>  	irq_set_chained_handler(ipu->irq_sync, NULL);
>  	irq_set_handler_data(ipu->irq_sync, NULL);
>  
> +	/* TODO: remove irq_domain_generic_chips */
> +
>  	for (i = 0; i < IPU_NUM_IRQS; i++) {
>  		irq = irq_linear_revmap(ipu->domain, i);
>  		if (irq)
> -- 
> 1.8.3.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
email sent from notmuch.vim plugin
