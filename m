From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  5 Mar 2013 18:42:32 +0100
Subject: [PATCH 22/23] ARM: exynos: work around missing gpio code on
 multiplatform
In-Reply-To: <1362505353-8873-1-git-send-email-arnd@arndb.de>
References: <1362505353-8873-1-git-send-email-arnd@arndb.de>
Message-ID: <1362505353-8873-23-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With CONFIG_ARCH_MULTIPLATFORM, we can no longer have
our own mach/gpio.h included by the kernel-wide linux/gpio.h
header, and disabling the gpio-samsung driver means we cannot
use any of the private interfaces. This patch disables
all code referring to the driver and gets things to build
again, but surely breaks a lot of stuff in the process.

Thomas Abraham alrady has a proper set of patches to
address this.

Do not apply.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-exynos/Makefile                  | 2 ++
 arch/arm/mach-exynos/common.c                  | 3 +++
 arch/arm/mach-exynos/dev-audio.c               | 1 +
 arch/arm/mach-exynos/include/mach/gpio.h       | 2 ++
 arch/arm/mach-exynos/mach-armlex4210.c         | 1 +
 arch/arm/mach-exynos/mach-origen.c             | 1 +
 arch/arm/mach-exynos/setup-i2c0.c              | 3 ++-
 arch/arm/mach-s3c64xx/include/mach/gpio.h      | 4 ++++
 arch/arm/plat-samsung/include/plat/gpio-core.h | 3 +++
 arch/arm/plat-samsung/pm-gpio.c                | 1 +
 drivers/gpio/Makefile                          | 2 +-
 11 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index b0dcf7d..e2f1742 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -50,7 +50,9 @@ obj-$(CONFIG_MACH_EXYNOS5_DT)		+= mach-exynos5-dt.o
 # device support
 
 obj-y					+= dev-uart.o
+ifdef CONFIG_ARCH_EXYNOS_SINGLE
 obj-$(CONFIG_ARCH_EXYNOS4)		+= dev-audio.o
+endif
 obj-$(CONFIG_EXYNOS4_DEV_AHCI)		+= dev-ahci.o
 obj-$(CONFIG_EXYNOS_DEV_DMA)		+= dma.o
 obj-$(CONFIG_EXYNOS4_DEV_USB_OHCI)	+= dev-ohci.o
diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 504d50e..59607b5 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -37,6 +37,7 @@
 #include <mach/regs-irq.h>
 #include <mach/regs-pmu.h>
 #include <mach/regs-gpio.h>
+#include <mach/gpio.h>
 
 #include <plat/cpu.h>
 #include <plat/clock.h>
@@ -745,10 +746,12 @@ static int exynos_irq_eint_set_type(struct irq_data *data, unsigned int type)
 	__raw_writel(ctrl, EINT_CON(exynos_eint_base, data->irq));
 	spin_unlock(&eint_lock);
 
+#ifdef CONFIG_ARCH_EXYNOS_SINGLE
 	if (soc_is_exynos5250())
 		s3c_gpio_cfgpin(exynos5_irq_to_gpio(data->irq), S3C_GPIO_SFN(0xf));
 	else
 		s3c_gpio_cfgpin(exynos4_irq_to_gpio(data->irq), S3C_GPIO_SFN(0xf));
+#endif
 
 	return 0;
 }
diff --git a/arch/arm/mach-exynos/dev-audio.c b/arch/arm/mach-exynos/dev-audio.c
index c662c89..25b173b 100644
--- a/arch/arm/mach-exynos/dev-audio.c
+++ b/arch/arm/mach-exynos/dev-audio.c
@@ -21,6 +21,7 @@
 #include <mach/map.h>
 #include <mach/dma.h>
 #include <mach/irqs.h>
+#include <mach/gpio.h>
 
 #define EXYNOS4_AUDSS_INT_MEM	(0x03000000)
 
