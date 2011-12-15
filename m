From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 15 Dec 2011 13:50:59 +0100
Subject: [PATCH 2/5] ux500: update ASIC detection for U5500
Message-ID: <1323953459-27085-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This adds a few CPU identification functions for the U5500 variants.
Contains portions of code written by Rabin Vincent.

Cc: Rabin Vincent <rabin.vincent@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/include/mach/hardware.h |   10 +++++-----
 arch/arm/mach-ux500/include/mach/id.h       |   24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-ux500/include/mach/hardware.h b/arch/arm/mach-ux500/include/mach/hardware.h
index 470ac52..b6ba26a 100644
--- a/arch/arm/mach-ux500/include/mach/hardware.h
+++ b/arch/arm/mach-ux500/include/mach/hardware.h
@@ -10,20 +10,21 @@
 #ifndef __MACH_HARDWARE_H
 #define __MACH_HARDWARE_H
 
-/* macros to get at IO space when running virtually
+/*
+ * Macros to get at IO space when running virtually
  * We dont map all the peripherals, let ioremap do
  * this for us. We map only very basic peripherals here.
  */
 #define U8500_IO_VIRTUAL	0xf0000000
 #define U8500_IO_PHYSICAL	0xa0000000
 
-/* this macro is used in assembly, so no cast */
+/* This macro is used in assembly, so no cast */
 #define IO_ADDRESS(x)           \
 	(((x) & 0x0fffffff) + (((x) >> 4) & 0x0f000000) + U8500_IO_VIRTUAL)
 
 /* typesafe io address */
 #define __io_address(n)		__io(IO_ADDRESS(n))
-/* used by some plat-nomadik code */
+/* Used by some plat-nomadik code */
 #define io_p2v(n)		__io_address(n)
 
 #include <mach/db8500-regs.h>
@@ -36,6 +37,5 @@ extern void __iomem *_PRCMU_BASE;
 
 #define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
 
-#endif
-
+#endif				/* __ASSEMBLY__ */
 #endif				/* __MACH_HARDWARE_H */
diff --git a/arch/arm/mach-ux500/include/mach/id.h b/arch/arm/mach-ux500/include/mach/id.h
index 02b541a3..833d6a6 100644
--- a/arch/arm/mach-ux500/include/mach/id.h
+++ b/arch/arm/mach-ux500/include/mach/id.h
@@ -47,6 +47,30 @@ static inline bool __attribute_const__ cpu_is_u5500(void)
 }
 
 /*
+ * 5500 revisions
+ */
+
+static inline bool __attribute_const__ cpu_is_u5500v1(void)
+{
+	return cpu_is_u5500() && (dbx500_revision() & 0xf0) == 0xA0;
+}
+
+static inline bool __attribute_const__ cpu_is_u5500v2(void)
+{
+	return (dbx500_id.revision & 0xf0) == 0xB0;
+}
+
+static inline bool __attribute_const__ cpu_is_u5500v20(void)
+{
+	return cpu_is_u5500() && ((dbx500_revision() & 0xf0) == 0xB0);
+}
+
+static inline bool __attribute_const__ cpu_is_u5500v21(void)
+{
+	return cpu_is_u5500() && (dbx500_revision() == 0xB1);
+}
+
+/*
  * 8500 revisions
  */
 
-- 
1.7.3.2
