From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 12 Dec 2013 15:22:49 +0530
Subject: [PATCH] ARM: DRA7: hwmod: Fix boot crash with DEBUG_LL
Message-ID: <1386841969-765-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With commit '7dedd34: ARM: OMAP2+: hwmod: Fix a crash in _setup_reset() with
 DEBUG_LL' we moved from parsing cmdline to identify uart used for earlycon
to using the requsite hwmod CONFIG_DEBUG_OMAPxUARTy FLAGS.

On DRA7 though, we seem to be missing this flag, and atleast on the DRA7 EVM
where we use uart1 for console, boot fails with DEBUG_LL enabled.

Reported-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index db32d53..18f333c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1637,7 +1637,7 @@ static struct omap_hwmod dra7xx_uart1_hwmod = {
 	.class		= &dra7xx_uart_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.main_clk	= "uart1_gfclk_mux",
-	.flags		= HWMOD_SWSUP_SIDLE_ACT,
+	.flags		= HWMOD_SWSUP_SIDLE_ACT | DEBUG_OMAP2UART1_FLAGS,
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L4PER_UART1_CLKCTRL_OFFSET,
-- 
1.7.9.5
