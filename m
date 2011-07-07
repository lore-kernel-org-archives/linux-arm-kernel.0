From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  7 Jul 2011 16:50:24 +0100
Subject: [RFC PATCH 11/17] ARM: kernel: add support for Lamport's bakery locks
In-Reply-To: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1310053830-23779-12-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NOTE: This toy locking algorithm is there waiting for a warm-boot protocol
to be defined for ARM SMP platforms. It is there to prevent races
that will never show up in real platforms (ie multiple CPUs coming
out of low-power at once from cluster shutdown with no HW/SW control
so that they might try to renable shared resources like SCU
concurrently). When a warm-boot protocol is defined this patch
can be and must be simply ignored; it is provided for completeness.

The current implementation of spinlocks on ARM relies on ldrex/strex
which are only functional if and only if the D$ is looked-up and the CPU
is within the coherency domain. When a CPU has to be powered down, it
has to turn off D$ look-up to clean and invalidate L1 dirty lines, and on
an SMP system it must be taken out of the coherency domain it belongs
to.
This means that after the point of no return on power down (cache
look-up disabled and SMP bit cleared) ldrex/strex cacheable spinlocks become
unusable. Normal non-cacheable memory based ldrex/strex require a global
monitor which is not available in all HW configurations.

In order to ensure atomicity of complex operations like
cleaning/invalidating/disabling L2 and reset the SCU, this patch adds
the Lamport's bakery algorithm, which does not rely on any low-level
atomic operation, to the Linux kernel.

Unless restrictions are put in place in HW, processors can be powered
down and powered up at random times (e.g IRQ), which means that the ordering
is not really controlled by SW, so lock coordination is required to make the
code generic.
Memory allocated to LB spinlocks must be strongly ordered and the
algorithm relies on strongly and coherent writes ordering among
processors to guarantee atomicity.

It is slow and it must be avoided (see NOTE); it is not meant to provide
a definitive solution.

Tested on dual-core A9 with processors being powered-down and up
according to CPU idle workloads.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/include/asm/lb_lock.h |   34 ++++++++++++++++
 arch/arm/kernel/lb_lock.c      |   85 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/lb_lock.h
 create mode 100644 arch/arm/kernel/lb_lock.c

diff --git a/arch/arm/include/asm/lb_lock.h b/arch/arm/include/asm/lb_lock.h
new file mode 100644
index 0000000..2ed722c
--- /dev/null
+++ b/arch/arm/include/asm/lb_lock.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright (C) 2008-2011 ARM Limited
+ *
+ * Author(s): Jon Callan, Lorenzo Pieralisi
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __ASM_ARM_LB_LOCK_H
+#define __ASM_ARM_LB_LOCK_H
+
+/*
+ * Lamport's Bakery algorithm for spinlock handling
+ *
+ * Note that the algorithm requires the bakery struct
+ * to be in Strongly-Ordered memory.
+ */
+
+/*
+ * Bakery structure - declare/allocate one of these for each lock.
+ * A pointer to this struct is passed to the lock/unlock functions.
+ */
+struct bakery {
+	unsigned int number[CONFIG_NR_CPUS];
+	char entering[CONFIG_NR_CPUS];
+};
+
+extern void initialize_spinlock(struct bakery *bakery);
+extern void get_spinlock(unsigned cpuid, struct bakery *bakery);
+extern void release_spinlock(unsigned cpuid, struct bakery *bakery);
+#endif
diff --git a/arch/arm/kernel/lb_lock.c b/arch/arm/kernel/lb_lock.c
new file mode 100644
index 0000000..199e79e
--- /dev/null
+++ b/arch/arm/kernel/lb_lock.c
@@ -0,0 +1,85 @@
+/*
+ * Copyright (C) 2008-2011 ARM Limited
+ *
+ * Author(s): Jon Callan, Lorenzo Pieralisi
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Lamport's Bakery algorithm for spinlock handling
+ *
+ * Note that the algorithm requires the bakery struct to be in
+ * Strongly-Ordered memory.
+ */
+
+#include <asm/system.h>
+#include <asm/string.h>
+#include <asm/lb_lock.h>
+#include <asm/io.h>
+
+/*
+ * Initialize a bakery - only required if the bakery is
+ * on the stack or heap, as static data is zeroed anyway.
+ */
+void  initialize_spinlock(struct bakery *bakery)
+{
+	memset(bakery, 0, sizeof(struct bakery));
+}
+
+/*
+ * Claim a bakery lock. Function does not return until
+ * lock has been obtained.
+ */
+void notrace get_spinlock(unsigned cpuid, struct bakery *bakery)
+{
+	unsigned i, my_full_number, his_full_number, max = 0;
+
+	/* Get a ticket */
+	__raw_writeb(1, bakery->entering + cpuid);
+	/*
+	 * The order of writes is paramount to the algorithm
+	 * dsb() ensures the write happens in order here
+	 */
+	dsb();
+	for (i = 0; i < CONFIG_NR_CPUS; ++i) {
+		if (__raw_readl(bakery->number + i) > max)
+			max = __raw_readl(bakery->number + i);
+	}
+	++max;
+	/*
+	 * The order of writes is paramount to the algorithm
+	 * dsb() ensures the write happens in order here
+	 */
+	__raw_writel(max, bakery->number + cpuid);
+	dsb();
+	__raw_writeb(0, bakery->entering + cpuid);
+
+	/* Wait for our turn */
+	my_full_number = (max << 8) + cpuid;
+	for (i = 0; i < CONFIG_NR_CPUS; ++i) {
+		while (__raw_readb(bakery->entering + i))
+			;
+				/*
+				 * Wait since another CPU might be taking our
+				 * same ticket number and have higher priority
+				 */
+		do {
+			his_full_number = __raw_readl(bakery->number + i);
+			if (his_full_number)
+				his_full_number =
+				    (his_full_number << 8) + i;
+
+		} while (his_full_number && (his_full_number < my_full_number));
+	}
+	dsb();
+}
+
+/*
+ * Release a bakery lock.
+ */
+void  release_spinlock(unsigned cpuid, struct bakery *bakery)
+{
+	dsb();
+	__raw_writel(0, bakery->number + cpuid);
+}
-- 
1.7.4.4
