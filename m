From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 6 Feb 2014 22:54:39 +0100 (CET)
Subject: [linux-sunxi] Re: [PATCH] irq: Add new flag to ack level-triggered
 interrupts before unmasking
In-Reply-To: <CAOQ7t2Z0agZdDZ_OQZPtXWXoi5NMTcOOZz04q6wEVNy0rxn4AA@mail.gmail.com>
References: <1391721117-27446-1-git-send-email-carlo@caione.org>
 <alpine.DEB.2.02.1402062213590.21991@ionos.tec.linutronix.de>
 <CAOQ7t2Z0agZdDZ_OQZPtXWXoi5NMTcOOZz04q6wEVNy0rxn4AA@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1402062229000.21991@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 6 Feb 2014, Carlo Caione wrote:
> On Thu, Feb 6, 2014 at 10:14 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Thu, 6 Feb 2014, Carlo Caione wrote:
> >
> >> Several irqchip drivers require the level-triggered interrupt to be
> >> acked before unmasking to avoid that a second interrupt is immediately
> >> triggered. This small patch introduces a new irqchip flags that is used
> >> to ack the IRQ line before it is unmasked.
> >
> > And why are you not doing this in the unmask function of the affected
> > chip in the first place?
> 
> Because this is a common behavior of several irqchips (sunxi NMI
> controller,  exynos, etc...) so I think it should be useful to have it
> in the core instead of replicating the same code structure in all the
> irqchip drivers.

I'm all for making stuff generic, but you introduce this gem

+void ack_unmask_irq(struct irq_desc *desc)
+{
+       if ((desc->irq_data.chip->flags & IRQCHIP_ACK_ON_UNMASK) &&
+           (irqd_get_trigger_type(&desc->irq_data) & IRQ_TYPE_LEVEL_MASK) &&
+           desc->irq_data.chip->irq_ack)

This is totally backwards.

1) If level and edge are handled differently then you should provide
   different chips.

2) If a chip has IRQCHIP_ACK_ON_UNMASK set, then it better provides an
   irq_ack callback.

So why do you need this complex conditional?

+                       desc->irq_data.chip->irq_ack(&desc->irq_data);
+
+       unmask_irq(desc);
+}

Now the even more confusing part is a single call site in
irq_finalize_oneshot()

        if (!desc->threads_oneshot && !irqd_irq_disabled(&desc->irq_data) &&
            irqd_irq_masked(&desc->irq_data))
-               unmask_irq(desc);
+               ack_unmask_irq(desc);


But you completely fail to explain the rationale. 

- Why is this only an issue for the threaded irq case? 

- Why are other sites where interrupts are masked/unmasked not
  affected?

  IOW, why is the handle_level_irq() logic for a non threaded
  interrupt different from the threaded case?

  In the non threaded case we do:

  interrupt();
  mask_ack();
  handle_irq();
  unmask();
  reti();

  In the threaded case:

  interrupt();
  mask_ack();
  wake_thread();
  reti();
  run_thread();
  handle_irq();
  unmask();

  The difference between those scenarios is:

  1) The timing is different

  2) In the threaded case we return from the exception with the irq
     line masked and reenable it later after the threaded handler has
     run.

Do you have any sensible explanation for that requirement to ack
before unmask while you already acked on mask? And why this is only an
issue in the threaded case?

What's the context of the problem you are trying to solve?

Thanks,

	tglx
