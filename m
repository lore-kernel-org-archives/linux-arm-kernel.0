From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 11 Feb 2015 15:34:44 +0100
Subject: [PATCH v4 3/5] irqchip: Add DT binding doc for the virtual irq
 demuxer chip
In-Reply-To: <20150210204835.GL9432@leverpostej>
References: <1422527620-8308-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150210165201.634bc04b@bbrezillon> <20150210204835.GL9432@leverpostej>
Message-ID: <10113514.kjIFp8Z2ih@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, February 10, 2015 08:48:36 PM Mark Rutland wrote:
> On Tue, Feb 10, 2015 at 03:52:01PM +0000, Boris Brezillon wrote:
> > Hi Mark,
> > 
> > On Tue, 10 Feb 2015 15:36:28 +0000
> > Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > > Hi Boris,
> > > 
> > > On Thu, Jan 29, 2015 at 10:33:38AM +0000, Boris Brezillon wrote:
> > > > Add documentation for the virtual irq demuxer.
> > > > 
> > > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > > Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > > > ---
> > > >  .../bindings/interrupt-controller/dumb-demux.txt   | 41 ++++++++++++++++++++++
> > > >  1 file changed, 41 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/dumb-demux.txt
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/interrupt-controller/dumb-demux.txt b/Documentation/devicetree/bindings/interrupt-controller/dumb-demux.txt
> > > > new file mode 100644
> > > > index 0000000..b9a7830
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/interrupt-controller/dumb-demux.txt
> > > > @@ -0,0 +1,41 @@
> > > > +* Virtual Interrupt Demultiplexer
> > > > +
> > > > +This virtual demultiplexer simply forward all incoming interrupts to its
> > > > +enabled/unmasked children.
> > > > +It is only intended to be used by hardware that do not provide a proper way
> > > > +to demultiplex a source interrupt, and thus have to wake all their children
> > > > +up so that they can possibly handle the interrupt (if needed).
> > > > +This can be seen as an alternative to shared interrupts when at least one
> > > > +of the interrupt children is a timer (and require the irq to stay enabled
> > > > +on suspend) while others are not. This will prevent calling irq handlers of
> > > > +non timer devices while they are suspended.
> > > 
> > > This sounds like a DT-workaround for a Linux implementation problem, and
> > > I don't think this the right way to solve your problem.
> > 
> > I understand your concern, but why are you answering while I asked for
> > DT maintainers reviews for several days (if not several weeks).
> > 
> > > 
> > > Why does this have to be in DT at all? Why can we not fix the core to
> > > handle these details?
> > 
> > We already discussed that with Rob and Thomas, and hiding such a
> > demuxer chip is not an easy task.
> > I'm open to any suggestion to do that, though I'd like you (I mean DT
> > guys) to provide a working implementation (or at least a viable concept)
> > that would silently demultiplex an irq.
> > 
> > > 
> > > I am very much not keen on this binding.
> > 
> > Yes, but do you have anything else to propose.
> > We're experiencing this warning for 2 releases now, and this is time to
> > find a solution (even if it's not a perfect one).
> 
> Thoughts on the patch below?
> 
> Rather than handling this at the desc level it adds an extra flag to the
> irqaction which can be set/unset during suspend for those irqs we don't
> want to handle. That way we don't need to tell the core about the
> mismatch explicitly in DT (or ACPI/board files/whatever).
> 
> If we can request/free interrupts during suspend then there's some logic
> missing, but it shows the basic idea.
> 
> I didn't have a system to hand with shared mismatched IRQF_NO_SUSPEND
> interrupts, so I had to fake that up in code for testing.
> 
> Thanks,
> Mark.
> 
> ---->8----
> From f390ccbb31f06efee49b4469943c8d85d963bfb5 Mon Sep 17 00:00:00 2001
> From: Mark Rutland <mark.rutland@arm.com>
> Date: Tue, 10 Feb 2015 20:14:33 +0000
> Subject: [PATCH] genirq: allow mixed IRQF_NO_SUSPEND requests
> 
> In some cases a physical IRQ line may be shared between devices from
> which we expect interrupts during suspend (e.g. timers) and those we do
> not (e.g. anything we cut the power to). Where a driver did not request
> the interrupt with IRQF_NO_SUSPEND, it's unlikely that it can handle
> being called during suspend, and it may bring down the system.
> 
> This patch adds logic to automatically mark the irqactions for these
> potentially unsafe handlers as disabled during suspend, leaving actions
> with IRQF_NO_SUSPEND enabled. If an interrupt is raised on a shared line
> during suspend, only the handlers requested with IRQF_NO_SUSPEND will be
> called. The handlers requested without IRQF_NO_SUSPEND will be skipped
> as if they had immediately returned IRQF_NONE.
> 
> Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> ---
>  include/linux/interrupt.h |  4 ++++
>  kernel/irq/handle.c       | 13 +++++++++++-
>  kernel/irq/pm.c           | 50 +++++++++++++++++++++++++++++++++++++++++++----
>  3 files changed, 62 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index d9b05b5..49dcb35 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -57,6 +57,9 @@
>   * IRQF_NO_THREAD - Interrupt cannot be threaded
>   * IRQF_EARLY_RESUME - Resume IRQ early during syscore instead of at device
>   *                resume time.
> + * IRQF_NO_ACTION - This irqaction should not be triggered.
> + *                  Used during suspend for !IRQF_NO_SUSPEND irqactions which
> + *                  share lines with IRQF_NO_SUSPEND irqactions.
>   */
>  #define IRQF_DISABLED		0x00000020
>  #define IRQF_SHARED		0x00000080
> @@ -70,6 +73,7 @@
>  #define IRQF_FORCE_RESUME	0x00008000
>  #define IRQF_NO_THREAD		0x00010000
>  #define IRQF_EARLY_RESUME	0x00020000
> +#define IRQF_NO_ACTION		0x00040000
>  
>  #define IRQF_TIMER		(__IRQF_TIMER | IRQF_NO_SUSPEND | IRQF_NO_THREAD)
>  
> diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
> index 6354802..44c8662 100644
> --- a/kernel/irq/handle.c
> +++ b/kernel/irq/handle.c
> @@ -130,6 +130,17 @@ void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action)
>  	wake_up_process(action->thread);
>  }
>  
> +static irqreturn_t __handle_irq_event_percpu(unsigned int irq, struct irqaction *action)
> +{
> +	/*
> +	 * During suspend we must not call potentially unsafe irq handlers.
> +	 * See suspend_suspendable_actions.
> +	 */
> +	if (unlikely(action->flags & IRQF_NO_ACTION))
> +		return IRQ_NONE;

Nope.  We can't add this check here, as that would affect interrupt handling
performance for everyone including people who never use system suspend and
never will.

> +	return action->handler(irq, action->dev_id);
> +}

Rafael
