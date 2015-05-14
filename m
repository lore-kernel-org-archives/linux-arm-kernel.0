From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 May 2015 18:12:27 +0200
Subject: [PATCH 01/10] ARM: ux500: delete UART static map
Message-ID: <1431619947-14850-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Delete the static maps for the Ux500 UARTs and rely
on debug_ll_io_init() to do the trick.
commit f87b95dd2e4a8832b1d6034f15a5324db42608a0
"ARM: ux500: move debugmacro to debug includes"
defined the necessary addruart macro two years ago.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 537a7753afc1..391d329a7e88 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -43,12 +43,6 @@ static struct prcmu_pdata db8500_prcmu_pdata = {
 	.legacy_offset	= DB8500_PRCMU_LEGACY_OFFSET,
 };
 
-/* minimum static i/o mapping required to boot U8500 platforms */
-static struct map_desc u8500_uart_io_desc[] __initdata = {
-	__IO_DEV_DESC(U8500_UART0_BASE, SZ_4K),
-	__IO_DEV_DESC(U8500_UART2_BASE, SZ_4K),
-};
-
 /*  U8500 and U9540 common io_desc */
 static struct map_desc u8500_common_io_desc[] __initdata = {
 	/* SCU base also covers GIC CPU BASE and TWD with its 4K page */
@@ -73,11 +67,7 @@ static struct map_desc u9540_io_desc[] __initdata = {
 
 static void __init u8500_map_io(void)
 {
-	/*
-	 * Map the UARTs early so that the DEBUG_LL stuff continues to work.
-	 */
-	iotable_init(u8500_uart_io_desc, ARRAY_SIZE(u8500_uart_io_desc));
-
+	debug_ll_io_init();
 	ux500_map_io();
 
 	iotable_init(u8500_common_io_desc, ARRAY_SIZE(u8500_common_io_desc));
-- 
1.9.3
