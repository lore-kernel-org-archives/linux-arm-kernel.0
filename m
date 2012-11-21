From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 21 Nov 2012 17:00:15 +0100
Subject: [PATCH V7 4/5] arm: mm: Add support for PJ4B cpu and init routines
In-Reply-To: <1353513616-10139-1-git-send-email-gregory.clement@free-electrons.com>
References: <1353513616-10139-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1353513616-10139-5-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PJ4B is an implementation of the ARMv7 (such as the Cortex A9 for
example) released by Marvell. This CPU is currently found in
Armada 370 and Armada XP SoCs. This patch provides a support for the
specific initialization of this CPU.

Signed-off-by: Yehuda Yitschak <yehuday@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mach-mvebu/Kconfig |    2 +-
 arch/arm/mm/Kconfig         |    4 +++
 arch/arm/mm/proc-v7.S       |   67 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 79299cd..f4c3bf8 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -21,7 +21,7 @@ menu "Marvell SOC with device tree"
 config MACH_ARMADA_370_XP
 	bool
 	select ARMADA_370_XP_TIMER
-	select CPU_V7
+	select CPU_PJ4B
 
 config MACH_ARMADA_370
 	bool "Marvell Armada 370 boards"
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 94186b6..3fd629d 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -352,6 +352,10 @@ config CPU_PJ4
 	select ARM_THUMBEE
 	select CPU_V7
 
+config CPU_PJ4B
+	bool
+	select CPU_V7
+
 # ARMv6
 config CPU_V6
 	bool "Support ARM V6 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 846d279..7cd0028 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -169,6 +169,63 @@ __v7_ca15mp_setup:
 	orreq	r0, r0, r10			@ Enable CPU-specific SMP bits
 	mcreq	p15, 0, r0, c1, c0, 1
 #endif
+
+__v7_pj4b_setup:
+#ifdef CONFIG_CPU_PJ4B
+
+/* Auxiliary Debug Modes Control 1 Register */
+#define PJ4B_STATIC_BP (1 << 2) /* Enable Static BP */
+#define PJ4B_INTER_PARITY (1 << 8) /* Disable Internal Parity Handling */
+#define PJ4B_BCK_OFF_STREX (1 << 5) /* Enable the back off of STREX instr */
+#define PJ4B_CLEAN_LINE (1 << 16) /* Disable data transfer for clean line */
+
+/* Auxiliary Debug Modes Control 2 Register */
+#define PJ4B_FAST_LDR (1 << 23) /* Disable fast LDR */
+#define PJ4B_SNOOP_DATA (1 << 25) /* Do not interleave write and snoop data */
+#define PJ4B_CWF (1 << 27) /* Disable Critical Word First feature */
+#define PJ4B_OUTSDNG_NC (1 << 29) /* Disable outstanding non cacheable rqst */
+#define PJ4B_L1_REP_RR (1 << 30) /* L1 replacement - Strict round robin */
+#define PJ4B_AUX_DBG_CTRL2 (PJ4B_SNOOP_DATA | PJ4B_CWF |\
+			    PJ4B_OUTSDNG_NC | PJ4B_L1_REP_RR)
+
+/* Auxiliary Functional Modes Control Register 0 */
+#define PJ4B_SMP_CFB (1 << 1) /* Set SMP mode. Join the coherency fabric */
+#define PJ4B_L1_PAR_CHK (1 << 2) /* Support L1 parity checking */
+#define PJ4B_BROADCAST_CACHE (1 << 8) /* Broadcast Cache and TLB maintenance */
+
+/* Auxiliary Debug Modes Control 0 Register */
+#define PJ4B_WFI_WFE (1 << 22) /* WFI/WFE - serve the DVM and back to idle */
+
+	/* Auxiliary Debug Modes Control 1 Register */
+	mrc	p15, 1,	r0, c15, c1, 1
+	orr     r0, r0, #PJ4B_CLEAN_LINE
+	orr     r0, r0, #PJ4B_BCK_OFF_STREX
+	orr     r0, r0, #PJ4B_INTER_PARITY
+	bic	r0, r0, #PJ4B_STATIC_BP
+	mcr	p15, 1,	r0, c15, c1, 1
+
+	/* Auxiliary Debug Modes Control 2 Register */
+	mrc	p15, 1,	r0, c15, c1, 2
+	bic	r0, r0, #PJ4B_FAST_LDR
+	orr	r0, r0, #PJ4B_AUX_DBG_CTRL2
+	mcr	p15, 1,	r0, c15, c1, 2
+
+	/* Auxiliary Functional Modes Control Register 0 */
+	mrc	p15, 1,	r0, c15, c2, 0
+#ifdef CONFIG_SMP
+	orr	r0, r0, #PJ4B_SMP_CFB
+#endif
+	orr	r0, r0, #PJ4B_L1_PAR_CHK
+	orr	r0, r0, #PJ4B_BROADCAST_CACHE
+	mcr	p15, 1,	r0, c15, c2, 0
+
+	/* Auxiliary Debug Modes Control 0 Register */
+	mrc	p15, 1,	r0, c15, c1, 0
+	orr	r0, r0, #PJ4B_WFI_WFE
+	mcr	p15, 1,	r0, c15, c1, 0
+
+#endif /* CONFIG_CPU_PJ4B */
+
 __v7_setup:
 	adr	r12, __v7_setup_stack		@ the local stack
 	stmia	r12, {r0-r5, r7, r9, r11, lr}
@@ -342,6 +399,16 @@ __v7_ca9mp_proc_info:
 	.long	0xff0ffff0
 	__v7_proc __v7_ca9mp_setup
 	.size	__v7_ca9mp_proc_info, . - __v7_ca9mp_proc_info
+
+	/*
+	 * Marvell PJ4B processor.
+	 */
+	.type   __v7_pj4b_proc_info, #object
+__v7_pj4b_proc_info:
+	.long	0x562f5840
+	.long	0xfffffff0
+	__v7_proc __v7_pj4b_setup
+	.size	__v7_pj4b_proc_info, . - __v7_pj4b_proc_info
 #endif	/* CONFIG_ARM_LPAE */
 
 	/*
-- 
1.7.9.5
