From: fransmeulenbroeks@gmail.com (Frans Meulenbroeks)
Date: Sun, 30 Oct 2011 12:21:33 +0100
Subject: [PATCH] mach-ixp4xx: made gpio functions atomic
Message-ID: <1319973693-19063-1-git-send-email-fransmeulenbroeks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpio_line_set and gpio_line config on ixp4xx were not atomic
This patch fixes this by surrounding them with local_irq_save and
local_irq_restore calls, similar to the way Lennert Buytenhek
implemented this for iop. (see arch/arm/plat-iop/gpio.c)

Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---

Note: an alternative solution would be to use the set_bit and 
clear_bit atomic functions, but I felt it better to do things
the same way as Lennert did. Also it could be that this is a few
bytes smaller. Didn't check that.

--- git/arch/arm/mach-ixp4xx/include/mach/platform.h.orig	2011-08-09 19:16:52.645482269 +0200
+++ git/arch/arm/mach-ixp4xx/include/mach/platform.h	2011-08-09 19:17:39.915482235 +0200
@@ -14,6 +14,8 @@
 #ifndef __ASSEMBLY__
 
 #include <asm/types.h>
+#include <asm/system.h>
+#include <linux/kernel.h>
 
 #ifndef	__ARMEB__
 #define	REG_OFFSET	0
@@ -150,10 +152,14 @@
 
 static inline void gpio_line_config(u8 line, u32 direction)
 {
+	unsigned long flags;
+
+	local_irq_save(flags);
 	if (direction == IXP4XX_GPIO_IN)
 		*IXP4XX_GPIO_GPOER |= (1 << line);
 	else
 		*IXP4XX_GPIO_GPOER &= ~(1 << line);
+	local_irq_restore(flags);
 }
 
 static inline void gpio_line_get(u8 line, int *value)
@@ -163,10 +169,14 @@
 
 static inline void gpio_line_set(u8 line, int value)
 {
+	unsigned long flags;
+
+	local_irq_save(flags);
 	if (value == IXP4XX_GPIO_HIGH)
 	    *IXP4XX_GPIO_GPOUTR |= (1 << line);
 	else if (value == IXP4XX_GPIO_LOW)
 	    *IXP4XX_GPIO_GPOUTR &= ~(1 << line);
+	local_irq_restore(flags);
 }
 
 #endif // __ASSEMBLY__
