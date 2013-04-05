From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 5 Apr 2013 16:22:50 +0200
Subject: [PATCH 08/14] ARM: ux500: make debug macro stand-alone
In-Reply-To: <1365171776-8463-1-git-send-email-linus.walleij@stericsson.com>
References: <1365171776-8463-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1365171776-8463-9-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This pushes the knowledge of physical addresses down into
the debug macro so we can get rid of the <mach/hardware.h>
dependency.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/debug/ux500.S | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/debug/ux500.S b/arch/arm/include/debug/ux500.S
index 6703522..2848857 100644
--- a/arch/arm/include/debug/ux500.S
+++ b/arch/arm/include/debug/ux500.S
@@ -8,7 +8,7 @@
  * published by the Free Software Foundation.
  *
  */
-#include <mach/hardware.h>
+
 
 #if CONFIG_UX500_DEBUG_UART > 2
 #error Invalid Ux500 debug UART
@@ -21,19 +21,28 @@
  */
 
 #ifdef CONFIG_UX500_SOC_DB8500
-#define __UX500_UART(n)	U8500_UART##n##_BASE
+#define U8500_UART0_PHYS_BASE	(0x80120000)
+#define U8500_UART1_PHYS_BASE	(0x80121000)
+#define U8500_UART2_PHYS_BASE	(0x80007000)
+#define U8500_UART0_VIRT_BASE	(0xa8120000)
+#define U8500_UART1_VIRT_BASE	(0xa8121000)
+#define U8500_UART2_VIRT_BASE	(0xa8007000)
+#define __UX500_PHYS_UART(n)	U8500_UART##n##_PHYS_BASE
+#define __UX500_VIRT_UART(n)	U8500_UART##n##_VIRT_BASE
 #endif
 
-#ifndef __UX500_UART
+#if !defined(__UX500_PHYS_UART) || !defined(__UX500_VIRT_UART)
 #error Unknown SOC
 #endif
 
-#define UX500_UART(n)	__UX500_UART(n)
-#define UART_BASE	UX500_UART(CONFIG_UX500_DEBUG_UART)
+#define UX500_PHYS_UART(n)	__UX500_PHYS_UART(n)
+#define UX500_VIRT_UART(n)	__UX500_VIRT_UART(n)
+#define UART_PHYS_BASE	UX500_PHYS_UART(CONFIG_UX500_DEBUG_UART)
+#define UART_VIRT_BASE	UX500_VIRT_UART(CONFIG_UX500_DEBUG_UART)
 
 	.macro	addruart, rp, rv, tmp
-	ldr	\rp, =UART_BASE				@ no, physical address
-	ldr	\rv, =IO_ADDRESS(UART_BASE)		@ yes, virtual address
+	ldr	\rp, =UART_PHYS_BASE		@ no, physical address
+	ldr	\rv, =UART_VIRT_BASE		@ yes, virtual address
 	.endm
 
 #include <asm/hardware/debug-pl01x.S>
-- 
1.7.11.3
