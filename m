From: tom.leiming@gmail.com (Ming Lei)
Date: Thu,  7 Mar 2013 10:47:48 +0800
Subject: [RFC PATCH] ARM: keep __my_cpu_offset consistent with generic one
Message-ID: <1362624468-5451-1-git-send-email-tom.leiming@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 14318efb(ARM: 7587/1: implement optimized percpu variable access)
introduces arm's __my_cpu_offset to optimize percpu vaiable access,
which really works well on hackbench test, but may cause __my_cpu_offset
to return garbage value before it is initialized in cpu_init() called
by setup_arch, so accessing a percpu variable before setup_arch may cause
kernel hang. But the generic__my_cpu_offset always returns zero before
percpu area is brought up.

So the patch tries to clear __my_cpu_offset on boot CPU early
to avoid boot hang.

At least now percpu variable is accessed by lockdep before
setup_arch(), and enabling CONFIG_LOCK_STAT or CONFIG_DEBUG_LOCKDEP
can trigger kernel hang.

Cc: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 arch/arm/kernel/setup.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 3f6cbb2..bc7ee4b 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -439,6 +439,13 @@ void __init smp_setup_processor_id(void)
 	for (i = 1; i < nr_cpu_ids; ++i)
 		cpu_logical_map(i) = i == cpu ? 0 : i;
 
+	/*
+	 * clear __my_cpu_offset on boot CPU early to avoid hang
+	 * caused by accessing percpu variable before percpu area is
+	 * brought up
+	 */
+	set_my_cpu_offset(0);
+
 	printk(KERN_INFO "Booting Linux on physical CPU 0x%x\n", mpidr);
 }
 
-- 
1.7.9.5
