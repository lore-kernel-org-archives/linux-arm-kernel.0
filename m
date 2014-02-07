From: carlo.caione@gmail.com (Carlo Caione)
Date: Fri, 7 Feb 2014 11:08:46 +0100
Subject: [linux-sunxi] Re: [PATCH] irq: Add new flag to ack
 level-triggered interrupts before unmasking
In-Reply-To: <alpine.DEB.2.02.1402062229000.21991@ionos.tec.linutronix.de>
References: <1391721117-27446-1-git-send-email-carlo@caione.org>
 <alpine.DEB.2.02.1402062213590.21991@ionos.tec.linutronix.de>
 <CAOQ7t2Z0agZdDZ_OQZPtXWXoi5NMTcOOZz04q6wEVNy0rxn4AA@mail.gmail.com>
 <alpine.DEB.2.02.1402062229000.21991@ionos.tec.linutronix.de>
Message-ID: <CAOQ7t2bzz9vKh_5h2nF=m+JpeYVa=Ttd4XQgrAa6Lhdzjg_Qxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 6, 2014 at 10:54 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 6 Feb 2014, Carlo Caione wrote:
>> On Thu, Feb 6, 2014 at 10:14 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> > On Thu, 6 Feb 2014, Carlo Caione wrote:
>> >
>> >> Several irqchip drivers require the level-triggered interrupt to be
>> >> acked before unmasking to avoid that a second interrupt is immediately
>> >> triggered. This small patch introduces a new irqchip flags that is used
>> >> to ack the IRQ line before it is unmasked.
>> >
>> > And why are you not doing this in the unmask function of the affected
>> > chip in the first place?
>>
>> Because this is a common behavior of several irqchips (sunxi NMI
>> controller,  exynos, etc...) so I think it should be useful to have it
>> in the core instead of replicating the same code structure in all the
>> irqchip drivers.
>
> I'm all for making stuff generic, but you introduce this gem
>
> +void ack_unmask_irq(struct irq_desc *desc)
> +{
> +       if ((desc->irq_data.chip->flags & IRQCHIP_ACK_ON_UNMASK) &&
> +           (irqd_get_trigger_type(&desc->irq_data) & IRQ_TYPE_LEVEL_MASK) &&
> +           desc->irq_data.chip->irq_ack)
>
> This is totally backwards.
>
> 1) If level and edge are handled differently then you should provide
>    different chips.

Agree. I was trying to use the flag to trigger a different behavior
since AFAIK the problem of the IRQ retrigger is specific for
level-triggered interrupts.

> 2) If a chip has IRQCHIP_ACK_ON_UNMASK set, then it better provides an
>    irq_ack callback.

The check on irq_ack is done to be sure that the irq_ack callback is
really defined by the irqchip driver before calling it.

> So why do you need this complex conditional?

I wanted to be sure to be in the right case: level-triggered interrupt
with the flag defined in the driver (and the ack callback correctly
defined).
To the best of my knowledge this is the only case in which a flag like
 IRQCHIP_ACK_ON_UNMASK could make sense.

> +                       desc->irq_data.chip->irq_ack(&desc->irq_data);
> +
> +       unmask_irq(desc);
> +}
>
> Now the even more confusing part is a single call site in
> irq_finalize_oneshot()
>
>         if (!desc->threads_oneshot && !irqd_irq_disabled(&desc->irq_data) &&
>             irqd_irq_masked(&desc->irq_data))
> -               unmask_irq(desc);
> +               ack_unmask_irq(desc);
>
>
> But you completely fail to explain the rationale.

You are right. I'll try to clarify it,

> - Why is this only an issue for the threaded irq case?
>
> - Why are other sites where interrupts are masked/unmasked not
>   affected?

<snip>

> Do you have any sensible explanation for that requirement to ack
> before unmask while you already acked on mask? And why this is only an
> issue in the threaded case?
>
> What's the context of the problem you are trying to solve?

The context and the rationale is fully explained in this thread
http://www.spinics.net/lists/arm-kernel/msg299952.html and some
answers are already given along the thread especially by Hans here
http://www.spinics.net/lists/arm-kernel/msg303542.html
Shortly, the double interrupt problem as seen on sunxi NMI controller
(and other chips AFAIK) is specific for level-triggered interrupts
when the hard interrupt handler is not able to ACK the interrupts on
the originating device since this device can only be accessed via a
bus (in our case it was a PMIC on I2C).
This explains why my patch was specific for the threaded case and why
the ACK on mask is not really effective in actually acking the IRQs
(so that I need a second ACK before unmasking the line). In fact in
our case (PMIC connected via I2C with an interrupt line on a special
NMI controller) the implicit ACK done by the unmask is ignored if the
NMI line is still high, and to have the line going down we have to ACK
all the IRQs on the device accessing to it by I2C in the thread and
then ACK the NMI controller with the second ACK before the unmasking
callback.
I hope this clarifies a bit.

Thank you,

-- 
Carlo Caione
