From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 07 Jan 2014 21:53:51 +0100
Subject: [PATCH] ARM: SAMSUNG: remove obsolete tick.h
Message-ID: <1907750.XQ1uIOEDlS@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 48cf83dc12f2 (ARM: samsung: remove unused tick.h) removed some
occurences of tick.h. tick.h itself and s3c24xx_ostimer_pending was only
used by the old timer driver and is not used anymore.

Therefore remove the last 3 occurences.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/include/mach/tick.h |   15 --------------
 arch/arm/mach-s3c64xx/include/mach/tick.h |   31 -----------------------------
 arch/arm/mach-s5pc100/include/mach/tick.h |   31 -----------------------------
 3 files changed, 77 deletions(-)
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/tick.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/tick.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/tick.h

diff --git a/arch/arm/mach-s3c24xx/include/mach/tick.h b/arch/arm/mach-s3c24xx/include/mach/tick.h
deleted file mode 100644
index 544da41..0000000
--- a/arch/arm/mach-s3c24xx/include/mach/tick.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* linux/arch/arm/mach-s3c2410/include/mach/tick.h
- *
- * Copyright 2008 Simtec Electronics
- *      Ben Dooks <ben@simtec.co.uk>
- *      http://armlinux.simtec.co.uk/
- *
- * S3C2410 - timer tick support
- */
-
-#define SRCPND_TIMER4 (1<<(IRQ_TIMER4 - IRQ_EINT0))
-
-static inline int s3c24xx_ostimer_pending(void)
-{
-	return __raw_readl(S3C2410_SRCPND) & SRCPND_TIMER4;
-}
diff --git a/arch/arm/mach-s3c64xx/include/mach/tick.h b/arch/arm/mach-s3c64xx/include/mach/tick.h
deleted file mode 100644
index db9c1b1..0000000
--- a/arch/arm/mach-s3c64xx/include/mach/tick.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/* linux/arch/arm/mach-s3c6400/include/mach/tick.h
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C64XX - Timer tick support definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_TICK_H
-#define __ASM_ARCH_TICK_H __FILE__
-
-#include <linux/irqchip/arm-vic.h>
-
-/* note, the timer interrutps turn up in 2 places, the vic and then
- * the timer block. We take the VIC as the base at the moment.
- */
-static inline u32 s3c24xx_ostimer_pending(void)
-{
-	u32 pend = __raw_readl(VA_VIC0 + VIC_RAW_STATUS);
-	return pend & 1 << (IRQ_TIMER4_VIC - S3C64XX_IRQ_VIC0(0));
-}
-
-#define TICK_MAX	(0xffffffff)
-
-#endif /* __ASM_ARCH_6400_TICK_H */
diff --git a/arch/arm/mach-s5pc100/include/mach/tick.h b/arch/arm/mach-s5pc100/include/mach/tick.h
deleted file mode 100644
index 0af8e41..0000000
--- a/arch/arm/mach-s5pc100/include/mach/tick.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/* linux/arch/arm/mach-s5pc100/include/mach/tick.h
- *
- * Copyright 2009 Samsung Electronics Co.
- *	Byungho Min <bhmin@samsung.com>
- *
- * S3C64XX - Timer tick support definitions
- *
- * Based on mach-s3c6400/include/mach/tick.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_TICK_H
-#define __ASM_ARCH_TICK_H __FILE__
-
-#include <linux/irqchip/arm-vic.h>
-
-/* note, the timer interrutps turn up in 2 places, the vic and then
- * the timer block. We take the VIC as the base at the moment.
- */
-static inline u32 s3c24xx_ostimer_pending(void)
-{
-	u32 pend = __raw_readl(VA_VIC0 + VIC_RAW_STATUS);
-	return pend & (1 << (IRQ_TIMER4_VIC - S5P_IRQ_VIC0(0)));
-}
-
-#define TICK_MAX	(0xffffffff)
-
-#endif /* __ASM_ARCH_TICK_H */
-- 
1.7.10.4
