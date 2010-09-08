From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed,  8 Sep 2010 09:42:41 -0400
Subject: [PATCH 3/4] ARM: pxa: update cpuid of pxa168 & pxa910
In-Reply-To: <1283953362-2363-2-git-send-email-haojian.zhuang@marvell.com>
References: <1283953362-2363-1-git-send-email-haojian.zhuang@marvell.com>
	<1283953362-2363-2-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1283953362-2363-3-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support more steppings of pxa168 and pxa910.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-mmp/include/mach/cputype.h |   30 ++++++++++++++++++++----------
 1 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/cputype.h b/arch/arm/mach-mmp/include/mach/cputype.h
index 83b1872..f45cdbc 100644
--- a/arch/arm/mach-mmp/include/mach/cputype.h
+++ b/arch/arm/mach-mmp/include/mach/cputype.h
@@ -8,32 +8,42 @@
  *
  * PXA168    A0    0x41159263   0x56158400   0x00A0A333
  * PXA910    Y0    0x41159262   0x56158000   0x00F0C910
+ * PXA920    Y0                 0x56158400   0x00F2C920
+ * PXA920    A0                 0x56158400   0x00A0C920
  * MMP2	     Z0			0x560f5811
  */
 
+#define CHIP_ID		(AXI_VIRT_BASE + 0x82c00)
+
 #ifdef CONFIG_CPU_PXA168
-#  define __cpu_is_pxa168(id)	\
-	({ unsigned int _id = ((id) >> 8) & 0xff; _id == 0x84; })
+#define __cpu_is_pxa168(id, cid)	\
+	({ unsigned int _id = ((id) >> 8) & 0xff; \
+	   unsigned int _cid = (cid) & 0xfff; \
+	   _id == 0x84 && _cid != 0x910 && _cid != 0x920; })
 #else
-#  define __cpu_is_pxa168(id)	(0)
+#define __cpu_is_pxa168(id, cid)	(0)
 #endif
 
 #ifdef CONFIG_CPU_PXA910
-#  define __cpu_is_pxa910(id)	\
-	({ unsigned int _id = ((id) >> 8) & 0xff; _id == 0x80; })
+#define __cpu_is_pxa910(id, cid)	\
+	({ unsigned int _id = ((id) >> 8) & 0xff; \
+	   unsigned int _cid = (cid) & 0xfff; \
+	   (_id == 0x84 || _id == 0x80) && (_cid == 0x910 || _cid == 0x920); })
 #else
-#  define __cpu_is_pxa910(id)	(0)
+#define __cpu_is_pxa910(id, cid)	(0)
 #endif
 
 #ifdef CONFIG_CPU_MMP2
-#  define __cpu_is_mmp2(id)	\
+#define __cpu_is_mmp2(id)	\
 	({ unsigned int _id = ((id) >> 8) & 0xff; _id == 0x58; })
 #else
-#  define __cpu_is_mmp2(id)	(0)
+#define __cpu_is_mmp2(id)	(0)
 #endif
 
-#define cpu_is_pxa168()		({ __cpu_is_pxa168(read_cpuid_id()); })
-#define cpu_is_pxa910()		({ __cpu_is_pxa910(read_cpuid_id()); })
+#define cpu_is_pxa168()		({ __cpu_is_pxa168(read_cpuid_id(), \
+				__raw_readl(CHIP_ID)); })
+#define cpu_is_pxa910()		({ __cpu_is_pxa910(read_cpuid_id(), \
+				__raw_readl(CHIP_ID)); })
 #define cpu_is_mmp2()		({ __cpu_is_mmp2(read_cpuid_id()); })
 
 #endif /* __ASM_MACH_CPUTYPE_H */
-- 
1.5.6.5
