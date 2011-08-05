From: bs14@csr.com (Barry Song)
Date: Thu, 4 Aug 2011 19:54:48 -0700
Subject: [RFC PATCH 2/2] ARM: CSR: add PM sleep entry for SiRFprimaII
In-Reply-To: <1312512888-25070-1-git-send-email-bs14@csr.com>
References: <1312512888-25070-1-git-send-email-bs14@csr.com>
Message-ID: <1312512888-25070-3-git-send-email-bs14@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rongjun Ying <rongjun.ying@csr.com>

Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
Signed-off-by: Barry Song <baohua.song@csr.com>
---
 arch/arm/mach-prima2/Makefile |    1 +
 arch/arm/mach-prima2/common.h |    1 +
 arch/arm/mach-prima2/l2x0.c   |   34 ++++---
 arch/arm/mach-prima2/pm.c     |  139 ++++++++++++++++++++++++
 arch/arm/mach-prima2/pm.h     |   32 ++++++
 arch/arm/mach-prima2/sleep.S  |  238 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 431 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm/mach-prima2/pm.c
 create mode 100644 arch/arm/mach-prima2/pm.h
 create mode 100644 arch/arm/mach-prima2/sleep.S

diff --git a/arch/arm/mach-prima2/Makefile b/arch/arm/mach-prima2/Makefile
index f49d70b..f69b24e 100644
--- a/arch/arm/mach-prima2/Makefile
+++ b/arch/arm/mach-prima2/Makefile
@@ -6,3 +6,4 @@ obj-y += prima2.o
 obj-y += rtciobrg.o
 obj-$(CONFIG_DEBUG_LL) += lluart.o
 obj-$(CONFIG_CACHE_L2X0) += l2x0.o
+obj-$(CONFIG_PM_SLEEP) += sleep.o pm.o
diff --git a/arch/arm/mach-prima2/common.h b/arch/arm/mach-prima2/common.h
index 83e5d21..894e361 100644
--- a/arch/arm/mach-prima2/common.h
+++ b/arch/arm/mach-prima2/common.h
@@ -16,6 +16,7 @@ extern struct sys_timer sirfsoc_timer;
 
 extern void __init sirfsoc_of_irq_init(void);
 extern void __init sirfsoc_of_clk_init(void);
+extern void sirfsoc_l2x_init(void);
 
 #ifndef CONFIG_DEBUG_LL
 static inline void sirfsoc_map_lluart(void)  {}
diff --git a/arch/arm/mach-prima2/l2x0.c b/arch/arm/mach-prima2/l2x0.c
index 9cda205..adc9840 100644
--- a/arch/arm/mach-prima2/l2x0.c
+++ b/arch/arm/mach-prima2/l2x0.c
@@ -18,25 +18,14 @@
 #define L2X0_ADDR_FILTERING_START       0xC00
 #define L2X0_ADDR_FILTERING_END         0xC04
 
+void __iomem *sirfsoc_l2x_base;
+
 static struct of_device_id l2x_ids[]  = {
 	{ .compatible = "arm,pl310-cache" },
 };
 
