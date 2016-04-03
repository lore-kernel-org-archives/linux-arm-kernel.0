From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun,  3 Apr 2016 09:23:54 +0200
Subject: [PATCH 2/2] ARM: at91: pm: switch to the PIE infrastructure
In-Reply-To: <1459668234-16033-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1459668234-16033-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1459668234-16033-3-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using the PIE infrastructure allows to write the whole suspend/resume
functions in C instead of assembly.

The only remaining assembly instruction is wfi for armv5
It makes the code shorter and clearer.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/Kconfig       |   1 +
 arch/arm/mach-at91/Makefile      |   2 +-
 arch/arm/mach-at91/pm.c          |  31 ++--
 arch/arm/mach-at91/pm/.gitignore |   2 +
 arch/arm/mach-at91/pm/Makefile   |   3 +
 arch/arm/mach-at91/pm/atmel_pm.c |  97 +++++++++++
 arch/arm/mach-at91/pm_suspend.S  | 338 ---------------------------------------
 7 files changed, 114 insertions(+), 360 deletions(-)
 create mode 100644 arch/arm/mach-at91/pm/.gitignore
 create mode 100644 arch/arm/mach-at91/pm/Makefile
 create mode 100644 arch/arm/mach-at91/pm/atmel_pm.c
 delete mode 100644 arch/arm/mach-at91/pm_suspend.S

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 08047afdf38e..ab430c04a699 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -5,6 +5,7 @@ menuconfig ARCH_AT91
 	select COMMON_CLK_AT91
 	select PINCTRL
 	select SOC_BUS
+	select PIE
 
 if ARCH_AT91
 config SOC_SAMA5D2
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index c5bbf8bb8c0f..062336de4f66 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_SOC_SAMA5)		+= sama5.o
 
 # Power Management
 obj-$(CONFIG_PM)		+= pm.o
