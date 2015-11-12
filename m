From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Nov 2015 17:19:58 +0100
Subject: [PATCH v2] sched/rt: hide push_irq_work_func declaration
In-Reply-To: <3810009.VdDTV0h1Qp@wuerfel>
References: <3810009.VdDTV0h1Qp@wuerfel>
Message-ID: <3828565.oKfGk7yNIT@wuerfel>
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

As Peter Zijlstra, we can possibly get rid of the whole HAVE_RT_PUSH_IPI
thing after:
8053871d0f7f ("smp: Fix smp_call_function_single_async() locking")

Until that is done, this patch can be used to avoid the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: b6366f048e0c ("sched/rt: Use IPI to trigger RT task push migration instead of pulling")
---
Found on arm64 allnoconfig

v2: now using #if defined() instead IS_ENABLED()

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index e3cc16312046..ce7b36d6f477 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -64,7 +64,7 @@ static void start_rt_bandwidth(struct rt_bandwidth *rt_b)
        raw_spin_unlock(&rt_b->rt_runtime_lock);
 }
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && defined(HAVE_RT_PUSH_IPI)
 static void push_irq_work_func(struct irq_work *work);
 #endif
 
