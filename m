From: digetx@gmail.com (Dmitry Osipenko)
Date: Wed, 18 Mar 2015 18:55:55 +0300
Subject: [PATCH] ARM: tegra: Maintain CPU endianness for asm code
Message-ID: <1426694170-6866-1-git-send-email-digetx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for big-endian CPU mode to assembler code, which is
required for booting secondary CPU's, cpuidle drivers and machine suspend/resume
functionality with big-endian kernel.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Tested on Tegra 2 and 3.

 arch/arm/mach-tegra/reset-handler.S | 13 +++++++++++++
 arch/arm/mach-tegra/sleep-tegra20.S | 16 +++++++++++++++-
 arch/arm/mach-tegra/sleep-tegra30.S |  9 +++++++++
 arch/arm/mach-tegra/sleep.S         |  1 +
 arch/arm/mach-tegra/sleep.h         |  3 +++
 5 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index e3070fd..38f8fe0 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -19,6 +19,7 @@
 
 #include <soc/tegra/fuse.h>
 
+#include <asm/assembler.h>
 #include <asm/asm-offsets.h>
 #include <asm/cache.h>
 
@@ -43,6 +44,9 @@
  *	r8: CPU part number
  */
 ENTRY(tegra_resume)
+
+ARM_BE8(setend	be)
+
 	check_cpu_part_num 0xc09, r8, r9
 	bleq	v7_invalidate_l1
 
@@ -59,12 +63,14 @@ ENTRY(tegra_resume)
 	cpu_to_csr_reg r1, r0
 	mov32	r2, TEGRA_FLOW_CTRL_BASE
 	ldr	r1, [r2, r1]
+ARM_BE8(rev	r1, r1)
 	/* Clear event & intr flag */
 	orr	r1, r1, \
 		#FLOW_CTRL_CSR_INTR_FLAG | FLOW_CTRL_CSR_EVENT_FLAG
 	movw	r0, #0x3FFD	@ enable, cluster_switch, immed, bitmaps
 				@ & ext flags for CPU power mgnt
 	bic	r1, r1, r0
+ARM_BE8(rev	r1, r1)
 	str	r1, [r2]
 1:
 
@@ -75,7 +81,9 @@ ENTRY(tegra_resume)
 	/* enable SCU */
 	mov32	r0, TEGRA_ARM_PERIF_BASE
 	ldr	r1, [r0]
+ARM_BE8(rev	r1, r1)
 	orr	r1, r1, #1
+ARM_BE8(rev	r1, r1)
 	str	r1, [r0]
 #endif
 
@@ -118,6 +126,8 @@ ENTRY(__tegra_cpu_reset_handler_start)
 	.align L1_CACHE_SHIFT
 ENTRY(__tegra_cpu_reset_handler)
 
+ARM_BE8(setend	be)
+
 	cpsid	aif, 0x13			@ SVC mode, interrupts disabled
 
 	tegra_get_soc_id TEGRA_APB_MISC_BASE, r6
@@ -222,6 +232,9 @@ __no_cpu0_chk:
  */
 
 __die:
