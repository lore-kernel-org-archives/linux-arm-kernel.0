From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Sun, 26 Sep 2010 15:23:13 +0800
Subject: [PATCH 1/1] ARM: mmp: update cpuid of pxa168 and pxa910
Message-ID: <1285485793-10738-1-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct the cpuid of pxa168 and pxa910.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-mmp/common.c               |    7 ++++
 arch/arm/mach-mmp/include/mach/cputype.h |   50 +++++++++++++++++++----------
 2 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-mmp/common.c b/arch/arm/mach-mmp/common.c
index 3b29fa7..9993a56 100644
--- a/arch/arm/mach-mmp/common.c
+++ b/arch/arm/mach-mmp/common.c
@@ -14,9 +14,14 @@
 #include <asm/page.h>
 #include <asm/mach/map.h>
 #include <mach/addr-map.h>
+#include <mach/cputype.h>
 
 #include "common.h"
 
+#define MMP_CHIPID	(AXI_VIRT_BASE + 0x82c00)
+
+unsigned int mmp_chip_id;
+
 static struct map_desc standard_io_desc[] __initdata = {
 	{
 		.pfn		= __phys_to_pfn(APB_PHYS_BASE),
@@ -34,4 +39,6 @@ static struct map_desc standard_io_desc[] __initdata = {
 void __init mmp_map_io(void)
 {
 	iotable_init(standard_io_desc, ARRAY_SIZE(standard_io_desc));
+
+	mmp_chip_id = __raw_readl(MMP_CHIPID);
 }
diff --git a/arch/arm/mach-mmp/include/mach/cputype.h b/arch/arm/mach-mmp/include/mach/cputype.h
index 83b1872..cc63615 100644
--- a/arch/arm/mach-mmp/include/mach/cputype.h
+++ b/arch/arm/mach-mmp/include/mach/cputype.h
@@ -4,36 +4,52 @@
 #include <asm/cputype.h>
 
 /*
- *  CPU   Stepping   OLD_ID       CPU_ID      CHIP_ID
+ *  CPU   Stepping   CPU_ID      CHIP_ID
  *
- * PXA168    A0    0x41159263   0x56158400   0x00A0A333
- * PXA910    Y0    0x41159262   0x56158000   0x00F0C910
- * MMP2	     Z0			0x560f5811
+ * PXA168    S0    0x56158400   0x0000C910
+ * PXA168    A0    0x56158400   0x00A0A168
+ * PXA910    Y1    0x56158400   0x00F2C920
+ * PXA910    A0    0x56158400   0x00F2C910
+ * PXA910    A1    0x56158400   0x00A0C910
+ * PXA920    Y0    0x56158400   0x00F2C920
+ * PXA920    A0    0x56158400   0x00A0C920
+ * PXA920    A1    0x56158400   0x00A1C920
+ * MMP2	     Z0	   0x560f5811   0x00F00410
+ * MMP2      Z1    0x560f5811   0x00E00410
+ * MMP2      A0    0x560f5811   0x00A0A610
  */
 
+extern unsigned int mmp_chip_id;
+
 #ifdef CONFIG_CPU_PXA168
-#  define __cpu_is_pxa168(id)	\
-	({ unsigned int _id = ((id) >> 8) & 0xff; _id == 0x84; })
+static inline int cpu_is_pxa168(void)
+{
+	return (((read_cpuid_id() >> 8) & 0xff) == 0x84)
+		&& ((mmp_chip_id & 0xfff) == 0x168);
+}
 #else
-#  define __cpu_is_pxa168(id)	(0)
+#define cpu_is_pxa168()	(0)
 #endif
 
+/* cpu_is_pxa910() is shared on both pxa910 and pxa920 */
 #ifdef CONFIG_CPU_PXA910
-#  define __cpu_is_pxa910(id)	\
-	({ unsigned int _id = ((id) >> 8) & 0xff; _id == 0x80; })
+static inline int cpu_is_pxa910(void)
+{
+	return (((read_cpuid_id() >> 8) & 0xff) == 0x84)
+		&& (((mmp_chip_id & 0xfff) == 0x910)
+		|| ((mmp_chip_id & 0xfff) == 0x920));
+}
 #else
-#  define __cpu_is_pxa910(id)	(0)
+#define cpu_is_pxa910()	(0)
 #endif
 
 #ifdef CONFIG_CPU_MMP2
-#  define __cpu_is_mmp2(id)	\
-	({ unsigned int _id = ((id) >> 8) & 0xff; _id == 0x58; })
+static inline int cpu_is_mmp2(void)
+{
+	return (((read_cpuid_id() >> 8) & 0xff) == 0x58);
+}
 #else
-#  define __cpu_is_mmp2(id)	(0)
+#define cpu_is_mmp2()	(0)
 #endif
 
-#define cpu_is_pxa168()		({ __cpu_is_pxa168(read_cpuid_id()); })
-#define cpu_is_pxa910()		({ __cpu_is_pxa910(read_cpuid_id()); })
-#define cpu_is_mmp2()		({ __cpu_is_mmp2(read_cpuid_id()); })
-
 #endif /* __ASM_MACH_CPUTYPE_H */
-- 
1.5.6.5
