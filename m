From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 10 Feb 2015 20:48:36 +0000
Subject: [PATCH v4 3/5] irqchip: Add DT binding doc for the virtual irq
 demuxer chip
In-Reply-To: <20150210165201.634bc04b@bbrezillon>
References: <1422527620-8308-1-git-send-email-boris.brezillon@free-electrons.com>
 <1422527620-8308-4-git-send-email-boris.brezillon@free-electrons.com>
 <20150210153628.GF9432@leverpostej>
 <20150210165201.634bc04b@bbrezillon>
Message-ID: <20150210204835.GL9432@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 10, 2015 at 03:52:01PM +0000, Boris Brezillon wrote:
> Hi Mark,
> 
> On Tue, 10 Feb 2015 15:36:28 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > Hi Boris,
> > 
> > On Thu, Jan 29, 2015 at 10:33:38AM +0000, Boris Brezillon wrote:
> > > Add documentation for the virtual irq demuxer.
> > > 
> > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > > ---
> > >  .../bindings/interrupt-controller/dumb-demux.txt   | 41 ++++++++++++++++++++++
> > >  1 file changed, 41 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/dumb-demux.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/interrupt-controller/dumb-demux.txt b/Documentation/devicetree/bindings/interrupt-controller/dumb-demux.txt
> > > new file mode 100644
> > > index 0000000..b9a7830
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/interrupt-controller/dumb-demux.txt
> > > @@ -0,0 +1,41 @@
> > > +* Virtual Interrupt Demultiplexer
> > > +
> > > +This virtual demultiplexer simply forward all incoming interrupts to its
> > > +enabled/unmasked children.
> > > +It is only intended to be used by hardware that do not provide a proper way
> > > +to demultiplex a source interrupt, and thus have to wake all their children
> > > +up so that they can possibly handle the interrupt (if needed).
> > > +This can be seen as an alternative to shared interrupts when at least one
> > > +of the interrupt children is a timer (and require the irq to stay enabled
> > > +on suspend) while others are not. This will prevent calling irq handlers of
> > > +non timer devices while they are suspended.
> > 
> > This sounds like a DT-workaround for a Linux implementation problem, and
> > I don't think this the right way to solve your problem.
> 
> I understand your concern, but why are you answering while I asked for
> DT maintainers reviews for several days (if not several weeks).
> 
> > 
> > Why does this have to be in DT at all? Why can we not fix the core to
> > handle these details?
> 
> We already discussed that with Rob and Thomas, and hiding such a
> demuxer chip is not an easy task.
> I'm open to any suggestion to do that, though I'd like you (I mean DT
> guys) to provide a working implementation (or at least a viable concept)
> that would silently demultiplex an irq.
> 
> > 
> > I am very much not keen on this binding.
> 
> Yes, but do you have anything else to propose.
> We're experiencing this warning for 2 releases now, and this is time to
> find a solution (even if it's not a perfect one).

Thoughts on the patch below?

Rather than handling this at the desc level it adds an extra flag to the
irqaction which can be set/unset during suspend for those irqs we don't
want to handle. That way we don't need to tell the core about the
mismatch explicitly in DT (or ACPI/board files/whatever).

If we can request/free interrupts during suspend then there's some logic
missing, but it shows the basic idea.

I didn't have a system to hand with shared mismatched IRQF_NO_SUSPEND
interrupts, so I had to fake that up in code for testing.

Thanks,
Mark.

---->8----
>From f390ccbb31f06efee49b4469943c8d85d963bfb5 Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Tue, 10 Feb 2015 20:14:33 +0000
Subject: [PATCH] genirq: allow mixed IRQF_NO_SUSPEND requests

In some cases a physical IRQ line may be shared between devices from
which we expect interrupts during suspend (e.g. timers) and those we do
not (e.g. anything we cut the power to). Where a driver did not request
the interrupt with IRQF_NO_SUSPEND, it's unlikely that it can handle
being called during suspend, and it may bring down the system.

This patch adds logic to automatically mark the irqactions for these
potentially unsafe handlers as disabled during suspend, leaving actions
with IRQF_NO_SUSPEND enabled. If an interrupt is raised on a shared line
during suspend, only the handlers requested with IRQF_NO_SUSPEND will be
called. The handlers requested without IRQF_NO_SUSPEND will be skipped
as if they had immediately returned IRQF_NONE.

Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 include/linux/interrupt.h |  4 ++++
 kernel/irq/handle.c       | 13 +++++++++++-
 kernel/irq/pm.c           | 50 +++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index d9b05b5..49dcb35 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -57,6 +57,9 @@
  * IRQF_NO_THREAD - Interrupt cannot be threaded
  * IRQF_EARLY_RESUME - Resume IRQ early during syscore instead of at device
  *                resume time.
+ * IRQF_NO_ACTION - This irqaction should not be triggered.
+ *                  Used during suspend for !IRQF_NO_SUSPEND irqactions which
+ *                  share lines with IRQF_NO_SUSPEND irqactions.
  */
 #define IRQF_DISABLED		0x00000020
 #define IRQF_SHARED		0x00000080
@@ -70,6 +73,7 @@
 #define IRQF_FORCE_RESUME	0x00008000
 #define IRQF_NO_THREAD		0x00010000
 #define IRQF_EARLY_RESUME	0x00020000
+#define IRQF_NO_ACTION		0x00040000
 
 #define IRQF_TIMER		(__IRQF_TIMER | IRQF_NO_SUSPEND | IRQF_NO_THREAD)
 
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 6354802..44c8662 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -130,6 +130,17 @@ void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action)
 	wake_up_process(action->thread);
 }
 