diff --git a/arch/arm/mach-exynos/include/mach/gpio.h b/arch/arm/mach-exynos/include/mach/gpio.h
index eb24f1e..88c6d26 100644
--- a/arch/arm/mach-exynos/include/mach/gpio.h
+++ b/arch/arm/mach-exynos/include/mach/gpio.h
@@ -284,6 +284,8 @@ enum exynos5_gpio_number {
 
 /* define the number of gpios */
 
+#ifdef CONFIG_MACH_EXYNOS_SINGLE
 #define ARCH_NR_GPIOS		(CONFIG_SAMSUNG_GPIO_EXTRA + S3C_GPIO_END)
+#endif
 
 #endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-exynos/mach-armlex4210.c b/arch/arm/mach-exynos/mach-armlex4210.c
index cb95992..2a8e7c1 100644
--- a/arch/arm/mach-exynos/mach-armlex4210.c
+++ b/arch/arm/mach-exynos/mach-armlex4210.c
@@ -27,6 +27,7 @@
 
 #include <mach/irqs.h>
 #include <mach/map.h>
+#include <mach/gpio.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-exynos/mach-origen.c b/arch/arm/mach-exynos/mach-origen.c
index d1849d1..72650e2 100644
--- a/arch/arm/mach-exynos/mach-origen.c
+++ b/arch/arm/mach-exynos/mach-origen.c
@@ -47,6 +47,7 @@
 
 #include <mach/map.h>
 #include <mach/irqs.h>
+#include <mach/gpio.h>
 
 #include <drm/exynos_drm.h>
 #include "common.h"
diff --git a/arch/arm/mach-exynos/setup-i2c0.c b/arch/arm/mach-exynos/setup-i2c0.c
index e2d9dfb..95acd62 100644
--- a/arch/arm/mach-exynos/setup-i2c0.c
+++ b/arch/arm/mach-exynos/setup-i2c0.c
@@ -17,10 +17,11 @@ struct platform_device; /* don't need the contents */
 #include <linux/platform_data/i2c-s3c2410.h>
 #include <plat/gpio-cfg.h>
 #include <plat/cpu.h>
+#include <mach/gpio.h>
 
 void s3c_i2c0_cfg_gpio(struct platform_device *dev)
 {
-	if (soc_is_exynos5250() || soc_is_exynos5440())
+	if (soc_is_exynos5250() || soc_is_exynos5440() || !IS_ENABLED(CONFIG_ARCH_EXYNOS_SINGLE))
 		/* will be implemented with gpio function */
 		return;
 
diff --git a/arch/arm/mach-s3c64xx/include/mach/gpio.h b/arch/arm/mach-s3c64xx/include/mach/gpio.h
index 8b540c4..95be5b5 100644
--- a/arch/arm/mach-s3c64xx/include/mach/gpio.h
+++ b/arch/arm/mach-s3c64xx/include/mach/gpio.h
@@ -11,6 +11,8 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
 */
+#ifndef __MACH_GPIO_H
+#define __MACH_GPIO_H
 
 /* GPIO bank sizes */
 #define S3C64XX_GPIO_A_NR	(8)
@@ -91,3 +93,5 @@ enum s3c_gpio_number {
 #define BOARD_NR_GPIOS	(16 + CONFIG_SAMSUNG_GPIO_EXTRA)
 
 #define ARCH_NR_GPIOS	(GPIO_BOARD_START + BOARD_NR_GPIOS)
+
+#endif /* __MACH_GPIO_H */
diff --git a/arch/arm/plat-samsung/include/plat/gpio-core.h b/arch/arm/plat-samsung/include/plat/gpio-core.h
index cf5aae5..103a958 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-core.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-core.h
@@ -101,6 +101,9 @@ extern struct samsung_gpio_chip *s3c_gpios[S3C_GPIO_END];
 
 static inline struct samsung_gpio_chip *samsung_gpiolib_getchip(unsigned int chip)
 {
+	if (!IS_ENABLED(CONFIG_ARCH_EXYNOS_SINGLE))
+		return NULL;
+
 	return (chip < S3C_GPIO_END) ? s3c_gpios[chip] : NULL;
 }
 #else
diff --git a/arch/arm/plat-samsung/pm-gpio.c b/arch/arm/plat-samsung/pm-gpio.c
index c2ff92c..b24c159 100644
--- a/arch/arm/plat-samsung/pm-gpio.c
+++ b/arch/arm/plat-samsung/pm-gpio.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 
+#include <mach/gpio.h>
 #include <plat/gpio-core.h>
 #include <plat/pm.h>
 
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 22e07bc..91ed0f9 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -57,7 +57,7 @@ obj-$(CONFIG_GPIO_PL061)	+= gpio-pl061.o
 obj-$(CONFIG_GPIO_PXA)		+= gpio-pxa.o
 obj-$(CONFIG_GPIO_RC5T583)	+= gpio-rc5t583.o
 obj-$(CONFIG_GPIO_RDC321X)	+= gpio-rdc321x.o
-obj-$(CONFIG_PLAT_SAMSUNG)	+= gpio-samsung.o
+obj-$(CONFIG_PLAT_SAMSUNG_SINGLE) += gpio-samsung.o
 obj-$(CONFIG_ARCH_SA1100)	+= gpio-sa1100.o
 obj-$(CONFIG_GPIO_SCH)		+= gpio-sch.o
 obj-$(CONFIG_GPIO_SODAVILLE)	+= gpio-sodaville.o
-- 
1.8.1.2
