From: rmallon@gmail.com (Ryan Mallon)
Date: Fri, 14 Sep 2012 09:24:14 +1000
Subject: [PATCH 2/2] ep93xx: Move ts72xx.h out of include/mach
In-Reply-To: <1347578654-26483-1-git-send-email-rmallon@gmail.com>
References: <1347578654-26483-1-git-send-email-rmallon@gmail.com>
Message-ID: <1347578654-26483-2-git-send-email-rmallon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ts72xx.h header is only included by arch/arm/mach-ep93xx/ts72xx.c.
It therefore does not need to be in the globally exported include/mach
directory. Move it to to arch/arm/mach-ep93xx.

Signed-off-by: Ryan Mallon <rmallon@gmail.com>
---
 arch/arm/mach-ep93xx/include/mach/ts72xx.h |  110 ----------------------------
 arch/arm/mach-ep93xx/ts72xx.c              |    2 +-
 arch/arm/mach-ep93xx/ts72xx.h              |  110 ++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+), 111 deletions(-)
 delete mode 100644 arch/arm/mach-ep93xx/include/mach/ts72xx.h
 create mode 100644 arch/arm/mach-ep93xx/ts72xx.h

diff --git a/arch/arm/mach-ep93xx/include/mach/ts72xx.h b/arch/arm/mach-ep93xx/include/mach/ts72xx.h
deleted file mode 100644
index b30deb6..0000000
--- a/arch/arm/mach-ep93xx/include/mach/ts72xx.h
+++ /dev/null
@@ -1,110 +0,0 @@
-/*
- * arch/arm/mach-ep93xx/include/mach/ts72xx.h
- */
-
-#ifndef _TS72XX_H
-#define _TS72XX_H
-
-#include <asm/io.h>
-
-/*
- * TS72xx memory map:
- *
- * virt		phys		size
- * febff000	22000000	4K	model number register (bits 0-2)
- * febfe000	22400000	4K	options register
- * febfd000	22800000	4K	options register #2
- * febf9000	10800000	4K	TS-5620 RTC index register
- * febf8000	11700000	4K	TS-5620 RTC data register
- */
-
-#define TS72XX_MODEL_PHYS_BASE		0x22000000
-#define TS72XX_MODEL_VIRT_BASE		0xfebff000
-#define TS72XX_MODEL_VIRT_BASE_IOMEM	IOMEM(TS72XX_MODEL_VIRT_BASE)
-#define TS72XX_MODEL_SIZE		0x00001000
-
-#define TS72XX_MODEL_TS7200		0x00
-#define TS72XX_MODEL_TS7250		0x01
-#define TS72XX_MODEL_TS7260		0x02
-#define TS72XX_MODEL_TS7300		0x03
-#define TS72XX_MODEL_TS7400		0x04
-#define TS72XX_MODEL_MASK		0x07
-
-
-#define TS72XX_OPTIONS_PHYS_BASE	0x22400000
-#define TS72XX_OPTIONS_VIRT_BASE	0xfebfe000
-#define TS72XX_OPTIONS_VIRT_BASE_IOMEM	IOMEM(TS72XX_OPTIONS_VIRT_BASE)
-#define TS72XX_OPTIONS_SIZE		0x00001000
-
-#define TS72XX_OPTIONS_COM2_RS485	0x02
-#define TS72XX_OPTIONS_MAX197		0x01
-
-
-#define TS72XX_OPTIONS2_PHYS_BASE	0x22800000
-#define TS72XX_OPTIONS2_VIRT_BASE	0xfebfd000
-#define TS72XX_OPTIONS2_VIRT_BASE_IOMEM	IOMEM(TS72XX_OPTIONS2_VIRT_BASE)
-#define TS72XX_OPTIONS2_SIZE		0x00001000
-
-#define TS72XX_OPTIONS2_TS9420		0x04
-#define TS72XX_OPTIONS2_TS9420_BOOT	0x02
-
-
-#define TS72XX_RTC_INDEX_VIRT_BASE	0xfebf9000
-#define TS72XX_RTC_INDEX_VIRT_BASE_IOMEM IOMEM(TS72XX_RTC_INDEX_VIRT_BASE)
-#define TS72XX_RTC_INDEX_PHYS_BASE	0x10800000
-#define TS72XX_RTC_INDEX_SIZE		0x00001000
-
-#define TS72XX_RTC_DATA_VIRT_BASE	0xfebf8000
-#define TS72XX_RTC_DATA_VIRT_BASE_IOMEM	IOMEM(TS72XX_RTC_DATA_VIRT_BASE)
-#define TS72XX_RTC_DATA_PHYS_BASE	0x11700000
-#define TS72XX_RTC_DATA_SIZE		0x00001000
-
-#define TS72XX_WDT_CONTROL_PHYS_BASE	0x23800000
-#define TS72XX_WDT_FEED_PHYS_BASE	0x23c00000
-
-#ifndef __ASSEMBLY__
-
-static inline int ts72xx_model(void)
-{
-	return __raw_readb(TS72XX_MODEL_VIRT_BASE_IOMEM) & TS72XX_MODEL_MASK;
-}
-
-static inline int board_is_ts7200(void)
-{
-	return ts72xx_model() == TS72XX_MODEL_TS7200;
-}
-
-static inline int board_is_ts7250(void)
-{
-	return ts72xx_model() == TS72XX_MODEL_TS7250;
-}
-
-static inline int board_is_ts7260(void)
-{
-	return ts72xx_model() == TS72XX_MODEL_TS7260;
-}
-
-static inline int board_is_ts7300(void)
-{
-	return ts72xx_model()  == TS72XX_MODEL_TS7300;
-}
-
-static inline int board_is_ts7400(void)
-{
-	return ts72xx_model() == TS72XX_MODEL_TS7400;
-}
-
-static inline int is_max197_installed(void)
-{
-	return !!(__raw_readb(TS72XX_OPTIONS_VIRT_BASE_IOMEM) &
-					TS72XX_OPTIONS_MAX197);
-}
-
-static inline int is_ts9420_installed(void)
-{
-	return !!(__raw_readb(TS72XX_OPTIONS2_VIRT_BASE_IOMEM) &
-					TS72XX_OPTIONS2_TS9420);
-}
-#endif /* __ASSEMBLY__ */
-
-#endif /* _TS72XX_H */
diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index aefda11..b363dd8 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -21,13 +21,13 @@
 #include <linux/mtd/partitions.h>
 
 #include <mach/hardware.h>
