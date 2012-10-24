From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 24 Oct 2012 15:49:20 +0200
Subject: [PATCH 1/2] arm: mvebu: increase atomic coherent pool size for armada
 370/XP
In-Reply-To: <1351086561-13569-1-git-send-email-gregory.clement@free-electrons.com>
References: <1351086561-13569-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1351086561-13569-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For Armada 370/XP we have the same problem that for the commit
cb01b63, so we applied the same solution: "The default 256 KiB
coherent pool may be too small for some of the Kirkwood devices, so
increase it to make sure that devices will be able to allocate their
buffers with GFP_ATOMIC flag"

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-mvebu/armada-370-xp.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index 2af6ce5..cbad821 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -17,6 +17,7 @@
 #include <linux/of_platform.h>
 #include <linux/io.h>
 #include <linux/time-armada-370-xp.h>
+#include <linux/dma-mapping.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
@@ -43,6 +44,16 @@ void __init armada_370_xp_timer_and_clk_init(void)
 	armada_370_xp_timer_init();
 }
 
+void __init armada_370_xp_init_early(void)
+{
+	/*
+	 * Some Armada 370/XP devices allocate their coherent buffers
+	 * from atomic context. Increase size of atomic coherent pool
+	 * to make sure such the allocations won't fail.
+	 */
+	init_dma_coherent_pool_size(SZ_1M);
+}
+
 struct sys_timer armada_370_xp_timer = {
 	.init		= armada_370_xp_timer_and_clk_init,
 };
@@ -61,6 +72,7 @@ static const char * const armada_370_xp_dt_board_dt_compat[] = {
 DT_MACHINE_START(ARMADA_XP_DT, "Marvell Aramada 370/XP (Device Tree)")
 	.init_machine	= armada_370_xp_dt_init,
 	.map_io		= armada_370_xp_map_io,
+	.init_early	= armada_370_xp_init_early,
 	.init_irq	= armada_370_xp_init_irq,
 	.handle_irq     = armada_370_xp_handle_irq,
 	.timer		= &armada_370_xp_timer,
-- 
1.7.9.5
