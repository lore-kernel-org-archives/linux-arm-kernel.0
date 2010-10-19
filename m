From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 19 Oct 2010 16:38:58 +0200
Subject: [PATCH 03/12] ARM: Convert die_lock and undef_lock to raw_spinlocks
In-Reply-To: <20101019143717.GH11713@pengutronix.de>
References: <20101019143717.GH11713@pengutronix.de>
Message-ID: <1287499147-13846-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Gleixner <tglx@linutronix.de>

die_lock and undef_lock need to be real spinlocks on
preempt-rt. Convert them to raw_spinlock. No change for !RT kernels.

Make die_lock static while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/kernel/traps.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index cda78d5..eb9a240 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -257,7 +257,7 @@ static int __die(const char *str, int err, struct thread_info *thread, struct pt
 	return ret;
 }
 
-DEFINE_SPINLOCK(die_lock);
+static DEFINE_RAW_SPINLOCK(die_lock);
 
 /*
  * This function is protected against re-entrancy.
@@ -269,7 +269,7 @@ void die(const char *str, struct pt_regs *regs, int err)
 
 	oops_enter();
 
-	spin_lock_irq(&die_lock);
+	raw_spin_lock_irq(&die_lock);
 	console_verbose();
 	bust_spinlocks(1);
 	ret = __die(str, err, thread, regs);
@@ -279,7 +279,7 @@ void die(const char *str, struct pt_regs *regs, int err)
 
 	bust_spinlocks(0);
 	add_taint(TAINT_DIE);
-	spin_unlock_irq(&die_lock);
+	raw_spin_unlock_irq(&die_lock);
 	oops_exit();
 
 	if (in_interrupt())
@@ -304,24 +304,24 @@ void arm_notify_die(const char *str, struct pt_regs *regs,
 }
 
 static LIST_HEAD(undef_hook);
-static DEFINE_SPINLOCK(undef_lock);
+static DEFINE_RAW_SPINLOCK(undef_lock);
 
 void register_undef_hook(struct undef_hook *hook)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&undef_lock, flags);
+	raw_spin_lock_irqsave(&undef_lock, flags);
 	list_add(&hook->node, &undef_hook);
-	spin_unlock_irqrestore(&undef_lock, flags);
+	raw_spin_unlock_irqrestore(&undef_lock, flags);
 }
 
 void unregister_undef_hook(struct undef_hook *hook)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&undef_lock, flags);
+	raw_spin_lock_irqsave(&undef_lock, flags);
 	list_del(&hook->node);
-	spin_unlock_irqrestore(&undef_lock, flags);
+	raw_spin_unlock_irqrestore(&undef_lock, flags);
 }
 
 static int call_undef_hook(struct pt_regs *regs, unsigned int instr)
@@ -330,12 +330,12 @@ static int call_undef_hook(struct pt_regs *regs, unsigned int instr)
 	unsigned long flags;
 	int (*fn)(struct pt_regs *regs, unsigned int instr) = NULL;
 
-	spin_lock_irqsave(&undef_lock, flags);
+	raw_spin_lock_irqsave(&undef_lock, flags);
 	list_for_each_entry(hook, &undef_hook, node)
 		if ((instr & hook->instr_mask) == hook->instr_val &&
 		    (regs->ARM_cpsr & hook->cpsr_mask) == hook->cpsr_val)
 			fn = hook->fn;
-	spin_unlock_irqrestore(&undef_lock, flags);
+	raw_spin_unlock_irqrestore(&undef_lock, flags);
 
 	return fn ? fn(regs, instr) : 1;
 }
-- 
1.7.2.3
