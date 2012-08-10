From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 10 Aug 2012 23:52:07 +0800
Subject: [PATCH] ARM: mmp: implement DEBUG_LL port choice
Message-ID: <1344613927-8238-1-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DEBUG_LL port must be choiced in arch-mmp. DEBUG_LL port should be
UART2 in TTC DKB. And it should be UART3 in brownstone.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/Kconfig.debug                       |   14 ++++++++++++++
 arch/arm/mach-mmp/include/mach/debug-macro.S |   12 ++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index f15f82b..0919191 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -224,6 +224,20 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on i.MX6Q UART4.
 
+	config DEBUG_MMP_UART2
+		bool "Kernel low-level debugging message via MMP UART2"
+		depends on ARCH_MMP
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on MMP UART2.
+
+	config DEBUG_MMP_UART3
+		bool "Kernel low-level debugging message via MMP UART3"
+		depends on ARCH_MMP
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on MMP UART3.
+
 	config DEBUG_MSM_UART1
 		bool "Kernel low-level debugging messages via MSM UART1"
 		depends on ARCH_MSM7X00A || ARCH_MSM7X30 || ARCH_QSD8X50
diff --git a/arch/arm/mach-mmp/include/mach/debug-macro.S b/arch/arm/mach-mmp/include/mach/debug-macro.S
index b6f14d2..5c3cc29 100644
--- a/arch/arm/mach-mmp/include/mach/debug-macro.S
+++ b/arch/arm/mach-mmp/include/mach/debug-macro.S
@@ -9,13 +9,21 @@
  * published by the Free Software Foundation.
  */
 
+#if defined(CONFIG_DEBUG_MMP_UART2)
+#define MMP_UART_OFFSET	0x00017000
+#elif defined(CONFIG_DEBUG_MMP_UART3)
+#define MMP_UART_OFFSET	0x00018000
+#else
+#error "Select uart for DEBUG_LL"
+#endif
+
 #include <mach/addr-map.h>
 
 		.macro	addruart, rp, rv, tmp
 		ldr	\rp, =APB_PHYS_BASE		@ physical
 		ldr	\rv, =APB_VIRT_BASE		@ virtual
-		orr	\rp, \rp, #0x00017000
-		orr	\rv, \rv, #0x00017000
+		orr	\rp, \rp, #MMP_UART_OFFSET
+		orr	\rv, \rv, #MMP_UART_OFFSET
 		.endm
 
 #define UART_SHIFT	2
-- 
1.7.9.5
