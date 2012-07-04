From: Barry.Song@csr.com (Barry Song)
Date: Wed, 4 Jul 2012 11:43:19 +0800
Subject: [PATCH 1/2] ARM: PRIMA2: add of_dev_auxdata table for I2C, SPI,
 UART and PINCTRL
Message-ID: <1341373400-15763-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

This patch adds lookup table for attaching a specific name and platform_data
pointer to devices like i2c, spi, uart and pinctrl as they get created by
of_platform_populate().  Ideally this table would not exist.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/prima2.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-prima2/prima2.c b/arch/arm/mach-prima2/prima2.c
index 8f0429d..82f5c0d 100644
--- a/arch/arm/mach-prima2/prima2.c
+++ b/arch/arm/mach-prima2/prima2.c
@@ -13,8 +13,26 @@
 #include <asm/mach/arch.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/pinctrl/machine.h>
 #include "common.h"
 
+/*
+ * Lookup table for attaching a specific name and platform_data pointer to
+ * devices as they get created by of_platform_populate().  Ideally this table
+ * would not exist.
+ */
+struct of_dev_auxdata prima2_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("sirf,prima2-uart", 0xb0050000, "uart0", NULL),
+	OF_DEV_AUXDATA("sirf,prima2-uart", 0xb0060000, "uart1", NULL),
+	OF_DEV_AUXDATA("sirf,prima2-uart", 0xb0070000, "uart2", NULL),
+	OF_DEV_AUXDATA("sirf,prima2-spi", 0xb00d0000, "spi0", NULL),
+	OF_DEV_AUXDATA("sirf,prima2-spi", 0xb0170000, "spi1", NULL),
+	OF_DEV_AUXDATA("sirf,prima2-i2c", 0xb00e0000, "i2c0", NULL),
+	OF_DEV_AUXDATA("sirf,prima2-i2c", 0xb00f0000, "i2c1", NULL),
+	OF_DEV_AUXDATA("sirf,prima2-gpio-pinmux", 0xb0120000, "pinctrl0", NULL),
+	{},
+};
+
 static struct of_device_id sirfsoc_of_bus_ids[] __initdata = {
 	{ .compatible = "simple-bus", },
 	{},
@@ -22,7 +40,7 @@ static struct of_device_id sirfsoc_of_bus_ids[] __initdata = {
 
 void __init sirfsoc_mach_init(void)
 {
-	of_platform_bus_probe(NULL, sirfsoc_of_bus_ids, NULL);
+	of_platform_populate(NULL, sirfsoc_of_bus_ids, prima2_auxdata_lookup, NULL);
 }
 
 void __init sirfsoc_init_late(void)
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
