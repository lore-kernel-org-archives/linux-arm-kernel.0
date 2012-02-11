From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 12 Feb 2012 02:34:39 +0900
Subject: [PATCH v2 05/11] ARM: EXYNOS: add initial setup-i2c0 for EXYNOS5
In-Reply-To: <1328981685-8602-1-git-send-email-kgene.kim@samsung.com>
References: <1328981685-8602-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1328981685-8602-6-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In all of Samsung platform, the setup-i2c0.c file for I2C channel 0
is always compiled. So when supporting new SoC,it should be updated
for it. Since EXYNOS5 GPIO will be supported after this, there is no
setup gpio in there now. It will be implemented with that, of course.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/Makefile     |    2 +-
 arch/arm/mach-exynos/setup-i2c0.c |    9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 995e7cc..2117f02 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -52,7 +52,7 @@ obj-$(CONFIG_EXYNOS4_DEV_DWMCI)		+= dev-dwmci.o
 obj-$(CONFIG_EXYNOS4_DEV_DMA)		+= dma.o
 obj-$(CONFIG_EXYNOS4_DEV_USB_OHCI)	+= dev-ohci.o
 
-obj-$(CONFIG_ARCH_EXYNOS4)		+= setup-i2c0.o
+obj-$(CONFIG_ARCH_EXYNOS)		+= setup-i2c0.o
 obj-$(CONFIG_EXYNOS4_SETUP_FIMC)	+= setup-fimc.o
 obj-$(CONFIG_EXYNOS4_SETUP_FIMD0)	+= setup-fimd0.o
 obj-$(CONFIG_EXYNOS4_SETUP_I2C1)	+= setup-i2c1.o
diff --git a/arch/arm/mach-exynos/setup-i2c0.c b/arch/arm/mach-exynos/setup-i2c0.c
index d395bd1..b90d94c 100644
--- a/arch/arm/mach-exynos/setup-i2c0.c
+++ b/arch/arm/mach-exynos/setup-i2c0.c
@@ -1,7 +1,5 @@
 /*
- * linux/arch/arm/mach-exynos4/setup-i2c0.c
- *
- * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2009-2012 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
  *
  * I2C0 GPIO configuration.
@@ -18,9 +16,14 @@ struct platform_device; /* don't need the contents */
 #include <linux/gpio.h>
 #include <plat/iic.h>
 #include <plat/gpio-cfg.h>
+#include <plat/cpu.h>
 
 void s3c_i2c0_cfg_gpio(struct platform_device *dev)
 {
+	if (soc_is_exynos5250())
+		/* will be implemented with gpio function */
+		return;
+
 	s3c_gpio_cfgall_range(EXYNOS4_GPD1(0), 2,
 			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
 }
-- 
1.7.4.4
