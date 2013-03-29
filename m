From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 29 Mar 2013 16:55:42 +0800
Subject: [PATCH 06/13] ARM: mxs: remove system.c
In-Reply-To: <1364547350-30498-1-git-send-email-shawn.guo@linaro.org>
References: <1364547350-30498-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1364547350-30498-7-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no user of function mxs_reset_block() now.  Let's move
mxs_restart() into mach-mxs.c as a static function and remove system.c
completely.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/Makefile              |    2 +-
 arch/arm/mach-mxs/include/mach/common.h |    2 -
 arch/arm/mach-mxs/mach-mxs.c            |   37 +++++++++
 arch/arm/mach-mxs/system.c              |  137 -------------------------------
 4 files changed, 38 insertions(+), 140 deletions(-)
 delete mode 100644 arch/arm/mach-mxs/system.c

diff --git a/arch/arm/mach-mxs/Makefile b/arch/arm/mach-mxs/Makefile
index b934603..5339973 100644
--- a/arch/arm/mach-mxs/Makefile
+++ b/arch/arm/mach-mxs/Makefile
@@ -1,5 +1,5 @@
 # Common support
-obj-y := ocotp.o system.o mm.o
+obj-y := ocotp.o mm.o
 
 obj-$(CONFIG_PM) += pm.o
 
diff --git a/arch/arm/mach-mxs/include/mach/common.h b/arch/arm/mach-mxs/include/mach/common.h
index df2a4ef..b7946a6 100644
--- a/arch/arm/mach-mxs/include/mach/common.h
+++ b/arch/arm/mach-mxs/include/mach/common.h
@@ -12,8 +12,6 @@
 #define __MACH_MXS_COMMON_H__
 
 extern const u32 *mxs_get_ocotp(void);
-extern int mxs_reset_block(void __iomem *);
-extern void mxs_restart(char, const char *);
 extern int mxs_saif_clkmux_select(unsigned int clkmux);
 
 extern int mx23_clocks_init(void);
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 79a5ce4..a8fe453 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -22,11 +22,13 @@
 #include <linux/irqchip/mxs.h>
 #include <linux/micrel_phy.h>
 #include <linux/mxsfb.h>
+#include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/phy.h>
 #include <linux/pinctrl/consumer.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
+#include <asm/system_misc.h>
 #include <mach/common.h>
 #include <mach/digctl.h>
 #include <mach/mxs.h>
@@ -459,6 +461,41 @@ static void __init mxs_machine_init(void)
 		imx28_evk_post_init();
 }
 
