From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 9 Jul 2015 23:33:50 +0200 (CEST)
Subject: [PATCH 4/6] irqchip: GIC: Use chip_data instead of handler_data
 for cascaded interrupts
In-Reply-To: <1436447951-22357-5-git-send-email-marc.zyngier@arm.com>
References: <1436447951-22357-1-git-send-email-marc.zyngier@arm.com>
 <1436447951-22357-5-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.11.1507092331130.5134@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 9 Jul 2015, Marc Zyngier wrote:

> When used as a primary interrupt controller, the GIC driver uses
> irq_data->chip_data to extract controller-specific information.
> 
> When used as a secondary interrupt controller, it uses handler_data
> instead. As this difference is relatively pointless and only creates
> confusion, change the secondary path to match what the rest of the
> driver does.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/irqchip/irq-gic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index e264675..3c7f3a4 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -298,7 +298,7 @@ static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
>  
>  static void gic_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
>  {
> -	struct gic_chip_data *chip_data = irq_get_handler_data(irq);
> +	struct gic_chip_data *chip_data = irq_get_chip_data(irq);
>  	struct irq_chip *chip = irq_get_chip(irq);

You should make that

    chip_data = irq_desc_get_chip_data(desc);
    chip = irq_desc_get_chip(desc);

That avoids two pointless lookups of irqdesc ....

Thanks,

	tglx
