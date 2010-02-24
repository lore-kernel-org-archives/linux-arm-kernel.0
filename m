From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:08:16 +0100
Subject: [PATCH 21/39] arm/imx: remove MTD_XIP support
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-21-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is broken since at least one year when

	ec996ba (mxc timer: make compile time independent)

removed the symbol MXC_TCN.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Kconfig                         |    1 -
 arch/arm/plat-mxc/include/mach/mtd-xip.h |   34 ------------------------------
 2 files changed, 0 insertions(+), 35 deletions(-)
 delete mode 100644 arch/arm/plat-mxc/include/mach/mtd-xip.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9c78cfb..3bf3d48 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -308,7 +308,6 @@ config ARCH_MXC
 	bool "Freescale MXC/iMX-based"
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
-	select ARCH_MTD_XIP
 	select ARCH_REQUIRE_GPIOLIB
 	select HAVE_CLK
 	select COMMON_CLKDEV
diff --git a/arch/arm/plat-mxc/include/mach/mtd-xip.h b/arch/arm/plat-mxc/include/mach/mtd-xip.h
deleted file mode 100644
index 1ab1bba..0000000
--- a/arch/arm/plat-mxc/include/mach/mtd-xip.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * MTD primitives for XIP support. Architecture specific functions
- *
- * Do not include this file directly. It's included from linux/mtd/xip.h
- *
- * Copyright (C) 2008 Darius Augulis <augulis.darius@gmail.com>, Teltonika, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-
-#include <mach/mxc_timer.h>
-
-#ifndef __ARCH_IMX_MTD_XIP_H__
-#define __ARCH_IMX_MTD_XIP_H__
-
-#ifdef CONFIG_ARCH_MX1
-/* AITC registers */
-#define AITC_BASE	IO_ADDRESS(AVIC_BASE_ADDR)
-#define NIPNDH		(AITC_BASE + 0x58)
-#define NIPNDL		(AITC_BASE + 0x5C)
-#define INTENABLEH	(AITC_BASE + 0x10)
-#define INTENABLEL	(AITC_BASE + 0x14)
-/* MTD macros */
-#define xip_irqpending() ((__raw_readl(INTENABLEH) &  __raw_readl(NIPNDH)) \
-			|| (__raw_readl(INTENABLEL) &  __raw_readl(NIPNDL)))
-#define xip_currtime()		(__raw_readl(TIMER_BASE + MXC_TCN))
-#define xip_elapsed_since(x)	(signed)((__raw_readl(TIMER_BASE + MXC_TCN) - (x)) / 96)
-#define xip_cpu_idle()		asm volatile ("mcr p15, 0, %0, c7, c0, 4" :: "r" (0))
-#endif /* CONFIG_ARCH_MX1 */
-
-#endif /* __ARCH_IMX_MTD_XIP_H__ */
-- 
1.6.6.2
