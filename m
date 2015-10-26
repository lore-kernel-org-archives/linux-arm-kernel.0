From: amittomer25@gmail.com (Amit)
Date: Mon, 26 Oct 2015 15:45:58 +0530
Subject: [PATCH v1] Ftrace: arm/arm64: Define a new arm/arm64 trace clock
 source based on CNTPCT/CNTPCT_EL0 register.
Message-ID: <1445854558-16253-1-git-send-email-amittomer25@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Amit Singh Tomar <amittomer25@gmail.com>

Define new arm/arm64 specific trace clock using CNTPCT/CNTPCT_EL0 register,
similar to x86-tsc. It can be used to correlate trace events across
hosts and guest that can be useful for debugging purpose.

Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes since RFC:
	* Replaced define with static inline
	* Revert few changes done in ftrace.txt
	* Made it common between ARM and ARM64.
---
 Documentation/trace/ftrace.txt       | 12 ++++++++++++
 arch/arm/include/asm/Kbuild          |  1 -
 arch/arm/include/asm/trace_clock.h   | 21 +++++++++++++++++++++
 arch/arm/kernel/Makefile             |  2 ++
 arch/arm/kernel/trace_clock.c        | 33 +++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/Kbuild        |  1 -
 arch/arm64/include/asm/trace_clock.h | 21 +++++++++++++++++++++
 arch/arm64/kernel/Makefile           |  2 ++
 8 files changed, 91 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/include/asm/trace_clock.h
 create mode 100644 arch/arm/kernel/trace_clock.c
 create mode 100644 arch/arm64/include/asm/trace_clock.h

diff --git a/Documentation/trace/ftrace.txt b/Documentation/trace/ftrace.txt
index ef621d3..13f3737 100644
--- a/Documentation/trace/ftrace.txt
+++ b/Documentation/trace/ftrace.txt
@@ -351,6 +351,18 @@ of ftrace. Here is a list of some of the key files:
 		  to correlate events across hypervisor/guest if
 		  tb_offset is known.
 
+	 arm-pct: This uses ARM Physical Count register value.This
+	 	  is different from default "local" clock which
+		  usese Virtual Count register.This is consistent
+		  across processors and can be used to correlate
+		  events across host/guest.
+
+	 arm64-pct: This uses ARM64 Physical Timer Count register
+                   value. This is different from default "local"
+                   clock which usese Virtual Timer Count register.
+                   This is consistent across processors and can be
+                   used to correlate events across host/guest.
+
 	To set a clock, simply echo the clock name into this file.
 
 	  echo global > trace_clock
diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index be648eb..bc3964b 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -34,5 +34,4 @@ generic-y += sockios.h
 generic-y += termbits.h
 generic-y += termios.h
 generic-y += timex.h
-generic-y += trace_clock.h
 generic-y += unaligned.h
diff --git a/arch/arm/include/asm/trace_clock.h b/arch/arm/include/asm/trace_clock.h
new file mode 100644
index 0000000..dc41f75
--- /dev/null
+++ b/arch/arm/include/asm/trace_clock.h
@@ -0,0 +1,21 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * Copyright (C) 2015 Amit Singh Tomar, amittomer25 at gmail.com
+*/
+
+#ifndef _ASM_ARM_TRACE_CLOCK_H
+#define _ASM_ARM_TRACE_CLOCK_H
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+extern u64 notrace trace_clock_arm_pct(void);
+
+# define ARCH_TRACE_CLOCKS \
+	{ trace_clock_arm_pct,  "arm-pct",  0},
+
+#endif  /* _ASM_ARM_TRACE_CLOCK_H */
+
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index af9e59b..c3abf7c 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -92,4 +92,6 @@ obj-y				+= psci-call.o
 obj-$(CONFIG_SMP)		+= psci_smp.o
 endif
 
+obj-$(CONFIG_TRACING)           += trace_clock.o
+
 extra-y := $(head-y) vmlinux.lds
diff --git a/arch/arm/kernel/trace_clock.c b/arch/arm/kernel/trace_clock.c
new file mode 100644
index 0000000..3bf040d
--- /dev/null
+++ b/arch/arm/kernel/trace_clock.c
@@ -0,0 +1,33 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * Copyright (C) 2015 Amit Singh Tomar, amittomer25 at gmail.com
+ *
+ * Thanks to Steven Rostedt and Andre Przywara!
+*/
+
+#include <asm/trace_clock.h>
+#include <asm/barrier.h>
+#include <asm/arch_timer.h>
+
+static inline u64 get_cntpct(void)
+{
+	u64 cycles;
+
+	isb();
+	asm volatile("mrs %0, cntpct_el0" : "=r" (cycles));
+
+	return cycles;
+}
+
+u64 notrace trace_clock_arm_pct(void)
+{
+	return arch_counter_get_cntpct();
+}
+
+#ifdef CONFIG_ARM64
+u64 notrace trace_clock_arm64_pct(void)
+{
+	return get_cntpct();
+}
+#endif
diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 70fd9ff..8608f9e 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -50,7 +50,6 @@ generic-y += switch_to.h
 generic-y += termbits.h
 generic-y += termios.h
 generic-y += topology.h
-generic-y += trace_clock.h
 generic-y += types.h
 generic-y += unaligned.h
 generic-y += user.h
diff --git a/arch/arm64/include/asm/trace_clock.h b/arch/arm64/include/asm/trace_clock.h
new file mode 100644
index 0000000..aef4ccd
--- /dev/null
+++ b/arch/arm64/include/asm/trace_clock.h
@@ -0,0 +1,21 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * Copyright (C) 2015 Amit Singh Tomar, amittomer25 at gmail.com
+*/
+
+#ifndef _ASM_ARM_TRACE_CLOCK_H
+#define _ASM_ARM_TRACE_CLOCK_H
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+extern u64 notrace trace_clock_arm64_pct(void);
+
+# define ARCH_TRACE_CLOCKS \
+	{ trace_clock_arm64_pct,  "arm64-pct",  0},
+
+#endif  /* _ASM_ARM_TRACE_CLOCK_H */
+
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 22dc9bc..b23a149 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -10,6 +10,7 @@ CFLAGS_armv8_deprecated.o := -I$(src)
 CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_insn.o = -pg
 CFLAGS_REMOVE_return_address.o = -pg
+ARM=../../../arch/arm/kernel
 
 # Object file lists.
 arm64-obj-y		:= debug-monitors.o entry.o irq.o fpsimd.o		\
@@ -36,6 +37,7 @@ arm64-obj-$(CONFIG_EFI)			+= efi.o efi-stub.o efi-entry.o
 arm64-obj-$(CONFIG_PCI)			+= pci.o
 arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
 arm64-obj-$(CONFIG_ACPI)		+= acpi.o
+arm64-obj-$(CONFIG_TRACING)             += $(ARM)/trace_clock.o
 
 obj-y					+= $(arm64-obj-y) vdso/
 obj-m					+= $(arm64-obj-m)
-- 
1.9.1