+static irqreturn_t __handle_irq_event_percpu(unsigned int irq, struct irqaction *action)
+{
+	/*
+	 * During suspend we must not call potentially unsafe irq handlers.
+	 * See suspend_suspendable_actions.
+	 */
+	if (unlikely(action->flags & IRQF_NO_ACTION))
+		return IRQ_NONE;
+	return action->handler(irq, action->dev_id);
+}
+
 irqreturn_t
 handle_irq_event_percpu(struct irq_desc *desc, struct irqaction *action)
 {
@@ -140,7 +151,7 @@ handle_irq_event_percpu(struct irq_desc *desc, struct irqaction *action)
 		irqreturn_t res;
 
 		trace_irq_handler_entry(irq, action);
-		res = action->handler(irq, action->dev_id);
+		res = __handle_irq_event_percpu(irq, action);
 		trace_irq_handler_exit(irq, action, res);
 
 		if (WARN_ONCE(!irqs_disabled(),"irq %u handler %pF enabled interrupts\n",
diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index 3ca5325..9d8a71f 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -43,9 +43,6 @@ void irq_pm_install_action(struct irq_desc *desc, struct irqaction *action)
 
 	if (action->flags & IRQF_NO_SUSPEND)
 		desc->no_suspend_depth++;
-
-	WARN_ON_ONCE(desc->no_suspend_depth &&
-		     desc->no_suspend_depth != desc->nr_actions);
 }
 
 /*
@@ -63,11 +60,54 @@ void irq_pm_remove_action(struct irq_desc *desc, struct irqaction *action)
 		desc->no_suspend_depth--;
 }
 
+/*
+ * Physical IRQ lines may be shared between devices which may be expected to
+ * raise interrupts during suspend (e.g. timers) and those which may not (e.g.
+ * anything we cut the power to). If an action was requested without
+ * IRQF_NO_SUSPEND, then the handler probably can't handle being called during
+ * suspend, and may bring the system down.
+ *
+ * When going down for suspend, mark those potentially unsafe actions so they
+ * won't be called by handle_irq_event_percpu, as if we'd actually disabled the
+ * irq.
+ */
+static void suspend_suspendable_actions(struct irq_desc *desc)
+{
+	struct irqaction *action;
+
+	if (desc->nr_actions == desc->no_suspend_depth)
+		return;
+
+	for (action = desc->action; action; action = action->next)
+		if (!(action->flags & IRQF_NO_SUSPEND))
+			action->flags |= IRQF_NO_ACTION;
+}
+
+/*
+ * Reenable irqactions which were disabled during suspend. This undoes
+ * suspend_suspendable_actions.
+ */
+static void resume_suspendable_actions(struct irq_desc *desc)
+{
+	struct irqaction *action;
+
+	if (desc->nr_actions == desc->no_suspend_depth)
+		return;
+
+	for (action = desc->action; action; action = action->next)
+		action->flags &= ~IRQF_NO_ACTION;
+}
+
 static bool suspend_device_irq(struct irq_desc *desc, int irq)
 {
-	if (!desc->action || desc->no_suspend_depth)
+	if (!desc->action)
 		return false;
 
+	if (desc->no_suspend_depth) {
+		suspend_suspendable_actions(desc);
+		return false;
+	}
+
 	if (irqd_is_wakeup_set(&desc->irq_data)) {
 		irqd_set(&desc->irq_data, IRQD_WAKEUP_ARMED);
 		/*
@@ -135,6 +175,8 @@ static void resume_irq(struct irq_desc *desc, int irq)
 	if (desc->istate & IRQS_SUSPENDED)
 		goto resume;
 
+	resume_suspendable_actions(desc);
+
 	/* Force resume the interrupt? */
 	if (!desc->force_resume_depth)
 		return;
-- 
1.9.1
