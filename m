From: rmallon@gmail.com (Ryan Mallon)
Date: Fri, 14 Sep 2012 09:24:13 +1000
Subject: [PATCH 1/2] ep93xx: Fix type error warnings in ts72xx build
Message-ID: <1347578654-26483-1-git-send-email-rmallon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add IOMEM defines for the TS72xx VIRT_BASE defines to fix type
conversion warnings.

Signed-off-by: Ryan Mallon <rmallon@gmail.com>
---
 arch/arm/mach-ep93xx/include/mach/ts72xx.h |   20 ++++++++++++++++----
 arch/arm/mach-ep93xx/ts72xx.c              |    8 ++++----
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-ep93xx/include/mach/ts72xx.h b/arch/arm/mach-ep93xx/include/mach/ts72xx.h
index f1397a1..b30deb6 100644
--- a/arch/arm/mach-ep93xx/include/mach/ts72xx.h
+++ b/arch/arm/mach-ep93xx/include/mach/ts72xx.h
@@ -2,6 +2,11 @@
  * arch/arm/mach-ep93xx/include/mach/ts72xx.h
  */
 
+#ifndef _TS72XX_H
+#define _TS72XX_H
+
+#include <asm/io.h>
+
 /*
  * TS72xx memory map:
  *
@@ -15,6 +20,7 @@
 
 #define TS72XX_MODEL_PHYS_BASE		0x22000000
 #define TS72XX_MODEL_VIRT_BASE		0xfebff000
+#define TS72XX_MODEL_VIRT_BASE_IOMEM	IOMEM(TS72XX_MODEL_VIRT_BASE)
 #define TS72XX_MODEL_SIZE		0x00001000
 
 #define TS72XX_MODEL_TS7200		0x00
@@ -27,6 +33,7 @@
 
 #define TS72XX_OPTIONS_PHYS_BASE	0x22400000
 #define TS72XX_OPTIONS_VIRT_BASE	0xfebfe000
+#define TS72XX_OPTIONS_VIRT_BASE_IOMEM	IOMEM(TS72XX_OPTIONS_VIRT_BASE)
 #define TS72XX_OPTIONS_SIZE		0x00001000
 
 #define TS72XX_OPTIONS_COM2_RS485	0x02
@@ -35,6 +42,7 @@
 
 #define TS72XX_OPTIONS2_PHYS_BASE	0x22800000
 #define TS72XX_OPTIONS2_VIRT_BASE	0xfebfd000
+#define TS72XX_OPTIONS2_VIRT_BASE_IOMEM	IOMEM(TS72XX_OPTIONS2_VIRT_BASE)
 #define TS72XX_OPTIONS2_SIZE		0x00001000
 
 #define TS72XX_OPTIONS2_TS9420		0x04
@@ -42,10 +50,12 @@
 
 
 #define TS72XX_RTC_INDEX_VIRT_BASE	0xfebf9000
+#define TS72XX_RTC_INDEX_VIRT_BASE_IOMEM IOMEM(TS72XX_RTC_INDEX_VIRT_BASE)
 #define TS72XX_RTC_INDEX_PHYS_BASE	0x10800000
 #define TS72XX_RTC_INDEX_SIZE		0x00001000
 
 #define TS72XX_RTC_DATA_VIRT_BASE	0xfebf8000
+#define TS72XX_RTC_DATA_VIRT_BASE_IOMEM	IOMEM(TS72XX_RTC_DATA_VIRT_BASE)
 #define TS72XX_RTC_DATA_PHYS_BASE	0x11700000
 #define TS72XX_RTC_DATA_SIZE		0x00001000
 
@@ -56,7 +66,7 @@
 
 static inline int ts72xx_model(void)
 {
-	return __raw_readb(TS72XX_MODEL_VIRT_BASE) & TS72XX_MODEL_MASK;
+	return __raw_readb(TS72XX_MODEL_VIRT_BASE_IOMEM) & TS72XX_MODEL_MASK;
 }
 
 static inline int board_is_ts7200(void)
@@ -86,13 +96,15 @@ static inline int board_is_ts7400(void)
 
 static inline int is_max197_installed(void)
 {
-	return !!(__raw_readb(TS72XX_OPTIONS_VIRT_BASE) &
+	return !!(__raw_readb(TS72XX_OPTIONS_VIRT_BASE_IOMEM) &
 					TS72XX_OPTIONS_MAX197);
 }
 
 static inline int is_ts9420_installed(void)
 {
-	return !!(__raw_readb(TS72XX_OPTIONS2_VIRT_BASE) &
+	return !!(__raw_readb(TS72XX_OPTIONS2_VIRT_BASE_IOMEM) &
 					TS72XX_OPTIONS2_TS9420);
 }
-#endif
+#endif /* __ASSEMBLY__ */
+
+#endif /* _TS72XX_H */
diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index 75cab2d..aefda11 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -183,14 +183,14 @@ static void __init ts72xx_register_flash(void)
 
 static unsigned char ts72xx_rtc_readbyte(unsigned long addr)
 {
-	__raw_writeb(addr, TS72XX_RTC_INDEX_VIRT_BASE);
-	return __raw_readb(TS72XX_RTC_DATA_VIRT_BASE);
+	__raw_writeb(addr, TS72XX_RTC_INDEX_VIRT_BASE_IOMEM);
+	return __raw_readb(TS72XX_RTC_DATA_VIRT_BASE_IOMEM);
 }
 
 static void ts72xx_rtc_writebyte(unsigned char value, unsigned long addr)
 {
-	__raw_writeb(addr, TS72XX_RTC_INDEX_VIRT_BASE);
-	__raw_writeb(value, TS72XX_RTC_DATA_VIRT_BASE);
+	__raw_writeb(addr, TS72XX_RTC_INDEX_VIRT_BASE_IOMEM);
+	__raw_writeb(value, TS72XX_RTC_DATA_VIRT_BASE_IOMEM);
 }
 
 static struct m48t86_ops ts72xx_rtc_ops = {
-- 
1.7.9.7
