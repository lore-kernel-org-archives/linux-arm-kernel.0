From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 29 Mar 2013 16:55:46 +0800
Subject: [PATCH 10/13] ARM: mxs: move mxs_get_ocotp() into mach-mxs.c
In-Reply-To: <1364547350-30498-1-git-send-email-shawn.guo@linaro.org>
References: <1364547350-30498-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1364547350-30498-11-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the users of mxs_get_ocotp() are in mach-mxs.c.  Move the function
into mach-mxs.c, make it a static function, and then remove ocotp.c.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/Makefile              |    4 --
 arch/arm/mach-mxs/include/mach/common.h |    1 -
 arch/arm/mach-mxs/mach-mxs.c            |   76 +++++++++++++++++++++++
 arch/arm/mach-mxs/ocotp.c               |  100 -------------------------------
 4 files changed, 76 insertions(+), 105 deletions(-)
 delete mode 100644 arch/arm/mach-mxs/ocotp.c

diff --git a/arch/arm/mach-mxs/Makefile b/arch/arm/mach-mxs/Makefile
index 2568d24..80db726 100644
--- a/arch/arm/mach-mxs/Makefile
+++ b/arch/arm/mach-mxs/Makefile
@@ -1,6 +1,2 @@
-# Common support
-obj-y := ocotp.o
-
 obj-$(CONFIG_PM) += pm.o
-
 obj-$(CONFIG_MACH_MXS_DT) += mach-mxs.o
diff --git a/arch/arm/mach-mxs/include/mach/common.h b/arch/arm/mach-mxs/include/mach/common.h
index 79cb572..aca982c 100644
--- a/arch/arm/mach-mxs/include/mach/common.h
+++ b/arch/arm/mach-mxs/include/mach/common.h
@@ -11,7 +11,6 @@
 #ifndef __MACH_MXS_COMMON_H__
 #define __MACH_MXS_COMMON_H__
 
-extern const u32 *mxs_get_ocotp(void);
 extern int mxs_saif_clkmux_select(unsigned int clkmux);
 
 extern int mx23_clocks_init(void);
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index cf73976..f442b39 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -193,6 +193,82 @@ static void __init imx28_timer_init(void)
 	clocksource_of_init();
 }
 
