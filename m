From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 20 Jan 2012 12:00:20 +0100
Subject: [PATCH] mach-u300: do away with MMC config files
Message-ID: <1327057220-8300-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

All the special stuff (like registering input device and so on)
for the U300 MMC is now done away with. We don't need this
special MMC setup kludges, merge this into core.c and be done
with it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-u300/Makefile |    1 -
 arch/arm/mach-u300/core.c   |   34 ++++++++++++++++++----------
 arch/arm/mach-u300/mmc.c    |   52 -------------------------------------------
 arch/arm/mach-u300/mmc.h    |   18 ---------------
 4 files changed, 22 insertions(+), 83 deletions(-)
 delete mode 100644 arch/arm/mach-u300/mmc.c
 delete mode 100644 arch/arm/mach-u300/mmc.h

diff --git a/arch/arm/mach-u300/Makefile b/arch/arm/mach-u300/Makefile
index 2855381..fd3a5c3 100644
--- a/arch/arm/mach-u300/Makefile
+++ b/arch/arm/mach-u300/Makefile
@@ -8,7 +8,6 @@ obj-n		:=
 obj-		:=
 
 obj-$(CONFIG_ARCH_U300)	          += u300.o
-obj-$(CONFIG_MMC)                 += mmc.o
 obj-$(CONFIG_SPI_PL022)           += spi.o
 obj-$(CONFIG_MACH_U300_SPIDUMMY)  += dummyspichip.o
 obj-$(CONFIG_I2C_STU300)          += i2c.o
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index b4c6926..2bf98b0 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -18,6 +18,7 @@
 #include <linux/termios.h>
 #include <linux/dmaengine.h>
 #include <linux/amba/bus.h>
+#include <linux/amba/mmci.h>
 #include <linux/amba/serial.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
@@ -43,9 +44,9 @@
 #include <mach/gpio-u300.h>
 
 #include "clock.h"
-#include "mmc.h"
 #include "spi.h"
 #include "i2c.h"
+#include "u300-gpio.h"
 
 /*
  * Static I/O mappings that are needed for booting the U300 platforms. The
@@ -167,10 +168,29 @@ static struct amba_device pl022_device = {
 	 */
 };
 
+static struct mmci_platform_data mmcsd_platform_data = {
+	/*
+	 * Do not set ocr_mask or voltage translation function,
+	 * we have a regulator we can control instead.
+	 */
+	/* Nominally 2.85V on our platform */
+	.f_max = 24000000,
+	.gpio_wp = -1,
+	.gpio_cd = U300_GPIO_PIN_MMC_CD,
+	.cd_invert = true,
+	.capabilities = MMC_CAP_MMC_HIGHSPEED |
+	MMC_CAP_SD_HIGHSPEED | MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
+#ifdef CONFIG_COH901318
+	.dma_filter = coh901318_filter_id,
+	.dma_rx_param = (void *) U300_DMA_MMCSD_RX_TX,
+	/* Don't specify a TX channel, this RX channel is bidirectional */
+#endif
+};
+
 static struct amba_device mmcsd_device = {
 	.dev = {
 		.init_name = "mmci", /* Fast device at 0x1000 offset */
-		.platform_data = NULL, /* Added later */
+		.platform_data = &mmcsd_platform_data,
 	},
 	.res = {
 		.start = U300_MMCSD_BASE,
@@ -1879,16 +1899,6 @@ void __init u300_init_devices(void)
 	writew(val, U300_SYSCON_VBASE + U300_SYSCON_SMCR);
 }
 
-static int core_module_init(void)
-{
-	/*
-	 * This needs to be initialized later: it needs the input framework
-	 * to be initialized first.
-	 */
-	return mmc_init(&mmcsd_device);
-}
-module_init(core_module_init);
-
 /* Forward declare this function from the watchdog */
 void coh901327_watchdog_reset(void);
 
diff --git a/arch/arm/mach-u300/mmc.c b/arch/arm/mach-u300/mmc.c
deleted file mode 100644
index 05abd6a..0000000
--- a/arch/arm/mach-u300/mmc.c
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- *
- * arch/arm/mach-u300/mmc.c
- *
- *
- * Copyright (C) 2009 ST-Ericsson SA
- * License terms: GNU General Public License (GPL) version 2
- *
- * Author: Linus Walleij <linus.walleij@stericsson.com>
- * Author: Johan Lundin
- * Author: Jonas Aaberg <jonas.aberg@stericsson.com>
- */
-#include <linux/device.h>
-#include <linux/amba/bus.h>
-#include <linux/mmc/host.h>
-#include <linux/dmaengine.h>
-#include <linux/amba/mmci.h>
-#include <linux/slab.h>
-#include <mach/coh901318.h>
-#include <mach/dma_channels.h>
-
-#include "u300-gpio.h"
-#include "mmc.h"
-
-static struct mmci_platform_data mmc0_plat_data = {
-	/*
-	 * Do not set ocr_mask or voltage translation function,
-	 * we have a regulator we can control instead.
-	 */
-	/* Nominally 2.85V on our platform */
-	.f_max = 24000000,
-	.gpio_wp = -1,
-	.gpio_cd = U300_GPIO_PIN_MMC_CD,
-	.cd_invert = true,
-	.capabilities = MMC_CAP_MMC_HIGHSPEED |
-	MMC_CAP_SD_HIGHSPEED | MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
-#ifdef CONFIG_COH901318
-	.dma_filter = coh901318_filter_id,
-	.dma_rx_param = (void *) U300_DMA_MMCSD_RX_TX,
-	/* Don't specify a TX channel, this RX channel is bidirectional */
-#endif
-};
-
-int __devinit mmc_init(struct amba_device *adev)
-{
-	struct device *mmcsd_device = &adev->dev;
-	int ret = 0;
-
-	mmcsd_device->platform_data = &mmc0_plat_data;
-
-	return ret;
-}
diff --git a/arch/arm/mach-u300/mmc.h b/arch/arm/mach-u300/mmc.h
deleted file mode 100644
index 92b8512..0000000
--- a/arch/arm/mach-u300/mmc.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- *
- * arch/arm/mach-u300/mmc.h
- *
- *
- * Copyright (C) 2009 ST-Ericsson AB
- * License terms: GNU General Public License (GPL) version 2
- *
- * Author: Jonas Aaberg <jonas.aberg@stericsson.com>
- */
-#ifndef MMC_H
-#define MMC_H
-
-#include <linux/amba/bus.h>
-
-int __devinit mmc_init(struct amba_device *adev);
-
-#endif
-- 
1.7.8
