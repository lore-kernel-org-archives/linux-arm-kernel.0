From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 21 Jan 2013 17:12:08 -0800
Subject: [PATCH 3/6] ARM: S3C2412: Remove useless codes mach-s3c2412/gpio.c
In-Reply-To: <1358817131-27169-1-git-send-email-kgene.kim@samsung.com>
References: <1358817131-27169-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1358817131-27169-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c2412/gpio.c                  |   62 -------------------------
 arch/arm/mach-s3c24xx/include/mach/hardware.h |    6 ---
 2 files changed, 68 deletions(-)
 delete mode 100644 arch/arm/mach-s3c2412/gpio.c

diff --git a/arch/arm/mach-s3c2412/gpio.c b/arch/arm/mach-s3c2412/gpio.c
deleted file mode 100644
index 4526f6b..0000000
--- a/arch/arm/mach-s3c2412/gpio.c
+++ /dev/null
@@ -1,62 +0,0 @@
-/* linux/arch/arm/mach-s3c2412/gpio.c
- *
- * Copyright (c) 2007 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * http://armlinux.simtec.co.uk/.
- *
- * S3C2412/S3C2413 specific GPIO support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/gpio.h>
-
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-
-#include <mach/regs-gpio.h>
-#include <mach/hardware.h>
-
-#include <plat/gpio-core.h>
-
-int s3c2412_gpio_set_sleepcfg(unsigned int pin, unsigned int state)
-{
-	struct samsung_gpio_chip *chip = samsung_gpiolib_getchip(pin);
-	unsigned long offs = pin - chip->chip.base;
-	unsigned long flags;
-	unsigned long slpcon;
-
-	offs *= 2;
-
-	if (pin < S3C2410_GPB(0))
-		return -EINVAL;
-
-	if (pin >= S3C2410_GPF(0) &&
-	    pin <= S3C2410_GPG(16))
-		return -EINVAL;
-
-	if (pin > S3C2410_GPH(16))
-		return -EINVAL;
-
-	local_irq_save(flags);
-
-	slpcon = __raw_readl(chip->base + 0x0C);
-
-	slpcon &= ~(3 << offs);
-	slpcon |= state << offs;
-
-	__raw_writel(slpcon, chip->base + 0x0C);
-
-	local_irq_restore(flags);
-
-	return 0;
-}
-
-EXPORT_SYMBOL(s3c2412_gpio_set_sleepcfg);
diff --git a/arch/arm/mach-s3c24xx/include/mach/hardware.h b/arch/arm/mach-s3c24xx/include/mach/hardware.h
index aef5631..a6cc14a 100644
--- a/arch/arm/mach-s3c24xx/include/mach/hardware.h
+++ b/arch/arm/mach-s3c24xx/include/mach/hardware.h
@@ -23,12 +23,6 @@ extern int s3c2440_set_dsc(unsigned int pin, unsigned int value);
 
 #endif /* CONFIG_CPU_S3C2440 */
 
-#ifdef CONFIG_CPU_S3C2412
-
-extern int s3c2412_gpio_set_sleepcfg(unsigned int pin, unsigned int state);
-
-#endif /* CONFIG_CPU_S3C2412 */
-
 #endif /* __ASSEMBLY__ */
 
 #include <asm/sizes.h>
-- 
1.7.10.4
