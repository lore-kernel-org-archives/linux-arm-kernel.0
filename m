From: panand@redhat.com (Pratyush Anand)
Date: Thu, 17 Dec 2015 19:09:29 +0530
Subject: [PATCH RFC] ARM64: Add cpu hotplug for device tree parking method
Message-ID: <49d1ca9f7ca09707cdefbebe6f0163c376b1eaea.1450358510.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch has been implemented for CPU hotplug support for device tree
spin-table based parking method.

While cpu is offlined, cpu_die is called and when it is brought online
cpu_boot is called. So, cpu_boot must wake secondary and release pen,
otherwise dynamic cpu offline/online will not work.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
Hi,

Actually this patch is using some infrastructure from Geoff's kexec-v12.3.
But I am sending this patch for your review and feedback in advance. This
patch is needed for kexec and cpu hotplug to work on a system with device
tree spin-table method.

Have tested this patch with kexec and also with cpu offline from sys
interface.

 # lscpu
Architecture:          aarch64
Byte Order:            Little Endian
CPU(s):                8
On-line CPU(s) list:   0-7
Thread(s) per core:    1
Core(s) per socket:    2
Socket(s):             4
 # echo 0 > /sys/bus/cpu/devices/cpu3/online
 # lscpu
Architecture:          aarch64
Byte Order:            Little Endian
CPU(s):                8
On-line CPU(s) list:   0-2,4-7
Off-line CPU(s) list:  3
Thread(s) per core:    1
Core(s) per socket:    1
Socket(s):             4
 # echo 1 > /sys/bus/cpu/devices/cpu3/online
 # lscpu
Architecture:          aarch64
Byte Order:            Little Endian
CPU(s):                8
On-line CPU(s) list:   0-7
Thread(s) per core:    1
Core(s) per socket:    2
Socket(s):             4

cpu-park infrastructure of this patch can further be shared by ACPI parking
protocol support for providing CPU hotplug support.

~Pratyush

 arch/arm64/kernel/Makefile         |  2 +-
 arch/arm64/kernel/cpu-park.S       | 54 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/cpu-park.h       | 25 ++++++++++++++++++
 arch/arm64/kernel/smp_spin_table.c | 40 +++++++++++++++++++++++-----
 4 files changed, 113 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/kernel/cpu-park.S
 create mode 100644 arch/arm64/kernel/cpu-park.h

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index a08b0545bffa..f229f3d4b455 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -17,7 +17,7 @@ arm64-obj-y		:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   hyp-stub.o psci.o psci-call.o cpu_ops.o insn.o	\
 			   return_address.o cpuinfo.o cpu_errata.o		\
 			   cpufeature.o alternative.o cacheinfo.o		\
-			   smp.o smp_spin_table.o topology.o
+			   smp.o smp_spin_table.o cpu-park.o topology.o
 
 extra-$(CONFIG_EFI)			:= efi-entry.o
 
