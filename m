From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 3 Aug 2015 22:07:29 +0200
Subject: [PATCH 1/3] clocksource: atmel-st: Remove irq handler when
 clock event is unused
In-Reply-To: <alpine.DEB.2.11.1508031619230.3825@nanos>
References: <1437161608-26782-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1437161608-26782-2-git-send-email-alexandre.belloni@free-electrons.com>
 <alpine.DEB.2.11.1507180942360.18576@nanos>
 <20150718222308.GA30489@piout.net>
 <alpine.DEB.2.11.1507201103550.18576@nanos>
 <20150720193726.GJ15539@piout.net>
 <alpine.DEB.2.11.1507202245310.18576@nanos>
 <alpine.DEB.2.11.1508021100390.3825@nanos>
 <20150802094028.GN12596@twins.programming.kicks-ass.net>
 <20150803153004.4a74d99a@bbrezillon>
 <alpine.DEB.2.11.1508031619230.3825@nanos>
Message-ID: <20150803220729.23feba3f@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 3 Aug 2015 16:36:29 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Mon, 3 Aug 2015, Boris Brezillon wrote:
> > On Sun, 2 Aug 2015 11:40:28 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Sun, Aug 02, 2015 at 11:10:21AM +0200, Thomas Gleixner wrote:
> > > > I think Boris Brezillon had implemented it at some point, but it was
> > > > shot down for reasons I can't remember. 
> > > 
> > > You weren't around at the time.. DT people didn't like it, said they
> > > didn't like having to make up fake hardware in their DT crap.
> > 
> > I don't know who was right, but the fact is they won't be inclined to
> > take such an approach unless the virtual demuxer is not exposed in the
> > DT, which is almost impossible since irq users are identifying their
> > irq lines with a phandle to the interrupt controller and an interrupt
> > id (usually extracted from the datasheet).
> 
> I really have no idea why DT folks think that virtual devices are not
> suitable for DT entries. Marks working assumption from the old thread:
> 
>  > This sounds like a DT-workaround for a Linux implementation problem,
>  > and I don't think this the right way to solve your problem.
> 
> is simply wrong. This has nothing to do with a Linux implementation
> problem. It's a sensible workaround for braindamaged hardware at the
> proper abstraction level.
> 
> > Anyway, below is a solution providing a way to disable specific
> > handlers without reworking the way we are modeling shared interrupts.
> > Thomas, I know you were not in favor of the proposed approach, but,
> > AFAICT, it does not add any conditional path to the interrupt handling
> > path (which, IIRC, was one of your requirements), and is simple enough
> > to be used by people really needing it.
> > 
> > There's probably other drawback I haven't noticed, so please don't
> > hesitate to share your thoughts.
> 
> Yes, aside of the bloat, it needs special handling in free_irq() as
> well.

Right. Below is a patch fixing the __setup_irq()/__free_irq() functions.

Anyway, I won't insist on this approach unless you want me to go
further, and I don't plan to spend more time on convincing DT folks that
the virtual demux is what we need (I already spent more time than I
wanted arguing on this feature :-/).

Best Regards,

Boris

--- >8 ---

>From 96448d56b202f2140e7008a3ca291b133696b4c8 Mon Sep 17 00:00:00 2001
From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Mon, 3 Aug 2015 21:59:29 +0200
Subject: [PATCH] irq: add disable_irq_handler()/enable_irq_handler() functions

Sometime we need to disable a specific handler on a shared irq line.
Currently, the only way this can be achieved is by freeing the irq handler
when we want to disable the irq and creating a new one when we want to
enable.
This is not only adding some overhead to the disable/enable operations, but
the request_irq function cannot be called in atomic context, which means
it prevents disabling the interrupt in such situation.

This patch introduces three new functions: disable_irq_handler(),
disable_irq_handler_nosync() and enable_irq_handler() to allow disabling
a specific handler on a shared irq line.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 include/linux/irqdesc.h |   1 +
 kernel/irq/manage.c     | 143 ++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 126 insertions(+), 18 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index fcea4e4..c8bd055 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -52,6 +52,7 @@ struct irq_desc {
 	irq_preflow_handler_t	preflow_handler;
 #endif
 	struct irqaction	*action;	/* IRQ action list */
+	struct irqaction	*disabled_actions;	/* IRQ disabled action list */
 	unsigned int		status_use_accessors;
 	unsigned int		core_internal_state__do_not_mess_with_it;
 	unsigned int		depth;		/* nested irq disables */
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index f974485..0e7432b 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -458,6 +458,47 @@ void disable_irq_nosync(unsigned int irq)
 }
 EXPORT_SYMBOL(disable_irq_nosync);
 
