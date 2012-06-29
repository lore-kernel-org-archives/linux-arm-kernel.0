From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Fri, 29 Jun 2012 16:58:26 +0530
Subject: [PATCH-V2] ARM: OMAP: cpu: Make cpu_class_is_omap2 true for all
 non-omap1 platforms
Message-ID: <1340969306-28464-1-git-send-email-hvaibhav@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As omap1 and omap2 will never be compiled together, due to
different compiler flags, so we can simply make
cpu_class_is_omap2() = true, for all non-omap1 platforms.

In order to fix build error from plat-omap/sram.c file,
omap_type() function is encapsulated under #ifdef CONFIG_ARCH_OMAP2PLUS.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
CC: Tony Lindgren <tony@atomide.com>
---
Boot tested on Beable Bone, AM37x EVM and build tested for omap1.
It would be helpful if someone can test it on omap1 platform.

Change from V1:
	- Fix omap1 build failure, by adding inline function
	  for omap_type().

 arch/arm/plat-omap/include/plat/cpu.h |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 8c84d05..c3617e2 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -42,7 +42,18 @@
 #define OMAP2_DEVICE_TYPE_GP		3
 #define OMAP2_DEVICE_TYPE_BAD		4

+#ifdef CONFIG_ARCH_OMAP2PLUS
 int omap_type(void);
+#else
+static inline int omap_type(void)
+{
+	/*
+	 * Safe to return 0, since this function will not
+	 * be called for omap1.
+	 */
+	return 0;
+}
+#endif

 /*
  * omap_rev bits:
@@ -358,8 +369,7 @@ IS_OMAP_TYPE(3430, 0x3430)
 /* Macros to detect if we have OMAP1 or OMAP2 */
 #define cpu_class_is_omap1()	(cpu_is_omap7xx() || cpu_is_omap15xx() || \
 				cpu_is_omap16xx())
-#define cpu_class_is_omap2()	(cpu_is_omap24xx() || cpu_is_omap34xx() || \
-				cpu_is_omap44xx())
+#define cpu_class_is_omap2()	!cpu_class_is_omap1()

 /* Various silicon revisions for omap2 */
 #define OMAP242X_CLASS		0x24200024
--
1.7.0.4
