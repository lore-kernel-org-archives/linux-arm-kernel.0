From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:59 +0100
Subject: [PATCH 62/62] ARM: tegra: make debug_ll code build for ARMv6
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-63-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a combined ARMv6/v7 kernel, we cannot use the
movt/movw instructions to load an immediate, as they
are not valid on ARMv6.

This changes the file to use an indirect load instead,
as lots of other implementations do.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-tegra at vger.kernel.org
---
 arch/arm/include/debug/tegra.S | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/debug/tegra.S b/arch/arm/include/debug/tegra.S
index f98763f..3bc8059 100644
--- a/arch/arm/include/debug/tegra.S
+++ b/arch/arm/include/debug/tegra.S
@@ -53,8 +53,7 @@
 
 #define checkuart(rp, rv, lhu, bit, uart) \
 		/* Load address of CLK_RST register */ \
-		movw	rp, #TEGRA_CLK_RST_DEVICES_##lhu & 0xffff ; \
-		movt	rp, #TEGRA_CLK_RST_DEVICES_##lhu >> 16 ; \
+		ldr	rp, =TEGRA_CLK_RST_DEVICES_##lhu ; \
 		/* Load value from CLK_RST register */ \
 		ldr	rp, [rp, #0] ; \
 		/* Test UART's reset bit */ \
@@ -62,8 +61,7 @@
 		/* If set, can't use UART; jump to save no UART */ \
 		bne	90f ; \
 		/* Load address of CLK_OUT_ENB register */ \
-		movw	rp, #TEGRA_CLK_OUT_ENB_##lhu & 0xffff ; \
-		movt	rp, #TEGRA_CLK_OUT_ENB_##lhu >> 16 ; \
+		ldr	rp, =TEGRA_CLK_OUT_ENB_##lhu ; \
 		/* Load value from CLK_OUT_ENB register */ \
 		ldr	rp, [rp, #0] ; \
 		/* Test UART's clock enable bit */ \
@@ -71,8 +69,7 @@
 		/* If clear, can't use UART; jump to save no UART */ \
 		beq	90f ; \
 		/* Passed all tests, load address of UART registers */ \
-		movw	rp, #TEGRA_UART##uart##_BASE & 0xffff ; \
-		movt	rp, #TEGRA_UART##uart##_BASE >> 16 ; \
+		ldr	rp, =TEGRA_UART##uart##_BASE ; \
 		/* Jump to save UART address */ \
 		b 91f
 
@@ -90,15 +87,16 @@
 
 #ifdef CONFIG_TEGRA_DEBUG_UART_AUTO_ODMDATA
 		/* Check ODMDATA */
-10:		movw	\rp, #TEGRA_PMC_SCRATCH20 & 0xffff
-		movt	\rp, #TEGRA_PMC_SCRATCH20 >> 16
+10:		ldr	\rp, =TEGRA_PMC_SCRATCH20
 		ldr	\rp, [\rp, #0]		@ Load PMC_SCRATCH20
-		ubfx	\rv, \rp, #18, #2	@ 19:18 are console type
+		lsr	\rv, \rp, #18		@ 19:18 are console type
+		and	\rv, \rv, #3
 		cmp	\rv, #2			@ 2 and 3 mean DCC, UART
 		beq	11f			@ some boards swap the meaning
 		cmp	\rv, #3			@ so accept either
 		bne	90f
-11:		ubfx	\rv, \rp, #15, #3	@ 17:15 are UART ID
+11:		lsr	\rv, \rp, #15		@ 17:15 are UART ID
+		and	\rv, #7	
 		cmp	\rv, #0			@ UART 0?
 		beq	20f
 		cmp	\rv, #1			@ UART 1?
-- 
1.8.3.2
