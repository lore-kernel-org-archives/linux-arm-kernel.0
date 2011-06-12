From: ynezz@true.cz (=?UTF-8?q?Petr=20=C5=A0tetiar?=)
Date: Sun, 12 Jun 2011 17:05:00 +0200
Subject: [PATCH v2 5/5] ARM: ep93xx: ts72xx: fix board model detection
In-Reply-To: <1307891100-31123-1-git-send-email-ynezz@true.cz>
References: <1307891100-31123-1-git-send-email-ynezz@true.cz>
Message-ID: <1307891100-31123-6-git-send-email-ynezz@true.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the obvious error in board detection logic, because according to the TS's
manual, the model is stored in the least three significant bits. For example
the byte read on my ts-7300 is 0x23 and the detection then fails.

Cc: Ryan Mallon <ryan@bluewatersys.com>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Signed-off-by: Petr ?tetiar <ynezz@true.cz>
---
 arch/arm/mach-ep93xx/include/mach/ts72xx.h |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-ep93xx/include/mach/ts72xx.h b/arch/arm/mach-ep93xx/include/mach/ts72xx.h
index ee7f875..f1397a1 100644
--- a/arch/arm/mach-ep93xx/include/mach/ts72xx.h
+++ b/arch/arm/mach-ep93xx/include/mach/ts72xx.h
@@ -6,7 +6,7 @@
  * TS72xx memory map:
  *
  * virt		phys		size
- * febff000	22000000	4K	model number register
+ * febff000	22000000	4K	model number register (bits 0-2)
  * febfe000	22400000	4K	options register
  * febfd000	22800000	4K	options register #2
  * febf9000	10800000	4K	TS-5620 RTC index register
@@ -22,6 +22,7 @@
 #define TS72XX_MODEL_TS7260		0x02
 #define TS72XX_MODEL_TS7300		0x03
 #define TS72XX_MODEL_TS7400		0x04
+#define TS72XX_MODEL_MASK		0x07
 
 
 #define TS72XX_OPTIONS_PHYS_BASE	0x22400000
@@ -53,29 +54,34 @@
 
 #ifndef __ASSEMBLY__
 
+static inline int ts72xx_model(void)
+{
+	return __raw_readb(TS72XX_MODEL_VIRT_BASE) & TS72XX_MODEL_MASK;
+}
+
 static inline int board_is_ts7200(void)
 {
-	return __raw_readb(TS72XX_MODEL_VIRT_BASE) == TS72XX_MODEL_TS7200;
+	return ts72xx_model() == TS72XX_MODEL_TS7200;
 }
 
 static inline int board_is_ts7250(void)
 {
-	return __raw_readb(TS72XX_MODEL_VIRT_BASE) == TS72XX_MODEL_TS7250;
+	return ts72xx_model() == TS72XX_MODEL_TS7250;
 }
 
 static inline int board_is_ts7260(void)
 {
-	return __raw_readb(TS72XX_MODEL_VIRT_BASE) == TS72XX_MODEL_TS7260;
+	return ts72xx_model() == TS72XX_MODEL_TS7260;
 }
 
 static inline int board_is_ts7300(void)
 {
-	return __raw_readb(TS72XX_MODEL_VIRT_BASE) == TS72XX_MODEL_TS7300;
+	return ts72xx_model()  == TS72XX_MODEL_TS7300;
 }
 
 static inline int board_is_ts7400(void)
 {
-	return __raw_readb(TS72XX_MODEL_VIRT_BASE) == TS72XX_MODEL_TS7400;
+	return ts72xx_model() == TS72XX_MODEL_TS7400;
 }
 
 static inline int is_max197_installed(void)
-- 
1.7.1
