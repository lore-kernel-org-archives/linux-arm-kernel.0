From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 27 Apr 2010 09:46:41 +0530
Subject: [PATCH 03/14] ux500: allow choice of the DEBUG_LL UART
In-Reply-To: <1272341812-4622-1-git-send-email-rabin.vincent@stericsson.com>
References: <1272341812-4622-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1272341812-4622-4-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow the UART used for DEBUG_LL to be selected.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Acked-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-ux500/Kconfig                    |    7 +++++++
 arch/arm/mach-ux500/include/mach/debug-macro.S |   12 ++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 699588f..8ad5ee8 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -27,4 +27,11 @@ config MACH_U8500_MOP
 	  on early drop silicon version of 8500.
 endmenu
 
+config UX500_DEBUG_UART
+	int "Ux500 UART to use for low-level debug"
+	default 2
+	help
+	  Choose the UART on which kernel low-level debug messages should be
+	  output.
+
 endif
diff --git a/arch/arm/mach-ux500/include/mach/debug-macro.S b/arch/arm/mach-ux500/include/mach/debug-macro.S
index 09cbfda..c5203b7 100644
--- a/arch/arm/mach-ux500/include/mach/debug-macro.S
+++ b/arch/arm/mach-ux500/include/mach/debug-macro.S
@@ -10,11 +10,19 @@
  */
 #include <mach/hardware.h>
 
+#if CONFIG_UX500_DEBUG_UART > 2
+#error Invalid Ux500 debug UART
+#endif
+
+#define __UX500_UART(n)	UX500_UART##n##_BASE
+#define UX500_UART(n)	__UX500_UART(n)
+#define UART_BASE	UX500_UART(CONFIG_UX500_DEBUG_UART)
+
 	.macro	addruart, rx, tmp
 	mrc	p15, 0, \rx, c1, c0
 	tst	\rx, #1					@ MMU enabled?
-	ldreq	\rx, =U8500_UART2_BASE			@ no, physical address
-	ldrne	\rx, =IO_ADDRESS(U8500_UART2_BASE)	@ yes, virtual address
+	ldreq	\rx, =UART_BASE				@ no, physical address
+	ldrne	\rx, =IO_ADDRESS(UART_BASE)		@ yes, virtual address
 	.endm
 
 #include <asm/hardware/debug-pl01x.S>
-- 
1.7.0
