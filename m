From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 3 Aug 2015 15:30:04 +0200
Subject: [PATCH 1/3] clocksource: atmel-st: Remove irq handler when
 clock event is unused
In-Reply-To: <20150802094028.GN12596@twins.programming.kicks-ass.net>
References: <1437161608-26782-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1437161608-26782-2-git-send-email-alexandre.belloni@free-electrons.com>
 <alpine.DEB.2.11.1507180942360.18576@nanos>
 <20150718222308.GA30489@piout.net>
 <alpine.DEB.2.11.1507201103550.18576@nanos>
 <20150720193726.GJ15539@piout.net>
 <alpine.DEB.2.11.1507202245310.18576@nanos>
 <alpine.DEB.2.11.1508021100390.3825@nanos>
 <20150802094028.GN12596@twins.programming.kicks-ass.net>
Message-ID: <20150803153004.4a74d99a@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter, Thomas,

On Sun, 2 Aug 2015 11:40:28 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Sun, Aug 02, 2015 at 11:10:21AM +0200, Thomas Gleixner wrote:
> > I think Boris Brezillon had implemented it at some point, but it was
> > shot down for reasons I can't remember. 
> 
> You weren't around at the time.. DT people didn't like it, said they
> didn't like having to make up fake hardware in their DT crap.

I don't know who was right, but the fact is they won't be inclined to
take such an approach unless the virtual demuxer is not exposed in the
DT, which is almost impossible since irq users are identifying their
irq lines with a phandle to the interrupt controller and an interrupt
id (usually extracted from the datasheet).

Anyway, below is a solution providing a way to disable specific
handlers without reworking the way we are modeling shared interrupts.
Thomas, I know you were not in favor of the proposed approach, but,
AFAICT, it does not add any conditional path to the interrupt handling
path (which, IIRC, was one of your requirements), and is simple enough
to be used by people really needing it.

There's probably other drawback I haven't noticed, so please don't
hesitate to share your thoughts.

Thanks,

Boris

--- >8 ---

>From 3add0dceff714d94748106eba9867ea9aa3cd6a8 Mon Sep 17 00:00:00 2001
From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Mon, 3 Aug 2015 15:18:08 +0200
Subject: [PATCH] irq: add disable_irq_handler()/enable_irq_handler() functions

Sometime we need to disable a specific handler on a shared irq line.
Currently, the only way this can be achieved is by freeing the irq handler
when we want to disable the irq and creating a new one when we want to
enable it.
This is not only adding some overhead to the disable/enable operations, but
the request_irq function cannot be called in atomic context, which means
it prevents disabling the interrupt in such situation.

This patch introduces three new functions: disable_irq_handler(),
disable_irq_handler_nosync() and enable_irq_handler() to allow disabling
a specific handler on a shared irq line.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 include/linux/irqdesc.h |  1 +
 kernel/irq/manage.c     | 82 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

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
index f974485..4690ab4 100644
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
-- 
1.9.1
