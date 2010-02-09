From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Mon,  8 Feb 2010 16:11:26 -0800
Subject: [PATCH 05/14] ARM: LPC32XX: System suspend support
In-Reply-To: <1265674295-23996-1-git-send-email-wellsk40@gmail.com>
References: <1265674295-23996-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1265674295-23996-6-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

Support for system suspend and resume

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/pm.c      |  155 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-lpc32xx/suspend.S |  165 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 320 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/pm.c b/arch/arm/mach-lpc32xx/pm.c
new file mode 100644
index 0000000..7480976
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/pm.c
@@ -0,0 +1,155 @@
+/*
+ * arch/arm/mach-lpc32xx/pm.c
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ * Based in part on PNX4008 power management code
+ *
+ * Copyright (C) 2010 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/*
+ * LPC32XX CPU and system power management
+ *
+ * The LCP32XX has three CPU modes for controlling system power: run,
+ * direct-run, and halt modes. When switching between halt and run modes,
+ * the CPU transistions through direct-run mode. For Linux, direct-run
+ * mode is not used in normal operation. Halt mode is used when the
+ * system is fully suspended.
+ *
+ * Run mode:
+ * The ARM CPU clock (HCLK_PLL), HCLK bus clock, and PCLK bus clocks are
+ * derived from the HCLK PLL. The HCLK and PCLK bus rates are divided from
+ * the HCLK_PLL rate. Linux runs in this mode.
+ *
+ * Direct-run mode:
+ * The ARM CPU clock, HCLK bus clock, and PCLK bus clocks are driven from
+ * SYSCLK. SYSCLK is usually around 13MHz, but may vary based on SYSCLK
+ * source or the frequency of the main oscillator. In this mode, the
+ * HCLK_PLL can be safely enabled, changed, or disabled.
+ *
+ * Halt mode:
+ * SYSCLK is gated off and the CPU and system clocks are halted.
+ * Peripherals based on the 32KHz oscillator clock (ie, RTC, touch,
+ * key scanner, etc.) still operate if enabled. In this state, an enabled
+ * system event (ie, GPIO state change, RTC match, key press, etc.) will
+ * wake the system up back into direct-run mode.
+ *
+ * DRAM refresh
+ * DRAM clocking and refresh are slightly different for systems with DDR
+ * DRAM or regular SDRAM devices. If SDRAM is used in the system, the
+ * SDRAM will still be accessible in direct-run mode. In DDR based systems,
+ * a transistion to direct-run mode will stop all DDR accesses (no clocks).
+ * Because of this, the code to switch power modes and the code to enter
+ * and exit DRAM self-refresh modes must not be executed in DRAM. A small
+ * section of IRAM is used instead for this.
+ *
+ * Suspend is handled with the following logic:
+ *  Backup a small area of IRAM used for the suspend code
+ *  Copy suspend code to IRAM
+ *  Transfer control to code in IRAM
+ *  Places DRAMs in self-refresh mode
+ *  Enter direct-run mode
+ *  Save state of HCLK_PLL PLL
+ *  Disable HCLK_PLL PLL
+ *  Enter halt mode - CPU and buses will stop
+ *  System enters direct-run mode when an enabled event occurs
+ *  HCLK PLL state is restored
+ *  Run mode is entered
+ *  DRAMS are placed back into normal mode
+ *  Code execution returns from IRAM
+ *  IRAM code are used for suspend is restored
+ *  Suspend mode is exited
+ */
+
+#include <linux/suspend.h>
+#include <linux/io.h>
+
+#include <asm/cacheflush.h>
+
+#include <mach/hardware.h>
+#include <mach/platform.h>
+#include "common.h"
+#include "clock.h"
+
+#define TEMP_IRAM_AREA  IO_ADDRESS(LPC32XX_IRAM_BASE)
+
+static int lpc32xx_pm_valid_state(suspend_state_t state)
+{
+	return (state == PM_SUSPEND_MEM);
+}
+
+/*
+ * Both STANDBY and MEM suspend states are handled the same with no
+ * loss of CPU or memory state
+ */
+static int lpc32xx_pm_enter(suspend_state_t state)
+{
+	int (*lpc32xx_suspend_ptr) (void);
+	void *iram_swap_area;
+
+	/* Allocate some space for temporary IRAM storage */
+	iram_swap_area = kmalloc(lpc32xx_sys_suspend_sz, GFP_KERNEL);
+	if (!iram_swap_area) {
+		printk(KERN_ERR
+		       "PM Suspend: cannot allocate memory to save portion "
+			"of SRAM\n");
+		return -ENOMEM;
+	}
+
+	/* Backup a small area of IRAM used for the suspend code */
+	memcpy(iram_swap_area, (void *) TEMP_IRAM_AREA,
+		lpc32xx_sys_suspend_sz);
+	flush_cache_all();
+
+	/*
+	 * Copy code to suspend system into IRAM. The suspend code
+	 * needs to run from IRAM as DRAM may no longer be available
+	 * when the PLL is stopped.
+	 */
+	memcpy((void *) TEMP_IRAM_AREA, &lpc32xx_sys_suspend,
+		lpc32xx_sys_suspend_sz);
+
+	/* Transfer to suspend code in IRAM */
+	lpc32xx_suspend_ptr = (void *) TEMP_IRAM_AREA;
+	(void) lpc32xx_suspend_ptr();
+
+	/* Restore original IRAM contents */
+	memcpy((void *) TEMP_IRAM_AREA, iram_swap_area,
+		lpc32xx_sys_suspend_sz);
+
+	kfree(iram_swap_area);
+
+	return 0;
+}
+
+static struct platform_suspend_ops lpc32xx_pm_ops = {
+	.valid	= lpc32xx_pm_valid_state,
+	.enter	= lpc32xx_pm_enter,
+};
+
+#define EMC_DYN_MEM_CTRL_OFS 0x20
+#define EMC_SRMMC           (1 << 3)
+#define EMC_CTRL_REG io_p2v(LPC32XX_EMC_BASE + EMC_DYN_MEM_CTRL_OFS)
+static int __init lpc32xx_pm_init(void)
+{
+	/*
+	 * Setup SDRAM self-refresh clock to automatically
+	 * disable on start of self-refresh
+	 */
+	__raw_writel(__raw_readl(EMC_CTRL_REG) | EMC_SRMMC, EMC_CTRL_REG);
+
+	suspend_set_ops(&lpc32xx_pm_ops);
+
+	return 0;
+}
+arch_initcall(lpc32xx_pm_init);
diff --git a/arch/arm/mach-lpc32xx/suspend.S b/arch/arm/mach-lpc32xx/suspend.S
new file mode 100644
index 0000000..01c02ce
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/suspend.S
@@ -0,0 +1,165 @@
+/*
+ * arch/arm/mach-lpc32xx/suspend.S
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ * Based in part on PNX4008 power management code
+ *
+ * Copyright (C) 2010 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <mach/platform.h>
+#include <mach/hardware.h>
+
+/* Using named register defines makes the code easier to follow */
+#define WORK1_REG			r0
+#define WORK2_REG			r1
+#define SAVED_HCLK_DIV_REG		r2
+#define SAVED_HCLK_PLL_REG		r3
+#define SAVED_DRAM_CLKCTRL_REG		r4
+#define SAVED_PWR_CTRL_REG		r5
+#define CLKPWRBASE_REG			r6
+#define EMCBASE_REG			r7
+
+#define LPC32XX_EMC_STATUS_OFFS		0x04
+#define LPC32XX_EMC_STATUS_BUSY		0x1
+#define LPC32XX_EMC_STATUS_SELF_RFSH	0x4
+
+#define LPC32XX_CLKPWR_PWR_CTRL_OFFS	0x44
+#define LPC32XX_CLKPWR_HCLK_DIV_OFFS	0x40
+#define LPC32XX_CLKPWR_HCLKPLL_CTRL_OFFS 0x58
+
+#define CLKPWR_PCLK_DIV_MASK		0xFFFFFE7F
+
+	.text
+
+ENTRY(lpc32xx_sys_suspend)
+	@ Save a copy of the used registers in IRAM, r0 is corrupted
+	adr	r0, tmp_stack_end
+	stmfd	r0!, {r1 - r7, sp, lr}
+
+	@ Load a few common register addresses
+	adr	WORK1_REG, reg_bases
+	ldr	CLKPWRBASE_REG, [WORK1_REG, #0]
+	ldr	EMCBASE_REG, [WORK1_REG, #4]
+
+	ldr	SAVED_PWR_CTRL_REG, [CLKPWRBASE_REG,\
+		#LPC32XX_CLKPWR_PWR_CTRL_OFFS]
+	orr	WORK1_REG, SAVED_PWR_CTRL_REG, #LPC32XX_CLKPWR_SDRAM_SELF_RFSH
+
+	@ Wait for SDRAM busy status to go busy and then idle
+	@ This guarantees a small windows where DRAM isn't busy
+1:
+	ldr	WORK2_REG, [EMCBASE_REG, #LPC32XX_EMC_STATUS_OFFS]
+	and	WORK2_REG, WORK2_REG, #LPC32XX_EMC_STATUS_BUSY
+	cmp	WORK2_REG, #LPC32XX_EMC_STATUS_BUSY
+	bne	1b @ Branch while idle
+2:
+	ldr	WORK2_REG, [EMCBASE_REG, #LPC32XX_EMC_STATUS_OFFS]
+	and	WORK2_REG, WORK2_REG, #LPC32XX_EMC_STATUS_BUSY
+	cmp	WORK2_REG, #LPC32XX_EMC_STATUS_BUSY
+	beq	2b @ Branch until idle
+
+	@ Setup self-refresh with support for manual exit of
+	@ self-refresh mode
+	str	WORK1_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_PWR_CTRL_OFFS]
+	orr	WORK2_REG, WORK1_REG, #LPC32XX_CLKPWR_UPD_SDRAM_SELF_RFSH
+	str	WORK2_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_PWR_CTRL_OFFS]
+	str	WORK1_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_PWR_CTRL_OFFS]
+
+	@ Wait for self-refresh acknowledge, clocks to the DRAM device
+	@ will automatically stop on start of self-refresh
+3:
+	ldr	WORK2_REG, [EMCBASE_REG, #LPC32XX_EMC_STATUS_OFFS]
+	and	WORK2_REG, WORK2_REG, #LPC32XX_EMC_STATUS_SELF_RFSH
+	cmp	WORK2_REG, #LPC32XX_EMC_STATUS_SELF_RFSH
+	bne	3b @ Branch until self-refresh mode starts
+
+	@ Enter direct-run mode from run mode
+	bic	WORK1_REG, WORK1_REG, #LPC32XX_CLKPWR_SELECT_RUN_MODE
+	str	WORK1_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_PWR_CTRL_OFFS]
+
+	@ Safe disable of DRAM clock in EMC block, prevents DDR sync
+	@ issues on restart
+	ldr	SAVED_HCLK_DIV_REG, [CLKPWRBASE_REG,\
+		#LPC32XX_CLKPWR_HCLK_DIV_OFFS]
+	and	WORK2_REG, SAVED_HCLK_DIV_REG, #CLKPWR_PCLK_DIV_MASK
+	str	WORK2_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_HCLK_DIV_OFFS]
+
+	@ Save HCLK PLL state and disable HCLK PLL
+	ldr	SAVED_HCLK_PLL_REG, [CLKPWRBASE_REG,\
+		#LPC32XX_CLKPWR_HCLKPLL_CTRL_OFFS]
+	bic	WORK2_REG, SAVED_HCLK_PLL_REG, #LPC32XX_CLKPWR_HCLKPLL_POWER_UP
+	str	WORK2_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_HCLKPLL_CTRL_OFFS]
+
+	@ Enter stop mode until an enabled event occurs
+	orr	WORK1_REG, WORK1_REG, #LPC32XX_CLKPWR_STOP_MODE_CTRL
+	str	WORK1_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_PWR_CTRL_OFFS]
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+
+	@ Clear stop status
+	bic	WORK1_REG, WORK1_REG, #LPC32XX_CLKPWR_STOP_MODE_CTRL
+
+	@ Restore original HCLK PLL value and wait for PLL lock
+	str	SAVED_HCLK_PLL_REG, [CLKPWRBASE_REG,\
+		#LPC32XX_CLKPWR_HCLKPLL_CTRL_OFFS]
+4:
+	ldr	WORK2_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_HCLKPLL_CTRL_OFFS]
+	and	WORK2_REG, WORK2_REG, #LPC32XX_CLKPWR_HCLKPLL_PLL_STS
+	bne	4b
+
+	@ Re-enter run mode with self-refresh flag cleared, but no DRAM
+	@ update yet. DRAM is still in self-refresh
+	str	SAVED_PWR_CTRL_REG, [CLKPWRBASE_REG,\
+		#LPC32XX_CLKPWR_PWR_CTRL_OFFS]
+
+	@ Restore original DRAM clock mode to restore DRAM clocks
+	str	SAVED_HCLK_DIV_REG, [CLKPWRBASE_REG,\
+		#LPC32XX_CLKPWR_HCLK_DIV_OFFS]
+
+	@ Clear self-refresh mode
+	orr	WORK1_REG, SAVED_PWR_CTRL_REG,\
+		#LPC32XX_CLKPWR_UPD_SDRAM_SELF_RFSH
+	str	WORK1_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_PWR_CTRL_OFFS]
+	str	SAVED_PWR_CTRL_REG, [CLKPWRBASE_REG,\
+		#LPC32XX_CLKPWR_PWR_CTRL_OFFS]
+
+	@ Wait for EMC to clear self-refresh mode
+5:
+	ldr	WORK2_REG, [EMCBASE_REG, #LPC32XX_EMC_STATUS_OFFS]
+	and	WORK2_REG, WORK2_REG, #LPC32XX_EMC_STATUS_SELF_RFSH
+	bne	5b @ Branch until self-refresh has exited
+
+	@ restore regs and return
+	adr	r0, tmp_stack
+	ldmfd	r0!, {r1 - r7, sp, pc}
+
+reg_bases:
+	.long	IO_ADDRESS(LPC32XX_CLK_PM_BASE)
+	.long	IO_ADDRESS(LPC32XX_EMC_BASE)
+
+tmp_stack:
+	.long	0, 0, 0, 0, 0, 0, 0, 0, 0
+tmp_stack_end:
+
+ENTRY(lpc32xx_sys_suspend_sz)
+	.word	. - lpc32xx_sys_suspend
+
-- 
1.6.6
