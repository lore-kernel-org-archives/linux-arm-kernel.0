From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  2 Apr 2012 03:22:11 +0200
Subject: [PATCH 4/4] ARM: ux500: factor out dynamic amba device allocator
Message-ID: <1333329731-31735-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This replaces the dynamic device allocator in the ux500 machine
with the common device allocator in the bus code.

Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: Rabin Vincent <rabin.vincent@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/devices-common.c |   33 ---------------------------------
 arch/arm/mach-ux500/devices-common.h |   23 ++++++++++-------------
 arch/arm/mach-ux500/devices-db8500.h |    2 +-
 3 files changed, 11 insertions(+), 47 deletions(-)

diff --git a/arch/arm/mach-ux500/devices-common.c b/arch/arm/mach-ux500/devices-common.c
index c5312a4..dfdd4a5 100644
--- a/arch/arm/mach-ux500/devices-common.c
+++ b/arch/arm/mach-ux500/devices-common.c
@@ -11,7 +11,6 @@
 #include <linux/irq.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
-#include <linux/amba/bus.h>
 
 #include <plat/gpio-nomadik.h>
 
@@ -19,38 +18,6 @@
 
 #include "devices-common.h"
 
-struct amba_device *
-dbx500_add_amba_device(struct device *parent, const char *name,
-		       resource_size_t base, int irq, void *pdata,
-		       unsigned int periphid)
-{
-	struct amba_device *dev;
-	int ret;
-
-	dev = amba_device_alloc(name, base, SZ_4K);
-	if (!dev)
-		return ERR_PTR(-ENOMEM);
-
-	dev->dma_mask = DMA_BIT_MASK(32);
-	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
-
-	dev->irq[0] = irq;
-
-	dev->periphid = periphid;
-
-	dev->dev.platform_data = pdata;
-
-	dev->dev.parent = parent;
-
-	ret = amba_device_add(dev, &iomem_resource);
-	if (ret) {
-		amba_device_put(dev);
-		return ERR_PTR(ret);
-	}
-
-	return dev;
-}
-
 static struct platform_device *
 dbx500_add_gpio(struct device *parent, int id, resource_size_t addr, int irq,
 		struct nmk_gpio_platform_data *pdata)
diff --git a/arch/arm/mach-ux500/devices-common.h b/arch/arm/mach-ux500/devices-common.h
index 39c74ec..f75bcb2 100644
--- a/arch/arm/mach-ux500/devices-common.h
+++ b/arch/arm/mach-ux500/devices-common.h
@@ -11,13 +11,9 @@
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/sys_soc.h>
+#include <linux/amba/bus.h>
 #include <plat/i2c.h>
 
-extern struct amba_device *
-dbx500_add_amba_device(struct device *parent, const char *name,
-		       resource_size_t base, int irq, void *pdata,
-		       unsigned int periphid);
-
 struct spi_master_cntlr;
 
 static inline struct amba_device *
@@ -25,8 +21,8 @@ dbx500_add_msp_spi(struct device *parent, const char *name,
 		   resource_size_t base, int irq,
 		   struct spi_master_cntlr *pdata)
 {
-	return dbx500_add_amba_device(parent, name, base, irq,
-				      pdata, 0);
+	return amba_ahb_device_add(parent, name, base, SZ_4K, irq, 0,
+				   pdata, 0);
 }
 
 static inline struct amba_device *
@@ -34,8 +30,8 @@ dbx500_add_spi(struct device *parent, const char *name, resource_size_t base,
 	       int irq, struct spi_master_cntlr *pdata,
 	       u32 periphid)
 {
-	return dbx500_add_amba_device(parent, name, base, irq,
-				      pdata, periphid);
+	return amba_ahb_device_add(parent, name, base, SZ_4K, irq, 0,
+				   pdata, periphid);
 }
 
 struct mmci_platform_data;
@@ -44,8 +40,8 @@ static inline struct amba_device *
 dbx500_add_sdi(struct device *parent, const char *name, resource_size_t base,
 	       int irq, struct mmci_platform_data *pdata, u32 periphid)
 {
-	return dbx500_add_amba_device(parent, name, base, irq,
-				      pdata, periphid);
+	return amba_ahb_device_add(parent, name, base, SZ_4K, irq, 0,
+				   pdata, periphid);
 }
 
 struct amba_pl011_data;
@@ -54,7 +50,7 @@ static inline struct amba_device *
 dbx500_add_uart(struct device *parent, const char *name, resource_size_t base,
 		int irq, struct amba_pl011_data *pdata)
 {
-	return dbx500_add_amba_device(parent, name, base, irq, pdata, 0);
+	return amba_ahb_device_add(parent, name, base, SZ_4K, irq, 0, pdata, 0);
 }
 
 struct nmk_i2c_controller;
@@ -85,7 +81,8 @@ dbx500_add_i2c(struct device *parent, int id, resource_size_t base, int irq,
 static inline struct amba_device *
 dbx500_add_rtc(struct device *parent, resource_size_t base, int irq)
 {
-	return dbx500_add_amba_device(parent, "rtc-pl031", base, irq, NULL, 0);
+	return amba_apb_device_add(parent, "rtc-pl031", base, SZ_4K, irq,
+				0, NULL, 0);
 }
 
 struct nmk_gpio_platform_data;
diff --git a/arch/arm/mach-ux500/devices-db8500.h b/arch/arm/mach-ux500/devices-db8500.h
index 9fd93e9..6fc7eb2 100644
--- a/arch/arm/mach-ux500/devices-db8500.h
+++ b/arch/arm/mach-ux500/devices-db8500.h
@@ -31,7 +31,7 @@ static inline struct amba_device *
 db8500_add_ssp(struct device *parent, const char *name, resource_size_t base,
 	       int irq, struct pl022_ssp_controller *pdata)
 {
-	return dbx500_add_amba_device(parent, name, base, irq, pdata, 0);
+	return amba_ahb_device_add(parent, name, base, SZ_4K, irq, 0, pdata, 0);
 }
 
 
-- 
1.7.7.6
