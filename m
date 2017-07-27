From: bich.hemon@st.com (Bich HEMON)
Date: Thu, 27 Jul 2017 16:50:20 +0000
Subject: [PATCH] ARM: stm32: debug: add low-level debug support
In-Reply-To: <1501174209-27550-1-git-send-email-bich.hemon@st.com>
References: <1501174209-27550-1-git-send-email-bich.hemon@st.com>
Message-ID: <1501174209-27550-2-git-send-email-bich.hemon@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gerald Baeza <gerald.baeza@st.com>

This adds low-level debug support on USART1 for STM32F4
and STM32F7.
Compiled via 'CONFIG_DEBUG_LL' and 'CONFIG_EARLY_PRINTK'.
Enabled via 'earlyprintk' in bootargs.

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 arch/arm/Kconfig.debug         | 27 +++++++++++++++++++++++++++
 arch/arm/include/debug/stm32.S | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100644 arch/arm/include/debug/stm32.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 447629d..0b6e61e 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1126,6 +1126,28 @@ choice
 
 		  If unsure, say N.
 
+	config STM32F4_DEBUG_UART
+		bool "Use STM32F4 UART for low-level debug"
+		depends on ARCH_STM32
+		select DEBUG_STM32_UART
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on STM32F4 based platforms, which default UART is wired on
+		  USART1.
+
+		  If unsure, say N.
+
+	config STM32F7_DEBUG_UART
+		bool "Use STM32F7 UART for low-level debug"
+		depends on ARCH_STM32
+		select DEBUG_STM32_UART
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on STM32F7 based platforms, which default UART is wired on
+		  USART1.
+
+		  If unsure, say N.
+
 	config TEGRA_DEBUG_UART_AUTO_ODMDATA
 		bool "Kernel low-level debugging messages via Tegra UART via ODMDATA"
 		depends on ARCH_TEGRA
@@ -1410,6 +1432,10 @@ config DEBUG_STI_UART
 	bool
 	depends on ARCH_STI
 
+config DEBUG_STM32_UART
+	bool
+	depends on ARCH_STM32
+
 config DEBUG_SIRFSOC_UART
 	bool
 	depends on ARCH_SIRF
@@ -1457,6 +1483,7 @@ config DEBUG_LL_INCLUDE
 	default "debug/s5pv210.S" if DEBUG_S5PV210_UART
 	default "debug/sirf.S" if DEBUG_SIRFSOC_UART
 	default "debug/sti.S" if DEBUG_STI_UART
+	default "debug/stm32.S" if DEBUG_STM32_UART
 	default "debug/tegra.S" if DEBUG_TEGRA_UART
 	default "debug/ux500.S" if DEBUG_UX500_UART
 	default "debug/vexpress.S" if DEBUG_VEXPRESS_UART0_DETECT
diff --git a/arch/arm/include/debug/stm32.S b/arch/arm/include/debug/stm32.S
new file mode 100644
index 0000000..1e060a5
--- /dev/null
+++ b/arch/arm/include/debug/stm32.S
@@ -0,0 +1,41 @@
+/*
+ * Copyright (C) STMicroelectronics SA 2017
+ * Author:   Gerald Baeza <gerald.baeza@st.com>
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+
+#define STM32_UART_BASE			0x40011000	/* USART1 */
+
+#ifdef CONFIG_STM32F4_DEBUG_UART
+#define STM32_USART_SR_OFF		0x00
+#define STM32_USART_TDR_OFF		0x04
+#endif
+
+#ifdef CONFIG_STM32F7_DEBUG_UART
+#define STM32_USART_SR_OFF		0x1C
+#define STM32_USART_TDR_OFF		0x28
+#endif
+
+#define STM32_USART_TC			(1 << 6)	/* Tx complete       */
+#define STM32_USART_TXE			(1 << 7)	/* Tx data reg empty */
+
+		.macro	addruart, rp, rv, tmp
+		ldr	\rp,      =STM32_UART_BASE	@ physical base
+		ldr	\rv,      =STM32_UART_BASE      @ virt base /* NoMMU */
+		.endm
+
+		.macro  senduart,rd,rx
+		strb    \rd, [\rx, #STM32_USART_TDR_OFF]
+		.endm
+
+		.macro  waituart,rd,rx
+1001:	ldr	\rd, [\rx, #(STM32_USART_SR_OFF)]	@ Read Status Register
+	tst	\rd, #STM32_USART_TXE			@ TXE = 1 = tx empty
+	beq	1001b
+		.endm
+
+		.macro  busyuart,rd,rx
+1001:	ldr	\rd, [\rx, #(STM32_USART_SR_OFF)]	@ Read Status Register
+	tst	\rd, #STM32_USART_TC			@ TC = 1 = tx complete
+	beq	1001b
+		.endm
-- 
1.9.1
