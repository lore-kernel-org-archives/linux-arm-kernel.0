From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 12 Mar 2014 11:09:35 +0100
Subject: [PATCH] irqchip: sun4i: Fix irq 0 not working
In-Reply-To: <1394553060-30298-1-git-send-email-hdegoede@redhat.com>
References: <1394553060-30298-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20140312100935.GY2815@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Mar 11, 2014 at 04:51:00PM +0100, Hans de Goede wrote:
> SUN4I_IRQ_VECTOR_REG containing 0 can mean one of 2 things:
> 1) irq 0 pending
> 2) no more irqs pending
> 
> So we must loop always atleast once to make irq 0 work, otherwise irq 0
> will never get serviced and we end up with a hard hang because
> sun4i_handle_irq gets re-entered constantly.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/irqchip/irq-sun4i.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
> index a5438d8..3761bf1 100644
> --- a/drivers/irqchip/irq-sun4i.c
> +++ b/drivers/irqchip/irq-sun4i.c
> @@ -140,10 +140,16 @@ static asmlinkage void __exception_irq_entry sun4i_handle_irq(struct pt_regs *re
>  {
>  	u32 irq, hwirq;
>  
> +	/*
> +	 * hwirq == 0 can mean one of 2 things:
> +	 * 1) irq 0 pending
> +	 * 2) no more irqs pending

3) spurious interrupt.

> +	 * So loop always atleast once to make irq 0 work.
> +	 */
>  	hwirq = readl(sun4i_irq_base + SUN4I_IRQ_VECTOR_REG) >> 2;
> -	while (hwirq != 0) {
> +	do {

I'd at least lookup in the pending register to see if the interrupt 0
was actually triggered. Otherwise, you could end up with spurious
handler calls on the interrupt 0.

>  		irq = irq_find_mapping(sun4i_irq_domain, hwirq);
>  		handle_IRQ(irq, regs);
>  		hwirq = readl(sun4i_irq_base + SUN4I_IRQ_VECTOR_REG) >> 2;

And you end up with the same issue if there's a first != 0 interrupt,
and then the interrupt 0.

What about something like:

while (1) {
	hwirq = readl(sun4i_irq_base + SUN4I_IRQ_VECTOR_REG) >> 2;
	if (!hwirq)
		if (!(readl(sun4i_irq_base + SUN4I_IRQ_PENDING_REG(0)) & BIT(0)))
			break;

	irq = irq_find_mapping(sun4i_irq_domain, hwirq);
	handle_IRQ(irq, regs);
}

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140312/7d937b9c/attachment.sig>
