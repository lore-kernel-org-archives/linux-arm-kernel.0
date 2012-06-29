From: will.deacon@arm.com (Will Deacon)
Date: Fri, 29 Jun 2012 18:33:51 +0100
Subject: [PATCH v2 2/2] ARM: delay: allow timer-based delay implementation to
 be selected
In-Reply-To: <1340991231-17682-1-git-send-email-will.deacon@arm.com>
References: <1340991231-17682-1-git-send-email-will.deacon@arm.com>
Message-ID: <1340991231-17682-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows a timer-based delay implementation to be selected by
switching the delay routines over to use get_cycles, which is
implemented in terms of read_current_timer. This further allows us to
skip the loop calibration and have a consistent delay function in the
face of core frequency scaling.

To avoid the pain of dealing with memory-mapped counters, this
implementation uses the co-processor interface to the architected timers
when they are available. The previous loop-based implementation is
kept around for CPUs without the architected timers and we retain both
the maximum delay (2ms) and the corresponding conversion factors for
determining the number of loops required for a given interval. Since the
indirection of the timer routines will only work when called from C,
the sa1100 sleep routines are modified to branch to the loop-based delay
functions directly.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/delay.h           |   32 ++++++++++++---
 arch/arm/kernel/arch_timer.c           |    3 +
 arch/arm/kernel/armksyms.c             |    3 +-
 arch/arm/lib/Makefile                  |    2 +-
 arch/arm/lib/{delay.S => delay-loop.S} |   20 ++++-----
 arch/arm/lib/delay.c                   |   66 ++++++++++++++++++++++++++++++++
 arch/arm/mach-sa1100/sleep.S           |    8 ++--
 7 files changed, 109 insertions(+), 25 deletions(-)
 rename arch/arm/lib/{delay.S => delay-loop.S} (81%)
 create mode 100644 arch/arm/lib/delay.c

diff --git a/arch/arm/include/asm/delay.h b/arch/arm/include/asm/delay.h
index b2deda1..dc61451 100644
--- a/arch/arm/include/asm/delay.h
+++ b/arch/arm/include/asm/delay.h
@@ -6,9 +6,22 @@
 #ifndef __ASM_ARM_DELAY_H
 #define __ASM_ARM_DELAY_H
 
+#include <asm/memory.h>
 #include <asm/param.h>	/* HZ */
 
-extern void __delay(int loops);
+#define MAX_UDELAY_MS	2
+#define UDELAY_MULT	((UL(2199023) * HZ) >> 11)
+#define UDELAY_SHIFT	30
+
+#ifndef __ASSEMBLY__
+
+extern struct arm_delay_ops {
+	void (*delay)(unsigned long);
+	void (*const_udelay)(unsigned long);
+	void (*udelay)(unsigned long);
+} arm_delay_ops;
+
+#define __delay(n)		arm_delay_ops.delay(n)
 
 /*
  * This function intentionally does not exist; if you see references to
@@ -23,22 +36,27 @@ extern void __bad_udelay(void);
  * division by multiplication: you don't have to worry about
  * loss of precision.
  *
- * Use only for very small delays ( < 1 msec).  Should probably use a
+ * Use only for very small delays ( < 2 msec).  Should probably use a
  * lookup table, really, as the multiplications take much too long with
  * short delays.  This is a "reasonable" implementation, though (and the
  * first constant multiplications gets optimized away if the delay is
  * a constant)
  */
-extern void __udelay(unsigned long usecs);
-extern void __const_udelay(unsigned long);
-
-#define MAX_UDELAY_MS 2
+#define __udelay(n)		arm_delay_ops.udelay(n)
+#define __const_udelay(n)	arm_delay_ops.const_udelay(n)
 
 #define udelay(n)							\
 	(__builtin_constant_p(n) ?					\
 	  ((n) > (MAX_UDELAY_MS * 1000) ? __bad_udelay() :		\
-			__const_udelay((n) * ((2199023U*HZ)>>11))) :	\
+			__const_udelay((n) * UDELAY_MULT)) :		\
 	  __udelay(n))
 
+/* Loop-based definitions for assembly code. */
+extern void __loop_delay(unsigned long loops);
+extern void __loop_udelay(unsigned long usecs);
+extern void __loop_const_udelay(unsigned long);
+
+#endif /* __ASSEMBLY__ */
+
 #endif /* defined(_ARM_DELAY_H) */
 
diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
index dbbeec4..675cee0 100644
--- a/arch/arm/kernel/arch_timer.c
+++ b/arch/arm/kernel/arch_timer.c
@@ -32,6 +32,8 @@ static int arch_timer_ppi2;
 
 static struct clock_event_device __percpu **arch_timer_evt;
 
+extern void init_current_timer_delay(unsigned long freq);
+
 /*
  * Architected system timer support.
  */
@@ -304,6 +306,7 @@ static int __init arch_timer_register(void)
 	if (err)
 		goto out_free_irq;
 
+	init_current_timer_delay(arch_timer_rate);
 	return 0;
 
 out_free_irq:
diff --git a/arch/arm/kernel/armksyms.c b/arch/arm/kernel/armksyms.c
index b57c75e..7196228 100644
--- a/arch/arm/kernel/armksyms.c
+++ b/arch/arm/kernel/armksyms.c
@@ -49,8 +49,7 @@ extern void __aeabi_ulcmp(void);
 extern void fpundefinstr(void);
 
 	/* platform dependent support */
