From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Mon, 17 Oct 2011 21:35:12 +0800
Subject: [PATCH v5 06/11] ARM: pxa: remove head file in plat-pxa
In-Reply-To: <1318858517-22494-1-git-send-email-haojian.zhuang@marvell.com>
References: <1318858517-22494-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1318858517-22494-7-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use generic API for gpio read and write. So head file in plat-pxa could
be removed.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/plat-pxa/include/plat/gpio.h |   30 ------------------------------
 1 files changed, 0 insertions(+), 30 deletions(-)
 delete mode 100644 arch/arm/plat-pxa/include/plat/gpio.h

diff --git a/arch/arm/plat-pxa/include/plat/gpio.h b/arch/arm/plat-pxa/include/plat/gpio.h
deleted file mode 100644
index 258f772..0000000
--- a/arch/arm/plat-pxa/include/plat/gpio.h
+++ /dev/null
@@ -1,30 +0,0 @@
-#ifndef __PLAT_GPIO_H
-#define __PLAT_GPIO_H
-
-#define __ARM_GPIOLIB_COMPLEX
-
-/* The individual machine provides register offsets and NR_BUILTIN_GPIO */
-#include <mach/gpio-pxa.h>
-
-static inline int gpio_get_value(unsigned gpio)
-{
-	if (__builtin_constant_p(gpio) && (gpio < NR_BUILTIN_GPIO))
-		return GPLR(gpio) & GPIO_bit(gpio);
-	else
-		return __gpio_get_value(gpio);
-}
-
-static inline void gpio_set_value(unsigned gpio, int value)
-{
-	if (__builtin_constant_p(gpio) && (gpio < NR_BUILTIN_GPIO)) {
-		if (value)
-			GPSR(gpio) = GPIO_bit(gpio);
-		else
-			GPCR(gpio) = GPIO_bit(gpio);
-	} else
-		__gpio_set_value(gpio, value);
-}
-
-#define gpio_cansleep		__gpio_cansleep
-
-#endif /* __PLAT_GPIO_H */
-- 
1.7.2.5
