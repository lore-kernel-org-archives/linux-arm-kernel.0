From: ynorov@caviumnetworks.com (Yury Norov)
Date: Thu,  5 Apr 2018 20:17:59 +0300
Subject: [PATCH 4/5] rcu: arm64: add rcu_dynticks_eqs_exit_sync()
In-Reply-To: <20180405171800.5648-1-ynorov@caviumnetworks.com>
References: <20180405171800.5648-1-ynorov@caviumnetworks.com>
Message-ID: <20180405171800.5648-5-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch of the series enables delaying of kernel memory
synchronization for CPUs running in extended quiescent state (EQS)
till the exit of that state.

In previous patch ISB was added in EQS exit path to ensure that
any change made by kernel patching framework is visible. But after
that isb(), EQS is still enabled for a while, and there's a chance
that some other core will modify text in parallel, and EQS core
will be not notified about it, as EQS will mask IPI:

CPU0                            CPU1

ISB
				patch_some_text()
				kick_all_active_cpus_sync()
exit EQS

// not synchronized!
use_of_patched_text()

This patch introduces rcu_dynticks_eqs_exit_sync() function and uses
it in arm64 code to call ipi() after the exit from quiescent state.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/kernel/Makefile | 2 ++
 arch/arm64/kernel/rcu.c    | 8 ++++++++
 kernel/rcu/tree.c          | 4 ++++
 3 files changed, 14 insertions(+)
 create mode 100644 arch/arm64/kernel/rcu.c

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 9b55a3f24be7..c87a203524ab 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -54,6 +54,8 @@ arm64-obj-$(CONFIG_ARM64_RELOC_TEST)	+= arm64-reloc-test.o
 arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
 arm64-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
 arm64-obj-$(CONFIG_ARM_SDE_INTERFACE)	+= sdei.o
+arm64-obj-$(CONFIG_TREE_RCU)		+= rcu.o
+arm64-obj-$(CONFIG_PREEMPT_RCU)		+= rcu.o
 
 arm64-obj-$(CONFIG_KVM_INDIRECT_VECTORS)+= bpi.o
 
diff --git a/arch/arm64/kernel/rcu.c b/arch/arm64/kernel/rcu.c
new file mode 100644
index 000000000000..67fe33c0ea03
--- /dev/null
+++ b/arch/arm64/kernel/rcu.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <asm/barrier.h>
+
+void rcu_dynticks_eqs_exit_sync(void)
+{
+	isb();
+};
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2a734692a581..363f91776b66 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -264,6 +264,8 @@ void rcu_bh_qs(void)
 #define rcu_eqs_special_exit() do { } while (0)
 #endif
 
+void __weak rcu_dynticks_eqs_exit_sync(void) {};
+
 static DEFINE_PER_CPU(struct rcu_dynticks, rcu_dynticks) = {
 	.dynticks_nesting = 1,
 	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
@@ -308,6 +310,8 @@ static void rcu_dynticks_eqs_exit(void)
 	 * critical section.
 	 */
 	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdtp->dynticks);
+	rcu_dynticks_eqs_exit_sync();
+
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     !(seq & RCU_DYNTICK_CTRL_CTR));
 	if (seq & RCU_DYNTICK_CTRL_MASK) {
-- 
2.14.1
