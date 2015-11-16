From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 16 Nov 2015 12:25:17 +0100
Subject: [PATCH] ARM: OMAP4: execute initcall to reserve SRAM for I688 only on
 OMAP4
Message-ID: <1447673117-32719-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

omap_interconnect_sync() is the only user of the SRAM scratch area
allocated in the omap4_sram_init initcall. The interconnect sync is
used exclusively in the OMAP4 specific WFI implementation, so there
is no point in allocating the SRAM scratch on other SoC types.

Bail out of the initcall if the kernel is not running on OMAP4 to
avoid a confusing warning about being unable to allocate the SRAM
needed for I688 handling.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Tested-by: Bastian Stender <bst@pengutronix.de>
---
 arch/arm/mach-omap2/omap4-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 949696b6f17b..6db393a30a28 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -131,6 +131,9 @@ static int __init omap4_sram_init(void)
 	struct device_node *np;
 	struct gen_pool *sram_pool;
 
+	if (!cpu_is_omap44xx())
+		return 0;
+
 	np = of_find_compatible_node(NULL, NULL, "ti,omap4-mpu");
 	if (!np)
 		pr_warn("%s:Unable to allocate sram needed to handle errata I688\n",
-- 
2.6.1