+#define OCOTP_WORD_OFFSET		0x20
+#define OCOTP_WORD_COUNT		0x20
+
+#define BM_OCOTP_CTRL_BUSY		(1 << 8)
+#define BM_OCOTP_CTRL_ERROR		(1 << 9)
+#define BM_OCOTP_CTRL_RD_BANK_OPEN	(1 << 12)
+
+static DEFINE_MUTEX(ocotp_mutex);
+static u32 ocotp_words[OCOTP_WORD_COUNT];
+
+static const u32 *mxs_get_ocotp(void)
+{
+	struct device_node *np;
+	void __iomem *ocotp_base;
+	int timeout = 0x400;
+	size_t i;
+	static int once;
+
+	if (once)
+		return ocotp_words;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,ocotp");
+	ocotp_base = of_iomap(np, 0);
+	WARN_ON(!ocotp_base);
+
+	mutex_lock(&ocotp_mutex);
+
+	/*
+	 * clk_enable(hbus_clk) for ocotp can be skipped
+	 * as it must be on when system is running.
+	 */
+
+	/* try to clear ERROR bit */
+	__mxs_clrl(BM_OCOTP_CTRL_ERROR, ocotp_base);
+
+	/* check both BUSY and ERROR cleared */
+	while ((__raw_readl(ocotp_base) &
+		(BM_OCOTP_CTRL_BUSY | BM_OCOTP_CTRL_ERROR)) && --timeout)
+		cpu_relax();
+
+	if (unlikely(!timeout))
+		goto error_unlock;
+
+	/* open OCOTP banks for read */
+	__mxs_setl(BM_OCOTP_CTRL_RD_BANK_OPEN, ocotp_base);
+
+	/* approximately wait 32 hclk cycles */
+	udelay(1);
+
+	/* poll BUSY bit becoming cleared */
+	timeout = 0x400;
+	while ((__raw_readl(ocotp_base) & BM_OCOTP_CTRL_BUSY) && --timeout)
+		cpu_relax();
+
+	if (unlikely(!timeout))
+		goto error_unlock;
+
+	for (i = 0; i < OCOTP_WORD_COUNT; i++)
+		ocotp_words[i] = __raw_readl(ocotp_base + OCOTP_WORD_OFFSET +
+						i * 0x10);
+
+	/* close banks for power saving */
+	__mxs_clrl(BM_OCOTP_CTRL_RD_BANK_OPEN, ocotp_base);
+
+	once = 1;
+
+	mutex_unlock(&ocotp_mutex);
+
+	return ocotp_words;
+
+error_unlock:
+	mutex_unlock(&ocotp_mutex);
+	pr_err("%s: timeout in reading OCOTP\n", __func__);
+	return NULL;
+}
+
 enum mac_oui {
 	OUI_FSL,
 	OUI_DENX,
diff --git a/arch/arm/mach-mxs/ocotp.c b/arch/arm/mach-mxs/ocotp.c
deleted file mode 100644
index c2002eb..0000000
--- a/arch/arm/mach-mxs/ocotp.c
+++ /dev/null
@@ -1,100 +0,0 @@
-/*
- * Copyright 2010 Freescale Semiconductor, Inc. All Rights Reserved.
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
-#include <linux/delay.h>
-#include <linux/err.h>
-#include <linux/mutex.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-
-#include <asm/processor.h>	/* for cpu_relax() */
-
-#include <mach/mxs.h>
-#include <mach/common.h>
-
-#define OCOTP_WORD_OFFSET		0x20
-#define OCOTP_WORD_COUNT		0x20
-
-#define BM_OCOTP_CTRL_BUSY		(1 << 8)
-#define BM_OCOTP_CTRL_ERROR		(1 << 9)
-#define BM_OCOTP_CTRL_RD_BANK_OPEN	(1 << 12)
-
-static DEFINE_MUTEX(ocotp_mutex);
-static u32 ocotp_words[OCOTP_WORD_COUNT];
-
-const u32 *mxs_get_ocotp(void)
-{
-	struct device_node *np;
-	void __iomem *ocotp_base;
-	int timeout = 0x400;
-	size_t i;
-	static int once = 0;
-
-	if (once)
-		return ocotp_words;
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,ocotp");
-	ocotp_base = of_iomap(np, 0);
-	WARN_ON(!ocotp_base);
-
-	mutex_lock(&ocotp_mutex);
-
-	/*
-	 * clk_enable(hbus_clk) for ocotp can be skipped
-	 * as it must be on when system is running.
-	 */
-
-	/* try to clear ERROR bit */
-	__mxs_clrl(BM_OCOTP_CTRL_ERROR, ocotp_base);
-
-	/* check both BUSY and ERROR cleared */
-	while ((__raw_readl(ocotp_base) &
-		(BM_OCOTP_CTRL_BUSY | BM_OCOTP_CTRL_ERROR)) && --timeout)
-		cpu_relax();
-
-	if (unlikely(!timeout))
-		goto error_unlock;
-
-	/* open OCOTP banks for read */
-	__mxs_setl(BM_OCOTP_CTRL_RD_BANK_OPEN, ocotp_base);
-
-	/* approximately wait 32 hclk cycles */
-	udelay(1);
-
-	/* poll BUSY bit becoming cleared */
-	timeout = 0x400;
-	while ((__raw_readl(ocotp_base) & BM_OCOTP_CTRL_BUSY) && --timeout)
-		cpu_relax();
-
-	if (unlikely(!timeout))
-		goto error_unlock;
-
-	for (i = 0; i < OCOTP_WORD_COUNT; i++)
-		ocotp_words[i] = __raw_readl(ocotp_base + OCOTP_WORD_OFFSET +
-						i * 0x10);
-
-	/* close banks for power saving */
-	__mxs_clrl(BM_OCOTP_CTRL_RD_BANK_OPEN, ocotp_base);
-
-	once = 1;
-
-	mutex_unlock(&ocotp_mutex);
-
-	return ocotp_words;
-
-error_unlock:
-	mutex_unlock(&ocotp_mutex);
-	pr_err("%s: timeout in reading OCOTP\n", __func__);
-	return NULL;
-}
-- 
1.7.9.5
