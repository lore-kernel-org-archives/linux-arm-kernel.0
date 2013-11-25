From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 25 Nov 2013 15:36:42 -0700
Subject: [PATCH 2/3] ARM: tegra: don't hard-code DEBUG_LL baud rate
In-Reply-To: <1385419003-11348-1-git-send-email-swarren@wwwdotorg.org>
References: <1385419003-11348-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1385419003-11348-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Stop writing to the UART clock divider registers in the Tegra DEBUG_LL
code. This allows the DEBUG_LL output to use whatever baud rate was set
up by the bootloader. Some users are using higher rates than 115200.

This removes the only usage of tegra_uart_config[3], so reduce the size
allocated for that array.

Finally, fix busyuart() so that it only waits for THRE and not TEMT. For
some reason, TEMT doesn't get asserted (at least on Tegra30 Beaver) at
9600 baud, even though it does at 115200 baud. This sounds like a HW bug,
but I haven't investigated. For reference, U-Boot's serial code has
always only checked THRE, and not checked TEMT.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
Tested-by: Paul Walmsley <pwalmsley@nvidia.com>
---
 arch/arm/include/debug/tegra.S | 30 +++---------------------------
 arch/arm/mach-tegra/tegra.c    |  4 +---
 2 files changed, 4 insertions(+), 30 deletions(-)

diff --git a/arch/arm/include/debug/tegra.S b/arch/arm/include/debug/tegra.S
index a7b7cedef1a6..f98763f0bc17 100644
--- a/arch/arm/include/debug/tegra.S
+++ b/arch/arm/include/debug/tegra.S
@@ -156,28 +156,6 @@
 92:		and	\rv, \rp, #0xffffff	@ offset within 1MB section
 		add	\rv, \rv, #UART_VIRTUAL_BASE
 		str	\rv, [\tmp, #8]		@ Store in tegra_uart_virt
-		movw	\rv, #TEGRA_APB_MISC_GP_HIDREV & 0xffff
-		movt	\rv, #TEGRA_APB_MISC_GP_HIDREV >> 16
-		ldr	\rv, [\rv, #0]		@ Load HIDREV
-		ubfx	\rv, \rv, #8, #8	@ 15:8 are SoC version
-		cmp	\rv, #0x20		@ Tegra20?
-		moveq	\rv, #0x75		@ Tegra20 divisor
-		movne	\rv, #0xdd		@ Tegra30 divisor
-		str	\rv, [\tmp, #12]	@ Save divisor to scratch
-		/* uart[UART_LCR] = UART_LCR_WLEN8 | UART_LCR_DLAB; */
-		mov	\rv, #UART_LCR_WLEN8 | UART_LCR_DLAB
-		str	\rv, [\rp, #UART_LCR << UART_SHIFT]
-		/* uart[UART_DLL] = div & 0xff; */
-		ldr	\rv, [\tmp, #12]
-		and	\rv, \rv, #0xff
-		str	\rv, [\rp, #UART_DLL << UART_SHIFT]
-		/* uart[UART_DLM] = div >> 8; */
-		ldr	\rv, [\tmp, #12]
-		lsr	\rv, \rv, #8
-		str	\rv, [\rp, #UART_DLM << UART_SHIFT]
-		/* uart[UART_LCR] = UART_LCR_WLEN8; */
-		mov	\rv, #UART_LCR_WLEN8
-		str	\rv, [\rp, #UART_LCR << UART_SHIFT]
 		b	100f
 
 		.align
@@ -205,8 +183,8 @@
 		cmp	\rx, #0
 		beq	1002f
 1001:		ldrb	\rd, [\rx, #UART_LSR << UART_SHIFT]
-		and	\rd, \rd, #UART_LSR_TEMT | UART_LSR_THRE
-		teq	\rd, #UART_LSR_TEMT | UART_LSR_THRE
+		and	\rd, \rd, #UART_LSR_THRE
+		teq	\rd, #UART_LSR_THRE
 		bne	1001b
 1002:
 		.endm
@@ -225,7 +203,7 @@
 /*
  * Storage for the state maintained by the macros above.
  *
- * In the kernel proper, this data is located in arch/arm/mach-tegra/common.c.
+ * In the kernel proper, this data is located in arch/arm/mach-tegra/tegra.c.
  * That's because this header is included from multiple files, and we only
  * want a single copy of the data. In particular, the UART probing code above
  * assumes it's running using physical addresses. This is true when this file
@@ -247,6 +225,4 @@ tegra_uart_config:
 	.word 0
 	/* Debug UART virtual address */
 	.word 0
-	/* Scratch space for debug macro */
-	.word 0
 #endif
diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 73368176c6e8..ea14d380fc0c 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -60,15 +60,13 @@
  * kernel is loaded. The data is declared here rather than debug-macro.S so
  * that multiple inclusions of debug-macro.S point@the same data.
  */
-u32 tegra_uart_config[4] = {
+u32 tegra_uart_config[3] = {
 	/* Debug UART initialization required */
 	1,
 	/* Debug UART physical address */
 	0,
 	/* Debug UART virtual address */
 	0,
-	/* Scratch space for debug macro */
-	0,
 };
 
 static void __init tegra_init_cache(void)
-- 
1.8.1.5
