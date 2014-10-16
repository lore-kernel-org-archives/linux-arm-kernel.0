From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu, 16 Oct 2014 11:31:36 +0400
Subject: [PATCH] ARM: debug: move StrongARM debug include to
 arch/arm/include/debug
Message-ID: <1413444696-25790-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

StrongARM debug-macro.S is quite standalone thing, depending only on
register mappings. Move it to proper place and add Kconfig entry.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/Kconfig.debug                                         |  9 +++++++++
 .../include/mach/debug-macro.S => include/debug/sa1100.S}      | 10 ++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)
 rename arch/arm/{mach-sa1100/include/mach/debug-macro.S => include/debug/sa1100.S} (83%)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index b11ad54..8adf043 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -547,6 +547,14 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on PXA UART1.
 
+	config DEBUG_SA1100
+		depends on ARCH_SA1100
+		bool "Use SA1100 UARTs for low-level debug"
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on SA-11x0 UART ports. The kernel will check for the first
+		  enabled UART in a sequence 3-1-2.
+
 	config DEBUG_REALVIEW_STD_PORT
 		bool "RealView Default UART"
 		depends on ARCH_REALVIEW
@@ -1009,6 +1017,7 @@ config DEBUG_STI_UART
 
 config DEBUG_LL_INCLUDE
 	string
+	default "debug/sa1100.S" if DEBUG_SA1100
 	default "debug/8250.S" if DEBUG_LL_UART_8250 || DEBUG_UART_8250
 	default "debug/clps711x.S" if DEBUG_CLPS711X_UART1 || DEBUG_CLPS711X_UART2
 	default "debug/pl01x.S" if DEBUG_LL_UART_PL01X || DEBUG_UART_PL01X
diff --git a/arch/arm/mach-sa1100/include/mach/debug-macro.S b/arch/arm/include/debug/sa1100.S
similarity index 83%
rename from arch/arm/mach-sa1100/include/mach/debug-macro.S
rename to arch/arm/include/debug/sa1100.S
index 530772d..a0ae4f4 100644
--- a/arch/arm/mach-sa1100/include/mach/debug-macro.S
+++ b/arch/arm/include/debug/sa1100.S
@@ -1,4 +1,4 @@
-/* arch/arm/mach-sa1100/include/mach/debug-macro.S
+/* arch/arm/include/debug/sa1100.S
  *
  * Debugging macro include header
  *
@@ -10,7 +10,13 @@
  * published by the Free Software Foundation.
  *
 */
-#include <mach/hardware.h>
+
+#define UTCR3		0x0c
+#define UTDR		0x14
+#define UTSR1		0x20
+#define UTCR3_TXE	0x00000002	/* Transmit Enable                 */
+#define UTSR1_TBY	0x00000001	/* Transmitter BusY (read)         */
+#define UTSR1_TNF	0x00000004	/* Transmit FIFO Not Full (read)   */
 
 		.macro	addruart, rp, rv, tmp
 		mrc	p15, 0, \rp, c1, c0
-- 
2.1.1
