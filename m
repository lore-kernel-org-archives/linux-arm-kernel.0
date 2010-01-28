From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Wed, 27 Jan 2010 17:43:27 -0800
Subject: [PATCH 09/13] ARM: LPC32XX: power and event management
In-Reply-To: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1264643011-17390-10-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

Power mode suspend code and event management code used for device,
system, and memory sleep/wakeup

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/pm.c        |  170 +++++++++++++++
 arch/arm/mach-lpc32xx/pm.h        |  140 ++++++++++++
 arch/arm/mach-lpc32xx/pm_events.c |  426 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-lpc32xx/suspend.S   |  155 ++++++++++++++
 4 files changed, 891 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/pm.c b/arch/arm/mach-lpc32xx/pm.c
new file mode 100644
index 0000000..8535e99
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/pm.c
@@ -0,0 +1,170 @@
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
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
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
+#include <asm/irq.h>
+#include <asm/atomic.h>
+#include <asm/mach/time.h>
+#include <asm/mach/irq.h>
+#include <asm/cacheflush.h>
+
+#include <mach/hardware.h>
+#include <mach/platform.h>
+#include "common.h"
+#include "clock.h"
+#include "pm.h"
+
+#define TEMP_IRAM_AREA  io_p2v(IRAM_BASE)
+
+static void *iram_swap_area;
+
+static int lpc32xx_pm_valid_state(suspend_state_t state)
+{
+	return (state == PM_SUSPEND_STANDBY) ||
+	       (state == PM_SUSPEND_MEM);
+}
+
+/*
+ * Both STANDBY and MEM suspend states are handled the same with no
+ * loss of CPU or memory state
+ */
+static int lpc32xx_pm_enter(suspend_state_t state)
+{
+	int (*lpc32xx_suspend_ptr) (void);
+
+	if (state == PM_SUSPEND_MEM || state == PM_SUSPEND_STANDBY) {
+		/* The CPU and MEM suspend code do the same thing. Wakeup
+		   from both states is very quick. */
+
+		/* Backup a small area of IRAM used for the suspend code */
+		memcpy(iram_swap_area, (void *) TEMP_IRAM_AREA,
+			lpc32xx_sys_suspend_sz);
+		flush_cache_all();
+
+		/* Copy code to suspend system into IRAM. The suspend code
+		   needs to run from IRAM as DRAM may no longer be available
+		   when the PLL is stopped. */
+		memcpy((void *) TEMP_IRAM_AREA, &lpc32xx_sys_suspend,
+			lpc32xx_sys_suspend_sz);
+
+		/* Transfer to suspend code in IRAM */
+		lpc32xx_suspend_ptr = (void *) TEMP_IRAM_AREA;
+		(void) lpc32xx_suspend_ptr();
+
+		/* Restore original IRAM contents */
+		memcpy((void *) TEMP_IRAM_AREA, iram_swap_area,
+			lpc32xx_sys_suspend_sz);
+	} else
+		return -ENOTSUPP;
+
+	/* Clear any pending wakeup events */
+	lpc32xx_event_clear_all();
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
+
+static int __init lpc32xx_pm_init(void)
+{
+	/* Setup SDRAM self-refresh clock to automatically
+	   disable on start of self-refresh */
+	writel(readl(io_p2v(EMC_BASE) + EMC_DYN_MEM_CTRL_OFS) | EMC_SRMMC,
+		io_p2v(EMC_BASE) + EMC_DYN_MEM_CTRL_OFS);
+
+	/* Allocate some space for temporary IRAM storage */
+	iram_swap_area = kmalloc(lpc32xx_sys_suspend_sz, GFP_ATOMIC);
+	if (!iram_swap_area) {
+		printk(KERN_ERR
+		       "PM Suspend: cannot allocate memory to save portion "
+			"of SRAM\n");
+		return -ENOMEM;
+	}
+
+	suspend_set_ops(&lpc32xx_pm_ops);
+
+	return 0;
+}
+arch_initcall(lpc32xx_pm_init);
diff --git a/arch/arm/mach-lpc32xx/pm.h b/arch/arm/mach-lpc32xx/pm.h
new file mode 100644
index 0000000..9d7d548
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/pm.h
@@ -0,0 +1,140 @@
+/*
+ * arch/arm/mach-lpc32xx/pm.h
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
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
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __LPC32XX__PM_H
+#define __LPC32XX__PM_H
+
+/*
+ * This file allows the enable and disable of events that can wake up
+ * the system when in sleep mode. Events fire on either the low or
+ * high edge transistion and can be configured in hardware.
+ */
+
+enum lpc32xx_events {
+	/* For the following group, an active transistion on the pin
+	   associated with the event will wakeup the chip if the
+	   event is enabled. */
+	LPC32XX_WKUP_GPI_08,
+	LPC32XX_WKUP_GPI_09,
+	LPC32XX_WKUP_GPI_19,
+	LPC32XX_WKUP_SPI2_DATIN,
+	LPC32XX_WKUP_GPI_07,
+	LPC32XX_WKUP_SPI1_DATIN,
+	LPC32XX_WKUP_SYSCLKEN,
+	LPC32XX_WKUP_GPI00, /* Input mode only */
+	LPC32XX_WKUP_GPI01, /* Input mode only */
+	LPC32XX_WKUP_GPI02, /* Input mode only */
+	LPC32XX_WKUP_GPI03, /* Input mode only */
+	LPC32XX_WKUP_GPI04, /* Input mode only */
+	LPC32XX_WKUP_GPI05, /* Input mode only */
+	LPC32XX_WKUP_GPI06, /* Input mode only */
+	LPC32XX_WKUP_MSDIO_START, /* All SD data signals Or'ed */
+	LPC32XX_WKUP_SDIO_INT_N, /* SDIO D1 only */
+	LPC32XX_WKUP_U1_RX,
+	LPC32XX_WKUP_U2_RX,
+	LPC32XX_WKUP_U2_HCTS,
+	LPC32XX_WKUP_U3_RX,
+	LPC32XX_WKUP_GPI_28,
+	LPC32XX_WKUP_U5_RX,
+	LPC32XX_WKUP_U6_IRRX,
+	LPC32XX_WKUP_U7_HCTS,
+	LPC32XX_WKUP_U7_RX,
+
+	/* For the following group, an interrupt for the peripheral
+	   will wakeup the chip if the event is enabled. */
+	LPC32XX_WKUP_GPIO_00,
+	LPC32XX_WKUP_GPIO_01,
+	LPC32XX_WKUP_GPIO_02,
+	LPC32XX_WKUP_GPIO_03,
+	LPC32XX_WKUP_GPIO_04,
+	LPC32XX_WKUP_GPIO_05,
+	LPC32XX_WKUP_P0_P1_ALL, /* One or more sources in P0/P1 */
+	LPC32XX_WKUP_MAC_START,
+	LPC32XX_WKUP_KEY_IRQ,
+	LPC32XX_WKUP_USB_OTG_ATX_INT_N,
+	LPC32XX_WKUP_USB_OTG_TIMER,
+	LPC32XX_WKUP_USB_I2C_INT,
+	LPC32XX_WKUP_USB_INT,
+	LPC32XX_WKUP_USB_NEED_CLK,
+	LPC32XX_WKUP_RTC_INT,
+	LPC32XX_WKUP_MSTIMER_INT,
+	LPC32XX_WKUP_USB_AHC_NEED_CLK,
+	LPC32XX_WKUP_TS_AUX_INT,
+	LPC32XX_WKUP_TS_P_INT,
+	LPC32XX_WKUP_TS_INT,
+
+	/* P0/P1 group signals. These signals are all routed through the
+	   LPC32XX_WKUP_P0_P1_ALL event in the previous group, so be sure
+	   to enable LPC32XX_WKUP_P0_P1_ALL if any of these are used. Any
+	   one enabled and active event will generate the
+	   LPC32XX_WKUP_P0_P1_ALL event */
+	LPC32XX_WKUP_P0_0,
+	LPC32XX_WKUP_P0_1,
+	LPC32XX_WKUP_P0_2,
+	LPC32XX_WKUP_P0_3,
+	LPC32XX_WKUP_P0_4,
+	LPC32XX_WKUP_P0_5,
+	LPC32XX_WKUP_P0_6,
+	LPC32XX_WKUP_P0_7,
+	LPC32XX_WKUP_P1_3,
+	LPC32XX_WKUP_P1_4,
+	LPC32XX_WKUP_P1_5,
+	LPC32XX_WKUP_P1_6,
+	LPC32XX_WKUP_P1_7,
+	LPC32XX_WKUP_P1_8,
+	LPC32XX_WKUP_P1_9,
+	LPC32XX_WKUP_P1_10,
+	LPC32XX_WKUP_P1_11,
+	LPC32XX_WKUP_P1_12,
+	LPC32XX_WKUP_P1_13,
+	LPC32XX_WKUP_P1_14,
+	LPC32XX_WKUP_P1_15,
+	LPC32XX_WKUP_P1_16,
+	LPC32XX_WKUP_P1_17,
+	LPC32XX_WKUP_P1_18,
+	LPC32XX_WKUP_P1_19,
+	LPC32XX_WKUP_P1_20,
+	LPC32XX_WKUP_P1_21,
+	LPC32XX_WKUP_P1_22,
+	LPC32XX_WKUP_P1_23,
+	LPC32XX_LAST_EVENT = LPC32XX_WKUP_P1_23
+};
+
+/*
+ * Wakeup event support
+ */
+extern void lpc32xx_event_init(void);
+extern void lpc32xx_event_enable(enum lpc32xx_events event_id);
+extern void lpc32xx_event_disable(enum lpc32xx_events event_id);
+extern int lpc32xx_event_set(enum lpc32xx_events event_id,
+	int high_edge);
+extern int lpc32xx_event_enabled(enum lpc32xx_events event_id);
+extern void lpc32xx_event_clear(enum lpc32xx_events event_id);
+extern void lpc32xx_event_clear_all(void);
+
+/*
+ * Pointers used for sizing and copying suspend function data
+ */
+extern int lpc32xx_sys_suspend(void);
+extern int lpc32xx_sys_suspend_sz;
+
+#endif
diff --git a/arch/arm/mach-lpc32xx/pm_events.c b/arch/arm/mach-lpc32xx/pm_events.c
new file mode 100644
index 0000000..d3b1b54
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/pm_events.c
@@ -0,0 +1,426 @@
+/*
+ * arch/arm/mach-lpc32xx/pm_events.c
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
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
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/types.h>
+#include <linux/io.h>
+#include <linux/err.h>
+
+#include <mach/hardware.h>
+#include <mach/platform.h>
+#include "common.h"
+#include "pm.h"
+
+struct lpc32xx_event_info {
+	u32 offs;
+	u32 mask;
+};
+
+static const struct lpc32xx_event_info events[LPC32XX_LAST_EVENT + 1] = {
+	[LPC32XX_WKUP_GPI_08] = {
+		.offs = CLKPWR_PIN_ER(0),
+		.mask = CLKPWR_EXTSRC_GPIO_O8_BIT,
+	},
+	[LPC32XX_WKUP_GPI_09] = {
+		.offs = CLKPWR_PIN_ER(0),
+		.mask = CLKPWR_EXTSRC_GPIO_O9_BIT,
+	},
+	[LPC32XX_WKUP_GPI_19] = {
+		.offs = CLKPWR_PIN_ER(0),
+		.mask = CLKPWR_EXTSRC_GPIO_19_BIT,
+	},
+	[LPC32XX_WKUP_SPI2_DATIN] = {
+		.offs = CLKPWR_PIN_ER(0),
+		.mask = CLKPWR_EXTSRC_SPI2_DATIN_BIT,
+	},
+	[LPC32XX_WKUP_GPI_07] = {
+		.offs = CLKPWR_PIN_ER(0),
+		.mask = CLKPWR_EXTSRC_GPIO_O7_BIT,
+	},
+	[LPC32XX_WKUP_SPI1_DATIN] = {
+		.offs = CLKPWR_PIN_ER(0),
+		.mask = CLKPWR_EXTSRC_SPI1_DATIN_BIT,
+	},
+	[LPC32XX_WKUP_SYSCLKEN] = {
+		.offs = CLKPWR_PIN_ER(0),
+		.mask = CLKPWR_EXTSRC_SYSCLKEN_BIT,
+	},
+	[LPC32XX_WKUP_GPI00] = {
+		.offs = CLKPWR_PIN_ER(0),
+		.mask = CLKPWR_EXTSRC_GPIO_O0_BIT,
+	},
+	[LPC32XX_WKUP_GPI01] = {
+		.offs = CLKPWR_PIN_ER(0),
+		.mask = CLKPWR_EXTSRC_GPIO_O1_BIT,
+	},
+	[LPC32XX_WKUP_GPI02] = {
+		.offs = CLKPWR_PIN_ER(0),
+		.mask = CLKPWR_EXTSRC_GPIO_O2_BIT,
+	},
+	[LPC32XX_WKUP_GPI03] = {
+		.offs = CLKPWR_PIN_ER(0),
+		.mask = CLKPWR_EXTSRC_GPIO_O3_BIT,
+	},
+	[LPC32XX_WKUP_GPI04] = {
+		.offs = CLKPWR_PIN_ER(0),
+		.mask = CLKPWR_EXTSRC_GPIO_O4_BIT,
+	},
+	[LPC32XX_WKUP_GPI05] = {
+		.offs = CLKPWR_PIN_ER(0),
+		.mask = CLKPWR_EXTSRC_GPIO_O5_BIT,
+	},
+	[LPC32XX_WKUP_GPI06] = {
+		.offs = CLKPWR_PIN_ER(0),
+		.mask = CLKPWR_EXTSRC_GPIO_O6_BIT,
+	},
+	[LPC32XX_WKUP_MSDIO_START] = {
+		.offs = CLKPWR_PIN_ER(0),
+		.mask = CLKPWR_EXTSRC_MSDIO_SRT_BIT,
+	},
+	[LPC32XX_WKUP_SDIO_INT_N] = {
+		.offs = CLKPWR_PIN_ER(0),
+		.mask = CLKPWR_EXTSRC_MSDIO_INT_BIT,
+	},
+	[LPC32XX_WKUP_U1_RX] = {
+		.offs = CLKPWR_PIN_ER(0),
+		.mask = CLKPWR_EXTSRC_U1_RX_BIT,
+	},
+	[LPC32XX_WKUP_U2_RX] = {
+		.offs = CLKPWR_PIN_ER(0),
+		.mask = CLKPWR_EXTSRC_U2_RX_BIT,
+	},
+	[LPC32XX_WKUP_U2_HCTS] = {
+		.offs = CLKPWR_PIN_ER(0),
+		.mask = CLKPWR_EXTSRC_U2_HCTS_BIT,
+	},
+	[LPC32XX_WKUP_U3_RX] = {
+		.offs = CLKPWR_PIN_ER(0),
+		.mask = CLKPWR_EXTSRC_U3_RX_BIT,
+	},
+	[LPC32XX_WKUP_GPI_28] = {
+		.offs = CLKPWR_PIN_ER(0),
+		.mask = CLKPWR_EXTSRC_GPI_11_BIT,
+	},
+	[LPC32XX_WKUP_U5_RX] = {
+		.offs = CLKPWR_PIN_ER(0),
+		.mask = CLKPWR_EXTSRC_U5_RX_BIT,
+	},
+	[LPC32XX_WKUP_U6_IRRX] = {
+		.offs = CLKPWR_PIN_ER(0),
+		.mask = CLKPWR_EXTSRC_U6_IRRX_BIT,
+	},
+	[LPC32XX_WKUP_U7_HCTS] = {
+		.offs = CLKPWR_PIN_ER(0),
+		.mask = CLKPWR_EXTSRC_U7_HCTS_BIT,
+	},
+	[LPC32XX_WKUP_U7_RX] = {
+		.offs = CLKPWR_PIN_ER(0),
+		.mask = CLKPWR_EXTSRC_U7_RX_BIT,
+	},
+
+	[LPC32XX_WKUP_GPIO_00] = {
+		.offs = CLKPWR_INT_ER(0),
+		.mask = CLKPWR_INTSRC_GPIO_00_BIT,
+	},
+	[LPC32XX_WKUP_GPIO_01] = {
+		.offs = CLKPWR_INT_ER(0),
+		.mask = CLKPWR_INTSRC_GPIO_01_BIT,
+	},
+	[LPC32XX_WKUP_GPIO_02] = {
+		.offs = CLKPWR_INT_ER(0),
+		.mask = CLKPWR_INTSRC_GPIO_02_BIT,
+	},
+	[LPC32XX_WKUP_GPIO_03] = {
+		.offs = CLKPWR_INT_ER(0),
+		.mask = CLKPWR_INTSRC_GPIO_03_BIT,
+	},
+	[LPC32XX_WKUP_GPIO_04] = {
+		.offs = CLKPWR_INT_ER(0),
+		.mask = CLKPWR_INTSRC_GPIO_04_BIT,
+	},
+	[LPC32XX_WKUP_GPIO_05] = {
+		.offs = CLKPWR_INT_ER(0),
+		.mask = CLKPWR_INTSRC_GPIO_05_BIT,
+	},
+	[LPC32XX_WKUP_P0_P1_ALL] = {
+		.offs = CLKPWR_INT_ER(0),
+		.mask = CLKPWR_INTSRC_P0P1_BIT,
+	},
+	[LPC32XX_WKUP_MAC_START] = {
+		.offs = CLKPWR_INT_ER(0),
+		.mask = CLKPWR_INTSRC_MAC_BIT,
+	},
+	[LPC32XX_WKUP_KEY_IRQ] = {
+		.offs = CLKPWR_INT_ER(0),
+		.mask = CLKPWR_INTSRC_KEY_BIT,
+	},
+	[LPC32XX_WKUP_USB_OTG_ATX_INT_N] = {
+		.offs = CLKPWR_INT_ER(0),
+		.mask = CLKPWR_INTSRC_USBATXINT_BIT,
+	},
+	[LPC32XX_WKUP_USB_OTG_TIMER] = {
+		.offs = CLKPWR_INT_ER(0),
+		.mask = CLKPWR_INTSRC_USBOTGTIMER_BIT,
+	},
+	[LPC32XX_WKUP_USB_I2C_INT] = {
+		.offs = CLKPWR_INT_ER(0),
+		.mask = CLKPWR_INTSRC_I2C_BIT,
+	},
+	[LPC32XX_WKUP_USB_INT] = {
+		.offs = CLKPWR_INT_ER(0),
+		.mask = CLKPWR_INTSRC_USB_BIT,
+	},
+	[LPC32XX_WKUP_USB_NEED_CLK] = {
+		.offs = CLKPWR_INT_ER(0),
+		.mask = CLKPWR_INTSRC_USBNEEDCLK_BIT,
+	},
+	[LPC32XX_WKUP_RTC_INT] = {
+		.offs = CLKPWR_INT_ER(0),
+		.mask = CLKPWR_INTSRC_RTC_BIT,
+	},
+	[LPC32XX_WKUP_MSTIMER_INT] = {
+		.offs = CLKPWR_INT_ER(0),
+		.mask = CLKPWR_INTSRC_MSTIMER_BIT,
+	},
+	[LPC32XX_WKUP_USB_AHC_NEED_CLK] = {
+		.offs = CLKPWR_INT_ER(0),
+		.mask = CLKPWR_INTSRC_USBAHNEEDCLK_BIT,
+	},
+	[LPC32XX_WKUP_TS_AUX_INT] = {
+		.offs = CLKPWR_INT_ER(0),
+		.mask = CLKPWR_INTSRC_TS_AUX_BIT,
+	},
+	[LPC32XX_WKUP_TS_P_INT] = {
+		.offs = CLKPWR_INT_ER(0),
+		.mask = CLKPWR_INTSRC_TS_P_BIT,
+	},
+	[LPC32XX_WKUP_TS_INT] = {
+		.offs = CLKPWR_INT_ER(0),
+		.mask = CLKPWR_INTSRC_ADC_BIT,
+	},
+	[LPC32XX_WKUP_P0_0] = {
+		.offs = CLKPWR_P01_ER(0),
+		.mask = CLKPWR_GPIOSRC_P0IO0_BIT,
+	},
+	[LPC32XX_WKUP_P0_1] = {
+		.offs = CLKPWR_P01_ER(0),
+		.mask = CLKPWR_GPIOSRC_P0IO1_BIT,
+	},
+	[LPC32XX_WKUP_P0_2] = {
+		.offs = CLKPWR_P01_ER(0),
+		.mask = CLKPWR_GPIOSRC_P0IO2_BIT,
+	},
+	[LPC32XX_WKUP_P0_3] = {
+		.offs = CLKPWR_P01_ER(0),
+		.mask = CLKPWR_GPIOSRC_P0IO3_BIT,
+	},
+	[LPC32XX_WKUP_P0_4] = {
+		.offs = CLKPWR_P01_ER(0),
+		.mask = CLKPWR_GPIOSRC_P0IO4_BIT,
+	},
+	[LPC32XX_WKUP_P0_5] = {
+		.offs = CLKPWR_P01_ER(0),
+		.mask = CLKPWR_GPIOSRC_P0IO5_BIT,
+	},
+	[LPC32XX_WKUP_P0_6] = {
+		.offs = CLKPWR_P01_ER(0),
+		.mask = CLKPWR_GPIOSRC_P0IO6_BIT,
+	},
+	[LPC32XX_WKUP_P0_7] = {
+		.offs = CLKPWR_P01_ER(0),
+		.mask = CLKPWR_GPIOSRC_P0IO7_BIT,
+	},
+	[LPC32XX_WKUP_P1_3] = {
+		.offs = CLKPWR_PIN_ER(0),
+		.mask = CLKPWR_GPIOSRC_P1IO3_BIT,
+	},
+	[LPC32XX_WKUP_P1_4] = {
+		.offs = CLKPWR_P01_ER(0),
+		.mask = CLKPWR_GPIOSRC_P1IO4_BIT,
+	},
+	[LPC32XX_WKUP_P1_5] = {
+		.offs = CLKPWR_P01_ER(0),
+		.mask = CLKPWR_GPIOSRC_P1IO5_BIT,
+	},
+	[LPC32XX_WKUP_P1_6] = {
+		.offs = CLKPWR_P01_ER(0),
+		.mask = CLKPWR_GPIOSRC_P1IO6_BIT,
+	},
+	[LPC32XX_WKUP_P1_7] = {
+		.offs = CLKPWR_P01_ER(0),
+		.mask = CLKPWR_GPIOSRC_P1IO7_BIT,
+	},
+	[LPC32XX_WKUP_P1_8] = {
+		.offs = CLKPWR_P01_ER(0),
+		.mask = CLKPWR_GPIOSRC_P1IO8_BIT,
+	},
+	[LPC32XX_WKUP_P1_9] = {
+		.offs = CLKPWR_P01_ER(0),
+		.mask = CLKPWR_GPIOSRC_P1IO9_BIT,
+	},
+	[LPC32XX_WKUP_P1_10] = {
+		.offs = CLKPWR_P01_ER(0),
+		.mask = CLKPWR_GPIOSRC_P1IO10_BIT,
+	},
+	[LPC32XX_WKUP_P1_11] = {
+		.offs = CLKPWR_P01_ER(0),
+		.mask = CLKPWR_GPIOSRC_P1IO11_BIT,
+	},
+	[LPC32XX_WKUP_P1_12] = {
+		.offs = CLKPWR_P01_ER(0),
+		.mask = CLKPWR_GPIOSRC_P1IO12_BIT,
+	},
+	[LPC32XX_WKUP_P1_13] = {
+		.offs = CLKPWR_P01_ER(0),
+		.mask = CLKPWR_GPIOSRC_P1IO13_BIT,
+	},
+	[LPC32XX_WKUP_P1_14] = {
+		.offs = CLKPWR_P01_ER(0),
+		.mask = CLKPWR_GPIOSRC_P1IO14_BIT,
+	},
+	[LPC32XX_WKUP_P1_15] = {
+		.offs = CLKPWR_P01_ER(0),
+		.mask = CLKPWR_GPIOSRC_P1IO15_BIT,
+	},
+	[LPC32XX_WKUP_P1_16] = {
+		.offs = CLKPWR_P01_ER(0),
+		.mask = CLKPWR_GPIOSRC_P1IO16_BIT,
+	},
+	[LPC32XX_WKUP_P1_17] = {
+		.offs = CLKPWR_P01_ER(0),
+		.mask = CLKPWR_GPIOSRC_P1IO17_BIT,
+	},
+	[LPC32XX_WKUP_P1_18] = {
+		.offs = CLKPWR_P01_ER(0),
+		.mask = CLKPWR_GPIOSRC_P1IO18_BIT,
+	},
+	[LPC32XX_WKUP_P1_19] = {
+		.offs = CLKPWR_P01_ER(0),
+		.mask = CLKPWR_GPIOSRC_P1IO19_BIT,
+	},
+	[LPC32XX_WKUP_P1_20] = {
+		.offs = CLKPWR_P01_ER(0),
+		.mask = CLKPWR_GPIOSRC_P1IO20_BIT,
+	},
+	[LPC32XX_WKUP_P1_21] = {
+		.offs = CLKPWR_P01_ER(0),
+		.mask = CLKPWR_GPIOSRC_P1IO21_BIT,
+	},
+	[LPC32XX_WKUP_P1_22] = {
+		.offs = CLKPWR_P01_ER(0),
+		.mask = CLKPWR_GPIOSRC_P1IO22_BIT,
+	},
+	[LPC32XX_WKUP_P1_23] = {
+		.offs = CLKPWR_P01_ER(0),
+		.mask = CLKPWR_GPIOSRC_P1IO23_BIT,
+	},
+};
+
+void lpc32xx_event_init(void)
+{
+	/* Initially disable all events, set all events to default
+	   type and polarity per chip User guide, and clear any
+	   pending event statuses */
+	writel(0, CLKPWR_P01_ER(CLKPWR_IOBASE));
+	writel(0, CLKPWR_INT_ER(CLKPWR_IOBASE));
+	writel(0, CLKPWR_PIN_ER(CLKPWR_IOBASE));
+
+	/* Default activation polarities, all pin sources are low edge
+	   triggered */
+	writel(CLKPWR_INTSRC_TS_P_BIT | CLKPWR_INTSRC_MSTIMER_BIT |
+		CLKPWR_INTSRC_RTC_BIT, CLKPWR_INT_AP(CLKPWR_IOBASE));
+	writel(0, CLKPWR_PIN_AP(CLKPWR_IOBASE));
+
+	/* Clear latched event states */
+	writel(readl(CLKPWR_PIN_RS(CLKPWR_IOBASE)),
+		CLKPWR_PIN_RS(CLKPWR_IOBASE));
+	writel(readl(CLKPWR_INT_RS(CLKPWR_IOBASE)),
+		CLKPWR_INT_RS(CLKPWR_IOBASE));
+}
+
+void lpc32xx_event_enable(enum lpc32xx_events event_id)
+{
+	writel(readl(CLKPWR_IOBASE + events[event_id].offs) |
+		events[event_id].mask, CLKPWR_IOBASE + events[event_id].offs);
+}
+
+void lpc32xx_event_disable(enum lpc32xx_events event_id)
+{
+	writel(readl(CLKPWR_IOBASE + events[event_id].offs) &
+		~events[event_id].mask, CLKPWR_IOBASE + events[event_id].offs);
+}
+
+extern int lpc32xx_event_set(enum lpc32xx_events event_id,
+	int high_edge)
+{
+	u32 tmp;
+
+	if (event_id <= LPC32XX_WKUP_U7_RX) {
+		tmp = readl(CLKPWR_PIN_AP(CLKPWR_IOBASE));
+
+		if (high_edge)
+			tmp |= events[event_id].mask;
+		else
+			tmp &= ~events[event_id].mask;
+
+		writel(tmp, CLKPWR_PIN_AP(CLKPWR_IOBASE));
+	} else if (event_id <= LPC32XX_WKUP_TS_INT) {
+		tmp = readl(CLKPWR_INT_AP(CLKPWR_IOBASE));
+
+		if (high_edge)
+			tmp |= events[event_id].mask;
+		else
+			tmp &= ~events[event_id].mask;
+
+		writel(tmp, CLKPWR_INT_AP(CLKPWR_IOBASE));
+	} else
+		return -EINVAL;
+
+	return 0;
+}
+
+int lpc32xx_event_enabled(enum lpc32xx_events event_id)
+{
+	u32 tmp;
+
+	tmp = readl(CLKPWR_IOBASE + events[event_id].offs) &
+		events[event_id].mask;
+
+	return (tmp != 0);
+}
+
+void lpc32xx_event_clear(enum lpc32xx_events event_id)
+{
+	if (event_id <= LPC32XX_WKUP_U7_RX)
+		writel(events[event_id].mask, CLKPWR_PIN_RS(CLKPWR_IOBASE));
+	else if (event_id <= LPC32XX_WKUP_TS_INT)
+		writel(events[event_id].mask, CLKPWR_INT_RS(CLKPWR_IOBASE));
+}
+
+void lpc32xx_event_clear_all(void)
+{
+	/* Clear all latched event states */
+	writel(readl(CLKPWR_PIN_RS(CLKPWR_IOBASE)),
+		CLKPWR_PIN_RS(CLKPWR_IOBASE));
+	writel(readl(CLKPWR_INT_RS(CLKPWR_IOBASE)),
+		CLKPWR_INT_RS(CLKPWR_IOBASE));
+}
+
diff --git a/arch/arm/mach-lpc32xx/suspend.S b/arch/arm/mach-lpc32xx/suspend.S
new file mode 100644
index 0000000..075708b
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/suspend.S
@@ -0,0 +1,155 @@
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
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <mach/platform.h>
+#include <mach/hardware.h>
+
+/* Using named register defines makes the code easier to follow */
+#define WORK1_REG		r0
+#define WORK2_REG		r1
+#define SAVED_HCLK_DIV_REG	r2
+#define SAVED_HCLK_PLL_REG	r3
+#define SAVED_DRAM_CLKCTRL_REG	r4
+#define SAVED_PWR_CTRL_REG	r5
+#define CLKPWRBASE_REG		r6
+#define EMCBASE_REG		r7
+
+#define EMC_STATUS_OFFS		0x04
+#define EMC_STATUS_BUSY		0x1
+#define EMC_STATUS_SELF_RFSH	0x4
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
+	ldr	SAVED_PWR_CTRL_REG, [CLKPWRBASE_REG, #CLKPWR_PWR_CTRL(0)]
+	orr	WORK1_REG, SAVED_PWR_CTRL_REG, #CLKPWR_SDRAM_SELF_RFSH
+
+	@ Wait for SDRAM busy status to go busy and then idle
+	@ This guarantees a small windows where DRAM isn't busy
+1:
+	ldr	WORK2_REG, [EMCBASE_REG, #EMC_STATUS_OFFS]
+	and	WORK2_REG, WORK2_REG, #EMC_STATUS_BUSY
+	cmp	WORK2_REG, #EMC_STATUS_BUSY
+	bne	1b @ Branch while idle
+2:
+	ldr	WORK2_REG, [EMCBASE_REG, #EMC_STATUS_OFFS]
+	and	WORK2_REG, WORK2_REG, #EMC_STATUS_BUSY
+	cmp	WORK2_REG, #EMC_STATUS_BUSY
+	beq	2b @ Branch until idle
+
+	@ Setup self-refresh with support for manual exit of
+	@ self-refresh mode
+	str	WORK1_REG, [CLKPWRBASE_REG, #CLKPWR_PWR_CTRL(0)]
+	orr	WORK2_REG, WORK1_REG, #CLKPWR_UPD_SDRAM_SELF_RFSH
+	str	WORK2_REG, [CLKPWRBASE_REG, #CLKPWR_PWR_CTRL(0)]
+	str	WORK1_REG, [CLKPWRBASE_REG, #CLKPWR_PWR_CTRL(0)]
+
+	@ Wait for self-refresh acknowledge, clocks to the DRAM device
+	@ will automatically stop on start of self-refresh
+3:
+	ldr	WORK2_REG, [EMCBASE_REG, #EMC_STATUS_OFFS]
+	and	WORK2_REG, WORK2_REG, #EMC_STATUS_SELF_RFSH
+	cmp	WORK2_REG, #EMC_STATUS_SELF_RFSH
+	bne	3b @ Branch until self-refresh mode starts
+
+	@ Enter direct-run mode from run mode
+	bic	WORK1_REG, WORK1_REG, #CLKPWR_SELECT_RUN_MODE
+	str	WORK1_REG, [CLKPWRBASE_REG, #CLKPWR_PWR_CTRL(0)]
+
+	@ Safe disable of DRAM clock in EMC block, prevents DDR sync
+	@ issues on restart
+	ldr	SAVED_HCLK_DIV_REG, [CLKPWRBASE_REG, #CLKPWR_HCLK_DIV(0)]
+	and	WORK2_REG, SAVED_HCLK_DIV_REG, #0xFFFFFE7F
+	str	WORK2_REG, [CLKPWRBASE_REG, #CLKPWR_HCLK_DIV(0)]
+
+	@ Save HCLK PLL state and disable HCLK PLL
+	ldr	SAVED_HCLK_PLL_REG, [CLKPWRBASE_REG, #CLKPWR_HCLKPLL_CTRL(0)]
+	bic	WORK2_REG, SAVED_HCLK_PLL_REG, #CLKPWR_HCLKPLL_POWER_UP
+	str	WORK2_REG, [CLKPWRBASE_REG, #CLKPWR_HCLKPLL_CTRL(0)]
+
+	@ Enter stop mode until an enabled event occurs
+	orr	WORK1_REG, WORK1_REG, #CLKPWR_STOP_MODE_CTRL
+	str	WORK1_REG, [CLKPWRBASE_REG, #CLKPWR_PWR_CTRL(0)]
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
+	bic	WORK1_REG, WORK1_REG, #CLKPWR_STOP_MODE_CTRL
+
+	@ Restore original HCLK PLL value and wait for PLL lock
+	str	SAVED_HCLK_PLL_REG, [CLKPWRBASE_REG, #CLKPWR_HCLKPLL_CTRL(0)]
+4:
+	ldr	WORK2_REG, [CLKPWRBASE_REG, #CLKPWR_HCLKPLL_CTRL(0)]
+	and	WORK2_REG, WORK2_REG, #CLKPWR_HCLKPLL_PLL_STS
+	bne	4b
+
+	@ Re-enter run mode with self-refresh flag cleared, but no DRAM
+	@ update yet. DRAM is still in self-refresh
+	str	SAVED_PWR_CTRL_REG, [CLKPWRBASE_REG, #CLKPWR_PWR_CTRL(0)]
+
+	@ Restore original DRAM clock mode to restore DRAM clocks
+	str	SAVED_HCLK_DIV_REG, [CLKPWRBASE_REG, #CLKPWR_HCLK_DIV(0)]
+
+	@ Clear self-refresh mode
+	orr	WORK1_REG, SAVED_PWR_CTRL_REG, #CLKPWR_UPD_SDRAM_SELF_RFSH
+	str	WORK1_REG, [CLKPWRBASE_REG, #CLKPWR_PWR_CTRL(0)]
+	str	SAVED_PWR_CTRL_REG, [CLKPWRBASE_REG, #CLKPWR_PWR_CTRL(0)]
+
+	@ Wait for EMC to clear self-refresh mode
+5:
+	ldr	WORK2_REG, [EMCBASE_REG, #EMC_STATUS_OFFS]
+	and	WORK2_REG, WORK2_REG, #EMC_STATUS_SELF_RFSH
+	bne	5b @ Branch until self-refresh has exited
+
+	@ restore regs and return
+	adr	r0, tmp_stack
+	ldmfd	r0!, {r1 - r7, sp, pc}
+
+reg_bases:
+	.long	IO_ADDRESS(CLK_PM_BASE)
+	.long	IO_ADDRESS(EMC_BASE)
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
