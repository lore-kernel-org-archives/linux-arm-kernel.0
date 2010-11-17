From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 17 Nov 2010 19:03:35 +0800
Subject: [PATCH 1/9] ARM: pxa: redefine the cpu_is_pxa3xx
Message-ID: <1289991823-24677-1-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After introducing pxa930/pxa935 and new silicons, original cpuid rules
of XScale generation 3 can't fit new silicons. Now redefine the rule
of PXA3xx.

Only PXA300/PXA310/PXA320/PXA930/PXA935 are family members of PXA3xx.
PXA930/PXA935 are family members of PXA93x. PXA93x can be considered
as PXA3xx + CP.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/include/mach/hardware.h |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/hardware.h b/arch/arm/mach-pxa/include/mach/hardware.h
index ca188cd..e480d1e 100644
--- a/arch/arm/mach-pxa/include/mach/hardware.h
+++ b/arch/arm/mach-pxa/include/mach/hardware.h
@@ -264,7 +264,6 @@
 /*
  * CPUID Core Generation Bit
  * <= 0x2 for pxa21x/pxa25x/pxa26x/pxa27x
- * == 0x3 for pxa300/pxa310/pxa320
  */
 #if defined(CONFIG_PXA25x) || defined(CONFIG_PXA27x)
 #define __cpu_is_pxa2xx(id)				\
@@ -279,8 +278,10 @@
 #ifdef CONFIG_PXA3xx
 #define __cpu_is_pxa3xx(id)				\
 	({						\
-		unsigned int _id = (id) >> 13 & 0x7;	\
-		_id == 0x3;				\
+		__cpu_is_pxa300(id)			\
+			|| __cpu_is_pxa310(id)		\
+			|| __cpu_is_pxa320(id)		\
+			|| __cpu_is_pxa93x(id);		\
 	 })
 #else
 #define __cpu_is_pxa3xx(id)	(0)
@@ -289,8 +290,8 @@
 #if defined(CONFIG_CPU_PXA930) || defined(CONFIG_CPU_PXA935)
 #define __cpu_is_pxa93x(id)				\
 	({						\
-		unsigned int _id = (id) >> 4 & 0xfff;	\
-		_id == 0x683 || _id == 0x693;		\
+		__cpu_is_pxa930(id)			\
+			|| __cpu_is_pxa935(id);		\
 	 })
 #else
 #define __cpu_is_pxa93x(id)	(0)
-- 
1.5.6.5
