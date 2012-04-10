From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 10 Apr 2012 13:26:19 -0600
Subject: [PATCH] ARM: tegra: uncompress.h: Implement
 TEGRA_DEBUG_UART_AUTO_ODMDATA
Message-ID: <1334085979-11678-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Tegra has 5 UARTS which could be used for low-level debug output. Commit
fe26398 "ARM: tegra: uncompress.h: Choose a UART at runtime" implemented
one method for the kernel to automatically determine which of these to
use at run-time, so that the same DEBUG_LL-enabled kernel image could be
used across multiple Tegra boards. The required bootloader-side setup for
that option is implemented in NVIDIA's various downstream U-Boot branches,
but the U-Boot maintainers have refused to accept it upstream.

This change implements an alternative automatic UART selection option
using ODMDATA. This is a 32-bit value programmed into Tegra's boot memory
which provides a few pieces of basic board-specific information, including
a field that indicates the console UART. Setting up this value is part of
the standard Tegra boot architecture, and so requires no Tegra-specific
hacks in the bootloader's UART driver.

Note that in theory, the format of ODMDATA is board-specific. However, in
practice all boards use the same location/size/values for the UART field.
ODMDATA[19:18] (which drive the type of debug console) is more problematic,
since some boards use value 2 for UART and others use 3. This patch just
accepts either value; if this doesn't work well for a given board, I'd
suggest simply not enabling this debug option when building for that board.

Note that the kernel assumes the bootloader has already set up any required
pinmux settings for the UART; there is no way the kernel can do this for
itself prior to knowing which board it's running on. In practice, people
using this feature are highly likely to be using bootloaders that have
indeed configured the pinmux. This assumption existed prior to this patch.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/Kconfig                   |   29 ++++-
 arch/arm/mach-tegra/include/mach/uncompress.h |  176 ++++++++++++++++++-------
 2 files changed, 153 insertions(+), 52 deletions(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index d0f2546..204d3d4 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -111,7 +111,7 @@ config MACH_VENTANA
          Support for the nVidia Ventana development platform
 
 choice
-        prompt "Low-level debug console UART"
+        prompt "Default low-level debug console UART"
         default TEGRA_DEBUG_UART_NONE
 
 config TEGRA_DEBUG_UART_NONE
@@ -134,6 +134,33 @@ config TEGRA_DEBUG_UARTE
 
 endchoice
 
+choice
+	prompt "Automatic low-level debug console UART"
+	default TEGRA_DEBUG_UART_AUTO_NONE
+
+config TEGRA_DEBUG_UART_AUTO_NONE
+	bool "None"
+
+config TEGRA_DEBUG_UART_AUTO_ODMDATA
+	bool "Via ODMDATA"
+	help
+	  Automatically determines which UART to use for low-level debug based
+	  on the ODMDATA value. This value is part of the BCT, and is written
+	  to the boot memory device using nvflash, or other flashing tool.
+	  When bits 19:18 are 3, then bits 17:15 indicate which UART to use;
+	  0/1/2/3/4 are UART A/B/C/D/E.
+
+config TEGRA_DEBUG_UART_AUTO_SCRATCH
+	bool "Via UART scratch register"
+	help
+	  Automatically determines which UART to use for low-level debug based
+	  on the UART scratch register value. Some bootloaders put ASCII 'D'
+	  in this register when they initialize their own console UART output.
+	  Using this option allows the kernel to automatically pick the same
+	  UART.
+
+endchoice
+
 config TEGRA_SYSTEM_DMA
 	bool "Enable system DMA driver for NVIDIA Tegra SoCs"
 	default y
diff --git a/arch/arm/mach-tegra/include/mach/uncompress.h b/arch/arm/mach-tegra/include/mach/uncompress.h
index 5a440f3..937c4c5 100644
--- a/arch/arm/mach-tegra/include/mach/uncompress.h
+++ b/arch/arm/mach-tegra/include/mach/uncompress.h
@@ -63,52 +63,86 @@ static inline void save_uart_address(void)
 		buf[0] = 0;
 }
 
