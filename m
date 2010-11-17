From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 17 Nov 2010 19:03:43 +0800
Subject: [PATCH 9/9] ARM: pxa: add iwmmx support for PJ4
In-Reply-To: <1289991823-24677-8-git-send-email-haojian.zhuang@marvell.com>
References: <1289991823-24677-1-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-2-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-3-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-4-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-5-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-6-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-7-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-8-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1289991823-24677-9-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

iwmmxt is used in XScale, XScale3, Mohawk and PJ4 core. But the instructions
of accessing CP0 and CP1 is changed in PJ4. Append more files to support
iwmmxt in PJ4 core.

Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Nicolas Pitre <nico@fluxnic.net>
---
 arch/arm/Kconfig         |    4 +-
 arch/arm/kernel/Makefile |    1 +
 arch/arm/kernel/iwmmxt.S |   55 +++++++++++++++++++++++++++++++++++-----------
 3 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a19a526..b0f25b0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -999,8 +999,8 @@ source arch/arm/mm/Kconfig
 
 config IWMMXT
 	bool "Enable iWMMXt support"
-	depends on CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK
-	default y if PXA27x || PXA3xx || ARCH_MMP
+	depends on CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_PJ4
+	default y if PXA27x || PXA3xx || PXA95x || ARCH_MMP
 	help
 	  Enable support for iWMMXt context switching at run time if
 	  running on a CPU that supports it.
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 5b9b268..b0f11fa 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -50,6 +50,7 @@ AFLAGS_crunch-bits.o		:= -Wa,-mcpu=ep9312
 obj-$(CONFIG_CPU_XSCALE)	+= xscale-cp0.o
 obj-$(CONFIG_CPU_XSC3)		+= xscale-cp0.o
 obj-$(CONFIG_CPU_MOHAWK)	+= xscale-cp0.o
+obj-$(CONFIG_CPU_PJ4)		+= pj4-cp0.o
 obj-$(CONFIG_IWMMXT)		+= iwmmxt.o
 obj-$(CONFIG_CPU_HAS_PMU)	+= pmu.o
 obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
diff --git a/arch/arm/kernel/iwmmxt.S b/arch/arm/kernel/iwmmxt.S
index b63b528..7fa3bb0 100644
--- a/arch/arm/kernel/iwmmxt.S
+++ b/arch/arm/kernel/iwmmxt.S
@@ -19,6 +19,14 @@
 #include <asm/thread_info.h>
 #include <asm/asm-offsets.h>
 
+#if defined(CONFIG_CPU_PJ4)
+#define PJ4(code...)		code
+#define XSC(code...)
+#else
+#define PJ4(code...)
+#define XSC(code...)		code
+#endif
+
 #define MMX_WR0		 	(0x00)
 #define MMX_WR1		 	(0x08)
 #define MMX_WR2		 	(0x10)
@@ -58,11 +66,17 @@
 
 ENTRY(iwmmxt_task_enable)
 
-	mrc	p15, 0, r2, c15, c1, 0
-	tst	r2, #0x3			@ CP0 and CP1 accessible?
+	XSC(mrc	p15, 0, r2, c15, c1, 0)
+	PJ4(mrc p15, 0, r2, c1, c0, 2)
+	@ CP0 and CP1 accessible?
+	XSC(tst	r2, #0x3)
+	PJ4(tst	r2, #0xf)
 	movne	pc, lr				@ if so no business here
-	orr	r2, r2, #0x3			@ enable access to CP0 and CP1
-	mcr	p15, 0, r2, c15, c1, 0
+	@ enable access to CP0 and CP1
+	XSC(orr	r2, r2, #0x3)
+	XSC(mcr	p15, 0, r2, c15, c1, 0)
+	PJ4(orr	r2, r2, #0xf)
+	PJ4(mcr	p15, 0, r2, c1, c0, 2)
 
 	ldr	r3, =concan_owner
 	add	r0, r10, #TI_IWMMXT_STATE	@ get task Concan save area
@@ -179,17 +193,26 @@ ENTRY(iwmmxt_task_disable)
 	teqne	r1, r2				@ or specified one?
 	bne	1f				@ no: quit
 
-	mrc	p15, 0, r4, c15, c1, 0
-	orr	r4, r4, #0x3			@ enable access to CP0 and CP1
-	mcr	p15, 0, r4, c15, c1, 0
+	@ enable access to CP0 and CP1
+	XSC(mrc	p15, 0, r4, c15, c1, 0)
+	XSC(orr	r4, r4, #0xf)
+	XSC(mcr	p15, 0, r4, c15, c1, 0)
+	PJ4(mrc p15, 0, r4, c1, c0, 2)
+	PJ4(orr	r4, r4, #0x3)
+	PJ4(mcr	p15, 0, r4, c1, c0, 2)
+
 	mov	r0, #0				@ nothing to load
 	str	r0, [r3]			@ no more current owner
 	mrc	p15, 0, r2, c2, c0, 0
 	mov	r2, r2				@ cpwait
 	bl	concan_save
 
-	bic	r4, r4, #0x3			@ disable access to CP0 and CP1
-	mcr	p15, 0, r4, c15, c1, 0
+	@ disable access to CP0 and CP1
+	XSC(bic	r4, r4, #0x3)
+	XSC(mcr	p15, 0, r4, c15, c1, 0)
+	PJ4(bic	r4, r4, #0xf)
+	PJ4(mcr	p15, 0, r4, c1, c0, 2)
+
 	mrc	p15, 0, r2, c2, c0, 0
 	mov	r2, r2				@ cpwait
 
@@ -277,8 +300,11 @@ ENTRY(iwmmxt_task_restore)
  */
 ENTRY(iwmmxt_task_switch)
 
-	mrc	p15, 0, r1, c15, c1, 0
-	tst	r1, #0x3			@ CP0 and CP1 accessible?
+	XSC(mrc	p15, 0, r1, c15, c1, 0)
+	PJ4(mrc	p15, 0, r1, c1, c0, 2)
+	@ CP0 and CP1 accessible?
+	XSC(tst	r1, #0x3)
+	PJ4(tst	r1, #0xf)
 	bne	1f				@ yes: block them for next task
 
 	ldr	r2, =concan_owner
@@ -287,8 +313,11 @@ ENTRY(iwmmxt_task_switch)
 	teq	r2, r3				@ next task owns it?
 	movne	pc, lr				@ no: leave Concan disabled
 
-1:	eor	r1, r1, #3			@ flip Concan access
-	mcr	p15, 0, r1, c15, c1, 0
+1:	@ flip Conan access
+	XSC(eor	r1, r1, #0x3)
+	XSC(mcr	p15, 0, r1, c15, c1, 0)
+	PJ4(eor r1, r1, #0xf)
+	PJ4(mcr	p15, 0, r1, c1, c0, 2)
 
 	mrc	p15, 0, r1, c2, c0, 0
 	sub	pc, lr, r1, lsr #32		@ cpwait and return
-- 
1.5.6.5
