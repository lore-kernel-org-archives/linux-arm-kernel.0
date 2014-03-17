From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 17 Mar 2014 12:10:39 +0100
Subject: [PATCH 2/3] irqchip: sun4i: Simplify irq mapping
In-Reply-To: <1394740202-1952-3-git-send-email-hdegoede@redhat.com>
References: <1394740202-1952-1-git-send-email-hdegoede@redhat.com>
 <1394740202-1952-3-git-send-email-hdegoede@redhat.com>
Message-ID: <20140317111039.GF27873@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 08:50:01PM +0100, Hans de Goede wrote:
> Now that we're using handle_fasteio_irq for all interrupts, we can get rid
> of having 2 irq_chip structs by making sun4i_irq_ack a nop for all irqs
> except irq 0.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/irqchip/irq-sun4i.c | 27 ++++-----------------------
>  1 file changed, 4 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
> index 0a71990..6a8c88d 100644
> --- a/drivers/irqchip/irq-sun4i.c
> +++ b/drivers/irqchip/irq-sun4i.c
> @@ -45,6 +45,9 @@ static void sun4i_irq_ack(struct irq_data *irqd)
>  	int reg = irq / 32;
>  	u32 val;
>  
> +	if (irq != 0)
> +		return; /* Only IRQ 0 / the ENMI needs to be acked */
> +
>  	val = readl(sun4i_irq_base + SUN4I_IRQ_PENDING_REG(reg));
>  	writel(val | (1 << irq_off),
>  	       sun4i_irq_base + SUN4I_IRQ_PENDING_REG(reg));
> @@ -74,24 +77,8 @@ static void sun4i_irq_unmask(struct irq_data *irqd)
>  	       sun4i_irq_base + SUN4I_IRQ_ENABLE_REG(reg));
>  }
>  
> -/*
> - * Since sun4i and sun5i are single core SOCs there is no need to mask non
> - * oneshot IRQs, to achieve this we use handle_fasteoi_irq with a dummy eoi.
> - */
> -static void sun4i_irq_dummy_eoi(struct irq_data *irqd)
> -{
> -}
> -
>  static struct irq_chip sun4i_irq_chip = {
>  	.name		= "sun4i_irq",
> -	.irq_eoi	= sun4i_irq_dummy_eoi,


Is it just me or did you just remove the code you added in patch 1?

Patches 1 and 2 can be easily squashed.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140317/3ab0b366/attachment.sig>