+#define MX23_CLKCTRL_RESET_OFFSET	0x120
+#define MX28_CLKCTRL_RESET_OFFSET	0x1e0
+#define MXS_CLKCTRL_RESET_CHIP		(1 << 1)
+
+/*
+ * Reset the system. It is called by machine_restart().
+ */
+static void mxs_restart(char mode, const char *cmd)
+{
+	struct device_node *np;
+	void __iomem *reset_addr;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,clkctrl");
+	reset_addr = of_iomap(np, 0);
+	if (!reset_addr)
+		goto soft;
+
+	if (of_device_is_compatible(np, "fsl,imx23-clkctrl"))
+		reset_addr += MX23_CLKCTRL_RESET_OFFSET;
+	else
+		reset_addr += MX28_CLKCTRL_RESET_OFFSET;
+
+	/* reset the chip */
+	__mxs_setl(MXS_CLKCTRL_RESET_CHIP, reset_addr);
+
+	pr_err("Failed to assert the chip reset\n");
+
+	/* Delay to allow the serial port to show the message */
+	mdelay(50);
+
+soft:
+	/* We'll take a jump through zero as a poor second */
+	soft_restart(0);
+}
+
 static const char *imx23_dt_compat[] __initdata = {
 	"fsl,imx23",
 	NULL,
diff --git a/arch/arm/mach-mxs/system.c b/arch/arm/mach-mxs/system.c
deleted file mode 100644
index 2d64ee9..0000000
--- a/arch/arm/mach-mxs/system.c
+++ /dev/null
@@ -1,137 +0,0 @@
-/*
- * Copyright (C) 1999 ARM Limited
- * Copyright (C) 2000 Deep Blue Solutions Ltd
- * Copyright 2006-2007,2010 Freescale Semiconductor, Inc. All Rights Reserved.
- * Copyright 2008 Juergen Beisert, kernel at pengutronix.de
- * Copyright 2009 Ilya Yanok, Emcraft Systems Ltd, yanok@emcraft.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/kernel.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/err.h>
-#include <linux/delay.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-
-#include <asm/proc-fns.h>
-#include <asm/system_misc.h>
-
-#include <mach/mxs.h>
-#include <mach/common.h>
-
-#define MX23_CLKCTRL_RESET_OFFSET	0x120
-#define MX28_CLKCTRL_RESET_OFFSET	0x1e0
-#define MXS_CLKCTRL_RESET_CHIP		(1 << 1)
-
-#define MXS_MODULE_CLKGATE		(1 << 30)
-#define MXS_MODULE_SFTRST		(1 << 31)
-
-/*
- * Reset the system. It is called by machine_restart().
- */
-void mxs_restart(char mode, const char *cmd)
-{
-	struct device_node *np;
-	void __iomem *reset_addr;
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,clkctrl");
-	reset_addr = of_iomap(np, 0);
-	if (!reset_addr)
-		goto soft;
-
-	if (of_device_is_compatible(np, "fsl,imx23-clkctrl"))
-		reset_addr += MX23_CLKCTRL_RESET_OFFSET;
-	else
-		reset_addr += MX28_CLKCTRL_RESET_OFFSET;
-
-	/* reset the chip */
-	__mxs_setl(MXS_CLKCTRL_RESET_CHIP, reset_addr);
-
-	pr_err("Failed to assert the chip reset\n");
-
-	/* Delay to allow the serial port to show the message */
-	mdelay(50);
-
-soft:
-	/* We'll take a jump through zero as a poor second */
-	soft_restart(0);
-}
-
-/*
- * Clear the bit and poll it cleared.  This is usually called with
- * a reset address and mask being either SFTRST(bit 31) or CLKGATE
- * (bit 30).
- */
-static int clear_poll_bit(void __iomem *addr, u32 mask)
-{
-	int timeout = 0x400;
-
-	/* clear the bit */
-	__mxs_clrl(mask, addr);
-
-	/*
-	 * SFTRST needs 3 GPMI clocks to settle, the reference manual
-	 * recommends to wait 1us.
-	 */
-	udelay(1);
-
-	/* poll the bit becoming clear */
-	while ((__raw_readl(addr) & mask) && --timeout)
-		/* nothing */;
-
-	return !timeout;
-}
-
-int mxs_reset_block(void __iomem *reset_addr)
-{
-	int ret;
-	int timeout = 0x400;
-
-	/* clear and poll SFTRST */
-	ret = clear_poll_bit(reset_addr, MXS_MODULE_SFTRST);
-	if (unlikely(ret))
-		goto error;
-
-	/* clear CLKGATE */
-	__mxs_clrl(MXS_MODULE_CLKGATE, reset_addr);
-
-	/* set SFTRST to reset the block */
-	__mxs_setl(MXS_MODULE_SFTRST, reset_addr);
-	udelay(1);
-
-	/* poll CLKGATE becoming set */
-	while ((!(__raw_readl(reset_addr) & MXS_MODULE_CLKGATE)) && --timeout)
-		/* nothing */;
-	if (unlikely(!timeout))
-		goto error;
-
-	/* clear and poll SFTRST */
-	ret = clear_poll_bit(reset_addr, MXS_MODULE_SFTRST);
-	if (unlikely(ret))
-		goto error;
-
-	/* clear and poll CLKGATE */
-	ret = clear_poll_bit(reset_addr, MXS_MODULE_CLKGATE);
-	if (unlikely(ret))
-		goto error;
-
-	return 0;
-
-error:
-	pr_err("%s(%p): module reset timeout\n", __func__, reset_addr);
-	return -ETIMEDOUT;
-}
-EXPORT_SYMBOL(mxs_reset_block);
-- 
1.7.9.5