diff --git a/arch/arm64/kernel/cpu-park.S b/arch/arm64/kernel/cpu-park.S
new file mode 100644
index 000000000000..7e80ecf24f28
--- /dev/null
+++ b/arch/arm64/kernel/cpu-park.S
@@ -0,0 +1,54 @@
+/*
+ * cpu park routines
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/sysreg.h>
+#include <asm/virt.h>
+
+.text
+.pushsection 	.idmap.text, "ax"
+
+/*
+ * __cpu_park(el2_switch, park_address) - Helper for cpu_park
+ *
+ * @el2_switch: Flag to indicate a swich to EL2 is needed, passed to cpu_park.
+ * @park_address - where cpu will keep on looking for address to jump
+ *
+ * Put the CPU into the wfe and check for valid none zero secondary address
+ * at parked address when a event is received. If secondary address is
+ * valid then jump to it.
+ */
+
+ENTRY(__cpu_park)
+	/* Clear sctlr_el1 flags. */
+	mrs	x12, sctlr_el1
+	ldr	x13, =SCTLR_ELx_FLAGS
+	bic	x12, x12, x13
+	msr	sctlr_el1, x12
+	isb
+1:
+	wfe
+	ldr	x3, [x1]			// get entry address
+	cmp	x3, #0
+	b.eq	1b
+
+	mov	x2, 0
+	str	x2, [x1]
+
+	cbz	x0, 2f				// el2_switch?
+
+	mov	x0, x3				// entry
+	hvc	#HVC_CALL_FUNC			// no return
+
+2:
+	ret	x3
+
+ENDPROC(__cpu_park)
+
+.popsection
diff --git a/arch/arm64/kernel/cpu-park.h b/arch/arm64/kernel/cpu-park.h
new file mode 100644
index 000000000000..356438d21360
--- /dev/null
+++ b/arch/arm64/kernel/cpu-park.h
@@ -0,0 +1,25 @@
+/*
+ * cpu park routines
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _ARM64_CPU_PARK_H
+#define _ARM64_CPU_PARK_H
+
+#include <asm/virt.h>
+
+void __cpu_park(unsigned long el2_switch, unsigned long park_address);
+
+static inline void __noreturn cpu_park(unsigned long el2_switch,
+					unsigned long park_address)
+{
+	typeof(__cpu_park) *park_fn;
+	park_fn = (void *)virt_to_phys(__cpu_park);
+	park_fn(el2_switch, park_address);
+	unreachable();
+}
+
+#endif
diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_spin_table.c
index aef3605a8c47..9411b9f59f9e 100644
--- a/arch/arm64/kernel/smp_spin_table.c
+++ b/arch/arm64/kernel/smp_spin_table.c
@@ -26,8 +26,11 @@
 #include <asm/cpu_ops.h>
 #include <asm/cputype.h>
 #include <asm/io.h>
+#include <asm/kexec.h>
 #include <asm/smp_plat.h>
 
+#include "cpu-park.h"
+
 extern void secondary_holding_pen(void);
 volatile unsigned long secondary_holding_pen_release = INVALID_HWID;
 
@@ -73,11 +76,16 @@ static int smp_spin_table_cpu_init(unsigned int cpu)
 
 static int smp_spin_table_cpu_prepare(unsigned int cpu)
 {
-	__le64 __iomem *release_addr;
-
 	if (!cpu_release_addr[cpu])
 		return -ENODEV;
 
+	return 0;
+}
+
+static int smp_spin_table_cpu_boot(unsigned int cpu)
+{
+	__le64 __iomem *release_addr;
+
 	/*
 	 * The cpu-release-addr may or may not be inside the linear mapping.
 	 * As ioremap_cache will either give us a new mapping or reuse the
@@ -107,11 +115,6 @@ static int smp_spin_table_cpu_prepare(unsigned int cpu)
 
 	iounmap(release_addr);
 
-	return 0;
-}
-
-static int smp_spin_table_cpu_boot(unsigned int cpu)
-{
 	/*
 	 * Update the pen release flag.
 	 */
@@ -125,9 +128,32 @@ static int smp_spin_table_cpu_boot(unsigned int cpu)
 	return 0;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static int smp_spin_table_cpu_disable(unsigned int cpu)
+{
+	if (!cpu_release_addr[cpu])
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static void smp_spin_table_cpu_die(unsigned int cpu)
+{
+	setup_mm_for_reboot();
+	cpu_park(in_crash_kexec ? 0 : is_hyp_mode_available(),
+			cpu_release_addr[cpu]);
+
+	pr_crit("unable to power off CPU%u\n", cpu);
+}
+#endif
+
 const struct cpu_operations smp_spin_table_ops = {
 	.name		= "spin-table",
 	.cpu_init	= smp_spin_table_cpu_init,
 	.cpu_prepare	= smp_spin_table_cpu_prepare,
 	.cpu_boot	= smp_spin_table_cpu_boot,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_disable	= smp_spin_table_cpu_disable,
+	.cpu_die	= smp_spin_table_cpu_die,
+#endif
 };
-- 
2.5.0