-#include <mach/ts72xx.h>
 
 #include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
 
+#include "ts72xx.h"
 #include "soc.h"
 
 static struct map_desc ts72xx_io_desc[] __initdata = {
diff --git a/arch/arm/mach-ep93xx/ts72xx.h b/arch/arm/mach-ep93xx/ts72xx.h
new file mode 100644
index 0000000..b30deb6
--- /dev/null
+++ b/arch/arm/mach-ep93xx/ts72xx.h
@@ -0,0 +1,110 @@
+/*
+ * arch/arm/mach-ep93xx/include/mach/ts72xx.h
+ */
+
+#ifndef _TS72XX_H
+#define _TS72XX_H
+
+#include <asm/io.h>
+
+/*
+ * TS72xx memory map:
+ *
+ * virt		phys		size
+ * febff000	22000000	4K	model number register (bits 0-2)
+ * febfe000	22400000	4K	options register
+ * febfd000	22800000	4K	options register #2
+ * febf9000	10800000	4K	TS-5620 RTC index register
+ * febf8000	11700000	4K	TS-5620 RTC data register
+ */
+
+#define TS72XX_MODEL_PHYS_BASE		0x22000000
+#define TS72XX_MODEL_VIRT_BASE		0xfebff000
+#define TS72XX_MODEL_VIRT_BASE_IOMEM	IOMEM(TS72XX_MODEL_VIRT_BASE)
+#define TS72XX_MODEL_SIZE		0x00001000
+
+#define TS72XX_MODEL_TS7200		0x00
+#define TS72XX_MODEL_TS7250		0x01
+#define TS72XX_MODEL_TS7260		0x02
+#define TS72XX_MODEL_TS7300		0x03
+#define TS72XX_MODEL_TS7400		0x04
+#define TS72XX_MODEL_MASK		0x07
+
+
+#define TS72XX_OPTIONS_PHYS_BASE	0x22400000
+#define TS72XX_OPTIONS_VIRT_BASE	0xfebfe000
+#define TS72XX_OPTIONS_VIRT_BASE_IOMEM	IOMEM(TS72XX_OPTIONS_VIRT_BASE)
+#define TS72XX_OPTIONS_SIZE		0x00001000
+
+#define TS72XX_OPTIONS_COM2_RS485	0x02
+#define TS72XX_OPTIONS_MAX197		0x01
+
+
+#define TS72XX_OPTIONS2_PHYS_BASE	0x22800000
+#define TS72XX_OPTIONS2_VIRT_BASE	0xfebfd000
+#define TS72XX_OPTIONS2_VIRT_BASE_IOMEM	IOMEM(TS72XX_OPTIONS2_VIRT_BASE)
+#define TS72XX_OPTIONS2_SIZE		0x00001000
+
+#define TS72XX_OPTIONS2_TS9420		0x04
+#define TS72XX_OPTIONS2_TS9420_BOOT	0x02
+
+
+#define TS72XX_RTC_INDEX_VIRT_BASE	0xfebf9000
+#define TS72XX_RTC_INDEX_VIRT_BASE_IOMEM IOMEM(TS72XX_RTC_INDEX_VIRT_BASE)
+#define TS72XX_RTC_INDEX_PHYS_BASE	0x10800000
+#define TS72XX_RTC_INDEX_SIZE		0x00001000
+
+#define TS72XX_RTC_DATA_VIRT_BASE	0xfebf8000
+#define TS72XX_RTC_DATA_VIRT_BASE_IOMEM	IOMEM(TS72XX_RTC_DATA_VIRT_BASE)
+#define TS72XX_RTC_DATA_PHYS_BASE	0x11700000
+#define TS72XX_RTC_DATA_SIZE		0x00001000
+
+#define TS72XX_WDT_CONTROL_PHYS_BASE	0x23800000
+#define TS72XX_WDT_FEED_PHYS_BASE	0x23c00000
+
+#ifndef __ASSEMBLY__
+
+static inline int ts72xx_model(void)
+{
+	return __raw_readb(TS72XX_MODEL_VIRT_BASE_IOMEM) & TS72XX_MODEL_MASK;
+}
+
+static inline int board_is_ts7200(void)
+{
+	return ts72xx_model() == TS72XX_MODEL_TS7200;
+}
+
+static inline int board_is_ts7250(void)
+{
+	return ts72xx_model() == TS72XX_MODEL_TS7250;
+}
+
+static inline int board_is_ts7260(void)
+{
+	return ts72xx_model() == TS72XX_MODEL_TS7260;
+}
+
+static inline int board_is_ts7300(void)
+{
+	return ts72xx_model()  == TS72XX_MODEL_TS7300;
+}
+
+static inline int board_is_ts7400(void)
+{
+	return ts72xx_model() == TS72XX_MODEL_TS7400;
+}
+
+static inline int is_max197_installed(void)
+{
+	return !!(__raw_readb(TS72XX_OPTIONS_VIRT_BASE_IOMEM) &
+					TS72XX_OPTIONS_MAX197);
+}
+
+static inline int is_ts9420_installed(void)
+{
+	return !!(__raw_readb(TS72XX_OPTIONS2_VIRT_BASE_IOMEM) &
+					TS72XX_OPTIONS2_TS9420);
+}
+#endif /* __ASSEMBLY__ */
+
+#endif /* _TS72XX_H */
-- 
1.7.9.7
