From: alex@digriz.org.uk (Alexander Clouter)
Date: Sun, 31 Mar 2013 22:56:11 +0100
Subject: [PATCH 3/3] arm: ep93xx: fixup ts72xx to be able to use the
 rtc-m48t86 again.
In-Reply-To: <1364766971-5914-1-git-send-email-alex@digriz.org.uk>
References: <1364766971-5914-1-git-send-email-alex@digriz.org.uk>
Message-ID: <1364766971-5914-4-git-send-email-alex@digriz.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the board to be able to use the rtc-m48t86 driver again.

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
---
 arch/arm/mach-ep93xx/ts72xx.c |   29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index 61f4b5d..c0ed3bf 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -16,7 +16,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
-#include <linux/m48t86.h>
+#include <linux/ioport.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 
@@ -179,31 +179,18 @@ static void __init ts72xx_register_flash(void)
 	}
 }
 
-
-static unsigned char ts72xx_rtc_readbyte(unsigned long addr)
-{
-	__raw_writeb(addr, TS72XX_RTC_INDEX_VIRT_BASE);
-	return __raw_readb(TS72XX_RTC_DATA_VIRT_BASE);
-}
-
-static void ts72xx_rtc_writebyte(unsigned char value, unsigned long addr)
-{
-	__raw_writeb(addr, TS72XX_RTC_INDEX_VIRT_BASE);
-	__raw_writeb(value, TS72XX_RTC_DATA_VIRT_BASE);
-}
-
-static struct m48t86_ops ts72xx_rtc_ops = {
-	.readbyte	= ts72xx_rtc_readbyte,
-	.writebyte	= ts72xx_rtc_writebyte,
+static struct resource ts72xx_rtc_resources[] = {
+	DEFINE_RES_NAMED(TS72XX_RTC_INDEX_PHYS_BASE, 4,
+				"rtc_index", IORESOURCE_MEM),
+	DEFINE_RES_NAMED(TS72XX_RTC_DATA_PHYS_BASE, 4,
+				"rtc_data", IORESOURCE_MEM),
 };
 
 static struct platform_device ts72xx_rtc_device = {
 	.name		= "rtc-m48t86",
 	.id		= -1,
-	.dev		= {
-		.platform_data	= &ts72xx_rtc_ops,
-	},
-	.num_resources	= 0,
+	.resource	= ts72xx_rtc_resources,
+	.num_resources	= ARRAY_SIZE(ts72xx_rtc_resources),
 };
 
 static struct resource ts72xx_wdt_resources[] = {
-- 
1.7.10.4
