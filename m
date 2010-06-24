From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:11 +0200
Subject: [PATCH 15/61] ARM: imx/mx1: fold crm_regs.h into its only consumer
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-16-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As crm_regs.h is GPL-v2 only don't allow "(at your option) any later
version" for clock.c any more.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx1/clock.c    |   47 ++++++++++++++++++++++++++++++-----
 arch/arm/mach-mx1/crm_regs.h |   55 ------------------------------------------
 2 files changed, 40 insertions(+), 62 deletions(-)
 delete mode 100644 arch/arm/mach-mx1/crm_regs.h

diff --git a/arch/arm/mach-mx1/clock.c b/arch/arm/mach-mx1/clock.c
index 610b88d..c05096c 100644
--- a/arch/arm/mach-mx1/clock.c
+++ b/arch/arm/mach-mx1/clock.c
@@ -2,18 +2,17 @@
  *  Copyright (C) 2008 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
  *
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
  */
 
 #include <linux/kernel.h>
@@ -29,7 +28,41 @@
 #include <mach/clock.h>
 #include <mach/hardware.h>
 #include <mach/common.h>
-#include "crm_regs.h"
+
+#define IO_ADDR_CCM(off)	(MX1_IO_ADDRESS(MX1_CCM_BASE_ADDR + (off)))
+
+/* CCM register addresses */
+#define CCM_CSCR	IO_ADDR_CCM(0x0)
+#define CCM_MPCTL0	IO_ADDR_CCM(0x4)
+#define CCM_SPCTL0	IO_ADDR_CCM(0xc)
+#define CCM_PCDR	IO_ADDR_CCM(0x20)
+
+#define CCM_CSCR_CLKO_OFFSET	29
+#define CCM_CSCR_CLKO_MASK	(0x7 << 29)
+#define CCM_CSCR_USB_OFFSET	26
+#define CCM_CSCR_USB_MASK	(0x7 << 26)
+#define CCM_CSCR_OSC_EN_SHIFT	17
+#define CCM_CSCR_SYSTEM_SEL	(1 << 16)
+#define CCM_CSCR_BCLK_OFFSET	10
+#define CCM_CSCR_BCLK_MASK	(0xf << 10)
+#define CCM_CSCR_PRESC		(1 << 15)
+
+#define CCM_PCDR_PCLK3_OFFSET	16
+#define CCM_PCDR_PCLK3_MASK	(0x7f << 16)
+#define CCM_PCDR_PCLK2_OFFSET	4
+#define CCM_PCDR_PCLK2_MASK	(0xf << 4)
+#define CCM_PCDR_PCLK1_OFFSET	0
+#define CCM_PCDR_PCLK1_MASK	0xf
+
+#define IO_ADDR_SCM(off)	(MX1_IO_ADDRESS(MX1_SCM_BASE_ADDR + (off)))
+
+/* SCM register addresses */
+#define SCM_GCCR	IO_ADDR_SCM(0xc)
+
+#define SCM_GCCR_DMA_CLK_EN_OFFSET	3
+#define SCM_GCCR_CSI_CLK_EN_OFFSET	2
+#define SCM_GCCR_MMA_CLK_EN_OFFSET	1
+#define SCM_GCCR_USBD_CLK_EN_OFFSET	0
 
 static int _clk_enable(struct clk *clk)
 {
diff --git a/arch/arm/mach-mx1/crm_regs.h b/arch/arm/mach-mx1/crm_regs.h
deleted file mode 100644
index 13e81e6..0000000
--- a/arch/arm/mach-mx1/crm_regs.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/*
- * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
- * Copyright (c) 2008 Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
- *
- * This file may be distributed under the terms of the GNU General
- * Public License, version 2.
- */
-
-#ifndef __ARCH_ARM_MACH_MX1_CRM_REGS_H__
-#define __ARCH_ARM_MACH_MX1_CRM_REGS_H__
-
-#define CCM_BASE	MX1_IO_ADDRESS(MX1_CCM_BASE_ADDR)
-#define SCM_BASE	MX1_IO_ADDRESS(MX1_SCM_BASE_ADDR)
-
-/* CCM register addresses */
-#define CCM_CSCR	(CCM_BASE + 0x0)
-#define CCM_MPCTL0	(CCM_BASE + 0x4)
-#define CCM_MPCTL1	(CCM_BASE + 0x8)
-#define CCM_SPCTL0	(CCM_BASE + 0xC)
-#define CCM_SPCTL1	(CCM_BASE + 0x10)
-#define CCM_PCDR	(CCM_BASE + 0x20)
-
-#define CCM_CSCR_CLKO_OFFSET	29
-#define CCM_CSCR_CLKO_MASK	(0x7 << 29)
-#define CCM_CSCR_USB_OFFSET	26
-#define CCM_CSCR_USB_MASK	(0x7 << 26)
-#define CCM_CSCR_SPLL_RESTART	(1 << 22)
-#define CCM_CSCR_MPLL_RESTART	(1 << 21)
-#define CCM_CSCR_OSC_EN_SHIFT	17
-#define CCM_CSCR_SYSTEM_SEL	(1 << 16)
-#define CCM_CSCR_BCLK_OFFSET	10
-#define CCM_CSCR_BCLK_MASK	(0xF << 10)
-#define CCM_CSCR_PRESC		(1 << 15)
-#define CCM_CSCR_SPEN		(1 << 1)
-#define CCM_CSCR_MPEN		(1 << 0)
-
-#define CCM_PCDR_PCLK3_OFFSET	16
-#define CCM_PCDR_PCLK3_MASK	(0x7F << 16)
-#define CCM_PCDR_PCLK2_OFFSET	4
-#define CCM_PCDR_PCLK2_MASK	(0xF << 4)
-#define CCM_PCDR_PCLK1_OFFSET	0
-#define CCM_PCDR_PCLK1_MASK	0xF
-
-/* SCM register addresses */
-#define SCM_SIDR	(SCM_BASE + 0x0)
-#define SCM_FMCR	(SCM_BASE + 0x4)
-#define SCM_GPCR	(SCM_BASE + 0x8)
-#define SCM_GCCR	(SCM_BASE + 0xC)
-
-#define SCM_GCCR_DMA_CLK_EN_OFFSET	3
-#define SCM_GCCR_CSI_CLK_EN_OFFSET	2
-#define SCM_GCCR_MMA_CLK_EN_OFFSET	1
-#define SCM_GCCR_USBD_CLK_EN_OFFSET	0
-
-#endif /* __ARCH_ARM_MACH_MX2_CRM_REGS_H__ */
-- 
1.7.1
