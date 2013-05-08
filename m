From: stephen.gallimore@st.com (Stephen GALLIMORE)
Date: Wed, 8 May 2013 18:50:40 +0200
Subject: [RFC 5/8] ARM:stih41x: Add STiH415 SOC support
In-Reply-To: <201305081818.01927.arnd@arndb.de>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022297-2334-1-git-send-email-srinivas.kandagatla@st.com>
 <201305081818.01927.arnd@arndb.de>
Message-ID: <A3BF01DB4A606149A4C20C4C4C808F6C3189E576E2@SAFEX1MAIL1.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Thank you for the feedback so far.

> +/*
> + * A basic implementation of irq_set_wake that ensures wakeup source
> + * interrupts are not disabled during PM_SUSPEND_FREEZE.
> + */
> +static int stih41x_set_wake(struct irq_data *d, unsigned int on) {
> +	struct irq_desc *desc = irq_to_desc(d->irq);
> +
> +	if (on) {
> +		if (desc->action)
> +			desc->action->flags |= IRQF_NO_SUSPEND;
> +	} else {
> +		if (desc->action)
> +			desc->action->flags &= ~IRQF_NO_SUSPEND;
> +	}
> +	return 0;
> +}
> +
> +static void __init stih41x_irq_init(void) {
> +	gic_arch_extn.irq_set_wake = stih41x_set_wake;
> +	gic_arch_extn.flags = IRQCHIP_MASK_ON_SUSPEND;
> +
> +	irqchip_init();
> +}
>
>This looks like it should be generic. Why do you need this?

On this point, I wrote it so I am happy to take some advice. Basically this was to allow us to wakeup from the new PM_SUSPEND_FREEZE state that was added at the beginning of the year, without having to pollute individual drivers (particularly the serial driver) with having to somehow change the IRQ flags, or uninstall/re-install the interrupt handler on suspend/resume when marked as a wakeup source with different flags. Those approaches all seemed too messy and not really the driver's responsibility and installing the interrupt handlers of all possible wakeup sources with IRQF_NO_SUSPEND regardless of if they are currently activated as a wakeup source or not also seemed wrong. The code I ended up with was inspired by the existing mach-mmp (mmp2) PM support which does the same thing, so it is not without precedent.

If you have a better solution, or a way to generalize this that would make sense for the ARM architecture as a whole, then we are more than happy to change.

Regards,
-stephen