-EXPORT_SYMBOL(__udelay);
-EXPORT_SYMBOL(__const_udelay);
+EXPORT_SYMBOL(arm_delay_ops);
 
 	/* networking */
 EXPORT_SYMBOL(csum_partial);
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 992769a..b621114 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -6,7 +6,7 @@
 
 lib-y		:= backtrace.o changebit.o csumipv6.o csumpartial.o   \
 		   csumpartialcopy.o csumpartialcopyuser.o clearbit.o \
-		   delay.o findbit.o memchr.o memcpy.o		      \
+		   delay.o delay-loop.o findbit.o memchr.o memcpy.o   \
 		   memmove.o memset.o memzero.o setbit.o              \
 		   strncpy_from_user.o strnlen_user.o                 \
 		   strchr.o strrchr.o                                 \
diff --git a/arch/arm/lib/delay.S b/arch/arm/lib/delay-loop.S
similarity index 81%
rename from arch/arm/lib/delay.S
rename to arch/arm/lib/delay-loop.S
index 3c9a05c..36b668d 100644
--- a/arch/arm/lib/delay.S
+++ b/arch/arm/lib/delay-loop.S
@@ -9,11 +9,11 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
-#include <asm/param.h>
+#include <asm/delay.h>
 		.text
 
 .LC0:		.word	loops_per_jiffy
-.LC1:		.word	(2199023*HZ)>>11
+.LC1:		.word	UDELAY_MULT
 
 /*
  * r0  <= 2000
@@ -21,10 +21,10 @@
  * HZ  <= 1000
  */
 
-ENTRY(__udelay)
+ENTRY(__loop_udelay)
 		ldr	r2, .LC1
 		mul	r0, r2, r0
-ENTRY(__const_udelay)				@ 0 <= r0 <= 0x7fffff06
+ENTRY(__loop_const_udelay)			@ 0 <= r0 <= 0x7fffff06
 		mov	r1, #-1
 		ldr	r2, .LC0
 		ldr	r2, [r2]		@ max = 0x01ffffff
@@ -39,12 +39,10 @@ ENTRY(__const_udelay)				@ 0 <= r0 <= 0x7fffff06
 
 /*
  * loops = r0 * HZ * loops_per_jiffy / 1000000
- *
- * Oh, if only we had a cycle counter...
  */
 
 @ Delay routine
-ENTRY(__delay)
+ENTRY(__loop_delay)
 		subs	r0, r0, #1
 #if 0
 		movls	pc, lr
@@ -62,8 +60,8 @@ ENTRY(__delay)
 		movls	pc, lr
 		subs	r0, r0, #1
 #endif
-		bhi	__delay
+		bhi	__loop_delay
 		mov	pc, lr
-ENDPROC(__udelay)
-ENDPROC(__const_udelay)
-ENDPROC(__delay)
+ENDPROC(__loop_udelay)
+ENDPROC(__loop_const_udelay)
+ENDPROC(__loop_delay)
diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
new file mode 100644
index 0000000..e1030e1
--- /dev/null
+++ b/arch/arm/lib/delay.c
@@ -0,0 +1,66 @@
+/*
+ * Delay loops based on the OpenRISC implementation.
+ *
+ * Copyright (C) 2012 ARM Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ * Author: Will Deacon <will.deacon@arm.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/timex.h>
+
+/*
+ * Default to the loop-based delay implementation.
+ */
+struct arm_delay_ops arm_delay_ops = {
+	.delay		= __loop_delay,
+	.const_udelay	= __loop_const_udelay,
+	.udelay		= __loop_udelay,
+};
+
+#ifdef ARCH_HAS_READ_CURRENT_TIMER
+static void __timer_delay(unsigned long cycles)
+{
+	cycles_t start = get_cycles();
+
+	while ((get_cycles() - start) < cycles)
+		cpu_relax();
+}
+
+static void __timer_const_udelay(unsigned long xloops)
+{
+	unsigned long long loops = xloops;
+	loops *= loops_per_jiffy;
+	__timer_delay(loops >> UDELAY_SHIFT);
+}
+
+static void __timer_udelay(unsigned long usecs)
+{
+	__timer_const_udelay(usecs * UDELAY_MULT);
+}
+
+void __init init_current_timer_delay(unsigned long freq)
+{
+	pr_info("Switching to timer-based delay loop\n");
+	lpj_fine			= freq / HZ;
+	arm_delay_ops.delay		= __timer_delay;
+	arm_delay_ops.const_udelay	= __timer_const_udelay;
+	arm_delay_ops.udelay		= __timer_udelay;
+}
+#endif
diff --git a/arch/arm/mach-sa1100/sleep.S b/arch/arm/mach-sa1100/sleep.S
index 30cc672..8586374 100644
--- a/arch/arm/mach-sa1100/sleep.S
+++ b/arch/arm/mach-sa1100/sleep.S
@@ -38,9 +38,9 @@ ENTRY(sa1100_finish_suspend)
 	orr     r4, r4, #MDREFR_K1DB2
 	ldr	r5, =PPCR
 
-	@ Pre-load __udelay into the I-cache
+	@ Pre-load __loop_udelay into the I-cache
 	mov	r0, #1
-	bl	__udelay
+	bl	__loop_udelay
 	mov	r0, r0
 
 	@ The following must all exist in a single cache line to
@@ -53,11 +53,11 @@ ENTRY(sa1100_finish_suspend)
 	@ delay 90us and set CPU PLL to lowest speed
 	@ fixes resume problem on high speed SA1110
 	mov	r0, #90
-	bl	__udelay
+	bl	__loop_udelay
 	mov	r1, #0
 	str	r1, [r5]
 	mov	r0, #90
-	bl	__udelay
+	bl	__loop_udelay
 
 	/*
 	 * SA1110 SDRAM controller workaround.  register values:
-- 
1.7.4.1