-obj-$(CONFIG_PM)		+= pm_suspend.o
+obj-$(CONFIG_PM)		+= pm/
 
 ifeq ($(CONFIG_CPU_V7),y)
 AFLAGS_pm_suspend.o := -march=armv7-a
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index f06270198bf1..f2f2a97ee1de 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -21,6 +21,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/of_address.h>
+#include <linux/pie.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/clk/at91_pmc.h>
@@ -56,6 +57,8 @@ static struct {
 
 void __iomem *at91_ramc_base[2];
 
+static struct pie_chunk *atmel_pm_pie;
+
 static int at91_pm_valid_state(suspend_state_t state)
 {
 	switch (state) {
@@ -133,10 +136,6 @@ EXPORT_SYMBOL(at91_suspend_entering_slow_clock);
 static void (*at91_suspend_sram_fn)(void __iomem *pmc, void __iomem *ramc0,
 			  void __iomem *ramc1, int memctrl);
 
-extern void at91_pm_suspend_in_sram(void __iomem *pmc, void __iomem *ramc0,
-			    void __iomem *ramc1, int memctrl);
-extern u32 at91_pm_suspend_in_sram_sz;
-
 static void at91_pm_suspend(suspend_state_t state)
 {
 	unsigned int pm_data = at91_pm_data.memctrl;
@@ -370,11 +369,12 @@ void at91sam9_idle(void)
 	cpu_do_idle();
 }
 
+extern void atmel_pm_suspend(void __iomem *pmc, void __iomem *ramc0,
+			     void __iomem *ramc1, int memctrl);
+
 static void __init at91_pm_sram_init(void)
 {
 	struct gen_pool *sram_pool;
-	phys_addr_t sram_pbase;
-	unsigned long sram_base;
 	struct device_node *node;
 	struct platform_device *pdev = NULL;
 
@@ -397,23 +397,12 @@ static void __init at91_pm_sram_init(void)
 		return;
 	}
 
-	sram_base = gen_pool_alloc(sram_pool, at91_pm_suspend_in_sram_sz);
-	if (!sram_base) {
-		pr_warn("%s: unable to alloc sram!\n", __func__);
+	atmel_pm_pie = pie_load_sections(sram_pool, atmel_pm,
+					 arch_arm_mach_at91_pm);
+	if (IS_ERR(atmel_pm_pie))
 		return;
-	}
-
-	sram_pbase = gen_pool_virt_to_phys(sram_pool, sram_base);
-	at91_suspend_sram_fn = __arm_ioremap_exec(sram_pbase,
-					at91_pm_suspend_in_sram_sz, false);
-	if (!at91_suspend_sram_fn) {
-		pr_warn("SRAM: Could not map\n");
-		return;
-	}
 
-	/* Copy the pm suspend handler to SRAM */
-	at91_suspend_sram_fn = fncpy(at91_suspend_sram_fn,
-			&at91_pm_suspend_in_sram, at91_pm_suspend_in_sram_sz);
+	at91_suspend_sram_fn = fn_to_pie(atmel_pm_pie, atmel_pm_suspend);
 }
 
 static const struct of_device_id atmel_pmc_ids[] __initconst = {
diff --git a/arch/arm/mach-at91/pm/.gitignore b/arch/arm/mach-at91/pm/.gitignore
new file mode 100644
index 000000000000..1cb8879eb0bf
--- /dev/null
+++ b/arch/arm/mach-at91/pm/.gitignore
@@ -0,0 +1,2 @@
+*.lds*
+*.syms
diff --git a/arch/arm/mach-at91/pm/Makefile b/arch/arm/mach-at91/pm/Makefile
new file mode 100644
index 000000000000..c12d54862c10
--- /dev/null
+++ b/arch/arm/mach-at91/pm/Makefile
@@ -0,0 +1,3 @@
+PIE_NAME := atmel_pm
+
+include arch/arm/pie/Makefile.pie
diff --git a/arch/arm/mach-at91/pm/atmel_pm.c b/arch/arm/mach-at91/pm/atmel_pm.c
new file mode 100644
index 000000000000..7f391addd2da
--- /dev/null
+++ b/arch/arm/mach-at91/pm/atmel_pm.c
@@ -0,0 +1,97 @@
+#include <linux/io.h>
+#include <linux/clk/at91_pmc.h>
+#include <linux/mfd/syscon/atmel-mc.h>
+#include <linux/pie.h>
+#include "../pm.h"
+
+#define	SRAMC_SELF_FRESH_ACTIVE		0x01
+#define	SRAMC_SELF_FRESH_EXIT		0x00
+
+static void at91_sramc_self_refresh(unsigned int is_active,
+				    unsigned int memtype,
+				    void __iomem *sdramc_base,
+				    void __iomem *sdramc_base1)
+{
+	static unsigned int lpr, mdr, lpr1, mdr1;
+
+	switch (memtype) {
+	case AT91_MEMCTRL_MC:
+	/*
+	 * at91rm9200 Memory controller
+	 */
+		if (is_active)
+			__raw_writel(1, sdramc_base + AT91_MC_SDRAMC_SRR);
+		break;
+
+	case AT91_MEMCTRL_DDRSDR:
+		if (is_active) {
+			mdr = __raw_readl(sdramc_base + AT91_DDRSDRC_MDR);
+			lpr = __raw_readl(sdramc_base + AT91_DDRSDRC_LPR);
+
+			if ((mdr & AT91_DDRSDRC_MD) == AT91_DDRSDRC_MD_LOW_POWER_DDR)
+				__raw_writel((mdr & ~AT91_DDRSDRC_MD) |
+					     AT91_DDRSDRC_MD_DDR2, sdramc_base +
+					     AT91_DDRSDRC_MDR);
+			__raw_writel((lpr & ~AT91_DDRSDRC_LPCB) |
+				     AT91_DDRSDRC_LPCB_SELF_REFRESH, sdramc_base
+				     + AT91_DDRSDRC_LPR);
+
+			if (sdramc_base1) {
+				mdr1 = __raw_readl(sdramc_base1 + AT91_DDRSDRC_MDR);
+				lpr1 = __raw_readl(sdramc_base1 + AT91_DDRSDRC_LPR);
+				if ((mdr1 & AT91_DDRSDRC_MD) == AT91_DDRSDRC_MD_LOW_POWER_DDR)
+					__raw_writel((mdr1 & ~AT91_DDRSDRC_MD) |
+						     AT91_DDRSDRC_MD_DDR2,
+						     sdramc_base1 +
+						     AT91_DDRSDRC_MDR);
+				__raw_writel((lpr1 & ~AT91_DDRSDRC_LPCB) |
+					     AT91_DDRSDRC_LPCB_SELF_REFRESH,
+					     sdramc_base1 + AT91_DDRSDRC_LPR);
+			}
+		} else {
+			__raw_writel(mdr, sdramc_base + AT91_DDRSDRC_MDR);
+			__raw_writel(lpr, sdramc_base + AT91_DDRSDRC_LPR);
+			if (sdramc_base1) {
+				__raw_writel(mdr, sdramc_base1 + AT91_DDRSDRC_MDR);
+				__raw_writel(lpr, sdramc_base1 + AT91_DDRSDRC_LPR);
+			}
+		}
+		break;
+
+	case AT91_MEMCTRL_SDRAMC:
+		if (is_active) {
+			lpr = __raw_readl(sdramc_base + AT91_SDRAMC_LPR);
+
+			__raw_writel((lpr & ~AT91_SDRAMC_LPCB) |
+				     AT91_SDRAMC_LPCB_SELF_REFRESH, sdramc_base
+				     + AT91_SDRAMC_LPR);
+		} else {
+			__raw_writel(lpr, sdramc_base + AT91_SDRAMC_LPR);
+		}
+		break;
+	}
+}
+
+void atmel_pm_suspend(void __iomem *pmc, void __iomem *ramc0,
+		      void __iomem *ramc1, int memctrl)
+{
+	int memtype, pm_mode;
+
+	memtype = memctrl & AT91_PM_MEMTYPE_MASK;
+	pm_mode = (memctrl >> AT91_PM_MODE_OFFSET) & AT91_PM_MODE_MASK;
+
+	dsb();
+
+	at91_sramc_self_refresh(1, memtype, ramc0, ramc1);
+
+#if defined(CONFIG_CPU_V7)
+	dsb();
+	wfi();
+#else
+	asm volatile ("mcr	p15, 0, %0, c7, c0, 4" \
+		      : : "r" (0) : "memory");
+#endif
+
+	at91_sramc_self_refresh(0, memtype, ramc0, ramc1);
+}
+EXPORT_PIE_SYMBOL(atmel_pm_suspend);
diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
deleted file mode 100644
index a25defda3d22..000000000000
--- a/arch/arm/mach-at91/pm_suspend.S
+++ /dev/null
@@ -1,338 +0,0 @@
-/*
- * arch/arm/mach-at91/pm_slow_clock.S
- *
- *  Copyright (C) 2006 Savin Zlobec
- *
- * AT91SAM9 support:
- *  Copyright (C) 2007 Anti Sullin <anti.sullin@artecdesign.ee
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-#include <linux/linkage.h>
-#include <linux/clk/at91_pmc.h>
-#include "pm.h"
-
-#define	SRAMC_SELF_FRESH_ACTIVE		0x01
-#define	SRAMC_SELF_FRESH_EXIT		0x00
-
-pmc	.req	r0
-tmp1	.req	r4
-tmp2	.req	r5
-
-/*
- * Wait until master clock is ready (after switching master clock source)
- */
-	.macro wait_mckrdy
-1:	ldr	tmp1, [pmc, #AT91_PMC_SR]
-	tst	tmp1, #AT91_PMC_MCKRDY
-	beq	1b
-	.endm
-
-/*
- * Wait until master oscillator has stabilized.
- */
-	.macro wait_moscrdy
-1:	ldr	tmp1, [pmc, #AT91_PMC_SR]
-	tst	tmp1, #AT91_PMC_MOSCS
-	beq	1b
-	.endm
-
-/*
- * Wait until PLLA has locked.
- */
-	.macro wait_pllalock
-1:	ldr	tmp1, [pmc, #AT91_PMC_SR]
-	tst	tmp1, #AT91_PMC_LOCKA
-	beq	1b
-	.endm
-
-/*
- * Put the processor to enter the idle state
- */
-	.macro at91_cpu_idle
-
-#if defined(CONFIG_CPU_V7)
-	mov	tmp1, #AT91_PMC_PCK
-	str	tmp1, [pmc, #AT91_PMC_SCDR]
-
-	dsb
-
-	wfi		@ Wait For Interrupt
-#else
-	mcr	p15, 0, tmp1, c7, c0, 4
-#endif
-
-	.endm
-
-	.text
-
-	.arm
-
-/*
- * void at91_pm_suspend_in_sram(void __iomem *pmc, void __iomem *sdramc,
- *			void __iomem *ramc1, int memctrl)
- * @input param:
- * 	@r0: base address of AT91_PMC
- *  	@r1: base address of SDRAM Controller (SDRAM, DDRSDR, or AT91_SYS)
- *	@r2: base address of second SDRAM Controller or 0 if not present
- *	@r3: pm information
- */
-/* at91_pm_suspend_in_sram must be 8-byte aligned per the requirements of fncpy() */
-	.align 3
-ENTRY(at91_pm_suspend_in_sram)
-	/* Save registers on stack */
-	stmfd	sp!, {r4 - r12, lr}
-
-	/* Drain write buffer */
-	mov	tmp1, #0
-	mcr	p15, 0, tmp1, c7, c10, 4
-
-	str	r0, .pmc_base
-	str	r1, .sramc_base
-	str	r2, .sramc1_base
-
-	and	r0, r3, #AT91_PM_MEMTYPE_MASK
-	str	r0, .memtype
-
-	lsr	r0, r3, #AT91_PM_MODE_OFFSET
-	and	r0, r0, #AT91_PM_MODE_MASK
-	str	r0, .pm_mode
-
-	/* Active the self-refresh mode */
-	mov	r0, #SRAMC_SELF_FRESH_ACTIVE
-	bl	at91_sramc_self_refresh
-
-	ldr	r0, .pm_mode
-	tst	r0, #AT91_PM_SLOW_CLOCK
-	beq	skip_disable_main_clock
-
-	ldr	pmc, .pmc_base
-
-	/* Save Master clock setting */
-	ldr	tmp1, [pmc, #AT91_PMC_MCKR]
-	str	tmp1, .saved_mckr
-
-	/*
-	 * Set the Master clock source to slow clock
-	 */
-	bic	tmp1, tmp1, #AT91_PMC_CSS
-	str	tmp1, [pmc, #AT91_PMC_MCKR]
-
-	wait_mckrdy
-
-	/* Save PLLA setting and disable it */
-	ldr	tmp1, [pmc, #AT91_CKGR_PLLAR]
-	str	tmp1, .saved_pllar
-
-	mov	tmp1, #AT91_PMC_PLLCOUNT
-	orr	tmp1, tmp1, #(1 << 29)		/* bit 29 always set */
-	str	tmp1, [pmc, #AT91_CKGR_PLLAR]
-
-	/* Turn off the main oscillator */
-	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
-	bic	tmp1, tmp1, #AT91_PMC_MOSCEN
-	orr	tmp1, tmp1, #AT91_PMC_KEY
-	str	tmp1, [pmc, #AT91_CKGR_MOR]
-
-skip_disable_main_clock:
-	ldr	pmc, .pmc_base
-
-	/* Wait for interrupt */
-	at91_cpu_idle
-
-	ldr	r0, .pm_mode
-	tst	r0, #AT91_PM_SLOW_CLOCK
-	beq	skip_enable_main_clock
-
-	ldr	pmc, .pmc_base
-
-	/* Turn on the main oscillator */
-	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
-	orr	tmp1, tmp1, #AT91_PMC_MOSCEN
-	orr	tmp1, tmp1, #AT91_PMC_KEY
-	str	tmp1, [pmc, #AT91_CKGR_MOR]
-
-	wait_moscrdy
-
-	/* Restore PLLA setting */
-	ldr	tmp1, .saved_pllar
-	str	tmp1, [pmc, #AT91_CKGR_PLLAR]
-
-	tst	tmp1, #(AT91_PMC_MUL &  0xff0000)
-	bne	3f
-	tst	tmp1, #(AT91_PMC_MUL & ~0xff0000)
-	beq	4f
-3:
-	wait_pllalock
-4:
-
-	/*
-	 * Restore master clock setting
-	 */
-	ldr	tmp1, .saved_mckr
-	str	tmp1, [pmc, #AT91_PMC_MCKR]
-
-	wait_mckrdy
-
-skip_enable_main_clock:
-	/* Exit the self-refresh mode */
-	mov	r0, #SRAMC_SELF_FRESH_EXIT
-	bl	at91_sramc_self_refresh
-
-	/* Restore registers, and return */
-	ldmfd	sp!, {r4 - r12, pc}
-ENDPROC(at91_pm_suspend_in_sram)
-
-/*
- * void at91_sramc_self_refresh(unsigned int is_active)
- *
- * @input param:
- *	@r0: 1 - active self-refresh mode
- *	     0 - exit self-refresh mode
- * register usage:
- * 	@r1: memory type
- *	@r2: base address of the sram controller
- */
-
-ENTRY(at91_sramc_self_refresh)
-	ldr	r1, .memtype
-	ldr	r2, .sramc_base
-
-	cmp	r1, #AT91_MEMCTRL_MC
-	bne	ddrc_sf
-
-	/*
-	 * at91rm9200 Memory controller
-	 */
-
-	 /*
-	  * For exiting the self-refresh mode, do nothing,
-	  * automatically exit the self-refresh mode.
-	  */
-	tst	r0, #SRAMC_SELF_FRESH_ACTIVE
-	beq	exit_sramc_sf
-
-	/* Active SDRAM self-refresh mode */
-	mov	r3, #1
-	str	r3, [r2, #AT91_MC_SDRAMC_SRR]
-	b	exit_sramc_sf
-
-ddrc_sf:
-	cmp	r1, #AT91_MEMCTRL_DDRSDR
-	bne	sdramc_sf
-
-	/*
-	 * DDR Memory controller
-	 */
-	tst	r0, #SRAMC_SELF_FRESH_ACTIVE
-	beq	ddrc_exit_sf
-
-	/* LPDDR1 --> force DDR2 mode during self-refresh */
-	ldr	r3, [r2, #AT91_DDRSDRC_MDR]
-	str	r3, .saved_sam9_mdr
-	bic	r3, r3, #~AT91_DDRSDRC_MD
-	cmp	r3, #AT91_DDRSDRC_MD_LOW_POWER_DDR
-	ldreq	r3, [r2, #AT91_DDRSDRC_MDR]
-	biceq	r3, r3, #AT91_DDRSDRC_MD
-	orreq	r3, r3, #AT91_DDRSDRC_MD_DDR2
-	streq	r3, [r2, #AT91_DDRSDRC_MDR]
-
-	/* Active DDRC self-refresh mode */
-	ldr	r3, [r2, #AT91_DDRSDRC_LPR]
-	str	r3, .saved_sam9_lpr
-	bic	r3, r3, #AT91_DDRSDRC_LPCB
-	orr	r3, r3, #AT91_DDRSDRC_LPCB_SELF_REFRESH
-	str	r3, [r2, #AT91_DDRSDRC_LPR]
-
-	/* If using the 2nd ddr controller */
-	ldr	r2, .sramc1_base
-	cmp	r2, #0
-	beq	no_2nd_ddrc
-
-	ldr	r3, [r2, #AT91_DDRSDRC_MDR]
-	str	r3, .saved_sam9_mdr1
-	bic	r3, r3, #~AT91_DDRSDRC_MD
-	cmp	r3, #AT91_DDRSDRC_MD_LOW_POWER_DDR
-	ldreq	r3, [r2, #AT91_DDRSDRC_MDR]
-	biceq	r3, r3, #AT91_DDRSDRC_MD
-	orreq	r3, r3, #AT91_DDRSDRC_MD_DDR2
-	streq	r3, [r2, #AT91_DDRSDRC_MDR]
-
-	/* Active DDRC self-refresh mode */
-	ldr	r3, [r2, #AT91_DDRSDRC_LPR]
-	str	r3, .saved_sam9_lpr1
-	bic	r3, r3, #AT91_DDRSDRC_LPCB
-	orr	r3, r3, #AT91_DDRSDRC_LPCB_SELF_REFRESH
-	str	r3, [r2, #AT91_DDRSDRC_LPR]
-
-no_2nd_ddrc:
-	b	exit_sramc_sf
-
-ddrc_exit_sf:
-	/* Restore MDR in case of LPDDR1 */
-	ldr	r3, .saved_sam9_mdr
-	str	r3, [r2, #AT91_DDRSDRC_MDR]
-	/* Restore LPR on AT91 with DDRAM */
-	ldr	r3, .saved_sam9_lpr
-	str	r3, [r2, #AT91_DDRSDRC_LPR]
-
-	/* If using the 2nd ddr controller */
-	ldr	r2, .sramc1_base
-	cmp	r2, #0
-	ldrne	r3, .saved_sam9_mdr1
-	strne	r3, [r2, #AT91_DDRSDRC_MDR]
-	ldrne	r3, .saved_sam9_lpr1
-	strne	r3, [r2, #AT91_DDRSDRC_LPR]
-
-	b	exit_sramc_sf
-
-	/*
-	 * SDRAMC Memory controller
-	 */
-sdramc_sf:
-	tst	r0, #SRAMC_SELF_FRESH_ACTIVE
-	beq	sdramc_exit_sf
-
-	/* Active SDRAMC self-refresh mode */
-	ldr	r3, [r2, #AT91_SDRAMC_LPR]
-	str	r3, .saved_sam9_lpr
-	bic	r3, r3, #AT91_SDRAMC_LPCB
-	orr	r3, r3, #AT91_SDRAMC_LPCB_SELF_REFRESH
-	str	r3, [r2, #AT91_SDRAMC_LPR]
-
-sdramc_exit_sf:
-	ldr	r3, .saved_sam9_lpr
-	str	r3, [r2, #AT91_SDRAMC_LPR]
-
-exit_sramc_sf:
-	mov	pc, lr
-ENDPROC(at91_sramc_self_refresh)
-
-.pmc_base:
-	.word 0
-.sramc_base:
-	.word 0
-.sramc1_base:
-	.word 0
-.memtype:
-	.word 0
-.pm_mode:
-	.word 0
-.saved_mckr:
-	.word 0
-.saved_pllar:
-	.word 0
-.saved_sam9_lpr:
-	.word 0
-.saved_sam9_lpr1:
-	.word 0
-.saved_sam9_mdr:
-	.word 0
-.saved_sam9_mdr1:
-	.word 0
-
-ENTRY(at91_pm_suspend_in_sram_sz)
-	.word .-at91_pm_suspend_in_sram
-- 
2.8.0.rc3
