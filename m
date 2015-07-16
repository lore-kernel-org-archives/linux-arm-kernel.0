From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 16 Jul 2015 11:08:11 +0300
Subject: =?UTF-8?q?=5BPATCH=5D=20ARM=3A=20OMAP3=3A=20clock=3A=20remove=20un-used=20core=20dpll=20re-program=20code?=
Message-ID: <1437034091-18306-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the OMAP3 core DPLL re-program code, and the associated SRAM
code that does the low-level programming of the DPLL divider, idling
of the SDRAM etc.

This code was never fully implemented in the kernel; things missing
were driver side handling of core clock changes (they need to account
for their functional clock rate being changed on-the-fly), and the whole
framework required for handling this. Thus, there is not much point
to keep carrying the low-level support code either.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile           |    3 +-
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c |  119 -----------
 arch/arm/mach-omap2/sram.c             |   25 ---
 arch/arm/mach-omap2/sram.h             |   14 --
 arch/arm/mach-omap2/sram34xx.S         |  346 --------------------------------
 5 files changed, 1 insertion(+), 506 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/clkt34xx_dpll3m2.c
 delete mode 100644 arch/arm/mach-omap2/sram34xx.S

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 903c85b..66129b6 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -49,7 +49,6 @@ AFLAGS_sleep44xx.o			:=-Wa,-march=armv7-a$(plus_sec)
 # Functions loaded to SRAM
 obj-$(CONFIG_SOC_OMAP2420)		+= sram242x.o
 obj-$(CONFIG_SOC_OMAP2430)		+= sram243x.o
-obj-$(CONFIG_ARCH_OMAP3)		+= sram34xx.o
 
 AFLAGS_sram242x.o			:=-Wa,-march=armv6
 AFLAGS_sram243x.o			:=-Wa,-march=armv6
@@ -188,7 +187,7 @@ obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_virt_prcm_set.o
 obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_dpll.o clkt_iclk.o
 obj-$(CONFIG_SOC_OMAP2430)		+= clock2430.o
 obj-$(CONFIG_ARCH_OMAP3)		+= $(clock-common) clock3xxx.o
-obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o clkt34xx_dpll3m2.o
+obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clock3517.o clock36xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= dpll3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clkt_iclk.o
diff --git a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
deleted file mode 100644
index eb69acf..0000000
--- a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
+++ /dev/null
@@ -1,119 +0,0 @@
-/*
- * OMAP34xx M2 divider clock code
- *
- * Copyright (C) 2007-2008 Texas Instruments, Inc.
- * Copyright (C) 2007-2010 Nokia Corporation
- *
- * Paul Walmsley
- * Jouni H?gander
- *
- * Parts of this code are based on code written by
- * Richard Woodruff, Tony Lindgren, Tuukka Tikkanen, Karthik Dasu
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#undef DEBUG
-
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-
-#include "clock.h"
-#include "clock3xxx.h"
-#include "clock34xx.h"
-#include "sdrc.h"
-#include "sram.h"
-
-#define CYCLES_PER_MHZ			1000000
-
-/*
- * CORE DPLL (DPLL3) M2 divider rate programming functions
- *
- * These call into SRAM code to do the actual CM writes, since the SDRAM
- * is clocked from DPLL3.
- */
-
-/**
- * omap3_core_dpll_m2_set_rate - set CORE DPLL M2 divider
- * @clk: struct clk * of DPLL to set
- * @rate: rounded target rate
- *
- * Program the DPLL M2 divider with the rounded target rate.  Returns
- * -EINVAL upon error, or 0 upon success.
- */
-int omap3_core_dpll_m2_set_rate(struct clk_hw *hw, unsigned long rate,
-					unsigned long parent_rate)
-{
-	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
-	u32 new_div = 0;
-	u32 unlock_dll = 0;
-	u32 c;
-	unsigned long validrate, sdrcrate, _mpurate;
-	struct omap_sdrc_params *sdrc_cs0;
-	struct omap_sdrc_params *sdrc_cs1;
-	int ret;
-	unsigned long clkrate;
-
-	if (!clk || !rate)
-		return -EINVAL;
-
-	validrate = omap2_clksel_round_rate_div(clk, rate, &new_div);
-	if (validrate != rate)
-		return -EINVAL;
-
-	sdrcrate = __clk_get_rate(sdrc_ick_p);
-	clkrate = __clk_get_rate(hw->clk);
-	if (rate > clkrate)
-		sdrcrate <<= ((rate / clkrate) >> 1);
-	else
-		sdrcrate >>= ((clkrate / rate) >> 1);
-
-	ret = omap2_sdrc_get_params(sdrcrate, &sdrc_cs0, &sdrc_cs1);
-	if (ret)
-		return -EINVAL;
-
-	if (sdrcrate < MIN_SDRC_DLL_LOCK_FREQ) {
-		pr_debug("clock: will unlock SDRC DLL\n");
-		unlock_dll = 1;
-	}
-
-	/*
-	 * XXX This only needs to be done when the CPU frequency changes
-	 */
-	_mpurate = __clk_get_rate(arm_fck_p) / CYCLES_PER_MHZ;
-	c = (_mpurate << SDRC_MPURATE_SCALE) >> SDRC_MPURATE_BASE_SHIFT;
-	c += 1;  /* for safety */
-	c *= SDRC_MPURATE_LOOPS;
-	c >>= SDRC_MPURATE_SCALE;
-	if (c == 0)
-		c = 1;
-
-	pr_debug("clock: changing CORE DPLL rate from %lu to %lu\n",
-		 clkrate, validrate);
-	pr_debug("clock: SDRC CS0 timing params used: RFR %08x CTRLA %08x CTRLB %08x MR %08x\n",
-		 sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
-		 sdrc_cs0->actim_ctrlb, sdrc_cs0->mr);
-	if (sdrc_cs1)
-		pr_debug("clock: SDRC CS1 timing params used: RFR %08x CTRLA %08x CTRLB %08x MR %08x\n",
-			 sdrc_cs1->rfr_ctrl, sdrc_cs1->actim_ctrla,
-			 sdrc_cs1->actim_ctrlb, sdrc_cs1->mr);
-
-	if (sdrc_cs1)
-		omap3_configure_core_dpll(
-				  new_div, unlock_dll, c, rate > clkrate,
-				  sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
-				  sdrc_cs0->actim_ctrlb, sdrc_cs0->mr,
-				  sdrc_cs1->rfr_ctrl, sdrc_cs1->actim_ctrla,
-				  sdrc_cs1->actim_ctrlb, sdrc_cs1->mr);
-	else
-		omap3_configure_core_dpll(
-				  new_div, unlock_dll, c, rate > clkrate,
-				  sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
-				  sdrc_cs0->actim_ctrlb, sdrc_cs0->mr,
-				  0, 0, 0, 0);
-	return 0;
-}
-
diff --git a/arch/arm/mach-omap2/sram.c b/arch/arm/mach-omap2/sram.c
index cd488b8..83d0e61 100644
--- a/arch/arm/mach-omap2/sram.c
+++ b/arch/arm/mach-omap2/sram.c
@@ -211,35 +211,10 @@ static inline int omap243x_sram_init(void)
 
 #ifdef CONFIG_ARCH_OMAP3
 
