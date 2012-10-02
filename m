From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue,  2 Oct 2012 13:07:44 -0600
Subject: [PATCH 1/3] ARM: tegra: simplify DEBUG_LL UART selection options
Message-ID: <1349204866-21810-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Delete CONFIG_TEGRA_DEBUG_UART_AUTO_SCRATCH; it's not useful any more:
* No upstream bootloader currently or will ever support this option.
* CONFIG_TEGRA_DEBUG_UART_AUTO_ODMDATA is a much more direct alternative.

Merge the fixed and automatic UART selection menus into a single choice
for simplicity; now you either pick AUTO_ODMDATA or a single fixed UART,
rather than potentially having an AUTO option override whatever fixed
option was chosen.

Remove TEGRA_DEBUG_UART_NONE; if you don't want a Tegra DEBUG_LL UART,
simply don't turn on DEBUG_LL. NONE used to be the default option, so
pick AUTO_ODMDATA as the new default.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/Kconfig                   |   41 +++++---------------
 arch/arm/mach-tegra/common.c                  |    5 +-
 arch/arm/mach-tegra/include/mach/iomap.h      |   14 -------
 arch/arm/mach-tegra/include/mach/uncompress.h |   52 ++-----------------------
 4 files changed, 16 insertions(+), 96 deletions(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 1219d87..87f0e2d 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -58,11 +58,17 @@ config TEGRA_AHB
 	  perfomance parameters(priority, prefech size).
 
 choice
-        prompt "Default low-level debug console UART"
-        default TEGRA_DEBUG_UART_NONE
+        prompt "Low-level debug console UART"
+        default TEGRA_DEBUG_UART_AUTO_ODMDATA
 
-config TEGRA_DEBUG_UART_NONE
-        bool "None"
+config TEGRA_DEBUG_UART_AUTO_ODMDATA
+	bool "Via ODMDATA"
+	help
+	  Automatically determines which UART to use for low-level debug based
+	  on the ODMDATA value. This value is part of the BCT, and is written
+	  to the boot memory device using nvflash, or other flashing tool.
+	  When bits 19:18 are 3, then bits 17:15 indicate which UART to use;
+	  0/1/2/3/4 are UART A/B/C/D/E.
 
 config TEGRA_DEBUG_UARTA
         bool "UART-A"
@@ -81,33 +87,6 @@ config TEGRA_DEBUG_UARTE
 
 endchoice
 
-choice
-	prompt "Automatic low-level debug console UART"
-	default TEGRA_DEBUG_UART_AUTO_NONE
-
-config TEGRA_DEBUG_UART_AUTO_NONE
-	bool "None"
-
-config TEGRA_DEBUG_UART_AUTO_ODMDATA
-	bool "Via ODMDATA"
-	help
-	  Automatically determines which UART to use for low-level debug based
-	  on the ODMDATA value. This value is part of the BCT, and is written
-	  to the boot memory device using nvflash, or other flashing tool.
-	  When bits 19:18 are 3, then bits 17:15 indicate which UART to use;
-	  0/1/2/3/4 are UART A/B/C/D/E.
-
-config TEGRA_DEBUG_UART_AUTO_SCRATCH
-	bool "Via UART scratch register"
-	help
-	  Automatically determines which UART to use for low-level debug based
-	  on the UART scratch register value. Some bootloaders put ASCII 'D'
-	  in this register when they initialize their own console UART output.
-	  Using this option allows the kernel to automatically pick the same
-	  UART.
-
-endchoice
-
 config TEGRA_EMC_SCALING_ENABLE
 	bool "Enable scaling the memory frequency"
 
diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 0b0a5f5..0913d1f 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -44,14 +44,13 @@
  * kernel is loaded. The data is declared here rather than debug-macro.S so
  * that multiple inclusions of debug-macro.S point at the same data.
  */
-#define TEGRA_DEBUG_UART_OFFSET (TEGRA_DEBUG_UART_BASE & 0xFFFF)
 u32 tegra_uart_config[3] = {
 	/* Debug UART initialization required */
 	1,
 	/* Debug UART physical address */
-	(u32)(IO_APB_PHYS + TEGRA_DEBUG_UART_OFFSET),
+	0,
 	/* Debug UART virtual address */
-	(u32)(IO_APB_VIRT + TEGRA_DEBUG_UART_OFFSET),
+	0,
 };
 
 #ifdef CONFIG_OF
diff --git a/arch/arm/mach-tegra/include/mach/iomap.h b/arch/arm/mach-tegra/include/mach/iomap.h
index fee3a94..4f1d9a3 100644
--- a/arch/arm/mach-tegra/include/mach/iomap.h
+++ b/arch/arm/mach-tegra/include/mach/iomap.h
@@ -263,20 +263,6 @@
 #define TEGRA_SDMMC4_BASE		0xC8000600
 #define TEGRA_SDMMC4_SIZE		SZ_512
 
-#if defined(CONFIG_TEGRA_DEBUG_UART_NONE)
-# define TEGRA_DEBUG_UART_BASE 0
-#elif defined(CONFIG_TEGRA_DEBUG_UARTA)
-# define TEGRA_DEBUG_UART_BASE TEGRA_UARTA_BASE
-#elif defined(CONFIG_TEGRA_DEBUG_UARTB)
-# define TEGRA_DEBUG_UART_BASE TEGRA_UARTB_BASE
-#elif defined(CONFIG_TEGRA_DEBUG_UARTC)
-# define TEGRA_DEBUG_UART_BASE TEGRA_UARTC_BASE
-#elif defined(CONFIG_TEGRA_DEBUG_UARTD)
-# define TEGRA_DEBUG_UART_BASE TEGRA_UARTD_BASE
-#elif defined(CONFIG_TEGRA_DEBUG_UARTE)
-# define TEGRA_DEBUG_UART_BASE TEGRA_UARTE_BASE
-#endif
-
 /* On TEGRA, many peripherals are very closely packed in
  * two 256MB io windows (that actually only use about 64KB
  * at the start of each).
diff --git a/arch/arm/mach-tegra/include/mach/uncompress.h b/arch/arm/mach-tegra/include/mach/uncompress.h
index 937c4c5..d5b86ce 100644
--- a/arch/arm/mach-tegra/include/mach/uncompress.h
+++ b/arch/arm/mach-tegra/include/mach/uncompress.h
@@ -139,51 +139,19 @@ int auto_odmdata(void)
 }
 #endif
 
-#ifdef CONFIG_TEGRA_DEBUG_UART_AUTO_SCRATCH
-int auto_scratch(void)
-{
-	int i;
-
-	/*
-	 * Look for the first UART that:
-	 * a) Is not in reset.
-	 * b) Is clocked.
-	 * c) Has a 'D' in the scratchpad register.
-	 *
-	 * Note that on Tegra30, the first two conditions are required, since
-	 * if not true, accesses to the UART scratch register will hang.
-	 * Tegra20 doesn't have this issue.
-	 *
-	 * The intent is that the bootloader will tell the kernel which UART
-	 * to use by setting up those conditions. If nothing found, we'll fall
-	 * back to what's specified in TEGRA_DEBUG_UART_BASE.
-	 */
-	for (i = 0; i < ARRAY_SIZE(uarts); i++) {
-		if (!uart_clocked(i))
-			continue;
-
-		uart = (volatile u8 *)uarts[i].base;
-		if (uart[UART_SCR << DEBUG_UART_SHIFT] != 'D')
-			continue;
-
-		return i;
-	}
-
-	return -1;
-}
-#endif
-
 /*
  * Setup before decompression.  This is where we do UART selection for
  * earlyprintk and init the uart_base register.
  */
 static inline void arch_decomp_setup(void)
 {
-	int uart_id, auto_uart_id;
+	int uart_id;
 	volatile u32 *apb_misc = (volatile u32 *)TEGRA_APB_MISC_BASE;
 	u32 chip, div;
 
-#if defined(CONFIG_TEGRA_DEBUG_UARTA)
+#if defined(CONFIG_TEGRA_DEBUG_UART_AUTO_ODMDATA)
+	uart_id = auto_odmdata();
+#elif defined(CONFIG_TEGRA_DEBUG_UARTA)
 	uart_id = 0;
 #elif defined(CONFIG_TEGRA_DEBUG_UARTB)
 	uart_id = 1;
@@ -193,19 +161,7 @@ static inline void arch_decomp_setup(void)
 	uart_id = 3;
 #elif defined(CONFIG_TEGRA_DEBUG_UARTE)
 	uart_id = 4;
-#else
-	uart_id = -1;
-#endif
-
-#if defined(CONFIG_TEGRA_DEBUG_UART_AUTO_ODMDATA)
-	auto_uart_id = auto_odmdata();
-#elif defined(CONFIG_TEGRA_DEBUG_UART_AUTO_SCRATCH)
-	auto_uart_id = auto_scratch();
-#else
-	auto_uart_id = -1;
 #endif
-	if (auto_uart_id != -1)
-		uart_id = auto_uart_id;
 
 	if (uart_id < 0 || uart_id >= ARRAY_SIZE(uarts) ||
 	    !uart_clocked(uart_id))
-- 
1.7.0.4
