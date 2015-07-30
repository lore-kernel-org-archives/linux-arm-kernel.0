From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 Jul 2015 15:36:06 +0200
Subject: [PATCH 2/2] ARM: ux500: simplify and move debug UART
Message-ID: <1438263366-29756-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The debug UART code defined three different virtual addresses
while only one is ever used. Get rid of this, and move the
UART remapping to 0xfffe8000 where DTCM reside on some platforms
but not on Ux500, so it can be reused moving the UART out of the
vmalloc area.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/debug/ux500.S | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/debug/ux500.S b/arch/arm/include/debug/ux500.S
index aa7f63a8b5e0..aa3af7cb45e0 100644
--- a/arch/arm/include/debug/ux500.S
+++ b/arch/arm/include/debug/ux500.S
@@ -24,21 +24,16 @@
 #define U8500_UART0_PHYS_BASE	(0x80120000)
 #define U8500_UART1_PHYS_BASE	(0x80121000)
 #define U8500_UART2_PHYS_BASE	(0x80007000)
-#define U8500_UART0_VIRT_BASE	(0xf8120000)
-#define U8500_UART1_VIRT_BASE	(0xf8121000)
-#define U8500_UART2_VIRT_BASE	(0xf8007000)
 #define __UX500_PHYS_UART(n)	U8500_UART##n##_PHYS_BASE
-#define __UX500_VIRT_UART(n)	U8500_UART##n##_VIRT_BASE
 #endif
 
-#if !defined(__UX500_PHYS_UART) || !defined(__UX500_VIRT_UART)
+#if !defined(__UX500_PHYS_UART)
 #error Unknown SOC
 #endif
 
 #define UX500_PHYS_UART(n)	__UX500_PHYS_UART(n)
-#define UX500_VIRT_UART(n)	__UX500_VIRT_UART(n)
 #define UART_PHYS_BASE	UX500_PHYS_UART(CONFIG_UX500_DEBUG_UART)
-#define UART_VIRT_BASE	UX500_VIRT_UART(CONFIG_UX500_DEBUG_UART)
+#define UART_VIRT_BASE	(0xfff07000)
 
 	.macro	addruart, rp, rv, tmp
 	ldr	\rp, =UART_PHYS_BASE		@ no, physical address
-- 
2.4.3
