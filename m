From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  4 Dec 2015 23:30:36 +0100
Subject: [PATCH 04/10] ARM: debug-ll: rework SPEAr handling
In-Reply-To: <1449268242-808553-1-git-send-email-arnd@arndb.de>
References: <1449268242-808553-1-git-send-email-arnd@arndb.de>
Message-ID: <1449268242-808553-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabling one of the SPEAr platforms in a multiplatform kernel
while trying to use DEBUG_LL for another platform can default to
the wrong UART address, as the options are purely based on the
architecture being enabled or not.

This changes the logic to use the SPEAr default addresses only
if we have also picked the respective Kconfig symbols introduced
here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig.debug | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index cbdd096b9d13..5eb62e97a35a 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1080,6 +1080,22 @@ choice
 		  Say Y here if you want the debug print routines to direct
 		  their output to the uart1 port on SiRFATLAS7 devices.
 
+	config DEBUG_SPEAR3XX
+		bool "Kernel low-level debugging messages via ST SPEAr 3xx/6xx UART"
+		depends on ARCH_SPEAR3XX || ARCH_SPEAR6XX
+		select DEBUG_UART_PL01X
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on ST SPEAr based platforms.
+
+	config DEBUG_SPEAR13XX
+		bool "Kernel low-level debugging messages via ST SPEAr 13xx UART"
+		depends on ARCH_SPEAR13XX
+		select DEBUG_UART_PL01X
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on ST SPEAr13xx based platforms.
+
 	config STIH41X_DEBUG_ASC2
 		bool "Use StiH415/416 ASC2 UART for low-level debug"
 		depends on ARCH_STI
@@ -1454,12 +1470,12 @@ config DEBUG_UART_PHYS
 	default 0xc0013000 if DEBUG_U300_UART
 	default 0xc8000000 if ARCH_IXP4XX && !CPU_BIG_ENDIAN
 	default 0xc8000003 if ARCH_IXP4XX && CPU_BIG_ENDIAN
-	default 0xd0000000 if ARCH_SPEAR3XX || ARCH_SPEAR6XX
+	default 0xd0000000 if DEBUG_SPEAR3XX
 	default 0xd0012000 if DEBUG_MVEBU_UART0
 	default 0xc81004c0 if DEBUG_MESON_UARTAO
 	default 0xd4017000 if DEBUG_MMP_UART2
 	default 0xd4018000 if DEBUG_MMP_UART3
-	default 0xe0000000 if ARCH_SPEAR13XX
+	default 0xe0000000 if DEBUG_SPEAR13XX
 	default 0xe4007000 if DEBUG_HIP04_UART
 	default 0xe6c40000 if DEBUG_RMOBILE_SCIFA0
 	default 0xe6c50000 if DEBUG_RMOBILE_SCIFA1
@@ -1547,8 +1563,7 @@ config DEBUG_UART_VIRT
 	default 0xfc40ab00 if DEBUG_BRCMSTB_UART
 	default 0xfc705000 if DEBUG_ZTE_ZX
 	default 0xfcfe8600 if DEBUG_UART_BCM63XX
-	default 0xfd000000 if ARCH_SPEAR3XX || ARCH_SPEAR6XX
-	default 0xfd000000 if ARCH_SPEAR13XX
+	default 0xfd000000 if DEBUG_SPEAR3XX || DEBUG_SPEAR13XX
 	default 0xfd012000 if DEBUG_MVEBU_UART0_ALTERNATE && ARCH_MV78XX0
 	default 0xfd883000 if DEBUG_ALPINE_UART0
 	default 0xfde12000 if DEBUG_MVEBU_UART0_ALTERNATE && ARCH_DOVE
-- 
2.1.0.rc2
