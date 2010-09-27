From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 27 Sep 2010 15:50:37 +0200
Subject: [PATCH 01/40] ARM: imx: remove #ifdefery for unmerged flexcan driver
In-Reply-To: <20100927135009.GC6271@pengutronix.de>
References: <20100927135009.GC6271@pengutronix.de>
Message-ID: <1285595476-10025-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The flexcan driver was merged as e955cead.

Cc: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/devices/Makefile              |    5 +----
 arch/arm/plat-mxc/include/mach/devices-common.h |   12 ------------
 2 files changed, 1 insertions(+), 16 deletions(-)

diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index 347da51..2062ab4 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -1,7 +1,4 @@
-ifdef CONFIG_CAN_FLEXCAN
-# the ifdef can be removed once the flexcan driver has been merged
-obj-$(CONFIG_IMX_HAVE_PLATFORM_FLEXCAN) +=  platform-flexcan.o
-endif
+obj-$(CONFIG_IMX_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_I2C) += platform-imx-i2c.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_UART) += platform-imx-uart.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_NAND) += platform-mxc_nand.o
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index c5f68c5..4a170a8 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -14,23 +14,11 @@ struct platform_device *imx_add_platform_device(const char *name, int id,
 		const struct resource *res, unsigned int num_resources,
 		const void *data, size_t size_data);
 
-#if defined (CONFIG_CAN_FLEXCAN) || defined (CONFIG_CAN_FLEXCAN_MODULE)
 #include <linux/can/platform/flexcan.h>
 struct platform_device *__init imx_add_flexcan(int id,
 		resource_size_t iobase, resource_size_t iosize,
 		resource_size_t irq,
 		const struct flexcan_platform_data *pdata);
-#else
-/* the ifdef can be removed once the flexcan driver has been merged */
-struct flexcan_platform_data;
-static inline struct platform_device *__init imx_add_flexcan(int id,
-		resource_size_t iobase, resource_size_t iosize,
-		resource_size_t irq,
-		const struct flexcan_platform_data *pdata)
-{
-	return NULL;
-}
-#endif
 
 #include <mach/i2c.h>
 struct platform_device *__init imx_add_imx_i2c(int id,
-- 
1.7.2.3
