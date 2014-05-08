From: arjun.kv@samsung.com (Arjun.K.V)
Date: Thu, 08 May 2014 11:25:08 +0530
Subject: [PATCH] ARM: mm: Add workaround for erratum 763126
Message-ID: <1399528508-2806-1-git-send-email-arjun.kv@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Arjun.K.V" <arjun.kv@samsung.com>

Three processor exclusive access livelock.
In a system with three or more coherent masters that all use
the ldrex/strex synchronization primitives to access a semaphore
in coherent cacheable memory, there is a possibility of a
livelock condition where two masters continuously attempt
and fail to get the lock while the third master
continuously reads the lock.

Workaround is to set the "Snoop-delayed exclusive handling"
bit in the Auxiliary Control Register, ACTLR[31] to 1.
This hardware is installed in each processor to detect
that the load/store exclusive livelock scenario may be occurring
and delay snoops for a period of time to allow the load
exclusive/store exclusive loop to complete and make
forward progress.

Change-Id: Idcf066e25ea6571a0f5da6f3a770318c1a9d6fff
Signed-off-by: Arjun.K.V <arjun.kv@samsung.com>
---
 arch/arm/Kconfig      |   13 +++++++++++++
 arch/arm/mm/proc-v7.S |   43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index db3c541..80b8562 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1464,6 +1464,19 @@ source "drivers/pci/pcie/Kconfig"
 
 source "drivers/pcmcia/Kconfig"
 
+config ARM_ERRATA_763126
+	bool "ARM errata: Three processor exclusive access livelock"
+	depends on CPU_V7 && SMP
+	help
+	  This enables the workaround got ARM Erratum 763126.
+	  In a system with three or more coherent masters that all use the
+	  ldrex/strex synchronization primitives to access a semaphore in
+	  coherent cacheable memory, there is a possibility of a livelock
+	  condition where two masters continuously attempt and fail to get
+	  the lock while the third master continuously reads the lock.
+	  Workaround is to set the "Snoop-delayed exclusive handling" bit
+	  in the Auxiliary Control Register, ACTLR[31] to 1.
+
 endmenu
 
 menu "Kernel Features"
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 195731d..e6d22c7 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -136,6 +136,29 @@ ENTRY(cpu_v7_do_resume)
 	mcr	p15, 0, r7, c2, c0, 1	@ TTB 1
 #endif
 	mcr	p15, 0, r11, c2, c0, 2	@ TTB control register
+
+#ifdef CONFIG_ARM_ERRATA_763126
+	mrc	p15, 0, r0, c0, c0, 0	@ Check if we are A15s
+	ubfx	r1, r0, #4, #12
+	ldr	r2, =0x00000c0f
+	teq	r1, r2
+	bne	6f
+	and	r1, r0, #0x00f00000
+	and	r2, r0, #0x0000000f
+	orr	r2, r2, r1, lsr #20-4
+	cmp	r2, #0x20		@ Is the revision < r2p0
+	blt	6f			@ If so, skip
+	mrc	p15, 1, r0, c9, c0, 2	@ read L2 Control register
+	and	r1, r0, #0x03000000
+	cmp	r1, #0x02000000		@ less than 3 A15 cores?
+	blt	6f			@ if yes, erratum doesnt apply
+	/* Read and set auxiliary register */
+	mrc	p15, 0, r0, c1, c0, 1	@ Read Auxiliary control register
+	orr	r0, r0, #(0x1 << 31)	@ Set ACTLR[31] bit
+	mcr	p15, 0, r0, c1, c0, 1	@ Write to Auxiliary control register
+
+6:
+#endif
 	ldr	r4, =PRRR		@ PRRR
 	ldr	r5, =NMRR		@ NMRR
 	mcr	p15, 0, r4, c10, c2, 0	@ write PRRR
@@ -350,6 +373,26 @@ __v7_setup:
 	mcrle	p15, 0, r10, c1, c0, 1		@ write aux control register
 #endif
 
+#ifdef CONFIG_ARM_ERRATA_763126
+	/*
+	 * Add workaround for 763126, by setting the ACTLR[31] = 1.
+	 * This bit enables Snoop-delayed exclusive handling feature,
+	 * which delay snoops for a period of time to allow the
+	 * load exclusive/store exclusive loop to complete
+	 * and make forward progress.
+	 * The resume path setting is taken care in cpu_v7_do_resume
+	 */
+	cmp	r6, #0x20			@ present from r2p0 onwards
+	blt	5f
+	mrc	p15, 1, r0, c9, c0, 2		@ read L2 Control register
+	and	r1, r0, #0x03000000
+	cmp	r1, #0x02000000			@ less than 3 A15 cores?
+	blt	5f				@ if yes, erratum doesnt apply
+	mrc	p15, 0, r5, c1, c0, 1		@ read Auxiliary Control register
+	orr	r5, r5, #(0x1 << 31)
+	mcr	p15, 0, r5, c1, c0, 1		@ set Auxiliary Control register
+5:
+#endif
 4:	mov	r10, #0
 	mcr	p15, 0, r10, c7, c5, 0		@ I+BTB cache invalidate
 #ifdef CONFIG_MMU
-- 
1.7.9.5
