From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 11 Mar 2015 11:21:33 -0300
Subject: [PATCH v2 6/7] ARM: mx25: Remove imxdi_rtc platform code
In-Reply-To: <1426083694-6624-1-git-send-email-festevam@gmail.com>
References: <1426083694-6624-1-git-send-email-festevam@gmail.com>
Message-ID: <1426083694-6624-6-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

platform-imxdi_rtc.c can is only used by mx25, so it can safely go away now that
mx25 has been converted to dt.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- None

 arch/arm/mach-imx/devices/Kconfig              |  3 --
 arch/arm/mach-imx/devices/Makefile             |  1 -
 arch/arm/mach-imx/devices/platform-imxdi_rtc.c | 42 --------------------------
 3 files changed, 46 deletions(-)
 delete mode 100644 arch/arm/mach-imx/devices/platform-imxdi_rtc.c

diff --git a/arch/arm/mach-imx/devices/Kconfig b/arch/arm/mach-imx/devices/Kconfig
index 1d2cc18..3a55298 100644
--- a/arch/arm/mach-imx/devices/Kconfig
+++ b/arch/arm/mach-imx/devices/Kconfig
@@ -21,9 +21,6 @@ config IMX_HAVE_PLATFORM_IMX27_CODA
 config IMX_HAVE_PLATFORM_IMX2_WDT
 	bool
 
-config IMX_HAVE_PLATFORM_IMXDI_RTC
-	bool
-
 config IMX_HAVE_PLATFORM_IMX_FB
 	bool
 
diff --git a/arch/arm/mach-imx/devices/Makefile b/arch/arm/mach-imx/devices/Makefile
index 8fdb12b..e5cf587 100644
--- a/arch/arm/mach-imx/devices/Makefile
+++ b/arch/arm/mach-imx/devices/Makefile
@@ -8,7 +8,6 @@ obj-y += platform-gpio-mxc.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX21_HCD) += platform-imx21-hcd.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX27_CODA) += platform-imx27-coda.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX2_WDT) += platform-imx2-wdt.o
-obj-$(CONFIG_IMX_HAVE_PLATFORM_IMXDI_RTC) += platform-imxdi_rtc.o
 obj-y += platform-imx-dma.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_FB) += platform-imx-fb.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_I2C) += platform-imx-i2c.o
diff --git a/arch/arm/mach-imx/devices/platform-imxdi_rtc.c b/arch/arm/mach-imx/devices/platform-imxdi_rtc.c
deleted file mode 100644
index 5bb490d..0000000
--- a/arch/arm/mach-imx/devices/platform-imxdi_rtc.c
+++ /dev/null
@@ -1,42 +0,0 @@
-/*
- * Copyright (C) 2010 Pengutronix
- * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
- *
- * This program is free software; you can redistribute it and/or modify it under
- * the terms of the GNU General Public License version 2 as published by the
- * Free Software Foundation.
- */
-#include <asm/sizes.h>
-
-#include "../hardware.h"
-#include "devices-common.h"
-
-#define imx_imxdi_rtc_data_entry_single(soc)				\
-	{								\
-		.iobase = soc ## _DRYICE_BASE_ADDR,			\
-		.irq = soc ## _INT_DRYICE,				\
-	}
-
-#ifdef CONFIG_SOC_IMX25
-const struct imx_imxdi_rtc_data imx25_imxdi_rtc_data __initconst =
-	imx_imxdi_rtc_data_entry_single(MX25);
-#endif /* ifdef CONFIG_SOC_IMX25 */
-
-struct platform_device *__init imx_add_imxdi_rtc(
-		const struct imx_imxdi_rtc_data *data)
-{
-	struct resource res[] = {
-		{
-			.start = data->iobase,
-			.end = data->iobase + SZ_16K - 1,
-			.flags = IORESOURCE_MEM,
-		}, {
-			.start = data->irq,
-			.end = data->irq,
-			.flags = IORESOURCE_IRQ,
-		},
-	};
-
-	return imx_add_platform_device("imxdi_rtc", 0,
-			res, ARRAY_SIZE(res), NULL, 0);
-}
-- 
1.9.1
