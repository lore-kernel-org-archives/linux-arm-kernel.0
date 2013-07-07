From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 07 Jul 2013 13:45:29 +0100
Subject: [PATCH RFC 2/9] ARM: debug: clean up low level kernel debugging
 selection
In-Reply-To: <20130707124326.GP24642@n2100.arm.linux.org.uk>
References: <20130707124326.GP24642@n2100.arm.linux.org.uk>
Message-ID: <E1UvoLJ-0006He-RH@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is silly to bury UART selection under multiple levels of choice
statements, where the top level choice statement will only list
about four entries when a single SoC is selected.  Move the UART
selection up into the top level choice statement as it was always
intended to be.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig.debug |  328 ++++++++++++++++++++++++++++--------------------
 1 files changed, 191 insertions(+), 137 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 2cc4b31..f9c1fc9 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -376,12 +376,72 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on TI-NSPIRE CX models.
 
-	config DEBUG_OMAP2PLUS_UART
-		bool "Kernel low-level debugging messages via OMAP2PLUS UART"
+	config DEBUG_OMAP2UART1
+		bool "OMAP2/3/4 UART1 (omap2/3 sdp boards and some omap3 boards)"
 		depends on ARCH_OMAP2PLUS
+		select DEBUG_OMAP2PLUS_UART
 		help
-		  Say Y here if you want kernel low-level debugging support
-		  on OMAP2PLUS based platforms.
+		  This covers at least h4, 2430sdp, 3430sdp, 3630sdp,
+		  omap3 torpedo and 3530 lv som.
+
+	config DEBUG_OMAP2UART2
+		bool "Kernel low-level debugging messages via OMAP2/3/4 UART2"
+		depends on ARCH_OMAP2PLUS
+		select DEBUG_OMAP2PLUS_UART
+
+	config DEBUG_OMAP2UART3
+		bool "Kernel low-level debugging messages via OMAP2 UART3 (n8x0)"
+		depends on ARCH_OMAP2PLUS
+		select DEBUG_OMAP2PLUS_UART
+
+	config DEBUG_OMAP3UART3
+		bool "Kernel low-level debugging messages via OMAP3 UART3 (most omap3 boards)"
+		depends on ARCH_OMAP2PLUS
+		select DEBUG_OMAP2PLUS_UART
+		help
+		  This covers at least cm_t3x, beagle, crane, devkit8000,
+		  igep00x0, ldp, n900, n9(50), pandora, overo, touchbook,
+		  and 3517evm.
+
+	config DEBUG_OMAP4UART3
+		bool "Kernel low-level debugging messages via OMAP4/5 UART3 (omap4 blaze, panda, omap5 sevm)"
+		depends on ARCH_OMAP2PLUS
+		select DEBUG_OMAP2PLUS_UART
+
+	config DEBUG_OMAP3UART4
+		bool "Kernel low-level debugging messages via OMAP36XX UART4"
+		depends on ARCH_OMAP2PLUS
+		select DEBUG_OMAP2PLUS_UART
+
+	config DEBUG_OMAP4UART4
+		bool "Kernel low-level debugging messages via OMAP4/5 UART4"
+		depends on ARCH_OMAP2PLUS
+		select DEBUG_OMAP2PLUS_UART
+
+	config DEBUG_TI81XXUART1
+		bool "Kernel low-level debugging messages via TI81XX UART1 (ti8148evm)"
+		depends on ARCH_OMAP2PLUS
+		select DEBUG_OMAP2PLUS_UART
+
+	config DEBUG_TI81XXUART2
+		bool "Kernel low-level debugging messages via TI81XX UART2"
+		depends on ARCH_OMAP2PLUS
+		select DEBUG_OMAP2PLUS_UART
+
+	config DEBUG_TI81XXUART3
+		bool "Kernel low-level debugging messages via TI81XX UART3 (ti8168evm)"
+		depends on ARCH_OMAP2PLUS
+		select DEBUG_OMAP2PLUS_UART
+
+	config DEBUG_AM33XXUART1
+		bool "Kernel low-level debugging messages via AM33XX UART1"
+		depends on ARCH_OMAP2PLUS
+		select DEBUG_OMAP2PLUS_UART
+
+	config DEBUG_ZOOM_UART
+		bool "Kernel low-level debugging messages via Zoom2/3 UART"
+		depends on ARCH_OMAP2PLUS
+		select DEBUG_OMAP2PLUS_UART
 
 	config DEBUG_PICOXCELL_UART
 		depends on ARCH_PICOXCELL
@@ -413,9 +473,58 @@ choice
 		  their output to the standard serial port on the RealView
 		  PB1176 platform.
 