-static u32 (*_omap3_sram_configure_core_dpll)(
-			u32 m2, u32 unlock_dll, u32 f, u32 inc,
-			u32 sdrc_rfr_ctrl_0, u32 sdrc_actim_ctrl_a_0,
-			u32 sdrc_actim_ctrl_b_0, u32 sdrc_mr_0,
-			u32 sdrc_rfr_ctrl_1, u32 sdrc_actim_ctrl_a_1,
-			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
-
-u32 omap3_configure_core_dpll(u32 m2, u32 unlock_dll, u32 f, u32 inc,
-			u32 sdrc_rfr_ctrl_0, u32 sdrc_actim_ctrl_a_0,
-			u32 sdrc_actim_ctrl_b_0, u32 sdrc_mr_0,
-			u32 sdrc_rfr_ctrl_1, u32 sdrc_actim_ctrl_a_1,
-			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1)
-{
-	BUG_ON(!_omap3_sram_configure_core_dpll);
-	return _omap3_sram_configure_core_dpll(
-			m2, unlock_dll, f, inc,
-			sdrc_rfr_ctrl_0, sdrc_actim_ctrl_a_0,
-			sdrc_actim_ctrl_b_0, sdrc_mr_0,
-			sdrc_rfr_ctrl_1, sdrc_actim_ctrl_a_1,
-			sdrc_actim_ctrl_b_1, sdrc_mr_1);
-}
-
 void omap3_sram_restore_context(void)
 {
 	omap_sram_reset();
 
-	_omap3_sram_configure_core_dpll =
-		omap_sram_push(omap3_sram_configure_core_dpll,
-			       omap3_sram_configure_core_dpll_sz);
 	omap_push_sram_idle();
 }
 
diff --git a/arch/arm/mach-omap2/sram.h b/arch/arm/mach-omap2/sram.h
index 948d3ed..18dc884 100644
--- a/arch/arm/mach-omap2/sram.h
+++ b/arch/arm/mach-omap2/sram.h
@@ -15,12 +15,6 @@ extern void omap2_sram_reprogram_sdrc(u32 perf_level, u32 dll_val,
 				      u32 mem_type);
 extern u32 omap2_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val, int bypass);
 
