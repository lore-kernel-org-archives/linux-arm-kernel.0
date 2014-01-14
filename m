From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Jan 2014 15:13:08 +0100
Subject: [PATCH] ARM: s3c24xx: explicit dependency on <plat/gpio-cfg.h>
Message-ID: <1389708788-18331-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously the custom GPIO header for the S3C24xx would in turn
bring in the custom pin control implementation from
<plat/gpio-cfg.h>. This is not good as it mixes up two
subsystems and makes the dependencies hard to track. Make
the dependency explicit by explicitly including the pin
control header where needed.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-samsung-soc at vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Maintainers: this builds on top of the previous patch moving
headers back to <mach/*>. This will also boil in linux-next,
ACKs appreciated.
---
 arch/arm/mach-s3c24xx/h1940-bluetooth.c           | 1 +
 arch/arm/mach-s3c24xx/include/mach/gpio-samsung.h | 2 --
 arch/arm/mach-s3c24xx/mach-rx1950.c               | 1 +
 arch/arm/mach-s3c24xx/pm-s3c2410.c                | 1 +
 arch/arm/mach-s3c24xx/setup-ts.c                  | 1 +
 drivers/mmc/host/s3cmci.c                         | 1 +
 6 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/h1940-bluetooth.c b/arch/arm/mach-s3c24xx/h1940-bluetooth.c
index ff3afc163178..b4d14b864367 100644
--- a/arch/arm/mach-s3c24xx/h1940-bluetooth.c
+++ b/arch/arm/mach-s3c24xx/h1940-bluetooth.c
@@ -19,6 +19,7 @@
 #include <linux/gpio.h>
 #include <linux/rfkill.h>
 
+#include <plat/gpio-cfg.h>
 #include <mach/hardware.h>
 #include <mach/regs-gpio.h>
 #include <mach/gpio-samsung.h>
diff --git a/arch/arm/mach-s3c24xx/include/mach/gpio-samsung.h b/arch/arm/mach-s3c24xx/include/mach/gpio-samsung.h
index 79b3a0e44955..528fcdc4f63e 100644
--- a/arch/arm/mach-s3c24xx/include/mach/gpio-samsung.h
+++ b/arch/arm/mach-s3c24xx/include/mach/gpio-samsung.h
@@ -93,8 +93,6 @@ enum s3c_gpio_number {
 #define S3C2410_GPL(_nr)	(S3C2410_GPIO_L_START + (_nr))
 #define S3C2410_GPM(_nr)	(S3C2410_GPIO_M_START + (_nr))
 
-#include <plat/gpio-cfg.h>
-
 #ifdef CONFIG_CPU_S3C244X
 #define S3C_GPIO_END	(S3C2410_GPJ(0) + 32)
 #elif defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2416)
diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
index 345d01aa3524..0a5456cda1bc 100644
--- a/arch/arm/mach-s3c24xx/mach-rx1950.c
+++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
@@ -59,6 +59,7 @@
 #include <plat/pm.h>
 #include <plat/regs-serial.h>
 #include <plat/samsung-time.h>
+#include <plat/gpio-cfg.h>
 
 #include "common.h"
 #include "h1940.h"
diff --git a/arch/arm/mach-s3c24xx/pm-s3c2410.c b/arch/arm/mach-s3c24xx/pm-s3c2410.c
index 509b20b4ab3b..20e481d8a33a 100644
--- a/arch/arm/mach-s3c24xx/pm-s3c2410.c
+++ b/arch/arm/mach-s3c24xx/pm-s3c2410.c
@@ -35,6 +35,7 @@
 #include <mach/regs-gpio.h>
 #include <mach/gpio-samsung.h>
 
+#include <plat/gpio-cfg.h>
 #include <plat/cpu.h>
 #include <plat/pm.h>
 
diff --git a/arch/arm/mach-s3c24xx/setup-ts.c b/arch/arm/mach-s3c24xx/setup-ts.c
index f61f02bdc52f..46466d20257e 100644
--- a/arch/arm/mach-s3c24xx/setup-ts.c
+++ b/arch/arm/mach-s3c24xx/setup-ts.c
@@ -15,6 +15,7 @@
 
 struct platform_device; /* don't need the contents */
 
+#include <plat/gpio-cfg.h>
 #include <mach/hardware.h>
 #include <mach/gpio-samsung.h>
 
diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index e34d499cb316..f23782683a7c 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -23,6 +23,7 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 
+#include <plat/gpio-cfg.h>
 #include <mach/dma.h>
 #include <mach/gpio-samsung.h>
 
-- 
1.8.4.2
