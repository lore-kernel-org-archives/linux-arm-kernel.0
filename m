From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Thu, 2 Apr 2015 23:39:56 -0500
Subject: [PATCH 5/7] ARM: socfpga: Add support for UART1 debug uart for
 earlyprintk
In-Reply-To: <1428035998-27542-1-git-send-email-dinguyen@opensource.altera.com>
References: <1428035998-27542-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <1428035998-27542-6-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Add support for hardware uart1 for earlyprintk support on Arria10 devkit.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/Kconfig.debug | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 970de75..0e52b92 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -920,13 +920,22 @@ choice
 		  on SA-11x0 UART ports. The kernel will check for the first
 		  enabled UART in a sequence 3-1-2.
 
-	config DEBUG_SOCFPGA_UART
+	config DEBUG_SOCFPGA_UART0
 		depends on ARCH_SOCFPGA
-		bool "Use SOCFPGA UART for low-level debug"
+		bool "Use SOCFPGA UART0 for low-level debug"
 		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
-		  on SOCFPGA based platforms.
+		  on SOCFPGA(Cyclone 5 and Arria 5) based platforms.
+
+	config DEBUG_SOCFPGA_UART1
+		depends on ARCH_SOCFPGA
+		bool "Use SOCFPGA UART1 for low-level debug"
+		select DEBUG_UART_8250
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on SOCFPGA(Arria 10) based platforms.
+
 
 	config DEBUG_SUN9I_UART0
 		bool "Kernel low-level debugging messages via sun9i UART0"
@@ -1419,7 +1428,8 @@ config DEBUG_UART_PHYS
 	default 0xfcb00000 if DEBUG_HI3620_UART
 	default 0xfe800000 if ARCH_IOP32X
 	default 0xff690000 if DEBUG_RK32_UART2
-	default 0xffc02000 if DEBUG_SOCFPGA_UART
+	default 0xffc02000 if DEBUG_SOCFPGA_UART0
+	default 0xffc02100 if DEBUG_SOCFPGA_UART1
 	default 0xffd82340 if ARCH_IOP13XX
 	default 0xffe40000 if DEBUG_RCAR_GEN1_SCIF0
 	default 0xffe42000 if DEBUG_RCAR_GEN1_SCIF2
@@ -1497,7 +1507,8 @@ config DEBUG_UART_VIRT
 	default 0xfeb26000 if DEBUG_RK3X_UART1
 	default 0xfeb30c00 if DEBUG_KEYSTONE_UART0
 	default 0xfeb31000 if DEBUG_KEYSTONE_UART1
-	default 0xfec02000 if DEBUG_SOCFPGA_UART
+	default 0xfec02000 if DEBUG_SOCFPGA_UART0
+	default 0xfec02100 if DEBUG_SOCFPGA_UART1
 	default 0xfec12000 if DEBUG_MVEBU_UART0 || DEBUG_MVEBU_UART0_ALTERNATE
 	default 0xfec12100 if DEBUG_MVEBU_UART1_ALTERNATE
 	default 0xfec10000 if DEBUG_SIRFATLAS7_UART0
@@ -1542,8 +1553,8 @@ config DEBUG_UART_8250_WORD
 	bool "Use 32-bit accesses for 8250 UART"
 	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
 	depends on DEBUG_UART_8250_SHIFT >= 2
-	default y if DEBUG_PICOXCELL_UART || DEBUG_SOCFPGA_UART || \
-		ARCH_KEYSTONE || \
+	default y if DEBUG_PICOXCELL_UART || DEBUG_SOCFPGA_UART0 || \
+		DEBUG_SOCFPGA_UART1 || ARCH_KEYSTONE || \
 		DEBUG_DAVINCI_DMx_UART0 || DEBUG_DAVINCI_DA8XX_UART1 || \
 		DEBUG_DAVINCI_DA8XX_UART2 || \
 		DEBUG_BCM_KONA_UART || DEBUG_RK32_UART2 || \
-- 
2.2.1
