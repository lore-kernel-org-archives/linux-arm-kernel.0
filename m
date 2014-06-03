From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 3 Jun 2014 15:47:53 +0200
Subject: [PATCH v2 5/5] pinctrl: sunxi: Define enable / disable irq
 callbacks for level triggered irqs
In-Reply-To: <1401544899-405-6-git-send-email-hdegoede@redhat.com>
References: <1401544899-405-1-git-send-email-hdegoede@redhat.com>
 <1401544899-405-6-git-send-email-hdegoede@redhat.com>
Message-ID: <20140603134753.GL27722@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 31, 2014 at 04:01:39PM +0200, Hans de Goede wrote:
> Some drivers use disable_irq / enable_irq and do the work clearing the source
> in another thread instead of using a threaded interrupt handler.
> 
> The irqchip used not having irq_disable and irq_enable callbacks in this case,
> will lead to unnecessary spurious interrupts:
> 
> On a disable_irq in a chip without a handller for this, the irq core will
> remember the disable, but not actually call into the irqchip. With a level
> triggered interrupt (where the source has not been cleared) this will lead
> to an immediate retrigger, at which point the irq-core will mask the irq.
> So having an irq_disable callback in the irqchip will save us the interrupt
> firing a 2nd time for nothing.

Judging by the comments there, it seems more like a feature.

> Drivers using disable / enable_irq like this, will call enable_irq when
> they finally have cleared the interrupt source, without an enable_irq callback,
> this will turn into an unmask, at which point the irq will trigger immediately
> because when it was originally acked the level was still high, so the ack was
> a nop.

I don't think enable_irq offers any warranty regarding the state of
the interrupt. It's up to the driver to clear the interrupts before
calling enable_irq if it doesn't want any irrelevant/spurious
interrupts.

> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> index 418a430..6ccbe43 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> @@ -34,6 +34,7 @@
>  static void sunxi_pinctrl_irq_ack(struct irq_data *d);
>  static void sunxi_pinctrl_irq_mask(struct irq_data *d);
>  static void sunxi_pinctrl_irq_unmask(struct irq_data *d);
> +static void sunxi_pinctrl_irq_ack_unmask(struct irq_data *d);
>  static int sunxi_pinctrl_irq_set_type(struct irq_data *d, unsigned int type);
>  
>  static struct sunxi_pinctrl_group *
> @@ -563,6 +564,10 @@ static struct irq_chip sunxi_pinctrl_level_irq_chip = {
>  	.irq_eoi		= sunxi_pinctrl_irq_ack,
>  	.irq_mask		= sunxi_pinctrl_irq_mask,
>  	.irq_unmask		= sunxi_pinctrl_irq_unmask,
> +	/* Define irq_enable / disable to avoid spurious irqs for drivers
> +	 * using these to suppress irqs while they clear the irq source */

What "drivers" are we talking about? I grepped for a while, and didn't
any obvious candidates.

But again, I feel like if a driver wants to work outside of the usual
interrupt workflow, it's up to the driver itself to know what it's
doing.

> +	.irq_enable		= sunxi_pinctrl_irq_ack_unmask,
> +	.irq_disable		= sunxi_pinctrl_irq_mask,
>  	.irq_request_resources	= sunxi_pinctrl_irq_request_resources,
>  	.irq_set_type		= sunxi_pinctrl_irq_set_type,
>  	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_EOI_THREADED
> @@ -662,6 +667,28 @@ static void sunxi_pinctrl_irq_unmask(struct irq_data *d)
>  	spin_unlock_irqrestore(&pctl->lock, flags);
>  }
>  
> +static void sunxi_pinctrl_irq_ack_unmask(struct irq_data *d)
> +{
> +	struct sunxi_pinctrl *pctl = irq_data_get_irq_chip_data(d);
> +	u32 ctrl_reg = sunxi_irq_ctrl_reg(d->hwirq);
> +	u8 ctrl_idx = sunxi_irq_ctrl_offset(d->hwirq);
> +	u32 status_reg = sunxi_irq_status_reg(d->hwirq);
> +	u8 status_idx = sunxi_irq_status_offset(d->hwirq);
> +	unsigned long flags;
> +	u32 val;
> +
> +	spin_lock_irqsave(&pctl->lock, flags);
> +
> +	/* Clear the IRQ */
> +	writel(1 << status_idx, pctl->membase + status_reg);
> +
> +	/* Unmask the IRQ */
> +	val = readl(pctl->membase + ctrl_reg);
> +	writel(val | (1 << ctrl_idx), pctl->membase + ctrl_reg);
> +
> +	spin_unlock_irqrestore(&pctl->lock, flags);
> +}

Please at least call sunxi_pinctrl_irq_ack and
sunxi_pinctrl_irq_unmask if you're doing this.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140603/08da55c8/attachment.sig>
