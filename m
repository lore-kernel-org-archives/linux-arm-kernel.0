From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 18 Dec 2010 21:39:27 +0800
Subject: [PATCH v7 03/15] ARM: mxs: Add reset routines
In-Reply-To: <1292679575-2635-1-git-send-email-shawn.guo@freescale.com>
References: <1292679575-2635-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1292679575-2635-2-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 - The mxs wdog is implemented in RTC block.
 - There is a generic software reset routine for most modules on mxs.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
Changes for v7:
 - Use CLKCTRL_RESET_CHIP over RTC_WATCHDOG to implement arch_reset

Changes for v6:
 - Use __mxs_setl() and __mxs_clrl() for bit set/clear

Changes for v4:
 - Add blank line above comment to make the code easy to read
 - Tell compiler unlikely(ret)
 - Make mxs_arch_reset_init __initcall

Changes for v3:
 - Change wdog timeout to 10ms for safety
 - Simplify function mxs_reset_block() to get it look better

Changes for v2:
 - Move rtc clock enabling from arch_reset() into mxs_arch_reset_init()

 arch/arm/mach-mxs/include/mach/system.h |   27 ++++++
 arch/arm/mach-mxs/system.c              |  137 +++++++++++++++++++++++++++++++
 2 files changed, 164 insertions(+), 0 deletions(-)
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
index 0000000..9343d7e
--- /dev/null
+++ b/arch/arm/mach-mxs/system.c
@@ -0,0 +1,137 @@
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
+#include <linux/init.h>
+
+#include <asm/proc-fns.h>
+#include <asm/system.h>
+
+#include <mach/mxs.h>
+#include <mach/common.h>
+
+#define MX23_CLKCTRL_RESET_OFFSET	0x120
+#define MX28_CLKCTRL_RESET_OFFSET	0x1e0
+#define MXS_CLKCTRL_RESET_CHIP		(1 << 1)
+
+#define MXS_MODULE_CLKGATE		(1 << 30)
+#define MXS_MODULE_SFTRST		(1 << 31)
+
+static void __iomem *mxs_clkctrl_reset_addr;
+
+/*
+ * Reset the system. It is called by machine_restart().
+ */
+void arch_reset(char mode, const char *cmd)
+{
+	/* reset the chip */
+	__mxs_setl(MXS_CLKCTRL_RESET_CHIP, mxs_clkctrl_reset_addr);
+
+	pr_err("Failed to assert the chip reset\n");
+
+	/* Delay to allow the serial port to show the message */
+	mdelay(50);
+
+	/* We'll take a jump through zero as a poor second */
+	cpu_reset(0);
+}
+
+static int __init mxs_arch_reset_init(void)
+{
+	struct clk *clk;
+
+	mxs_clkctrl_reset_addr = MXS_IO_ADDRESS(MXS_CLKCTRL_BASE_ADDR) +
+				(cpu_is_mx23() ? MX23_CLKCTRL_RESET_OFFSET :
+						 MX28_CLKCTRL_RESET_OFFSET);
+
+	clk = clk_get_sys("rtc", NULL);
+	if (!IS_ERR(clk))
+		clk_enable(clk);
+
+	return 0;
+}
+core_initcall(mxs_arch_reset_init);
+
+/*
+ * Clear the bit and poll it cleared.  This is usually called with
+ * a reset address and mask being either SFTRST(bit 31) or CLKGATE
+ * (bit 30).
+ */
+static int clear_poll_bit(void __iomem *addr, u32 mask)
+{
+	int timeout = 0x400;
+
+	/* clear the bit */
+	__mxs_clrl(mask, addr);
+
+	/*
+	 * SFTRST needs 3 GPMI clocks to settle, the reference manual
+	 * recommends to wait 1us.
+	 */
+	udelay(1);
+
+	/* poll the bit becoming clear */
+	while ((__raw_readl(addr) & mask) && --timeout)
+		/* nothing */;
+
+	return !timeout;
+}
+
+int mxs_reset_block(void __iomem *reset_addr)
+{
+	int ret;
+	int timeout = 0x400;
+
+	/* clear and poll SFTRST */
+	ret = clear_poll_bit(reset_addr, MXS_MODULE_SFTRST);
+	if (unlikely(ret))
+		goto error;
+
+	/* clear CLKGATE */
+	__mxs_clrl(MXS_MODULE_CLKGATE, reset_addr);
+
+	/* set SFTRST to reset the block */
+	__mxs_setl(MXS_MODULE_SFTRST, reset_addr);
+	udelay(1);
+
+	/* poll CLKGATE becoming set */
+	while ((!(__raw_readl(reset_addr) & MXS_MODULE_CLKGATE)) && --timeout)
+		/* nothing */;
+	if (unlikely(!timeout))
+		goto error;
+
+	/* clear and poll SFTRST */
+	ret = clear_poll_bit(reset_addr, MXS_MODULE_SFTRST);
+	if (unlikely(ret))
+		goto error;
+
+	/* clear and poll CLKGATE */
+	ret = clear_poll_bit(reset_addr, MXS_MODULE_CLKGATE);
+	if (unlikely(ret))
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
