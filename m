From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 22 Oct 2012 19:02:46 +0200
Subject: [PATCH 4/5] arm: mm: Added support for PJ4B cpu and init routines
In-Reply-To: <1350925368-24243-1-git-send-email-gregory.clement@free-electrons.com>
References: <1350925368-24243-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1350925368-24243-5-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yehuda Yitschak <yehuday@marvell.com>

Signed-off-by: Yehuda Yitschak <yehuday@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/Kconfig |    2 +-
 arch/arm/mm/Kconfig         |    4 ++++
 arch/arm/mm/proc-v7.S       |   43 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 17d246b..9bfaa0c 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -22,7 +22,7 @@ config MVEBU_CLK_CPU
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
index 846d279..1a373c2 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -169,6 +169,39 @@ __v7_ca15mp_setup:
 	orreq	r0, r0, r10			@ Enable CPU-specific SMP bits
 	mcreq	p15, 0, r0, c1, c0, 1
 #endif
+
+__v7_pj4b_setup:
+#ifdef CONFIG_CPU_PJ4B
+	/* Auxiliary Debug Modes Control 1 Register */
+	mrc	p15, 1,	r0, c15, c1, 1
+	orr	r0, r0, #(1 << 16)     @ Disable data transfer for clean line.
+	orr	r0, r0, #(1 << 5)      @ Enable the back off of STREX instr
+	orr	r0, r0, #(1 << 8)      @ Disable Internal Parity Handling
+	bic	r0, r0, #(1 << 2)      @ Disable Static BP
+	mcr	p15, 1,	r0, c15, c1, 1
+
+	/* Auxiliary Debug Modes Control 2 Register */
+	mrc	p15, 1,	r0, c15, c1, 2
+	bic	r0, r0, #(1 << 23)   @ Enable fast LDR.
+	orr	r0, r0, #(1 << 25)   @ Dont interleave write and snoop data.
+	orr	r0, r0, #(1 << 27)   @ Disable Critical Word First feature.
+	orr	r0, r0, #(1 << 29)   @ Disable outstanding non cacheable request
+	orr	r0, r0, #(1 << 30)   @ L1 replacement - Strict round robin
+	mcr	p15, 1,	r0, c15, c1, 2
+
+	/* Auxiliary Functional Modes Control Register 0 */
+	mrc	p15, 1,	r0, c15, c2, 0
+	orr	r0, r0, #(1 << 2)     @ Support L1 parity checking
+	orr	r0, r0, #(1 << 8)     @ Broadcast Cache and TLB maintenance
+	mcr	p15, 1,	r0, c15, c2, 0
+
+	/* Auxiliary Debug Modes Control 0 Register */
+	mrc	p15, 1,	r0, c15, c1, 0
+	orr	r0, r0, #(1 << 22)   @ WFI/WFE - serve the DVM and back to idle
+	mcr	p15, 1,	r0, c15, c1, 0
+
+#endif /* CONFIG_CPU_PJ4B */
+
 __v7_setup:
 	adr	r12, __v7_setup_stack		@ the local stack
 	stmia	r12, {r0-r5, r7, r9, r11, lr}
@@ -342,6 +375,16 @@ __v7_ca9mp_proc_info:
 	.long	0xff0ffff0
 	__v7_proc __v7_ca9mp_setup
 	.size	__v7_ca9mp_proc_info, . - __v7_ca9mp_proc_info
+
+	/*
+	 * Marvell PJ4B processor.
+	 */
+	.type   __v7_pj4b_proc_info, #object
+__v7_pj4b_proc_info:
+	.long	0x562f5842
+	.long	0xffffffff
+	__v7_proc __v7_pj4b_setup
+	.size	__v7_pj4b_proc_info, . - __v7_pj4b_proc_info
 #endif	/* CONFIG_ARM_LPAE */
 
 	/*
-- 
1.7.9.5
