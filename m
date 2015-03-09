From: 21cnbao@gmail.com (Barry Song)
Date: Mon,  9 Mar 2015 20:26:10 +0800
Subject: [PATCH] ARM: prima2: move to use REGMAP APIs
Message-ID: <1425903970-6188-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guo Zeng <Guo.Zeng@csr.com>

all devices behind rtciobrg needs a special way to access. currently they
are using a platform-specific API.
this patch moves to REGMAP, then clients can use regmap APIs to read/write.
for the moment, old APIs are still kept, once all clients move to regmap,
old APIs will be dropped.

this patch also does minor clean for comments, authors statement.

Signed-off-by: Guo Zeng <Guo.Zeng@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/Kconfig         |  1 +
 arch/arm/mach-prima2/rtciobrg.c      | 48 +++++++++++++++++++++++++++++++++---
 include/linux/rtc/sirfsoc_rtciobrg.h |  4 +++
 3 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-prima2/Kconfig b/arch/arm/mach-prima2/Kconfig
index ed868d1..2500f8b 100644
--- a/arch/arm/mach-prima2/Kconfig
+++ b/arch/arm/mach-prima2/Kconfig
@@ -4,6 +4,7 @@ menuconfig ARCH_SIRF
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_IRQ_CHIP
 	select NO_IOPORT_MAP
+	select REGMAP
 	select PINCTRL
 	select PINCTRL_SIRF
 	help
diff --git a/arch/arm/mach-prima2/rtciobrg.c b/arch/arm/mach-prima2/rtciobrg.c
index 8f66d8f..d4852d2 100644
--- a/arch/arm/mach-prima2/rtciobrg.c
+++ b/arch/arm/mach-prima2/rtciobrg.c
@@ -1,5 +1,5 @@
 /*
- * RTC I/O Bridge interfaces for CSR SiRFprimaII
+ * RTC I/O Bridge interfaces for CSR SiRFprimaII/atlas7
  * ARM access the registers of SYSRTC, GPSRTC and PWRC through this module
  *
  * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/io.h>
+#include <linux/regmap.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
@@ -66,6 +67,7 @@ u32 sirfsoc_rtc_iobrg_readl(u32 addr)
 {
 	unsigned long flags, val;
 
+	/* TODO: add hwspinlock to sync with M3 */
 	spin_lock_irqsave(&rtciobrg_lock, flags);
 
 	val = __sirfsoc_rtc_iobrg_readl(addr);
@@ -90,6 +92,7 @@ void sirfsoc_rtc_iobrg_writel(u32 val, u32 addr)
 {
 	unsigned long flags;
 
+	 /* TODO: add hwspinlock to sync with M3 */
 	spin_lock_irqsave(&rtciobrg_lock, flags);
 
 	sirfsoc_rtc_iobrg_pre_writel(val, addr);
@@ -102,6 +105,45 @@ void sirfsoc_rtc_iobrg_writel(u32 val, u32 addr)
 }
 EXPORT_SYMBOL_GPL(sirfsoc_rtc_iobrg_writel);
 
+
+static int regmap_iobg_regwrite(void *context, unsigned int reg,
+				   unsigned int val)
+{
+	sirfsoc_rtc_iobrg_writel(val, reg);
+	return 0;
+}
+
+static int regmap_iobg_regread(void *context, unsigned int reg,
+				  unsigned int *val)
+{
+	*val = (u32)sirfsoc_rtc_iobrg_readl(reg);
+	return 0;
+}
+
+static struct regmap_bus regmap_iobg = {
+	.reg_write = regmap_iobg_regwrite,
+	.reg_read = regmap_iobg_regread,
+};
+
+/**
+ * devm_regmap_init_iobg(): Initialise managed register map
+ *
+ * @iobg: Device that will be interacted with
+ * @config: Configuration for register map
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer
+ * to a struct regmap.  The regmap will be automatically freed by the
+ * device management code.
+ */
+struct regmap *devm_regmap_init_iobg(struct device *dev,
+				    const struct regmap_config *config)
+{
+	const struct regmap_bus *bus = &regmap_iobg;
+
+	return devm_regmap_init(dev, bus, dev, config);
+}
+EXPORT_SYMBOL_GPL(devm_regmap_init_iobg);
+
 static const struct of_device_id rtciobrg_ids[] = {
 	{ .compatible = "sirf,prima2-rtciobg" },
 	{}
@@ -132,7 +174,7 @@ static int __init sirfsoc_rtciobrg_init(void)
 }
 postcore_initcall(sirfsoc_rtciobrg_init);
 
-MODULE_AUTHOR("Zhiwu Song <zhiwu.song@csr.com>, "
-		"Barry Song <baohua.song@csr.com>");
+MODULE_AUTHOR("Zhiwu Song <zhiwu.song@csr.com>");
+MODULE_AUTHOR("Barry Song <baohua.song@csr.com>");
 MODULE_DESCRIPTION("CSR SiRFprimaII rtc io bridge");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/rtc/sirfsoc_rtciobrg.h b/include/linux/rtc/sirfsoc_rtciobrg.h
index 2c92e1c..aefd997 100644
--- a/include/linux/rtc/sirfsoc_rtciobrg.h
+++ b/include/linux/rtc/sirfsoc_rtciobrg.h
@@ -9,10 +9,14 @@
 #ifndef _SIRFSOC_RTC_IOBRG_H_
 #define _SIRFSOC_RTC_IOBRG_H_
 
+struct regmap_config;
+
 extern void sirfsoc_rtc_iobrg_besyncing(void);
 
 extern u32 sirfsoc_rtc_iobrg_readl(u32 addr);
 
 extern void sirfsoc_rtc_iobrg_writel(u32 val, u32 addr);
+struct regmap *devm_regmap_init_iobg(struct device *dev,
+				    const struct regmap_config *config);
 
 #endif
-- 
2.3.0