-	config DEBUG_ROCKCHIP_UART
-		bool "Kernel low-level debugging messages via Rockchip UART"
+	config DEBUG_RK29_UART0
+		bool "Kernel low-level debugging messages via Rockchip RK29 UART0"
+		depends on ARCH_ROCKCHIP
+		select DEBUG_ROCKCHIP_UART
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Rockchip based platforms.
+
+	config DEBUG_RK29_UART1
+		bool "Kernel low-level debugging messages via Rockchip RK29 UART1"
+		depends on ARCH_ROCKCHIP
+		select DEBUG_ROCKCHIP_UART
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Rockchip based platforms.
+
+	config DEBUG_RK29_UART2
+		bool "Kernel low-level debugging messages via Rockchip RK29 UART2"
+		depends on ARCH_ROCKCHIP
+		select DEBUG_ROCKCHIP_UART
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Rockchip based platforms.
+
+	config DEBUG_RK3X_UART0
+		bool "Kernel low-level debugging messages via Rockchip RK3X UART0"
+		depends on ARCH_ROCKCHIP
+		select DEBUG_ROCKCHIP_UART
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Rockchip based platforms.
+
+	config DEBUG_RK3X_UART1
+		bool "Kernel low-level debugging messages via Rockchip RK3X UART1"
 		depends on ARCH_ROCKCHIP
+		select DEBUG_ROCKCHIP_UART
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Rockchip based platforms.
+
+	config DEBUG_RK3X_UART2
+		bool "Kernel low-level debugging messages via Rockchip RK3X UART2"
+		depends on ARCH_ROCKCHIP
+		select DEBUG_ROCKCHIP_UART
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Rockchip based platforms.
+
+	config DEBUG_RK3X_UART3
+		bool "Kernel low-level debugging messages via Rockchip RK3X UART3"
+		depends on ARCH_ROCKCHIP
+		select DEBUG_ROCKCHIP_UART
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on Rockchip based platforms.
@@ -489,9 +598,54 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on Allwinner A1X based platforms on the UART1.
 
-	config DEBUG_TEGRA_UART
+	config TEGRA_DEBUG_UART_AUTO_ODMDATA
+		bool "Kernel low-level debugging messages via Tegra UART via ODMDATA"
 		depends on ARCH_TEGRA
-		bool "Use Tegra UART for low-level debug"
+		select DEBUG_TEGRA_UART
+		help
+		  Automatically determines which UART to use for low-level
+		  debug based on the ODMDATA value. This value is part of
+		  the BCT, and is written to the boot memory device using
+		  nvflash, or other flashing tool.  When bits 19:18 are 3,
+		  then bits 17:15 indicate which UART to use; 0/1/2/3/4
+		  are UART A/B/C/D/E.
+
+	config TEGRA_DEBUG_UARTA
+		bool "Kernel low-level debugging messages via Tegra UART A"
+		depends on ARCH_TEGRA
+		select DEBUG_TEGRA_UART
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Tegra based platforms.
+
+	config TEGRA_DEBUG_UARTB
+		bool "Kernel low-level debugging messages via Tegra UART B"
+		depends on ARCH_TEGRA
+		select DEBUG_TEGRA_UART
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Tegra based platforms.
+
+	config TEGRA_DEBUG_UARTC
+		bool "Kernel low-level debugging messages via Tegra UART C"
+		depends on ARCH_TEGRA
+		select DEBUG_TEGRA_UART
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Tegra based platforms.
+
+	config TEGRA_DEBUG_UARTD
+		bool "Kernel low-level debugging messages via Tegra UART D"
+		depends on ARCH_TEGRA
+		select DEBUG_TEGRA_UART
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Tegra based platforms.
+
+	config TEGRA_DEBUG_UARTE
+		bool "Kernel low-level debugging messages via Tegra UART E"
+		depends on ARCH_TEGRA
+		select DEBUG_TEGRA_UART
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on Tegra based platforms.
@@ -564,13 +718,25 @@ choice
 		  This option selects UART0 on VIA/Wondermedia System-on-a-chip
 		  devices, including VT8500, WM8505, WM8650 and WM8850.
 
-	config DEBUG_STI_UART
+	config STIH41X_DEBUG_ASC2
+		bool "Use StiH415/416 ASC2 UART for low-level debug"
+		depends on ARCH_STI
+		select DEBUG_STI_UART
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on STiH415/416 based platforms like b2000, which has
+		  default UART wired up to ASC2.
+
+		  If unsure, say N.
+
+	config STIH41X_DEBUG_SBC_ASC1
+		bool "Use StiH415/416 SBC ASC1 UART for low-level debug"
 		depends on ARCH_STI
-		bool "Use StiH415/416 ASC for low-level debug"
+		select DEBUG_STI_UART
 		help
 		  Say Y here if you want kernel low-level debugging support
-		  on StiH415/416 based platforms like B2000, B2020.
-		  It support UART2 and SBC_UART1.
+		  on STiH415/416 based platforms like b2020. which has
+		  default UART wired up to SBC ASC1.
 
 		  If unsure, say N.
 
@@ -615,6 +781,10 @@ endchoice
 config DEBUG_EXYNOS_UART
 	bool
 