-static int __init sirfsoc_of_l2x_init(void)
+void sirfsoc_l2x_init(void)
 {
-	struct device_node *np;
-	void __iomem *sirfsoc_l2x_base;
-
-	np = of_find_matching_node(NULL, l2x_ids);
-	if (!np)
-		panic("unable to find compatible l2x node in dtb\n");
-
-	sirfsoc_l2x_base = of_iomap(np, 0);
-	if (!sirfsoc_l2x_base)
-		panic("unable to map l2x cpu registers\n");
-
-	of_node_put(np);
-
 	if (!(readl_relaxed(sirfsoc_l2x_base + L2X0_CTRL) & 1)) {
 		/*
 		 * set the physical memory windows L2 cache will cover
@@ -53,6 +42,23 @@ static int __init sirfsoc_of_l2x_init(void)
 	}
 	l2x0_init((void __iomem *)sirfsoc_l2x_base, 0x00040000,
 		0x00000000);
+}
+
+static int __init sirfsoc_of_l2x_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, l2x_ids);
+	if (!np)
+		panic("unable to find compatible l2x node in dtb\n");
+
+	sirfsoc_l2x_base = of_iomap(np, 0);
+	if (!sirfsoc_l2x_base)
+		panic("unable to map l2x cpu registers\n");
+
+	of_node_put(np);
+
+	sirfsoc_l2x_init();
 
 	return 0;
 }
diff --git a/arch/arm/mach-prima2/pm.c b/arch/arm/mach-prima2/pm.c
new file mode 100644
index 0000000..bae7241
--- /dev/null
+++ b/arch/arm/mach-prima2/pm.c
@@ -0,0 +1,139 @@
+/*
+ * power management entry for CSR SiRFprimaII
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/suspend.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/io.h>
+#include <linux/rtc/sirfsoc_rtciobrg.h>
+
+#include "common.h"
+#include "pm.h"
+
+static u32 sirfsoc_pwrc_base;
+void __iomem *sirfsoc_memc_base;
+
+static void sirfsoc_set_wakeup_source(void)
+{
+        u32 pwr_trigger_en_reg;
+        pwr_trigger_en_reg = sirfsoc_rtc_iobrg_readl(sirfsoc_pwrc_base +
+		SIRFSOC_PWRC_TRIGGER_EN);
+#define X_ON_KEY_B (1 << 0)
+        sirfsoc_rtc_iobrg_writel(pwr_trigger_en_reg | X_ON_KEY_B,
+                        sirfsoc_pwrc_base + SIRFSOC_PWRC_TRIGGER_EN);
+}
+
+static void sirfsoc_set_sleep_mode(u32 mode)
+{
+        u32 sleep_mode = sirfsoc_rtc_iobrg_readl(sirfsoc_pwrc_base +
+		SIRFSOC_PWRC_PDN_CTRL);
+        sleep_mode &= ~(SIRFSOC_SLEEP_MODE_MASK << 1);
+        sleep_mode |= ((mode << 1));
+        sirfsoc_rtc_iobrg_writel(sleep_mode, sirfsoc_pwrc_base +
+		SIRFSOC_PWRC_PDN_CTRL);
+}
+
+int sirfsoc_pre_suspend_power_off(void)
+{
+	u32 wakeup_entry = virt_to_phys(sirfsoc_get_wakeup_pointer());
+
+	sirfsoc_rtc_iobrg_writel(wakeup_entry,
+		SIRFSOC_PWRC_SCRATCH_PAD1);
+
+	sirfsoc_set_wakeup_source();
+
+	sirfsoc_set_sleep_mode(SIRFSOC_DEEP_SLEEP_MODE);
+
+	return 0;
+}
+
+static void sirfsoc_save_register(u32 *ptr)
+{
+	/* todo: save necessary system registers here */
+}
+
+static void sirfsoc_restore_regs(u32 *ptr)
+{
+	/* todo: restore saved system registers here */
+}
+
+static int sirfsoc_pm_enter(suspend_state_t state)
+{
+	u32 *saved_regs;
+
+	saved_regs = kmalloc(1024, GFP_ATOMIC);
+	if (!saved_regs)
+		return -ENOMEM;
+
+	sirfsoc_save_register(saved_regs);
+	sirfsoc_sleep();
+#ifdef CONFIG_CACHE_L2X0
+	sirfsoc_l2x_init();
+#endif
+	sirfsoc_restore_regs(saved_regs);
+	kfree(saved_regs);
+
+	return 0;
+}
+
+static const struct platform_suspend_ops sirfsoc_pm_ops = {
+	.enter = sirfsoc_pm_enter,
+	.valid = suspend_valid_only_mem,
+};
+
+static struct of_device_id pwrc_ids[] = {
+	{ .compatible = "sirf,prima2-pwrc" },
+};
+
+static void __init sirfsoc_of_pwrc_init(void)
+{
+	struct device_node *np;
+	const __be32    *addrp;
+
+	np = of_find_matching_node(NULL, pwrc_ids);
+	if (!np)
+		panic("unable to find compatible pwrc node in dtb\n");
+
+	addrp = of_get_property(np, "reg", NULL);
+	if (!addrp)
+		panic("unable to find base address of pwrc node in dtb\n");
+
+	sirfsoc_pwrc_base = be32_to_cpup(addrp);
+
+	of_node_put(np);
+}
+
+static struct of_device_id memc_ids[] = {
+	{ .compatible = "sirf,prima2-memc" },
+};
+
+static void __init sirfsoc_of_memc_map(void)
+{
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, memc_ids);
+	if (!np)
+		panic("unable to find compatible memc node in dtb\n");
+
+	sirfsoc_memc_base = of_iomap(np, 0);
+	if (!np)
+		panic("unable to map compatible memc node in dtb\n");
+
+	of_node_put(np);
+}
+
+static int __init sirfsoc_pm_init(void)
+{
+	sirfsoc_of_memc_map();
+	sirfsoc_of_pwrc_init();
+	suspend_set_ops(&sirfsoc_pm_ops);
+	return 0;
+}
+late_initcall(sirfsoc_pm_init);
+
diff --git a/arch/arm/mach-prima2/pm.h b/arch/arm/mach-prima2/pm.h
new file mode 100644
index 0000000..ba85d4b
--- /dev/null
+++ b/arch/arm/mach-prima2/pm.h
@@ -0,0 +1,32 @@
+/*
+ * arch/arm/plat-sirfsoc/pm.h
+ *
+ * Copyright (C) 2011 CSR
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef _MACH_PRIMA2_PM_H_
+#define _MACH_PRIMA2_PM_H_
+
+#define SIRFSOC_PWR_SLEEPFORCE		0x01
+
+#define SIRFSOC_SLEEP_MODE_MASK         0x3
+#define SIRFSOC_DEEP_SLEEP_MODE         0x1
+
+#define SIRFSOC_PWRC_PDN_CTRL           0x0
+#define SIRFSOC_PWRC_PON_OFF            0x4
+#define SIRFSOC_PWRC_TRIGGER_EN         0x8
+#define SIRFSOC_PWRC_PIN_STATUS         0x14
+#define SIRFSOC_PWRC_SCRATCH_PAD1       0x18
+#define SIRFSOC_PWRC_SCRATCH_PAD2       0x1C
+
+#ifndef __ASSEMBLY__
+extern void sirfsoc_sleep(void);
+extern u32 *sirfsoc_get_wakeup_pointer(void);
+#endif
+
+#endif
+
diff --git a/arch/arm/mach-prima2/sleep.S b/arch/arm/mach-prima2/sleep.S
new file mode 100644
index 0000000..b8ef1ca
--- /dev/null
+++ b/arch/arm/mach-prima2/sleep.S
@@ -0,0 +1,238 @@
+/*
+ * sleep mode for CSR SiRFprimaII
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/linkage.h>
+#include <asm/ptrace.h>
+#include <asm/assembler.h>
+#include <asm/hardware/cache-l2x0.h>
+
+#include "pm.h"
+
+#define DENALI_CTL_22_OFF	0x58
+#define DENALI_CTL_112_OFF	0x1c0
+
+ENTRY(sirfsoc_get_wakeup_pointer)
+	stmfd	sp!, {lr}	@ save registers on stack
+	adr	r0, sirfsoc_wakeup
+	ldmfd	sp!, {pc}	@ restore regs and return
+
+ENTRY(sirfsoc_sleep)
+sirfsoc_sleep:
+	stmdb  sp!, {r0-r12, lr}		@ Push SVC state onto our stack
+
+	mrc     p15, 0, r2, c1, c0, 1           @ cp15 c1 auxiliary Control register
+	mrc     p15, 0, r3, c1, c0, 2           @ cp15 c1 coprocessor access control register
+	mrc     p15, 0, r4, c2, c0, 0           @ cp15 c2_r0 translation table base resigter 0
+	mrc     p15, 0, r5, c2, c0, 1          	@ cp15 c2_r1 translation table base resigter 1
+
+	mrc     p15, 0, r6, c2, c0, 2          	@ cp15 c2_r2 translation table base control resigter
+
+	mrc     p15, 0, r7, c3, c0, 0           @ load r2 with domain access control.
+	mrc     p15, 0, r8, c1, c0, 0           @ MMU Control
+	mrc	p15, 0, r9, c10,c2, 0		@ cp15 PRRR register
+	mrc     p15, 0, r10, c10,c2, 1		@ cp15 NMRR register
+	mov	r11, sp
+	ldr	r0, =save_context
+	add	r0, r0, #124
+	stmdb	r0!, {r2-r11}			@ Save CP15 and the SP to stack
+
+	mov     r1, #FIQ_MODE|PSR_I_BIT|PSR_F_BIT 	@ Enter FIQ mode, no interrupts
+	msr     cpsr, r1
+	mrs     r2, spsr
+	stmdb   r0!, {r2, r8-r12, sp, lr}      	@ store the FIQ Mode Registers
+
+	mov     r1, #ABT_MODE|PSR_I_BIT|PSR_F_BIT 	@ Enter ABT mode, no interrupts
+	msr     cpsr, r1
+	mrs     r2, spsr
+	stmdb   r0!, {r2, sp, lr}               @ store the ABT Mode Registers
+
+	mov     r1, #IRQ_MODE|PSR_I_BIT|PSR_F_BIT 	@ Enter IRQ mode, no interrupts
+	msr     cpsr, r1
+	mrs     r2, spsr
+	stmdb   r0!, {r2, sp, lr}               @ store the IRQ Mode Registers
+
+	mov     r1, #UND_MODE|PSR_I_BIT|PSR_F_BIT 	@ Enter UND mode, no interrupts
+	msr     cpsr, r1
+	mrs     r2, spsr
+	stmdb   r0!, {r2, sp, lr}               @ store the UND Mode Registers
+
+	mov     r1, #SYSTEM_MODE|PSR_I_BIT|PSR_F_BIT 	@ Enter SYS mode, no interrupts
+	msr     cpsr, r1
+	mrs     r2, spsr
+	stmdb   r0!, {r2, sp, lr}               @ store the SYS Mode Registers
+
+	mov     r1, #SVC_MODE|PSR_I_BIT|PSR_F_BIT @ Enter SVC mode, no interrupts
+	msr	cpsr, r1
+
+	ldr     r1, =save_context                  @ Get address of label save_sp in r1
+	sub	r0, r0, r1
+	str     r0, [r1]                      @ Store context offset to label memory
+
+	bl      sirfsoc_pre_suspend_power_off
+	cmp     r0,#0
+	bne     sirfsoc_sleep_exit
+
+	@ r5: 	mem controller
+	ldr     r0, =sirfsoc_memc_base
+	ldr	r5, [r0]
+	@ r7: 	rtc iobrg controller
+	ldr     r0, =sirfsoc_rtciobrg_base
+	ldr	r7, [r0]
+
+	@ Clean and invalidate all caches
+	bl v7_flush_kern_cache_all
+
+#ifdef CONFIG_CACHE_L2X0
+	ldr	r1, =sirfsoc_l2x_base
+	ldr     r0, [r1]
+	ldr	r1, =L2X0_CLEAN_INV_WAY
+	mov	r2, #0xff
+	str	r2, [r0,r1]
+	mov	r2, #0
+1:
+	ldr	r3, [r0,r1]
+	cmp	r2,r3
+	bne	1b
+	ldr	r1, =L2X0_CACHE_SYNC
+	mov	r2, #0
+	str	r2, [r0,r1]
+
+	ldr	r1, =L2X0_CTRL
+	mov	r2, #0
+	str	r2, [r0,r1]
+#endif
+
+	@ Read the power control register and set the
+	@ sleep force bit.
+	ldr	r0, =SIRFSOC_PWRC_PDN_CTRL
+	bl	__sirfsoc_rtc_iobrg_readl
+	orr	r0,r0,#SIRFSOC_PWR_SLEEPFORCE
+	ldr	r1, =SIRFSOC_PWRC_PDN_CTRL
+	bl	sirfsoc_rtc_iobrg_pre_writel
+	mov	r1, #0x1
+
+	@ The following code is arranged in such a way
+	@ that the code to be run after memory is put
+	@ into self refresh fits in a cache line (32 bytes).
+	@ This is done to make sure the code runs from
+	@ cache after memory is put into self refresh.
+
+	@ read the MEM ctl register and set the self
+	@ refresh bit
+
+	ldr	r2, [r5, #DENALI_CTL_22_OFF]
+	orr	r2, r2, #0x1
+
+	@ Following code has to run from cache since
+	@ the RAM is going to self refresh mode
+	.align 5
+	str	r2, [r5, #DENALI_CTL_22_OFF]
+
+1:
+	ldr	r4, [r5, #DENALI_CTL_112_OFF]
+	tst	r4, #0x1
+	bne	1b
+
+	@ write SLEEPFORCE through rtc iobridge
+
+	str	r1, [r7]
+	@ wait rtc io bridge sync
+1:
+	ldr	r3, [r7]
+	tst	r3, #0x01
+	bne	1b
+	b .
+
+	@ bootloader will jump here on wakeup
+
+	.align 5
+.globl sirfsoc_wakeup
+sirfsoc_wakeup:
+
+	mov r4, #0
+        mcr p15,0,r4,c8,c7,0            @invalid all unified tlb
+        mcr p15,0,r4,c8,c6,0            @invalid all data tlb
+        mcr p15,0,r4,c8,c5,0            @invalid all instruction tlb
+        mcr p15,0,r4,c7,c5,4            @flush prefetch buffer
+        mcr p15,0,r4,c7,c10,4           @Drain write buffer
+	mcr p15,0,r4,c7,c5,0		@invalid instruction cache
+
+	mov	r0, #PSR_I_BIT | PSR_F_BIT | SVC_MODE
+	msr	cpsr, r0			@ set SVC, irqs off
+
+	@ Get save_context phys address
+	ldr	r1, =save_context
+	ldr	r3, =(.+12)
+	sub	r3, r3, pc
+	sub	r1, r1, r3
+	ldr	r0, [r1]
+
+	add	r0, r0, r1
+
+	mov     r1, #SYSTEM_MODE|PSR_I_BIT|PSR_F_BIT 	@ Enter SYS mode, no interrupts
+	msr     cpsr, r1
+	ldmfd   r0!, {r2, sp, lr}               @ store the SYS Mode Registers
+	msr     spsr, r2
+
+	mov     r1, #UND_MODE|PSR_I_BIT|PSR_F_BIT 	@ Enter UND mode, no interrupts
+	msr     cpsr, r1
+	ldmfd   r0!, {r2, sp, lr}               @ store the UND Mode Registers
+	msr     spsr, r2
+
+	mov     r1, #IRQ_MODE|PSR_I_BIT|PSR_F_BIT 	@ Enter IRQ mode, no interrupts
+	msr     cpsr, r1
+	ldmfd   r0!, {r2, sp, lr}               @ store the IRQ Mode Registers
+	msr     spsr, r2
+
+	mov     r1, #ABT_MODE|PSR_I_BIT|PSR_F_BIT 	@ Enter ABT mode, no interrupts
+	msr     cpsr, r1
+	ldmfd   r0!, {r2, sp, lr}               @ store the ABT Mode Registers
+	msr     spsr, r2
+
+	mov     r1, #FIQ_MODE|PSR_I_BIT|PSR_F_BIT 	@ Enter FIQ mode, no interrupts
+	msr     cpsr, r1
+	ldmfd   r0!, {r2, r8-r12,sp, lr}     	@ store the FIQ Mode Registers
+	msr     spsr, r2
+
+	mov     r1, #SVC_MODE|PSR_I_BIT|PSR_F_BIT 	@ Enter SVC mode, no interrupts
+	msr	cpsr, r1
+
+	ldr	r1, =sirfsoc_sleep_exit		@ its absolute virtual address
+	ldmfd	r0, {r2 - r10, sp}		@ CP regs + virt stack ptr
+
+	mcr     p15, 0, r7, c3, c0, 0           @ load r2 with domain access control.
+	mcr     p15, 0, r6, c2, c0, 2          	@ cp15 c2_r2 translation table base control resigter
+	mcr     p15, 0, r4, c2, c0, 0           @ cp15 c2_r0 translation table base resigter 0
+	mcr     p15, 0, r5, c2, c0, 1          	@ cp15 c2_r1 translation table base resigter 1
+
+	mcr     p15, 0, r3, c1, c0, 2           @ cp15 c1 coprocessor access control register
+	mcr     p15, 0, r2, c1, c0, 1           @ cp15 c1 auxiliary Control register
+	mcr	p15, 0, r10, c10,c2, 1		@ cp15 NMRR register
+	mcr	p15, 0, r9, C10,c2, 0		@ cp15 PRRR register
+	b	resume_turn_on_mmu		@ cache align execution
+
+	.align 5
+resume_turn_on_mmu:
+	mcr     p15, 0, r8, c1, c0, 0           @ MMU Control
+	nop
+	mov	pc, r1				@ jump to virtual addr
+	nop
+	nop
+	nop
+
+sirfsoc_sleep_exit:
+	ldmfd	sp!, {r0 - r12, pc}		@ return to caller
+	/* back to caller of sleep */
+	nop
+	nop
+	nop
+@	.data
+	.align 5
+save_context:
+	.space 128,0
+
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