+
+ARM_BE8(setend	le)
+
 	sub	lr, lr, #4
 	mov32	r7, TEGRA_PMC_BASE
 	str	lr, [r7, #PMC_SCRATCH41]
diff --git a/arch/arm/mach-tegra/sleep-tegra20.S b/arch/arm/mach-tegra/sleep-tegra20.S
index e6b684e..0785b83 100644
--- a/arch/arm/mach-tegra/sleep-tegra20.S
+++ b/arch/arm/mach-tegra/sleep-tegra20.S
@@ -105,12 +105,14 @@ ENTRY(tegra20_cpu_shutdown)
 	cpu_to_halt_reg r1, r0
 	ldr	r3, =TEGRA_FLOW_CTRL_VIRT
 	mov	r2, #FLOW_CTRL_WAITEVENT | FLOW_CTRL_JTAG_RESUME
+ARM_BE8(rev	r2, r2)
 	str	r2, [r3, r1]		@ put flow controller in wait event mode
 	ldr	r2, [r3, r1]
 	isb
 	dsb
 	movw	r1, 0x1011
 	mov	r1, r1, lsl r0
+ARM_BE8(rev	r1, r1)
 	ldr	r3, =TEGRA_CLK_RESET_VIRT
 	str	r1, [r3, #0x340]	@ put slave CPU in reset
 	isb
@@ -155,13 +157,18 @@ ENTRY(tegra_pen_lock)
 	addne	r3, r3, #PMC_SCRATCH38
 
 	mov	r12, #1
+ARM_BE8(rev	r12, r12)
 	str	r12, [r2]		@ flag[cpu] = 1
 	dsb
 	str	r12, [r1]		@ !turn = cpu
 1:	dsb
 	ldr	r12, [r3]
+ARM_BE8(rev	r12, r12)
 	cmp	r12, #1			@ flag[!cpu] == 1?
-	ldreq	r12, [r1]
+	bne	2f
+	ldr	r12, [r1]
+ARM_BE8(rev	r12, r12)
+2:
 	cmpeq	r12, r0			@ !turn == cpu?
 	beq	1b			@ while !turn == cpu && flag[!cpu] == 1
 
@@ -337,6 +344,9 @@ tegra20_iram_start:
  * NOTE: THIS *MUST* BE RELOCATED TO TEGRA_IRAM_LPx_RESUME_AREA.
  */
 ENTRY(tegra20_lp1_reset)
+
+ARM_BE8(setend	le)
+
 	/*
 	 * The CPU and system bus are running at 32KHz and executing from
 	 * IRAM when this code is executed; immediately switch to CLKM and
@@ -360,8 +370,10 @@ ENTRY(tegra20_lp1_reset)
 	mov	r5, #0
 
 	ldr	r6, tegra20_sdram_pad_size
+ARM_BE8(rev	r6, r6)
 padload:
 	ldr	r7, [r2, r5]		@ r7 is the addr in the pad_address
+ARM_BE8(rev	r7, r7)
 
 	ldr	r1, [r4, r5]
 	str	r1, [r7]		@ restore the value in pad_save
@@ -521,8 +533,10 @@ emcself:
 	mov	r5, #0
 
 	ldr	r6, tegra20_sdram_pad_size
+ARM_BE8(rev	r6, r6)
 padsave:
 	ldr	r0, [r2, r5]		@ r0 is the addr in the pad_address
+ARM_BE8(rev	r0, r0)
 
 	ldr	r1, [r0]
 	str	r1, [r4, r5]		@ save the content of the addr
diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index 5d8d13a..821c6df 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -184,6 +184,7 @@ _no_cpu0_chk:
  ARM(	orr	r12, r12, r4, lsl r3	)
  THUMB(	lsl	r4, r4, r3		)
  THUMB(	orr	r12, r12, r4		)
+ARM_BE8(rev	r12, r12)
 	str	r12, [r1]
 
 	/* Halt this CPU. */
@@ -210,8 +211,10 @@ flow_ctrl_setting_for_lp2:
 	orrne	r3, r3, #FLOW_CTRL_HALT_GIC_FIQ
 flow_ctrl_done:
 	cmp	r10, #TEGRA30
+ARM_BE8(rev	r3, r3)
 	str	r3, [r2]
 	ldr	r0, [r2]
+ARM_BE8(rev	r0, r0)
 	b	wfe_war
 
 __cpu_reset_again:
@@ -319,6 +322,9 @@ tegra30_iram_start:
  * NOTE: THIS *MUST* BE RELOCATED TO TEGRA_IRAM_LPx_RESUME_AREA.
  */
 ENTRY(tegra30_lp1_reset)
+
+ARM_BE8(setend	le)
+
 	/*
 	 * The CPU and system bus are running at 32KHz and executing from
 	 * IRAM when this code is executed; immediately switch to CLKM and
@@ -722,11 +728,13 @@ tegra30_sdram_self_refresh:
 	cmp	r10, #TEGRA124
 	adreq	r2, tegra124_sdram_pad_address
 	ldreq	r3, tegra30_sdram_pad_size
+ARM_BE8(rev	r3, r3)
 
 	mov	r9, #0
 
 padsave:
 	ldr	r0, [r2, r9]		@ r0 is the addr in the pad_address
+ARM_BE8(rev	r0, r0)
 
 	ldr	r1, [r0]
 	str	r1, [r8, r9]		@ save the content of the addr
@@ -744,6 +752,7 @@ padsave_done:
 	ldreq	r0, =TEGRA_EMC0_BASE
 	cmp	r10, #TEGRA124
 	ldreq	r0, =TEGRA124_EMC_BASE
+ARM_BE8(rev	r0, r0)
 
 enter_self_refresh:
 	cmp	r10, #TEGRA30
diff --git a/arch/arm/mach-tegra/sleep.S b/arch/arm/mach-tegra/sleep.S
index f024a51..1fd201f 100644
--- a/arch/arm/mach-tegra/sleep.S
+++ b/arch/arm/mach-tegra/sleep.S
@@ -139,6 +139,7 @@ ENTRY(tegra_shut_off_mmu)
 	moveq	r3, #0
 	streq	r3, [r2, #L2X0_CTRL]
 #endif
+ARM_BE8(setend	le)
 	ret	r0
 ENDPROC(tegra_shut_off_mmu)
 	.popsection
diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
index 0d59360..fa7aba4 100644
--- a/arch/arm/mach-tegra/sleep.h
+++ b/arch/arm/mach-tegra/sleep.h
@@ -118,8 +118,11 @@
 /* Macro to check Tegra revision */
 #define APB_MISC_GP_HIDREV	0x804
 .macro tegra_get_soc_id base, tmp1
+ARM_BE8(mrc	p15, 0, \tmp1, c1, c0)
+ARM_BE8(tst	\tmp1, #(1 << 7))		@ check for little-endian bit
 	mov32	\tmp1, \base
 	ldr	\tmp1, [\tmp1, #APB_MISC_GP_HIDREV]
+ARM_BE8(revne	\tmp1, \tmp1)
 	and	\tmp1, \tmp1, #0xff00
 	mov	\tmp1, \tmp1, lsr #8
 .endm
-- 
2.3.2
