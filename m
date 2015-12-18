From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Dec 2015 15:46:54 +0100
Subject: [PATCH] ARM: s3c64xx: fix pm-debug compilation
Message-ID: <5515725.ojLSny3TOX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I got one randconfig build that failed to compile plat-samsung/pm-debug.c
on s3c64xx:

In file included from arch/arm/plat-samsung/pm-debug.c:27:0:
arch/arm/mach-s3c64xx/include/mach/pm-core.h: In function 's3c_pm_debug_init_uart':
arch/arm/mach-s3c64xx/include/mach/pm-core.h:25:25: error: 'S3C_VA_SYS' undeclared (first use in this function)
  u32 tmp = __raw_readl(S3C_PCLK_GATE);
arch/arm/mach-s3c64xx/include/mach/pm-core.h:25:25: note: each undeclared identifier is reported only once for each function it appears in
arch/arm/mach-s3c64xx/include/mach/pm-core.h:39:2: error: implicit declaration of function 'udelay' [-Werror=implicit-function-declaration]
  udelay(10);

I have not investigated why this does not show up much more often, I
guess the headers are usually included from elsewhere, but adding
explicit #include statements is an obvious fix.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I suspect this has been broken for a long time, so no rush, but please
apply this to a cleanup branch.

diff --git a/arch/arm/mach-s3c64xx/include/mach/pm-core.h b/arch/arm/mach-s3c64xx/include/mach/pm-core.h
index 5be8fe368e54..4a285e97afff 100644
--- a/arch/arm/mach-s3c64xx/include/mach/pm-core.h
+++ b/arch/arm/mach-s3c64xx/include/mach/pm-core.h
@@ -16,9 +16,11 @@
 #define __MACH_S3C64XX_PM_CORE_H __FILE__
 
 #include <linux/serial_s3c.h>
+#include <linux/delay.h>
 
 #include <mach/regs-gpio.h>
 #include <mach/regs-clock.h>
+#include <mach/map.h>
 
 static inline void s3c_pm_debug_init_uart(void)
 {
