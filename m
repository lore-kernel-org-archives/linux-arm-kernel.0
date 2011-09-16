From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 16 Sep 2011 11:37:23 +0200 (CEST)
Subject: [RFC PATCH 1/3] genirq: add support for per-cpu dev_id interrupts
In-Reply-To: <4E7306C8.4050809@arm.com>
References: <1316105551-17505-1-git-send-email-marc.zyngier@arm.com>
	<1316105551-17505-2-git-send-email-marc.zyngier@arm.com>
	<CAHXqBFKOQNOePc00yuzfotrYP6wT0ue_CJfv7rKdC+gEkomunA@mail.gmail.com>
	<4E7306C8.4050809@arm.com>
Message-ID: <alpine.LFD.2.02.1109161104200.2723@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Sep 2011, Marc Zyngier wrote:

> Hi Micha?,
> 
> On 15/09/11 22:36, Micha? Miros?aw wrote:
> > 2011/9/15 Marc Zyngier <marc.zyngier@arm.com>:
> > [...]
> >> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> >> index a103732..f9b7fa3 100644
> >> --- a/include/linux/interrupt.h
> >> +++ b/include/linux/interrupt.h
> >> @@ -95,6 +95,7 @@ typedef irqreturn_t (*irq_handler_t)(int, void *);
> >>  * @flags:     flags (see IRQF_* above)
> >>  * @name:      name of the device
> >>  * @dev_id:    cookie to identify the device
> >> + * @percpu_dev_id:     cookie to identify the device
> >>  * @next:      pointer to the next irqaction for shared interrupts
> >>  * @irq:       interrupt number
> >>  * @dir:       pointer to the proc/irq/NN/name entry
> >> @@ -104,17 +105,20 @@ typedef irqreturn_t (*irq_handler_t)(int, void *);
> >>  * @thread_mask:       bitmask for keeping track of @thread activity
> >>  */
> >>  struct irqaction {
> > [...]
> >> +       void                    *dev_id;
> >> +#ifdef CONFIG_IRQ_PERCPU_DEVID
> >> +       void __percpu           *percpu_dev_id;
> >> +#endif
> > 
> > Those two can share the memory (in a anonymous union), if I read the
> > idea correctly.
> 
> That was the initial implementation, and everything was fine until I
> tried gcc 4.4.1. Having an anonymous union breaks static initialization
> of the structure.

Bah, right. It wants to have brackets around it. So we can use a
separate pointer to get this going and then run coccinelle over it to
fix that up just before 3.2-rc1.

Thanks,

	tglx