-extern u32 omap3_configure_core_dpll(
-			u32 m2, u32 unlock_dll, u32 f, u32 inc,
-			u32 sdrc_rfr_ctrl_0, u32 sdrc_actim_ctrl_a_0,
-			u32 sdrc_actim_ctrl_b_0, u32 sdrc_mr_0,
-			u32 sdrc_rfr_ctrl_1, u32 sdrc_actim_ctrl_a_1,
-			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
 extern void omap3_sram_restore_context(void);
 
 /* Do not use these */
@@ -52,14 +46,6 @@ extern void omap243x_sram_reprogram_sdrc(u32 perf_level, u32 dll_val,
 						u32 mem_type);
 extern unsigned long omap243x_sram_reprogram_sdrc_sz;
 
-extern u32 omap3_sram_configure_core_dpll(
-			u32 m2, u32 unlock_dll, u32 f, u32 inc,
-			u32 sdrc_rfr_ctrl_0, u32 sdrc_actim_ctrl_a_0,
-			u32 sdrc_actim_ctrl_b_0, u32 sdrc_mr_0,
-			u32 sdrc_rfr_ctrl_1, u32 sdrc_actim_ctrl_a_1,
-			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
-extern unsigned long omap3_sram_configure_core_dpll_sz;
-
 #ifdef CONFIG_PM
 extern void omap_push_sram_idle(void);
 #else
diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
deleted file mode 100644
index 1446331..0000000
--- a/arch/arm/mach-omap2/sram34xx.S
+++ /dev/null
@@ -1,346 +0,0 @@
-/*
- * linux/arch/arm/mach-omap3/sram.S
- *
- * Omap3 specific functions that need to be run in internal SRAM
- *
- * Copyright (C) 2004, 2007, 2008 Texas Instruments, Inc.
- * Copyright (C) 2008 Nokia Corporation
- *
- * Rajendra Nayak <rnayak@ti.com>
- * Richard Woodruff <r-woodruff2@ti.com>
- * Paul Walmsley
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR /PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
- * MA 02111-1307 USA
- */
-#include <linux/linkage.h>
-
-#include <asm/assembler.h>
-
-#include "soc.h"
-#include "iomap.h"
-#include "sdrc.h"
-#include "cm3xxx.h"
-
-/*
- * This file needs be built unconditionally as ARM to interoperate correctly
- * with non-Thumb-2-capable firmware.
- */
-	.arm
-
-	.text
-
-/* r1 parameters */
-#define SDRC_NO_UNLOCK_DLL		0x0
-#define SDRC_UNLOCK_DLL			0x1
-
-/* SDRC_DLLA_CTRL bit settings */
-#define FIXEDDELAY_SHIFT		24
-#define FIXEDDELAY_MASK			(0xff << FIXEDDELAY_SHIFT)
-#define DLLIDLE_MASK			0x4
-
-/*
- * SDRC_DLLA_CTRL default values: TI hardware team indicates that
- * FIXEDDELAY should be initialized to 0xf.  This apparently was
- * empirically determined during process testing, so no derivation
- * was provided.
- */
-#define FIXEDDELAY_DEFAULT		(0x0f << FIXEDDELAY_SHIFT)
-
-/* SDRC_DLLA_STATUS bit settings */
-#define LOCKSTATUS_MASK			0x4
-
-/* SDRC_POWER bit settings */
-#define SRFRONIDLEREQ_MASK		0x40
-
-/* CM_IDLEST1_CORE bit settings */
-#define ST_SDRC_MASK			0x2
-
-/* CM_ICLKEN1_CORE bit settings */
-#define EN_SDRC_MASK			0x2
-
-/* CM_CLKSEL1_PLL bit settings */
-#define CORE_DPLL_CLKOUT_DIV_SHIFT	0x1b
-
-/*
- * omap3_sram_configure_core_dpll - change DPLL3 M2 divider
- *
- * Params passed in registers:
- *  r0 = new M2 divider setting (only 1 and 2 supported right now)
- *  r1 = unlock SDRC DLL? (1 = yes, 0 = no).  Only unlock DLL for
- *      SDRC rates < 83MHz
- *  r2 = number of MPU cycles to wait for SDRC to stabilize after
- *      reprogramming the SDRC when switching to a slower MPU speed
- *  r3 = increasing SDRC rate? (1 = yes, 0 = no)
- *
- * Params passed via the stack. The needed params will be copied in SRAM
- *  before use by the code in SRAM (SDRAM is not accessible during SDRC
- *  reconfiguration):
- *  new SDRC_RFR_CTRL_0 register contents
- *  new SDRC_ACTIM_CTRL_A_0 register contents
- *  new SDRC_ACTIM_CTRL_B_0 register contents
- *  new SDRC_MR_0 register value
- *  new SDRC_RFR_CTRL_1 register contents
- *  new SDRC_ACTIM_CTRL_A_1 register contents
- *  new SDRC_ACTIM_CTRL_B_1 register contents
- *  new SDRC_MR_1 register value
- *
- * If the param SDRC_RFR_CTRL_1 is 0, the parameters are not programmed into
- * the SDRC CS1 registers
- *
- * NOTE: This code no longer attempts to program the SDRC AC timing and MR
- * registers.  This is because the code currently cannot ensure that all
- * L3 initiators (e.g., sDMA, IVA, DSS DISPC, etc.) are not accessing the
- * SDRAM when the registers are written.  If the registers are changed while
- * an initiator is accessing SDRAM, memory can be corrupted and/or the SDRC
- * may enter an unpredictable state.  In the future, the intent is to
- * re-enable this code in cases where we can ensure that no initiators are
- * touching the SDRAM.  Until that time, users who know that their use case
- * can satisfy the above requirement can enable the CONFIG_OMAP3_SDRC_AC_TIMING
- * option.
- *
- * Richard Woodruff notes that any changes to this code must be carefully
- * audited and tested to ensure that they don't cause a TLB miss while
- * the SDRAM is inaccessible.  Such a situation will crash the system
- * since it will cause the ARM MMU to attempt to walk the page tables.
- * These crashes may be intermittent.
- */
-	.align	3
-ENTRY(omap3_sram_configure_core_dpll)
-	stmfd	sp!, {r1-r12, lr}	@ store regs to stack
-
-					@ pull the extra args off the stack
-					@  and store them in SRAM
-
-/*
- * PC-relative stores are deprecated in ARMv7 and lead to undefined behaviour
- * in Thumb-2: use a r7 as a base instead.
- * Be careful not to clobber r7 when maintaing this file.
- */
- THUMB(	adr	r7, omap3_sram_configure_core_dpll			)
-	.macro strtext Rt:req, label:req
- ARM(	str	\Rt, \label						)
- THUMB(	str	\Rt, [r7, \label - omap3_sram_configure_core_dpll]	)
-	.endm
-
-	ldr	r4, [sp, #52]
-	strtext	r4, omap_sdrc_rfr_ctrl_0_val
-	ldr	r4, [sp, #56]
-	strtext	r4, omap_sdrc_actim_ctrl_a_0_val
-	ldr	r4, [sp, #60]
-	strtext	r4, omap_sdrc_actim_ctrl_b_0_val
-	ldr	r4, [sp, #64]
-	strtext	r4, omap_sdrc_mr_0_val
-	ldr	r4, [sp, #68]
-	strtext	r4, omap_sdrc_rfr_ctrl_1_val
-	cmp	r4, #0			@ if SDRC_RFR_CTRL_1 is 0,
-	beq	skip_cs1_params		@  do not use cs1 params
-	ldr	r4, [sp, #72]
-	strtext	r4, omap_sdrc_actim_ctrl_a_1_val
-	ldr	r4, [sp, #76]
-	strtext	r4, omap_sdrc_actim_ctrl_b_1_val
-	ldr	r4, [sp, #80]
-	strtext	r4, omap_sdrc_mr_1_val
-skip_cs1_params:
-	mrc	p15, 0, r8, c1, c0, 0	@ read ctrl register
-	bic	r10, r8, #0x800		@ clear Z-bit, disable branch prediction
-	mcr	p15, 0, r10, c1, c0, 0	@ write ctrl register
-	dsb				@ flush buffered writes to interconnect
-	isb				@ prevent speculative exec past here
-	cmp	r3, #1			@ if increasing SDRC clk rate,
-	bleq	configure_sdrc		@ program the SDRC regs early (for RFR)
-	cmp	r1, #SDRC_UNLOCK_DLL	@ set the intended DLL state
-	bleq	unlock_dll
-	blne	lock_dll
-	bl	sdram_in_selfrefresh	@ put SDRAM in self refresh, idle SDRC
-	bl 	configure_core_dpll	@ change the DPLL3 M2 divider
-	mov	r12, r2
-	bl	wait_clk_stable		@ wait for SDRC to stabilize
-	bl	enable_sdrc		@ take SDRC out of idle
-	cmp	r1, #SDRC_UNLOCK_DLL	@ wait for DLL status to change
-	bleq	wait_dll_unlock
-	blne	wait_dll_lock
-	cmp	r3, #1			@ if increasing SDRC clk rate,
-	beq	return_to_sdram		@ return to SDRAM code, otherwise,
-	bl	configure_sdrc		@ reprogram SDRC regs now
-return_to_sdram:
-	mcr	p15, 0, r8, c1, c0, 0	@ restore ctrl register
-	isb				@ prevent speculative exec past here
-	mov 	r0, #0 			@ return value
-	ldmfd	sp!, {r1-r12, pc}	@ restore regs and return
-unlock_dll:
-	ldr	r11, omap3_sdrc_dlla_ctrl
-	ldr	r12, [r11]
-	bic	r12, r12, #FIXEDDELAY_MASK
-	orr	r12, r12, #FIXEDDELAY_DEFAULT
-	orr	r12, r12, #DLLIDLE_MASK
-	str	r12, [r11]		@ (no OCP barrier needed)
-	bx	lr
-lock_dll:
-	ldr	r11, omap3_sdrc_dlla_ctrl
-	ldr	r12, [r11]
-	bic	r12, r12, #DLLIDLE_MASK
-	str	r12, [r11]		@ (no OCP barrier needed)
-	bx	lr
-sdram_in_selfrefresh:
-	ldr	r11, omap3_sdrc_power	@ read the SDRC_POWER register
-	ldr	r12, [r11]		@ read the contents of SDRC_POWER
-	mov	r9, r12			@ keep a copy of SDRC_POWER bits
-	orr 	r12, r12, #SRFRONIDLEREQ_MASK	@ enable self refresh on idle
-	str 	r12, [r11]		@ write back to SDRC_POWER register
-	ldr	r12, [r11]		@ posted-write barrier for SDRC
-idle_sdrc:
-	ldr	r11, omap3_cm_iclken1_core	@ read the CM_ICLKEN1_CORE reg
-	ldr	r12, [r11]
-	bic	r12, r12, #EN_SDRC_MASK		@ disable iclk bit for SDRC
-	str 	r12, [r11]
-wait_sdrc_idle:
-	ldr 	r11, omap3_cm_idlest1_core
-	ldr 	r12, [r11]
-	and 	r12, r12, #ST_SDRC_MASK		@ check for SDRC idle
-	cmp 	r12, #ST_SDRC_MASK
-	bne 	wait_sdrc_idle
-	bx 	lr
-configure_core_dpll:
-	ldr 	r11, omap3_cm_clksel1_pll
-	ldr	r12, [r11]
-	ldr	r10, core_m2_mask_val	@ modify m2 for core dpll
-	and	r12, r12, r10
-	orr	r12, r12, r0, lsl #CORE_DPLL_CLKOUT_DIV_SHIFT
-	str	r12, [r11]
-	ldr	r12, [r11]		@ posted-write barrier for CM
-	bx	lr
-wait_clk_stable:
-	subs 	r12, r12, #1
-	bne	wait_clk_stable
-	bx	lr
-enable_sdrc:
-	ldr 	r11, omap3_cm_iclken1_core
-	ldr	r12, [r11]
-	orr 	r12, r12, #EN_SDRC_MASK		@ enable iclk bit for SDRC
-	str 	r12, [r11]
-wait_sdrc_idle1:
-	ldr 	r11, omap3_cm_idlest1_core
-	ldr	r12, [r11]
-	and 	r12, r12, #ST_SDRC_MASK
-	cmp	r12, #0
-	bne	wait_sdrc_idle1
-restore_sdrc_power_val:
-	ldr	r11, omap3_sdrc_power
-	str	r9, [r11]		@ restore SDRC_POWER, no barrier needed
-	bx	lr
-wait_dll_lock:
-	ldr	r11, omap3_sdrc_dlla_status
-	ldr	r12, [r11]
-	and 	r12, r12, #LOCKSTATUS_MASK
-	cmp	r12, #LOCKSTATUS_MASK
-	bne	wait_dll_lock
-	bx	lr
-wait_dll_unlock:
-	ldr	r11, omap3_sdrc_dlla_status
-	ldr	r12, [r11]
-	and	r12, r12, #LOCKSTATUS_MASK
-	cmp	r12, #0x0
-	bne	wait_dll_unlock
-	bx	lr
-configure_sdrc:
-	ldr	r12, omap_sdrc_rfr_ctrl_0_val	@ fetch value from SRAM
-	ldr	r11, omap3_sdrc_rfr_ctrl_0	@ fetch addr from SRAM
-	str	r12, [r11]			@ store
-#ifdef CONFIG_OMAP3_SDRC_AC_TIMING
-	ldr	r12, omap_sdrc_actim_ctrl_a_0_val
-	ldr	r11, omap3_sdrc_actim_ctrl_a_0
-	str	r12, [r11]
-	ldr	r12, omap_sdrc_actim_ctrl_b_0_val
-	ldr	r11, omap3_sdrc_actim_ctrl_b_0
-	str	r12, [r11]
-	ldr	r12, omap_sdrc_mr_0_val
-	ldr	r11, omap3_sdrc_mr_0
-	str	r12, [r11]
-#endif
-	ldr	r12, omap_sdrc_rfr_ctrl_1_val
-	cmp	r12, #0			@ if SDRC_RFR_CTRL_1 is 0,
-	beq	skip_cs1_prog		@  do not program cs1 params
-	ldr	r11, omap3_sdrc_rfr_ctrl_1
-	str	r12, [r11]
-#ifdef CONFIG_OMAP3_SDRC_AC_TIMING
-	ldr	r12, omap_sdrc_actim_ctrl_a_1_val
-	ldr	r11, omap3_sdrc_actim_ctrl_a_1
-	str	r12, [r11]
-	ldr	r12, omap_sdrc_actim_ctrl_b_1_val
-	ldr	r11, omap3_sdrc_actim_ctrl_b_1
-	str	r12, [r11]
-	ldr	r12, omap_sdrc_mr_1_val
-	ldr	r11, omap3_sdrc_mr_1
-	str	r12, [r11]
-#endif
-skip_cs1_prog:
-	ldr	r12, [r11]		@ posted-write barrier for SDRC
-	bx	lr
-
-	.align
-omap3_sdrc_power:
-	.word OMAP34XX_SDRC_REGADDR(SDRC_POWER)
-omap3_cm_clksel1_pll:
-	.word OMAP34XX_CM_REGADDR(PLL_MOD, CM_CLKSEL1)
-omap3_cm_idlest1_core:
-	.word OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST)
-omap3_cm_iclken1_core:
-	.word OMAP34XX_CM_REGADDR(CORE_MOD, CM_ICLKEN1)
-
-omap3_sdrc_rfr_ctrl_0:
-	.word OMAP34XX_SDRC_REGADDR(SDRC_RFR_CTRL_0)
-omap3_sdrc_rfr_ctrl_1:
-	.word OMAP34XX_SDRC_REGADDR(SDRC_RFR_CTRL_1)
-omap3_sdrc_actim_ctrl_a_0:
-	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_A_0)
-omap3_sdrc_actim_ctrl_a_1:
-	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_A_1)
-omap3_sdrc_actim_ctrl_b_0:
-	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_B_0)
-omap3_sdrc_actim_ctrl_b_1:
-	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_B_1)
-omap3_sdrc_mr_0:
-	.word OMAP34XX_SDRC_REGADDR(SDRC_MR_0)
-omap3_sdrc_mr_1:
-	.word OMAP34XX_SDRC_REGADDR(SDRC_MR_1)
-omap_sdrc_rfr_ctrl_0_val:
-	.word 0xDEADBEEF
-omap_sdrc_rfr_ctrl_1_val:
-	.word 0xDEADBEEF
-omap_sdrc_actim_ctrl_a_0_val:
-	.word 0xDEADBEEF
-omap_sdrc_actim_ctrl_a_1_val:
-	.word 0xDEADBEEF
-omap_sdrc_actim_ctrl_b_0_val:
-	.word 0xDEADBEEF
-omap_sdrc_actim_ctrl_b_1_val:
-	.word 0xDEADBEEF
-omap_sdrc_mr_0_val:
-	.word 0xDEADBEEF
-omap_sdrc_mr_1_val:
-	.word 0xDEADBEEF
-
-omap3_sdrc_dlla_status:
-	.word OMAP34XX_SDRC_REGADDR(SDRC_DLLA_STATUS)
-omap3_sdrc_dlla_ctrl:
-	.word OMAP34XX_SDRC_REGADDR(SDRC_DLLA_CTRL)
-core_m2_mask_val:
-	.word 0x07FFFFFF
-ENDPROC(omap3_sram_configure_core_dpll)
-
-ENTRY(omap3_sram_configure_core_dpll_sz)
-	.word	. - omap3_sram_configure_core_dpll
-
-- 
1.7.9.5