+static int __disable_irq_handler_nosync(unsigned int irq, void *dev_id)
+{
+	unsigned long flags;
+	struct irqaction *action, **prev;
+	struct irq_desc *desc = irq_get_desc_buslock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
+	int ret = 0;
+
+	if (!desc)
+		return -EINVAL;
+
+	for (action = desc->action, prev = &desc->action; action; action = action->next) {
+		if (action->dev_id == dev_id)
+			break;
+
+		prev = &action->next;
+	}
+
+	if (!action)
+		goto out;
+
+	*prev = action->next;
+
+	action->next = desc->disabled_actions;
+	desc->disabled_actions = action;
+	if (!desc->action) {
+		__disable_irq(desc, irq);
+		ret = 1;
+	}
+
+out:
+	irq_put_desc_busunlock(desc, flags);
+	return ret;
+}
+
+static void disable_irq_handler_nosync(unsigned int irq, void *dev_id)
+{
+	__disable_irq_handler_nosync(irq, dev_id);
+}
+EXPORT_SYMBOL(disable_irq_handler_nosync);
+
+
 /**
  *	disable_irq - disable an irq and wait for completion
  *	@irq: Interrupt to disable
@@ -477,6 +518,13 @@ void disable_irq(unsigned int irq)
 }
 EXPORT_SYMBOL(disable_irq);
 
+void disable_irq_handler(unsigned int irq, )
+{
+	if (__disable_irq_handler_nosync(irq) > 0)
+		synchronize_irq(irq);
+}
+EXPORT_SYMBOL(disable_irq);
+
 /**
  *	disable_hardirq - disables an irq and waits for hardirq completion
  *	@irq: Interrupt to disable
@@ -552,6 +600,40 @@ out:
 }
 EXPORT_SYMBOL(enable_irq);
 
+void enable_irq_handler(unsigned int irq, void *dev_id)
+{
+	unsigned long flags;
+	struct irqaction *action, **prev;
+	struct irq_desc *desc = irq_get_desc_buslock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
+
+	if (!desc)
+		return -EINVAL;
+
+	for (action = desc->disabled_actions, prev = &desc->action; action;
+	     action = action->next) {
+		if (action->dev_id == dev_id)
+			break;
+
+		prev = &action->next;
+	}
+
+	if (!action)
+		goto out;
+
+	*prev = action->next;
+
+	action->next = desc->action;
+	desc->action = action;
+
+	if (!action->next)
+		__enable_irq(desc, irq);
+
+out:
+	irq_put_desc_busunlock(desc, flags);
+
+}
+EXPORT_SYMBOL(enable_irq_handler);
+
 static int set_irq_wake_real(unsigned int irq, unsigned int on)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
@@ -1118,6 +1200,12 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	raw_spin_lock_irqsave(&desc->lock, flags);
 	old_ptr = &desc->action;
 	old = *old_ptr;
+	if (!old) {
+		old_ptr = &desc->disabled_actions;
+		old = *old_ptr;
+	}
+
+	old = desc->action ? : desc->disabled_actions;
 	if (old) {
 		/*
 		 * Can't share interrupts unless both agree to and are
@@ -1136,20 +1224,27 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 		    (new->flags & IRQF_PERCPU))
 			goto mismatch;
 
-		/* add new interrupt at end of irq queue */
-		do {
-			/*
-			 * Or all existing action->thread_mask bits,
-			 * so we can find the next zero bit for this
-			 * new action.
-			 */
-			thread_mask |= old->thread_mask;
-			old_ptr = &old->next;
-			old = *old_ptr;
-		} while (old);
 		shared = 1;
 	}
 
+	if (irq_settings_can_autoenable(desc))
+		old_ptr = &desc->action;
+	else
+		old_ptr = &desc->disabled_actions;
+	old = *old_ptr;
+
+	/* add new interrupt at end of irq queue */
+	while (old) {
+		/*
+		 * Or all existing action->thread_mask bits,
+		 * so we can find the next zero bit for this
+		 * new action.
+		 */
+		thread_mask |= old->thread_mask;
+		old_ptr = &old->next;
+		old = *old_ptr;
+	}
+
 	/*
 	 * Setup the thread mask for this irqaction for ONESHOT. For
 	 * !ONESHOT irqs the thread mask is 0 so we can avoid a
@@ -1373,25 +1468,37 @@ static struct irqaction *__free_irq(unsigned int irq, void *dev_id)
 	for (;;) {
 		action = *action_ptr;
 
-		if (!action) {
-			WARN(1, "Trying to free already-free IRQ %d\n", irq);
-			raw_spin_unlock_irqrestore(&desc->lock, flags);
-
-			return NULL;
-		}
 
 		if (action->dev_id == dev_id)
 			break;
 		action_ptr = &action->next;
 	}
 
+	if (!action) {
+		action_ptr = &desc->disabled_actions;
+		for (;;) {
+			action = *action_ptr;
+
+			if (action->dev_id == dev_id)
+				break;
+			action_ptr = &action->next;
+		}
+	}
+
+	if (!action) {
+		WARN(1, "Trying to free already-free IRQ %d\n", irq);
+		raw_spin_unlock_irqrestore(&desc->lock, flags);
+
+		return NULL;
+	}
+
 	/* Found it - now remove it from the list of entries: */
 	*action_ptr = action->next;
 
 	irq_pm_remove_action(desc, action);
 
 	/* If this was the last handler, shut down the IRQ line: */
-	if (!desc->action) {
+	if (!desc->action && !desc->disabled_actions) {
 		irq_shutdown(desc);
 		irq_release_resources(desc);
 	}
-- 
1.9.1