-/*
- * Setup before decompression.  This is where we do UART selection for
- * earlyprintk and init the uart_base register.
- */
-static inline void arch_decomp_setup(void)
+static const struct {
+	u32 base;
+	u32 reset_reg;
+	u32 clock_reg;
+	u32 bit;
+} uarts[] = {
+	{
+		TEGRA_UARTA_BASE,
+		TEGRA_CLK_RESET_BASE + 0x04,
+		TEGRA_CLK_RESET_BASE + 0x10,
+		6,
+	},
+	{
+		TEGRA_UARTB_BASE,
+		TEGRA_CLK_RESET_BASE + 0x04,
+		TEGRA_CLK_RESET_BASE + 0x10,
+		7,
+	},
+	{
+		TEGRA_UARTC_BASE,
+		TEGRA_CLK_RESET_BASE + 0x08,
+		TEGRA_CLK_RESET_BASE + 0x14,
+		23,
+	},
+	{
+		TEGRA_UARTD_BASE,
+		TEGRA_CLK_RESET_BASE + 0x0c,
+		TEGRA_CLK_RESET_BASE + 0x18,
+		1,
+	},
+	{
+		TEGRA_UARTE_BASE,
+		TEGRA_CLK_RESET_BASE + 0x0c,
+		TEGRA_CLK_RESET_BASE + 0x18,
+		2,
+	},
+};
+
+static inline bool uart_clocked(int i)
+{
+	if (*(u8 *)uarts[i].reset_reg & BIT(uarts[i].bit))
+		return false;
+
+	if (!(*(u8 *)uarts[i].clock_reg & BIT(uarts[i].bit)))
+		return false;
+
+	return true;
+}
+
+#ifdef CONFIG_TEGRA_DEBUG_UART_AUTO_ODMDATA
+int auto_odmdata(void)
+{
+	volatile u32 *pmc = (volatile u32 *)TEGRA_PMC_BASE;
+	u32 odmdata = pmc[0xa0 / 4];
+
+	/*
+	 * Bits 19:18 are the console type: 0=default, 1=none, 2==DCC, 3==UART
+	 * Some boards apparently swap the last two values, but we don't have
+	 * any way of catering for that here, so we just accept either. If this
+	 * doesn't make sense for your board, just don't enable this feature.
+	 *
+	 * Bits 17:15 indicate the UART to use, 0/1/2/3/4 are UART A/B/C/D/E.
+	 */
+
+	switch  ((odmdata >> 18) & 3) {
+	case 2:
+	case 3:
+		break;
+	default:
+		return -1;
+	}
+
+	return (odmdata >> 15) & 7;
+}
+#endif
+
+#ifdef CONFIG_TEGRA_DEBUG_UART_AUTO_SCRATCH
+int auto_scratch(void)
 {
-	static const struct {
-		u32 base;
-		u32 reset_reg;
-		u32 clock_reg;
-		u32 bit;
-	} uarts[] = {
-		{
-			TEGRA_UARTA_BASE,
-			TEGRA_CLK_RESET_BASE + 0x04,
-			TEGRA_CLK_RESET_BASE + 0x10,
-			6,
-		},
-		{
-			TEGRA_UARTB_BASE,
-			TEGRA_CLK_RESET_BASE + 0x04,
-			TEGRA_CLK_RESET_BASE + 0x10,
-			7,
-		},
-		{
-			TEGRA_UARTC_BASE,
-			TEGRA_CLK_RESET_BASE + 0x08,
-			TEGRA_CLK_RESET_BASE + 0x14,
-			23,
-		},
-		{
-			TEGRA_UARTD_BASE,
-			TEGRA_CLK_RESET_BASE + 0x0c,
-			TEGRA_CLK_RESET_BASE + 0x18,
-			1,
-		},
-		{
-			TEGRA_UARTE_BASE,
-			TEGRA_CLK_RESET_BASE + 0x0c,
-			TEGRA_CLK_RESET_BASE + 0x18,
-			2,
-		},
-	};
 	int i;
-	volatile u32 *apb_misc = (volatile u32 *)TEGRA_APB_MISC_BASE;
-	u32 chip, div;
 
 	/*
 	 * Look for the first UART that:
@@ -125,20 +159,60 @@ static inline void arch_decomp_setup(void)
 	 * back to what's specified in TEGRA_DEBUG_UART_BASE.
 	 */
 	for (i = 0; i < ARRAY_SIZE(uarts); i++) {
-		if (*(u8 *)uarts[i].reset_reg & BIT(uarts[i].bit))
-			continue;
-
-		if (!(*(u8 *)uarts[i].clock_reg & BIT(uarts[i].bit)))
+		if (!uart_clocked(i))
 			continue;
 
 		uart = (volatile u8 *)uarts[i].base;
 		if (uart[UART_SCR << DEBUG_UART_SHIFT] != 'D')
 			continue;
 
-		break;
+		return i;
 	}
-	if (i == ARRAY_SIZE(uarts))
-		uart = (volatile u8 *)TEGRA_DEBUG_UART_BASE;
+
+	return -1;
+}
+#endif
+
+/*
+ * Setup before decompression.  This is where we do UART selection for
+ * earlyprintk and init the uart_base register.
+ */
+static inline void arch_decomp_setup(void)
+{
+	int uart_id, auto_uart_id;
+	volatile u32 *apb_misc = (volatile u32 *)TEGRA_APB_MISC_BASE;
+	u32 chip, div;
+
+#if defined(CONFIG_TEGRA_DEBUG_UARTA)
+	uart_id = 0;
+#elif defined(CONFIG_TEGRA_DEBUG_UARTB)
+	uart_id = 1;
+#elif defined(CONFIG_TEGRA_DEBUG_UARTC)
+	uart_id = 2;
+#elif defined(CONFIG_TEGRA_DEBUG_UARTD)
+	uart_id = 3;
+#elif defined(CONFIG_TEGRA_DEBUG_UARTE)
+	uart_id = 4;
+#else
+	uart_id = -1;
+#endif
+
+#if defined(CONFIG_TEGRA_DEBUG_UART_AUTO_ODMDATA)
+	auto_uart_id = auto_odmdata();
+#elif defined(CONFIG_TEGRA_DEBUG_UART_AUTO_SCRATCH)
+	auto_uart_id = auto_scratch();
+#else
+	auto_uart_id = -1;
+#endif
+	if (auto_uart_id != -1)
+		uart_id = auto_uart_id;
+
+	if (uart_id < 0 || uart_id >= ARRAY_SIZE(uarts) ||
+	    !uart_clocked(uart_id))
+		uart = NULL;
+	else
+		uart = (volatile u8 *)uarts[uart_id].base;
+
 	save_uart_address();
 	if (uart == NULL)
 		return;
-- 
1.7.0.4
