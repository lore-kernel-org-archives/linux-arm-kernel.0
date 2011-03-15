From: philippe.langlais@stericsson.com (Philippe Langlais)
Date: Tue, 15 Mar 2011 15:41:56 +0100
Subject: [PATCH 4/4] ux500: pass name for db5500-spi & db8500v2-sdi devices
In-Reply-To: <1300200116-12185-1-git-send-email-philippe.langlais@stericsson.com>
References: <1300200116-12185-1-git-send-email-philippe.langlais@stericsson.com>
Message-ID: <1300200116-12185-5-git-send-email-philippe.langlais@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philippe Langlais <philippe.langlais@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
Signed-off-by: Philippe Langlais <philippe.langlais@linaro.org>
---
 arch/arm/mach-ux500/devices-common.c        |    8 ++++--
 arch/arm/mach-ux500/devices-common.h        |   31 ++++++++++++++++++--------
 arch/arm/mach-ux500/devices-db8500.h        |    2 +-
 arch/arm/mach-ux500/include/mach/hardware.h |    3 --
 4 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-ux500/devices-common.c b/arch/arm/mach-ux500/devices-common.c
index 13a4ce0..e0acb75 100644
--- a/arch/arm/mach-ux500/devices-common.c
+++ b/arch/arm/mach-ux500/devices-common.c
@@ -20,8 +20,9 @@
 #include "devices-common.h"
 
 struct amba_device *
-dbx500_add_amba_device(const char *name, resource_size_t base,
-		       int irq, void *pdata, unsigned int periphid)
+dbx500_add_amba_device(const char *init_name, resource_size_t base,
+		       int irq, void *pdata, unsigned int periphid,
+		       const char *name)
 {
 	struct amba_device *dev;
 	int ret;
@@ -30,7 +31,7 @@ dbx500_add_amba_device(const char *name, resource_size_t base,
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
 
-	dev->dev.init_name = name;
+	dev->dev.init_name = init_name;
 
 	dev->res.start = base;
 	dev->res.end = base + SZ_4K - 1;
@@ -43,6 +44,7 @@ dbx500_add_amba_device(const char *name, resource_size_t base,
 	dev->irq[1] = NO_IRQ;
 
 	dev->periphid = periphid;
+	dev->name = name;
 
 	dev->dev.platform_data = pdata;
 
diff --git a/arch/arm/mach-ux500/devices-common.h b/arch/arm/mach-ux500/devices-common.h
index c719b5a1..cb5739e 100644
--- a/arch/arm/mach-ux500/devices-common.h
+++ b/arch/arm/mach-ux500/devices-common.h
@@ -9,8 +9,9 @@
 #define __DEVICES_COMMON_H
 
 extern struct amba_device *
-dbx500_add_amba_device(const char *name, resource_size_t base,
-		       int irq, void *pdata, unsigned int periphid);
+dbx500_add_amba_device(const char *init_name, resource_size_t base,
+		       int irq, void *pdata, unsigned int periphid,
+		       const char *name);
 
 extern struct platform_device *
 dbx500_add_platform_device_4k1irq(const char *name, int id,
@@ -23,23 +24,33 @@ static inline struct amba_device *
 dbx500_add_msp_spi(const char *name, resource_size_t base, int irq,
 		   struct spi_master_cntlr *pdata)
 {
-	return dbx500_add_amba_device(name, base, irq, pdata, 0);
+	return dbx500_add_amba_device(name, base, irq, pdata, 0, NULL);
 }
 
 static inline struct amba_device *
-dbx500_add_spi(const char *name, resource_size_t base, int irq,
-				   struct spi_master_cntlr *pdata)
+dbx500_add_spi(const char *init_name, resource_size_t base, int irq,
+	       struct spi_master_cntlr *pdata)
 {
-	return dbx500_add_amba_device(name, base, irq, pdata, 0);
+	const char *name = NULL;
+
+	if (cpu_is_u5500())
+		name = "db5500-spi";
+
+	return dbx500_add_amba_device(init_name, base, irq, pdata, 0, name);
 }
 
 struct mmci_platform_data;
 
 static inline struct amba_device *
-dbx500_add_sdi(const char *name, resource_size_t base, int irq,
+dbx500_add_sdi(const char *init_name, resource_size_t base, int irq,
 	       struct mmci_platform_data *pdata)
 {
-	return dbx500_add_amba_device(name, base, irq, pdata, 0);
+	const char *name = NULL;
+
+	if (cpu_is_u8500v2())
+		name = "db8500v2-sdi";
+
+	return dbx500_add_amba_device(init_name, base, irq, pdata, 0, name);
 }
 
 struct amba_pl011_data;
@@ -48,7 +59,7 @@ static inline struct amba_device *
 dbx500_add_uart(const char *name, resource_size_t base, int irq,
 		struct amba_pl011_data *pdata)
 {
-	return dbx500_add_amba_device(name, base, irq, pdata, 0);
+	return dbx500_add_amba_device(name, base, irq, pdata, 0, NULL);
 }
 
 struct nmk_i2c_controller;
@@ -74,7 +85,7 @@ dbx500_add_msp_i2s(int id, resource_size_t base, int irq,
 static inline struct amba_device *
 dbx500_add_rtc(resource_size_t base, int irq)
 {
-	return dbx500_add_amba_device("rtc-pl031", base, irq, NULL, 0);
+	return dbx500_add_amba_device("rtc-pl031", base, irq, NULL, 0, NULL);
 }
 
 struct nmk_gpio_platform_data;
diff --git a/arch/arm/mach-ux500/devices-db8500.h b/arch/arm/mach-ux500/devices-db8500.h
index 9cc6f8f..fdcea73 100644
--- a/arch/arm/mach-ux500/devices-db8500.h
+++ b/arch/arm/mach-ux500/devices-db8500.h
@@ -25,7 +25,7 @@ static inline struct amba_device *
 db8500_add_ssp(const char *name, resource_size_t base, int irq,
 	       struct pl022_ssp_controller *pdata)
 {
-	return dbx500_add_amba_device(name, base, irq, pdata, SSP_PER_ID);
+	return dbx500_add_amba_device(name, base, irq, pdata, 0, NULL);
 }
 
 
diff --git a/arch/arm/mach-ux500/include/mach/hardware.h b/arch/arm/mach-ux500/include/mach/hardware.h
index bf63f26..d54bb61 100644
--- a/arch/arm/mach-ux500/include/mach/hardware.h
+++ b/arch/arm/mach-ux500/include/mach/hardware.h
@@ -29,9 +29,6 @@
 #include <mach/db8500-regs.h>
 #include <mach/db5500-regs.h>
 
-/* ST-Ericsson modified pl022 id */
-#define SSP_PER_ID		0x01080022
-
 #ifndef __ASSEMBLY__
 
 #include <mach/id.h>
-- 
1.7.3.1
