From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 9 Oct 2013 18:31:00 +0300
Subject: [PATCHv8 29/36] ARM: OMAP3: hwmod: initialize clkdm from clkdm_name
In-Reply-To: <1381332668-962-1-git-send-email-t-kristo@ti.com>
References: <1381332668-962-1-git-send-email-t-kristo@ti.com>
Message-ID: <1381332668-962-30-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT clocks are mostly missing clkdm info now, and this causes an issue with
counter32k which makes its slave idlemode wrong and prevents core idle.

Fixed by initializing the hwmod clkdm pointers for omap3 also which makes
sure the clkdm flag matching logic works properly.

This patch also changes the return value for _init_clkdm to 0 for
incorrect clkdm_name, as this a warning, not a fatal error.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 5f8f587..ae33fae 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1546,7 +1546,7 @@ static int _init_clkdm(struct omap_hwmod *oh)
 	if (!oh->clkdm) {
 		pr_warning("omap_hwmod: %s: could not associate to clkdm %s\n",
 			oh->name, oh->clkdm_name);
-		return -EINVAL;
+		return 0;
 	}
 
 	pr_debug("omap_hwmod: %s: associated to clkdm %s\n",
@@ -4117,6 +4117,7 @@ void __init omap_hwmod_init(void)
 		soc_ops.assert_hardreset = _omap2_assert_hardreset;
 		soc_ops.deassert_hardreset = _omap2_deassert_hardreset;
 		soc_ops.is_hardreset_asserted = _omap2_is_hardreset_asserted;
+		soc_ops.init_clkdm = _init_clkdm;
 	} else if (cpu_is_omap44xx() || soc_is_omap54xx() || soc_is_dra7xx()) {
 		soc_ops.enable_module = _omap4_enable_module;
 		soc_ops.disable_module = _omap4_disable_module;
-- 
1.7.9.5
