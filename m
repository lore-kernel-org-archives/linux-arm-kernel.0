From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Nov 2015 15:22:22 +0100
Subject: [PATCH] sched/rt: hide push_irq_work_func declaration
Message-ID: <3810009.VdDTV0h1Qp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The push_irq_work_func() function is conditionally defined only
when both CONFIG_SMP and HAVE_RT_PUSH_IPI are defined, but the
forward declaration remains visibile without HAVE_RT_PUSH_IPI,
causing a gcc warning in ARM64 allnoconfig:

kernel/sched/rt.c:68:13: warning: 'push_irq_work_func' declared 'static' but never defined [-Wunused-function]

This changes the code to use the same condition for both the
declaration and the function definition, which gets rid of the
warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: b6366f048e0c ("sched/rt: Use IPI to trigger RT task push migration instead of pulling")
---
Found on arm64 allnoconfig

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index e3cc16312046..ce7b36d6f477 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -64,7 +64,7 @@ static void start_rt_bandwidth(struct rt_bandwidth *rt_b)
 	raw_spin_unlock(&rt_b->rt_runtime_lock);
 }
 
-#ifdef CONFIG_SMP
+#if IS_ENABLED(CONFIG_SMP) && defined(HAVE_RT_PUSH_IPI)
 static void push_irq_work_func(struct irq_work *work);
 #endif
 
