From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  5 Dec 2014 15:44:55 +0100
Subject: [PATCH 2/5] ARM: mvebu: Add UART1 as DEBUG_LL possible target
In-Reply-To: <1417790698-9792-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1417790698-9792-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1417790698-9792-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some mvebu boards have the UART1 more easily accessible than the other UARTs
found on the system.

Add a debug_ll option for this case.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/Kconfig.debug | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index b0945d6b32b3..8f119f5ffcdd 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -457,6 +457,21 @@ choice
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
@@ -1154,6 +1169,7 @@ config DEBUG_UART_PHYS
 	default 0xe4007000 if DEBUG_HIP04_UART
 	default 0xf0000be0 if ARCH_EBSA110
 	default 0xf1012000 if DEBUG_MVEBU_UART0_ALTERNATE
+	default 0xf1012100 if DEBUG_MVEBU_UART1_ALTERNATE
 	default 0xf1012000 if ARCH_DOVE || ARCH_MV78XX0 || \
 				ARCH_ORION5X
 	default 0xf7fc9000 if DEBUG_BERLIN_UART
@@ -1224,6 +1240,7 @@ config DEBUG_UART_VIRT
 	default 0xfeb31000 if DEBUG_KEYSTONE_UART1
 	default 0xfec02000 if DEBUG_SOCFPGA_UART
 	default 0xfec12000 if DEBUG_MVEBU_UART0 || DEBUG_MVEBU_UART0_ALTERNATE
+	default 0xfec12100 if DEBUG_MVEBU_UART1_ALTERNATE
 	default 0xfec20000 if DEBUG_DAVINCI_DMx_UART0
 	default 0xfec90000 if DEBUG_RK32_UART2
 	default 0xfed0c000 if DEBUG_DAVINCI_DA8XX_UART1
-- 
2.2.0
