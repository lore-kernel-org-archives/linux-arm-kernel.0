From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  4 Dec 2015 23:30:35 +0100
Subject: [PATCH 03/10] ARM: debug-ll: rework ep93xx handling
In-Reply-To: <1449268242-808553-1-git-send-email-arnd@arndb.de>
References: <1449268242-808553-1-git-send-email-arnd@arndb.de>
Message-ID: <1449268242-808553-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes ep93xx debug-ll handling more consistent with the other
platforms, by adding a separate Kconfig symbol for it that
in turn selects the standard DEBUG_UART_PL01X symbol.

We still have to pick a physical address even if DEBUG_LL is disabled
here, because the EP93xx uncompress output code uses
CONFIG_DEBUG_UART_PHYS. If we ever move to multiplatform support,
this can go away.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig.debug | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 8258f9dd1f77..cbdd096b9d13 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -263,6 +263,14 @@ choice
 		  Say Y here if you want the debug print routines to direct
 		  their output to the UA0 serial port in the CX92755.
 
+	config DEBUG_EP93XX
+		bool "Kernel low-level debugging messages via ep93xx UART"
+		depends on ARCH_EP93XX
+		select DEBUG_UART_PL01X
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Cirrus Logic EP93xx based platforms.
+
 	config DEBUG_FOOTBRIDGE_COM1
 		bool "Kernel low-level debugging messages via footbridge 8250 at PCI COM1"
 		depends on FOOTBRIDGE
@@ -1439,7 +1447,7 @@ config DEBUG_UART_PHYS
 	default 0x80070000 if DEBUG_IMX23_UART
 	default 0x80074000 if DEBUG_IMX28_UART
 	default 0x80230000 if DEBUG_PICOXCELL_UART
-	default 0x808c0000 if ARCH_EP93XX
+	default 0x808c0000 if DEBUG_EP93XX || ARCH_EP93XX
 	default 0x90020000 if DEBUG_NSPIRE_CLASSIC_UART || DEBUG_NSPIRE_CX_UART
 	default 0xb0060000 if DEBUG_SIRFPRIMA2_UART1
 	default 0xb0090000 if DEBUG_VEXPRESS_UART0_CRX
@@ -1571,7 +1579,7 @@ config DEBUG_UART_VIRT
 	default 0xfed60000 if DEBUG_RK29_UART0
 	default 0xfed64000 if DEBUG_RK29_UART1 || DEBUG_RK3X_UART2
 	default 0xfed68000 if DEBUG_RK29_UART2 || DEBUG_RK3X_UART3
-	default 0xfedc0000 if ARCH_EP93XX
+	default 0xfedc0000 if DEBUG_EP93XX
 	default 0xfee003f8 if FOOTBRIDGE
 	default 0xfee20000 if DEBUG_NSPIRE_CLASSIC_UART || DEBUG_NSPIRE_CX_UART
 	default 0xfee82340 if ARCH_IOP13XX
-- 
2.1.0.rc2
