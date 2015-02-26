From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 26 Feb 2015 19:17:03 +0100
Subject: [RFC PATCH 0/3] genirq: mixing IRQF_NO_SUSPEND and wakeup sources
 on shared IRQs
In-Reply-To: <20150226164724.4f3c5921@bbrezillon>
References: <1424771762-16343-1-git-send-email-boris.brezillon@free-electrons.com>
 <20964379.cuQSlojCVH@vostro.rjw.lan> <20150226164724.4f3c5921@bbrezillon>
Message-ID: <8151717.nkhnGBri9h@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, February 26, 2015 04:47:24 PM Boris Brezillon wrote:
> On Thu, 26 Feb 2015 16:44:16 +0100
> "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> 
> > On Thursday, February 26, 2015 09:03:47 AM Boris Brezillon wrote:
> > > Hi Rafael,
> > > 
> > > On Wed, 25 Feb 2015 22:59:36 +0100
> > > "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> > > 
> > > > On Tuesday, February 24, 2015 10:55:59 AM Boris Brezillon wrote:
> > > > > Hello,
> > > > > 
> > > > > I put the IRQF_NO_SUSPEND_SAFE/IRQF_TIMER_SIBLING_OK/WHATEVER_NAME_YOU_CHOOSE
> > > > > debate aside to concentrate on another problem pointed out by Rafael and
> > > > > Mark: the fact that we cannot mix IRQF_NO_SUSPEND and wakeup sources on
> > > > > a shared IRQ line.
> > > > > 
> > > > > This is because the wakeup code is prevailing the IRQF_NO_SUSPEND case
> > > > > and will trigger a system wakeup as soon as the IRQ line is tagged as a
> > > > > wakeup source.
> > > > > 
> > > > > This series propose an approach to deal with such cases by doing the
> > > > > following:
> > > > > 1/ Prevent any system wakeup when at least one of the IRQ user has set
> > > > >    the IRQF_NO_SUSPEND flag
> > > > > 2/ Adapt IRQ handlers so that they can safely be called in suspended
> > > > >    state
> > > > > 3/ Let drivers decide when the system should be woken up
> > > > > 
> > > > > Let me know what you think of this approach.
> > > > 
> > > > So I have the appended patch that should deal with all that too (it doesn't
> > > > rework drivers that need to share NO_SUSPEND IRQs and do wakeup, but that
> > > > can be done on top of it in a straightforward way).
> > > > 
> > > > The idea is quite simple.  By default, the core replaces the interrupt handlers
> > > > of everyone sharing NO_SUSPEND lines and not using IRQF_NO_SUSPEND with a null
> > > > handler always returning IRQ_NONE at the suspend_device_irqs() time (the
> > > > rationale being that if you don't use IRQF_NO_SUSPEND, then your device has
> > > > no reason to generate interrupts after that point).  The original handlers are
> > > > then restored by resume_device_irqs().
> > > > 
> > > > However, if the IRQ is configured for wakeup, there may be a reason to generate
> > > > interrupts from a device not using IRQF_NO_SUSPEND.  For that, the patch adds
> > > > IRQF_COND_SUSPEND that, if set, will prevent the default behavior described
> > > > above from being applied to irqactions using it if the IRQs in question are
> > > > configured for wakeup.  Of course, the users of IRQF_COND_SUSPEND are supposed
> > > > to implement wakeup detection in their interrupt handlers and then call
> > > > pm_system_wakeup() if necessary.
> > > 
> > > That patch sounds good to me.
> > 
> > But it is still a bit risky.  Namely, if the driver in question is sufficiently
> > broken (eg. it may not suspend the device and rely on the fact that its interrupt
> > handler will be run just because it is sharing a "no suspend" IRQ), we may get
> > an interrupt storm.
> > 
> > Isn't that a problem?
> 
> For me no (I'll fix all the drivers to handle wakeup, and they are all
> already masking interrupts coming from their side in the suspend
> callback).
> I can't talk for other people though.
> The only problem I see here is that you're not informing people that
> they are erroneously mixing IRQF_NO_SUSPEND and !IRQF_NO_SUSPEND anymore
> (you removed the warning backtrace).
> Moreover, you are replacing their handler by a stub when entering
> suspend, so they might end-up receiving spurious interrupts when
> suspended without knowing why ?
> 
> How about checking if the number of actions registered with
> IRQF_NO_SUSPEND + those registered with IRQF_COND_SUSPEND (or another
> flag stating that the handler can safely be called in suspended state
> even if it didn't ask for NO_SUSPEND) are equal to the total number of
> registered actions, and complain if it's not the case.

The same idea I had while talking to Peter over IRC.  So the patch below
implements that.

> If some actions are offending this rule, you could keep the previous
> behavior by leaving its handler in place when entering suspend so that
> existing drivers/systems will keep working (but with a warning
> backtrace).

Right.


---
 include/linux/interrupt.h |    5 +++++
 include/linux/irqdesc.h   |    1 +
 kernel/irq/manage.c       |    7 ++++++-
 kernel/irq/pm.c           |    7 ++++++-
 4 files changed, 18 insertions(+), 2 deletions(-)

Index: linux-pm/include/linux/interrupt.h
===================================================================
--- linux-pm.orig/include/linux/interrupt.h
+++ linux-pm/include/linux/interrupt.h
@@ -57,6 +57,10 @@
  * IRQF_NO_THREAD - Interrupt cannot be threaded
  * IRQF_EARLY_RESUME - Resume IRQ early during syscore instead of at device
  *                resume time.
+ * IRQF_COND_SUSPEND - If the IRQ is shared with a NO_SUSPEND user, execute this
+ *                interrupt handler after suspending interrupts. For system
+ *                wakeup devices users need to implement wakeup detection in
+ *                their interrupt handlers.
  */
 #define IRQF_DISABLED		0x00000020
 #define IRQF_SHARED		0x00000080
@@ -70,6 +74,7 @@
 #define IRQF_FORCE_RESUME	0x00008000
 #define IRQF_NO_THREAD		0x00010000
 #define IRQF_EARLY_RESUME	0x00020000
+#define IRQF_COND_SUSPEND	0x00040000
 
 #define IRQF_TIMER		(__IRQF_TIMER | IRQF_NO_SUSPEND | IRQF_NO_THREAD)
 
Index: linux-pm/include/linux/irqdesc.h
===================================================================
--- linux-pm.orig/include/linux/irqdesc.h
+++ linux-pm/include/linux/irqdesc.h
@@ -78,6 +78,7 @@ struct irq_desc {
 #ifdef CONFIG_PM_SLEEP
 	unsigned int		nr_actions;
 	unsigned int		no_suspend_depth;
+	unsigned int		cond_suspend_depth;
 	unsigned int		force_resume_depth;
 #endif
 #ifdef CONFIG_PROC_FS
Index: linux-pm/kernel/irq/pm.c
===================================================================
--- linux-pm.orig/kernel/irq/pm.c
+++ linux-pm/kernel/irq/pm.c
@@ -43,9 +43,12 @@ void irq_pm_install_action(struct irq_de
 
 	if (action->flags & IRQF_NO_SUSPEND)
 		desc->no_suspend_depth++;
+	else if (action->flags & IRQF_COND_SUSPEND)
+		desc->cond_suspend_depth++;
 
 	WARN_ON_ONCE(desc->no_suspend_depth &&
-		     desc->no_suspend_depth != desc->nr_actions);
+		     (desc->no_suspend_depth +
+			desc->cond_suspend_depth) != desc->nr_actions);
 }
 
 /*
@@ -61,6 +64,8 @@ void irq_pm_remove_action(struct irq_des
 
 	if (action->flags & IRQF_NO_SUSPEND)
 		desc->no_suspend_depth--;
+	else if (action->flags & IRQF_COND_SUSPEND)
+		desc->cond_suspend_depth--;
 }
 
 static bool suspend_device_irq(struct irq_desc *desc, int irq)
Index: linux-pm/kernel/irq/manage.c
===================================================================
--- linux-pm.orig/kernel/irq/manage.c
+++ linux-pm/kernel/irq/manage.c
@@ -1474,8 +1474,13 @@ int request_threaded_irq(unsigned int ir
 	 * otherwise we'll have trouble later trying to figure out
 	 * which interrupt is which (messes up the interrupt freeing
 	 * logic etc).
+	 *
+	 * Also IRQF_COND_SUSPEND only makes sense for shared interrupts and
+	 * it is mutually exclusive with IRQF_NO_SUSPEND.
 	 */
-	if ((irqflags & IRQF_SHARED) && !dev_id)
+	if (((irqflags & IRQF_SHARED) && !dev_id) ||
+	    (!(irqflags & IRQF_SHARED) && (irqflags & IRQF_COND_SUSPEND)) ||
+	    ((irqflags & IRQF_NO_SUSPEND) && (irqflags & IRQF_COND_SUSPEND)))
 		return -EINVAL;
 
 	desc = irq_to_desc(irq);
