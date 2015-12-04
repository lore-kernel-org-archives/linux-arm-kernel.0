From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  4 Dec 2015 23:30:37 +0100
Subject: [PATCH 05/10] ARM: debug-ll: rework integrator/versatile handling
In-Reply-To: <1449268242-808553-1-git-send-email-arnd@arndb.de>
References: <1449268242-808553-1-git-send-email-arnd@arndb.de>
Message-ID: <1449268242-808553-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabling one of the integrator platforms in a multiplatform kernel
while trying to use DEBUG_LL for another platform can default to
the wrong UART address, as the options are purely based on the
architecture being enabled or not.

This changes the logic to use the integrator default addresses only
if we have also picked the respective Kconfig symbols introduced
here. Versatile is not yet part of multiplatform, but hopefully
soon will be, so we do the same change for versatile as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig.debug | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 5eb62e97a35a..aa27e58e210a 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -433,6 +433,14 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on i.MX7D.
 
+	config DEBUG_INTEGRATOR
+		bool "Kernel low-level debugging messages via ARM Integrator UART"
+		depends on ARCH_INTEGRATOR
+		select DEBUG_UART_PL01X
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on ARM Integrator platforms.
+
 	config DEBUG_KEYSTONE_UART0
 		bool "Kernel low-level debugging on KEYSTONE2 using UART0"
 		depends on ARCH_KEYSTONE
@@ -1141,6 +1149,14 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  for Mediatek mt6589 based platforms on UART0.
 
+	config DEBUG_VERSATILE
+		bool "Kernel low-level debugging messages via ARM Versatile UART"
+		depends on ARCH_VERSATILE
+		select DEBUG_UART_PL01X
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on ARM Versatile platforms.
+
 	config DEBUG_MT8127_UART0
 		bool "Mediatek mt8127/mt6592 UART0"
 		depends on ARCH_MEDIATEK
@@ -1426,12 +1442,12 @@ config DEBUG_UART_PHYS
 	default 0x1010c000 if DEBUG_REALVIEW_PB1176_PORT
 	default 0x10124000 if DEBUG_RK3X_UART0
 	default 0x10126000 if DEBUG_RK3X_UART1
-	default 0x101f1000 if ARCH_VERSATILE
+	default 0x101f1000 if DEBUG_VERSATILE
 	default 0x101fb000 if DEBUG_NOMADIK_UART
 	default 0x11002000 if DEBUG_MT8127_UART0
 	default 0x11006000 if DEBUG_MT6589_UART0
 	default 0x11009000 if DEBUG_MT8135_UART3
-	default 0x16000000 if ARCH_INTEGRATOR
+	default 0x16000000 if DEBUG_INTEGRATOR
 	default 0x18000300 if DEBUG_BCM_5301X
 	default 0x18010000 if DEBUG_SIRFATLAS7_UART0
 	default 0x18020000 if DEBUG_SIRFATLAS7_UART1
@@ -1533,8 +1549,8 @@ config DEBUG_UART_VIRT
 	default 0xf1002000 if DEBUG_MT8127_UART0
 	default 0xf1006000 if DEBUG_MT6589_UART0
 	default 0xf1009000 if DEBUG_MT8135_UART3
-	default 0xf11f1000 if ARCH_VERSATILE
-	default 0xf1600000 if ARCH_INTEGRATOR
+	default 0xf11f1000 if DEBUG_VERSATILE
+	default 0xf1600000 if DEBUG_INTEGRATOR
 	default 0xf1c28000 if DEBUG_SUNXI_UART0
 	default 0xf1c28400 if DEBUG_SUNXI_UART1
 	default 0xf1f02800 if DEBUG_SUNXI_R_UART
-- 
2.1.0.rc2
