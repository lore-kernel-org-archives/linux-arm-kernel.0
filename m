From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Jun 2014 22:52:55 +0800
Subject: [PATCH v2 18/20] ARM: sunxi: Add earlyprintk support using R_UART
 (sun6i/sun8i)
In-Reply-To: <1403016777-15121-1-git-send-email-wens@csie.org>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
Message-ID: <1403016777-15121-19-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sun6i/sun8i have a UART in the RTC block group, which can be used
as an early console. This is most useful on sun8i as UART0 is muxed
with MMC0, which is not available if we boot from MMC.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/Kconfig.debug | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 8f90595..3548612 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -715,6 +715,14 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on Allwinner A1X based platforms on the UART1.
 
+	config DEBUG_SUNXI_R_UART
+		bool "Kernel low-level debugging messages via sunXi R_UART"
+		depends on MACH_SUN6I || MACH_SUN8I
+		select DEBUG_UART_8250
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Allwinner A31/A23 based platforms on the R_UART.
+
 	config TEGRA_DEBUG_UART_AUTO_ODMDATA
 		bool "Kernel low-level debugging messages via Tegra UART via ODMDATA"
 		depends on ARCH_TEGRA
@@ -1043,6 +1051,7 @@ config DEBUG_UART_PHYS
 	default 0x01c28400 if DEBUG_SUNXI_UART1
 	default 0x01d0c000 if DEBUG_DAVINCI_DA8XX_UART1
 	default 0x01d0d000 if DEBUG_DAVINCI_DA8XX_UART2
+	default 0x01f02800 if DEBUG_SUNXI_R_UART
 	default 0x02530c00 if DEBUG_KEYSTONE_UART0
 	default 0x02531000 if DEBUG_KEYSTONE_UART1
 	default 0x03010fe0 if ARCH_RPC
@@ -1118,6 +1127,7 @@ config DEBUG_UART_VIRT
 	default 0xf1600000 if ARCH_INTEGRATOR
 	default 0xf1c28000 if DEBUG_SUNXI_UART0
 	default 0xf1c28400 if DEBUG_SUNXI_UART1
+	default 0xf1f02800 if DEBUG_SUNXI_R_UART
 	default 0xf2100000 if DEBUG_PXA_UART1
 	default 0xf4090000 if ARCH_LPC32XX
 	default 0xf4200000 if ARCH_GEMINI
-- 
2.0.0
