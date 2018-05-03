From: peron.clem@gmail.com (=?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?=)
Date: Thu,  3 May 2018 14:13:42 +0200
Subject: [PATCH] ARM: debug: enable UART1 for socfpga Cyclone5
Message-ID: <20180503121342.14178-1-peron.clem@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cyclone5 and Arria10 doesn't have the same memory map for UART1.

Split the SOCFPGA_UART1 into 2 options to allow debugging on UART1 for Cylone5.

Signed-off-by: Cl?ment P?ron <peron.clem@gmail.com>
---
 arch/arm/Kconfig.debug | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 199ebc1c4538..5b1f1ec1d3fe 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1067,14 +1067,21 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on SOCFPGA(Cyclone 5 and Arria 5) based platforms.
 
-	config DEBUG_SOCFPGA_UART1
+	config DEBUG_SOCFPGA_ARRIA10_UART1
 		depends on ARCH_SOCFPGA
-		bool "Use SOCFPGA UART1 for low-level debug"
+		bool "Use SOCFPGA Arria10 UART1 for low-level debug"
 		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on SOCFPGA(Arria 10) based platforms.
 
+	config DEBUG_SOCFPGA_CYCLONE5_UART1
+		depends on ARCH_SOCFPGA
+		bool "Use SOCFPGA Cyclone 5 UART1 for low-level debug"
+		select DEBUG_UART_8250
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on SOCFPGA(Cyclone 5 and Arria 5) based platforms.
 
 	config DEBUG_SUN9I_UART0
 		bool "Kernel low-level debugging messages via sun9i UART0"
@@ -1632,7 +1639,8 @@ config DEBUG_UART_PHYS
 	default 0xfe800000 if ARCH_IOP32X
 	default 0xff690000 if DEBUG_RK32_UART2
 	default 0xffc02000 if DEBUG_SOCFPGA_UART0
-	default 0xffc02100 if DEBUG_SOCFPGA_UART1
+	default 0xffc02100 if DEBUG_SOCFPGA_ARRIA10_UART1
+	default 0xffc03000 if DEBUG_SOCFPGA_CYCLONE5_UART1
 	default 0xffd82340 if ARCH_IOP13XX
 	default 0xffe40000 if DEBUG_RCAR_GEN1_SCIF0
 	default 0xffe42000 if DEBUG_RCAR_GEN1_SCIF2
@@ -1738,7 +1746,8 @@ config DEBUG_UART_VIRT
 	default 0xfeb30c00 if DEBUG_KEYSTONE_UART0
 	default 0xfeb31000 if DEBUG_KEYSTONE_UART1
 	default 0xfec02000 if DEBUG_SOCFPGA_UART0
-	default 0xfec02100 if DEBUG_SOCFPGA_UART1
+	default 0xfec02100 if DEBUG_SOCFPGA_ARRIA10_UART1
+	default 0xfec03000 if DEBUG_SOCFPGA_CYCLONE5_UART1
 	default 0xfec12000 if (DEBUG_MVEBU_UART0 || DEBUG_MVEBU_UART0_ALTERNATE) && ARCH_MVEBU
 	default 0xfec12100 if DEBUG_MVEBU_UART1_ALTERNATE
 	default 0xfec10000 if DEBUG_SIRFATLAS7_UART0
@@ -1787,9 +1796,9 @@ config DEBUG_UART_8250_WORD
 	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
 	depends on DEBUG_UART_8250_SHIFT >= 2
 	default y if DEBUG_PICOXCELL_UART || \
-		DEBUG_SOCFPGA_UART0 || DEBUG_SOCFPGA_UART1 || \
-		DEBUG_KEYSTONE_UART0 || DEBUG_KEYSTONE_UART1 || \
-		DEBUG_ALPINE_UART0 || \
+		DEBUG_SOCFPGA_UART0 || DEBUG_SOCFPGA_ARRIA10_UART1 || \
+		DEBUG_SOCFPGA_CYCLONE5_UART1 || DEBUG_KEYSTONE_UART0 || \
+		DEBUG_KEYSTONE_UART1 || DEBUG_ALPINE_UART0 || \
 		DEBUG_DAVINCI_DMx_UART0 || DEBUG_DAVINCI_DA8XX_UART1 || \
 		DEBUG_DAVINCI_DA8XX_UART2 || \
 		DEBUG_BCM_KONA_UART || DEBUG_RK32_UART2
-- 
2.17.0
