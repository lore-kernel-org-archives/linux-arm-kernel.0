From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 23 May 2014 15:51:22 +0800
Subject: [PATCH 19/22] ARM: sunxi: Add earlyprintk support using R_UART
 (sun6i/sun8i)
In-Reply-To: <1400831485-28576-1-git-send-email-wens@csie.org>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
Message-ID: <1400831485-28576-20-git-send-email-wens@csie.org>
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
index eab8ecb..9e22708 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -694,6 +694,14 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on Allwinner A1X based platforms on the UART1.
 
+	config DEBUG_SUNXI_R_UART
+		bool "Kernel low-level debugging messages via sunXi R_UART"
+		depends on ARCH_SUNXI
+		select DEBUG_UART_8250
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Allwinner A31 based platforms on the R_UART.
+
 	config TEGRA_DEBUG_UART_AUTO_ODMDATA
 		bool "Kernel low-level debugging messages via Tegra UART via ODMDATA"
 		depends on ARCH_TEGRA
@@ -1007,6 +1015,7 @@ config DEBUG_UART_PHYS
 	default 0x01c28400 if DEBUG_SUNXI_UART1
 	default 0x01d0c000 if DEBUG_DAVINCI_DA8XX_UART1
 	default 0x01d0d000 if DEBUG_DAVINCI_DA8XX_UART2
+	default 0x01f02800 if DEBUG_SUNXI_R_UART
 	default 0x02530c00 if DEBUG_KEYSTONE_UART0
 	default 0x02531000 if DEBUG_KEYSTONE_UART1
 	default 0x03010fe0 if ARCH_RPC
@@ -1072,6 +1081,7 @@ config DEBUG_UART_VIRT
 	default 0xf1600000 if ARCH_INTEGRATOR
 	default 0xf1c28000 if DEBUG_SUNXI_UART0
 	default 0xf1c28400 if DEBUG_SUNXI_UART1
+	default 0xf1f02800 if DEBUG_SUNXI_R_UART
 	default 0xf2100000 if DEBUG_PXA_UART1
 	default 0xf4090000 if ARCH_LPC32XX
 	default 0xf4200000 if ARCH_GEMINI
-- 
2.0.0.rc2
