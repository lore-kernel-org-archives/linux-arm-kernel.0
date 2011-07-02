From: simon@sequanux.org (Simon Guinot)
Date: Sat, 2 Jul 2011 12:35:54 +0000
Subject: [PATCH] genirq: replace irq_gc_ack with {set,clr}_bit variants
In-Reply-To: <1309469952-32242-1-git-send-email-simon@sequanux.org>
References: <20110630095223.GH31228@kw.sim.vm.gnt>
	<1309469952-32242-1-git-send-email-simon@sequanux.org>
Message-ID: <20110702123554.GK31228@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas, Nicolas, Lennert and Saeed,

On Thu, Jun 30, 2011 at 11:39:12PM +0200, Simon Guinot wrote:
> From: Simon Guinot <sguinot@lacie.com>
> 
> This patch fix the edge GPIO interrupts support for Orion based SoCs.
> For this devices, edge interrupt acknowledgement is done by clearing a
> cause register. Replace irq_gc_ack with {set,clr}_bit variants allows
> to address such cases.
> 
> Tested on Network Space v2.
> 
> Reported-by: Joey Oravec <joravec@drewtech.com>
> Signed-off-by: Simon Guinot <sguinot@lacie.com>
> ---
>  arch/arm/mach-davinci/irq.c      |    2 +-
>  arch/arm/plat-orion/gpio.c       |    2 +-
>  arch/arm/plat-s5p/irq-gpioint.c  |    2 +-
>  arch/arm/plat-samsung/irq-uart.c |    2 +-
>  include/linux/irq.h              |    3 ++-
>  kernel/irq/generic-chip.c        |   18 ++++++++++++++++--
>  6 files changed, 22 insertions(+), 7 deletions(-)

Please, give me your feedbacks about this patch.

Fix this bug for the 3.0 release could be a good thing.

Regards,

Simon

> 
> diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
> index bfe68ec..d8c1af0 100644
> --- a/arch/arm/mach-davinci/irq.c
> +++ b/arch/arm/mach-davinci/irq.c
> @@ -53,7 +53,7 @@ davinci_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
>  
>  	gc = irq_alloc_generic_chip("AINTC", 1, irq_start, base, handle_edge_irq);
>  	ct = gc->chip_types;
> -	ct->chip.irq_ack = irq_gc_ack;
> +	ct->chip.irq_ack = irq_gc_ack_set_bit;
>  	ct->chip.irq_mask = irq_gc_mask_clr_bit;
>  	ct->chip.irq_unmask = irq_gc_mask_set_bit;
>  
> diff --git a/arch/arm/plat-orion/gpio.c b/arch/arm/plat-orion/gpio.c
> index 5b4fffa..41ab97e 100644
> --- a/arch/arm/plat-orion/gpio.c
> +++ b/arch/arm/plat-orion/gpio.c
> @@ -432,7 +432,7 @@ void __init orion_gpio_init(int gpio_base, int ngpio,
>  	ct->regs.mask = ochip->mask_offset + GPIO_EDGE_MASK_OFF;
>  	ct->regs.ack = GPIO_EDGE_CAUSE_OFF;
>  	ct->type = IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING;
> -	ct->chip.irq_ack = irq_gc_ack;
> +	ct->chip.irq_ack = irq_gc_ack_clr_bit;
>  	ct->chip.irq_mask = irq_gc_mask_clr_bit;
>  	ct->chip.irq_unmask = irq_gc_mask_set_bit;
>  	ct->chip.irq_set_type = gpio_irq_set_type;
> diff --git a/arch/arm/plat-s5p/irq-gpioint.c b/arch/arm/plat-s5p/irq-gpioint.c
> index 135abda..327ab9f 100644
> --- a/arch/arm/plat-s5p/irq-gpioint.c
> +++ b/arch/arm/plat-s5p/irq-gpioint.c
> @@ -152,7 +152,7 @@ static __init int s5p_gpioint_add(struct s3c_gpio_chip *chip)
>  	if (!gc)
>  		return -ENOMEM;
>  	ct = gc->chip_types;
> -	ct->chip.irq_ack = irq_gc_ack;
> +	ct->chip.irq_ack = irq_gc_ack_set_bit;
>  	ct->chip.irq_mask = irq_gc_mask_set_bit;
>  	ct->chip.irq_unmask = irq_gc_mask_clr_bit;
>  	ct->chip.irq_set_type = s5p_gpioint_set_type,
> diff --git a/arch/arm/plat-samsung/irq-uart.c b/arch/arm/plat-samsung/irq-uart.c
> index 32582c0..0e46588 100644
> --- a/arch/arm/plat-samsung/irq-uart.c
> +++ b/arch/arm/plat-samsung/irq-uart.c
> @@ -55,7 +55,7 @@ static void __init s3c_init_uart_irq(struct s3c_uart_irq *uirq)
>  	gc = irq_alloc_generic_chip("s3c-uart", 1, uirq->base_irq, reg_base,
>  				    handle_level_irq);
>  	ct = gc->chip_types;
> -	ct->chip.irq_ack = irq_gc_ack;
> +	ct->chip.irq_ack = irq_gc_ack_set_bit;
>  	ct->chip.irq_mask = irq_gc_mask_set_bit;
>  	ct->chip.irq_unmask = irq_gc_mask_clr_bit;
>  	ct->regs.ack = S3C64XX_UINTP;
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index 8b45384..baa397e 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -676,7 +676,8 @@ void irq_gc_mask_disable_reg(struct irq_data *d);
>  void irq_gc_mask_set_bit(struct irq_data *d);
>  void irq_gc_mask_clr_bit(struct irq_data *d);
>  void irq_gc_unmask_enable_reg(struct irq_data *d);
> -void irq_gc_ack(struct irq_data *d);
> +void irq_gc_ack_set_bit(struct irq_data *d);
> +void irq_gc_ack_clr_bit(struct irq_data *d);
>  void irq_gc_mask_disable_reg_and_ack(struct irq_data *d);
>  void irq_gc_eoi(struct irq_data *d);
>  int irq_gc_set_wake(struct irq_data *d, unsigned int on);
> diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
> index 31a9db7..3a2cab4 100644
> --- a/kernel/irq/generic-chip.c
> +++ b/kernel/irq/generic-chip.c
> @@ -101,10 +101,10 @@ void irq_gc_unmask_enable_reg(struct irq_data *d)
>  }
>  
>  /**
> - * irq_gc_ack - Ack pending interrupt
> + * irq_gc_ack_set_bit - Ack pending interrupt via setting bit
>   * @d: irq_data
>   */
> -void irq_gc_ack(struct irq_data *d)
> +void irq_gc_ack_set_bit(struct irq_data *d)
>  {
>  	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
>  	u32 mask = 1 << (d->irq - gc->irq_base);
> @@ -115,6 +115,20 @@ void irq_gc_ack(struct irq_data *d)
>  }
>  
>  /**
> + * irq_gc_ack_clr_bit - Ack pending interrupt via clearing bit
> + * @d: irq_data
> + */
> +void irq_gc_ack_clr_bit(struct irq_data *d)
> +{
> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> +	u32 mask = ~(1 << (d->irq - gc->irq_base));
> +
> +	irq_gc_lock(gc);
> +	irq_reg_writel(mask, gc->reg_base + cur_regs(d)->ack);
> +	irq_gc_unlock(gc);
> +}
> +
> +/**
>   * irq_gc_mask_disable_reg_and_ack- Mask and ack pending interrupt
>   * @d: irq_data
>   */
> -- 
> 1.7.5.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110702/bca7bfba/attachment-0001.sig>
