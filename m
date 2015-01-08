From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  8 Jan 2015 18:38:04 +0100
Subject: [PATCH v4 02/12] ARM: mvebu: Add UART1 as DEBUG_LL possible target
In-Reply-To: <1420738694-6163-1-git-send-email-gregory.clement@free-electrons.com>
References: <1420738694-6163-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1420738694-6163-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

Some mvebu boards have the UART1 more easily accessible than the other UARTs
found on the system.

Add a debug_ll option for this case.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Jason Cooper <jason@lakedaemon.net>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/Kconfig.debug | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index eb3991cf63ab..7bd1bbccc43c 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -489,6 +489,21 @@ choice
 		  when u-boot hands over to the kernel, the system
 		  silently crashes, with no serial output at all.
 
+	config DEBUG_MVEBU_UART1_ALTERNATE
+		bool "Kernel low-level debugging messages via MVEBU UART1 (new bootloaders)"
+		depends on ARCH_MVEBU
+		select DEBUG_UART_8250
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on MVEBU based platforms on UART1.
+
+		  This option should be used with the new bootloaders
+		  that remap the internal registers at 0xf1000000.
+
+		  If the wrong DEBUG_MVEBU_UART* option is selected,
+		  when u-boot hands over to the kernel, the system
+		  silently crashes, with no serial output at all.
+
 	config DEBUG_VF_UART
 		bool "Vybrid UART"
 		depends on SOC_VF610
@@ -1297,6 +1312,7 @@ config DEBUG_UART_PHYS
 	default 0xf0000be0 if ARCH_EBSA110
 	default 0xf040ab00 if DEBUG_BRCMSTB_UART
 	default 0xf1012000 if DEBUG_MVEBU_UART0_ALTERNATE
+	default 0xf1012100 if DEBUG_MVEBU_UART1_ALTERNATE
 	default 0xf1012000 if ARCH_DOVE || ARCH_MV78XX0 || \
 				ARCH_ORION5X
 	default 0xf7fc9000 if DEBUG_BERLIN_UART
@@ -1378,6 +1394,7 @@ config DEBUG_UART_VIRT
 	default 0xfeb31000 if DEBUG_KEYSTONE_UART1
 	default 0xfec02000 if DEBUG_SOCFPGA_UART
 	default 0xfec12000 if DEBUG_MVEBU_UART0 || DEBUG_MVEBU_UART0_ALTERNATE
+	default 0xfec12100 if DEBUG_MVEBU_UART1_ALTERNATE
 	default 0xfec20000 if DEBUG_DAVINCI_DMx_UART0
 	default 0xfec90000 if DEBUG_RK32_UART2
 	default 0xfed0c000 if DEBUG_DAVINCI_DA8XX_UART1
-- 
1.9.1
