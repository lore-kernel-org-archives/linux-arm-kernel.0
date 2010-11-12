From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 12 Nov 2010 15:17:30 +0800
Subject: [PATCH 01/11] ARM: pxa: redefine the cpu_is_pxa3xx
Message-ID: <1289546260-6208-1-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PXA300/PXA310/PXA320/PXA930/PXA935 are sharing one cpu family id.
It's a little confusion on cpu_is_pxa3xx().

Now reduce the scope of cpu_is_pxa3xx(). Make it focusing on
PXA300/PXA310/PXA320. PXA930/PXA935 is coverd by cpu_is_pxa93x().

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/include/mach/hardware.h |   26 +++++++++-----------------
 1 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/hardware.h b/arch/arm/mach-pxa/include/mach/hardware.h
index ca188cd..59f145a 100644
--- a/arch/arm/mach-pxa/include/mach/hardware.h
+++ b/arch/arm/mach-pxa/include/mach/hardware.h
@@ -145,53 +145,44 @@
 #define __cpu_is_pxa27x(id)	(0)
 #endif
 
-#ifdef CONFIG_CPU_PXA300
+#ifdef CONFIG_PXA3xx
 #define __cpu_is_pxa300(id)				\
 	({						\
 		unsigned int _id = (id) >> 4 & 0xfff;	\
 		_id == 0x688;				\
 	 })
-#else
-#define __cpu_is_pxa300(id)	(0)
-#endif
 
-#ifdef CONFIG_CPU_PXA310
 #define __cpu_is_pxa310(id)				\
 	({						\
 		unsigned int _id = (id) >> 4 & 0xfff;	\
 		_id == 0x689;				\
 	 })
-#else
-#define __cpu_is_pxa310(id)	(0)
-#endif
 
-#ifdef CONFIG_CPU_PXA320
 #define __cpu_is_pxa320(id)				\
 	({						\
 		unsigned int _id = (id) >> 4 & 0xfff;	\
 		_id == 0x603 || _id == 0x682;		\
 	 })
 #else
+#define __cpu_is_pxa300(id)	(0)
+#define __cpu_is_pxa310(id)	(0)
 #define __cpu_is_pxa320(id)	(0)
 #endif
 
-#ifdef CONFIG_CPU_PXA930
+#ifdef CONFIG_PXA93x
 #define __cpu_is_pxa930(id)				\
 	({						\
 		unsigned int _id = (id) >> 4 & 0xfff;	\
 		_id == 0x683;				\
 	 })
-#else
-#define __cpu_is_pxa930(id)	(0)
-#endif
 
-#ifdef CONFIG_CPU_PXA935
 #define __cpu_is_pxa935(id)				\
 	({						\
 		unsigned int _id = (id) >> 4 & 0xfff;	\
 		_id == 0x693;				\
 	 })
 #else
+#define __cpu_is_pxa930(id)	(0)
 #define __cpu_is_pxa935(id)	(0)
 #endif
 
@@ -264,7 +255,7 @@
 /*
  * CPUID Core Generation Bit
  * <= 0x2 for pxa21x/pxa25x/pxa26x/pxa27x
- * == 0x3 for pxa300/pxa310/pxa320
+ * == 0x3 for pxa300/pxa310/pxa320 and pxa930/pxa935
  */
 #if defined(CONFIG_PXA25x) || defined(CONFIG_PXA27x)
 #define __cpu_is_pxa2xx(id)				\
@@ -279,8 +270,9 @@
 #ifdef CONFIG_PXA3xx
 #define __cpu_is_pxa3xx(id)				\
 	({						\
-		unsigned int _id = (id) >> 13 & 0x7;	\
-		_id == 0x3;				\
+		__cpu_is_pxa300(id)			\
+			|| __cpu_is_pxa310(id)		\
+			|| __cpu_is_pxa320(id);		\
 	 })
 #else
 #define __cpu_is_pxa3xx(id)	(0)
-- 
1.5.6.5
