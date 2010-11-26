From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 26 Nov 2010 14:49:02 +0800
Subject: [PATCH 03/15] ARM: mxs: Add reset routines
In-Reply-To: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1290754154-9428-4-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* The mxs wdog is implemented in RTC block.
* There is a generic software reset routine for most modules on mxs.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/include/mach/system.h |   27 ++++++
 arch/arm/mach-mxs/system.c              |  152 +++++++++++++++++++++++++++++++
 2 files changed, 179 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/include/mach/system.h
 create mode 100644 arch/arm/mach-mxs/system.c

diff --git a/arch/arm/mach-mxs/include/mach/system.h b/arch/arm/mach-mxs/include/mach/system.h
new file mode 100644
index 0000000..0e42823
--- /dev/null
+++ b/arch/arm/mach-mxs/include/mach/system.h
@@ -0,0 +1,27 @@
+/*
+ *  Copyright (C) 1999 ARM Limited
+ *  Copyright (C) 2000 Deep Blue Solutions Ltd
+ *  Copyright 2004-2008 Freescale Semiconductor, Inc. All Rights Reserved.
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
+#ifndef __MACH_MXS_SYSTEM_H__
+#define __MACH_MXS_SYSTEM_H__
+
+static inline void arch_idle(void)
+{
+	cpu_do_idle();
+}
+
+void arch_reset(char mode, const char *cmd);
+
+#endif /* __MACH_MXS_SYSTEM_H__ */
diff --git a/arch/arm/mach-mxs/system.c b/arch/arm/mach-mxs/system.c
new file mode 100644
index 0000000..de33c66
--- /dev/null
+++ b/arch/arm/mach-mxs/system.c
@@ -0,0 +1,152 @@
+/*
+ * Copyright (C) 1999 ARM Limited
+ * Copyright (C) 2000 Deep Blue Solutions Ltd
+ * Copyright 2006-2007,2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright 2008 Juergen Beisert, kernel at pengutronix.de
+ * Copyright 2009 Ilya Yanok, Emcraft Systems Ltd, yanok at emcraft.com
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
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+
+#include <asm/proc-fns.h>
+#include <asm/system.h>
+
+#include <mach/hardware.h>
+#include <mach/common.h>
+
+#define MXS_RTC_WATCHDOG	0x50
+#define MXS_WATCHDOG_EN		(1 << 4)
+
+#define MXS_MODULE_CLKGATE	(1 << 30)
+#define MXS_MODULE_SFTRST	(1 << 31)
+
+static void __iomem *wdog_base;
+
+/*
+ * Reset the system. It is called by machine_restart().
+ */
+void arch_reset(char mode, const char *cmd)
+{
+	struct clk *clk;
+
+	clk = clk_get_sys("rtc", NULL);
+	if (!IS_ERR(clk))
+		clk_enable(clk);
+
+	/* Set wdog count */
+	__raw_writel(1, wdog_base + MXS_RTC_WATCHDOG);
+
+	/* Assert SRS signal */
+	__raw_writel(MXS_WATCHDOG_EN, wdog_base + MXS_SET_ADDR);
+
+	/* Wait for reset to assert... */
+	mdelay(500);
+
+	pr_err("Watchdog reset failed to assert reset\n");
+
+	/* Delay to allow the serial port to show the message */
+	mdelay(50);
+
+	/* We'll take a jump through zero as a poor second */
+	cpu_reset(0);
+}
+
+void mxs_arch_reset_init(void __iomem *base)
+{
+	wdog_base = base;
+}
+
+int mxs_reset_block(void __iomem *reset_addr)
+{
+	u32 val;
+	int timeout;
+
+	/*
+	 * The process of software reset of IP block is done
+	 * in several steps:
+	 *
+	 * 1) clear SFTRST and wait it cleared;
+	 * 2) clear CLKGATE, set SFTRST, wait CLKGATE set;
+	 * 3) clear SFTRST and wait it cleared;
+	 * 4) clear CLKGATE and wait it cleared.
+	 */
+
+	/* Clear SFTRST */
+	val = __raw_readl(reset_addr);
+	val &= ~MXS_MODULE_SFTRST;
+	__raw_writel(val, reset_addr);
+	/*
+	 * SFTRST needs 3 GPMI clocks to settle, the reference manual
+	 * recommends to wait 1us.
+	 */
+	udelay(1);
+	/* Poll SFTRST cleared */
+	timeout = 0x400;
+	while ((__raw_readl(reset_addr) & MXS_MODULE_SFTRST) && --timeout)
+		/* nothing */;
+	if (!timeout)
+		goto error;
+
+	/* Clear CLKGATE */
+	val = __raw_readl(reset_addr);
+	val &= ~MXS_MODULE_CLKGATE;
+	__raw_writel(val, reset_addr);
+	/* Set SFTRST to reset the block */
+	val = __raw_readl(reset_addr);
+	val |= MXS_MODULE_SFTRST;
+	__raw_writel(val, reset_addr);
+	/* Wait 1us */
+	udelay(1);
+	/* Poll CLKGATE set */
+	timeout = 0x400;
+	while ((!(__raw_readl(reset_addr) & MXS_MODULE_CLKGATE)) && --timeout)
+		/* nothing */;
+	if (!timeout)
+		goto error;
+
+	/* Clear SFTRST */
+	val = __raw_readl(reset_addr);
+	val &= ~MXS_MODULE_SFTRST;
+	__raw_writel(val, reset_addr);
+	/* Wait 1us */
+	udelay(1);
+	/* Poll SFTRST cleared */
+	timeout = 0x400;
+	while ((__raw_readl(reset_addr) & MXS_MODULE_SFTRST) && --timeout)
+		/* nothing */;
+	if (!timeout)
+		goto error;
+
+	/* Clear CLKGATE */
+	val = __raw_readl(reset_addr);
+	val &= ~MXS_MODULE_CLKGATE;
+	__raw_writel(val, reset_addr);
+	/* Wait 1us */
+	udelay(1);
+	/* Poll CLKGATE cleared */
+	timeout = 0x400;
+	while ((__raw_readl(reset_addr) & MXS_MODULE_CLKGATE) && --timeout)
+		/* nothing */;
+	if (!timeout)
+		goto error;
+
+	return 0;
+
+error:
+	pr_err("%s(%p): module reset timeout\n", __func__, reset_addr);
+	return -ETIMEDOUT;
+}
-- 
1.7.1