+config DEBUG_OMAP2PLUS_UART
+	bool
+	depends on ARCH_OMAP2PLUS
+
 config DEBUG_IMX_UART_PORT
 	int "i.MX Debug UART Port Selection" if DEBUG_IMX1_UART || \
 						DEBUG_IMX25_UART || \
@@ -631,133 +801,17 @@ config DEBUG_IMX_UART_PORT
 	  Choose UART port on which kernel low-level debug messages
 	  should be output.
 
-choice
-	prompt "Low-level debug console UART"
-	depends on DEBUG_OMAP2PLUS_UART
-
-	config DEBUG_OMAP2UART1
-		bool "OMAP2/3/4 UART1 (omap2/3 sdp boards and some omap3 boards)"
-		help
-		  This covers at least h4, 2430sdp, 3430sdp, 3630sdp,
-		  omap3 torpedo and 3530 lv som.
-
-	config DEBUG_OMAP2UART2
-		bool "OMAP2/3/4 UART2"
-
-	config DEBUG_OMAP2UART3
-		bool "OMAP2 UART3 (n8x0)"
-
-	config DEBUG_OMAP3UART3
-		bool "OMAP3 UART3 (most omap3 boards)"
-		help
-		  This covers at least cm_t3x, beagle, crane, devkit8000,
-		  igep00x0, ldp, n900, n9(50), pandora, overo, touchbook,
-		  and 3517evm.
-
-	config DEBUG_OMAP4UART3
-		bool "OMAP4/5 UART3 (omap4 blaze, panda, omap5 sevm)"
-
-	config DEBUG_OMAP3UART4
-		bool "OMAP36XX UART4"
-
-	config DEBUG_OMAP4UART4
-		bool "OMAP4/5 UART4"
-
-	config DEBUG_TI81XXUART1
-		bool "TI81XX UART1 (ti8148evm)"
-
-	config DEBUG_TI81XXUART2
-		bool "TI81XX UART2"
-
-	config DEBUG_TI81XXUART3
-		bool "TI81XX UART3 (ti8168evm)"
-
-	config DEBUG_AM33XXUART1
-		bool "AM33XX UART1"
-
-	config DEBUG_ZOOM_UART
-		bool "Zoom2/3 UART"
-endchoice
-
-choice
-	prompt "Low-level debug console UART"
-	depends on DEBUG_ROCKCHIP_UART
-
-	config DEBUG_RK29_UART0
-		bool "RK29 UART0"
-
-	config DEBUG_RK29_UART1
-		bool "RK29 UART1"
-
-	config DEBUG_RK29_UART2
-		bool "RK29 UART2"
-
-	config DEBUG_RK3X_UART0
-		bool "RK3X UART0"
-
-	config DEBUG_RK3X_UART1
-		bool "RK3X UART1"
-
-	config DEBUG_RK3X_UART2
-		bool "RK3X UART2"
-
-	config DEBUG_RK3X_UART3
-		bool "RK3X UART3"
-endchoice
-
-choice
-	prompt "Low-level debug console UART"
-	depends on DEBUG_LL && DEBUG_TEGRA_UART
-
-	config TEGRA_DEBUG_UART_AUTO_ODMDATA
-	bool "Via ODMDATA"
-	help
-	  Automatically determines which UART to use for low-level debug based
-	  on the ODMDATA value. This value is part of the BCT, and is written
-	  to the boot memory device using nvflash, or other flashing tool.
-	  When bits 19:18 are 3, then bits 17:15 indicate which UART to use;
-	  0/1/2/3/4 are UART A/B/C/D/E.
-
-	config TEGRA_DEBUG_UARTA
-		bool "UART A"
-
-	config TEGRA_DEBUG_UARTB
-		bool "UART B"
-
-	config TEGRA_DEBUG_UARTC
-		bool "UART C"
-
-	config TEGRA_DEBUG_UARTD
-		bool "UART D"
-
-	config TEGRA_DEBUG_UARTE
-		bool "UART E"
-
-endchoice
-
-choice
-	prompt "Low-level debug console UART"
-	depends on DEBUG_LL && DEBUG_STI_UART
-
-	config STIH41X_DEBUG_ASC2
-		bool "ASC2 UART"
-		help
-		  Say Y here if you want kernel low-level debugging support
-		  on STiH415/416 based platforms like b2000, which has
-		  default UART wired up to ASC2.
-
-		  If unsure, say N.
-
-	config STIH41X_DEBUG_SBC_ASC1
-		bool "SBC ASC1 UART"
-		help
-		  Say Y here if you want kernel low-level debugging support
-		  on STiH415/416 based platforms like b2020. which has
-		  default UART wired up to SBC ASC1.
+config DEBUG_ROCKCHIP_UART
+	bool
+	depends on ARCH_ROCKCHIP
 
-		  If unsure, say N.
+config DEBUG_TEGRA_UART
+	bool
+	depends on ARCH_TEGRA
 
-endchoice
+config DEBUG_STI_UART
+	bool
+	depends on ARCH_STI
 
 config DEBUG_LL_INCLUDE
 	string
-- 
1.7.4.4
