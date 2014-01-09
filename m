From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 9 Jan 2014 16:00:43 +0200
Subject: [PATCHv13 32/40] ARM: OMAP: hwmod: fix an incorrect clk type cast
 with _get_clkdm
In-Reply-To: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
Message-ID: <1389276051-1326-33-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the main clock for a hwmod is of basic clock type, it is illegal to type
cast this to clk_hw_omap and will result in bogus data. Fixed by checking
the clock flags before attempting the type cast.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 8a1b5e0..cc24c95 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -686,6 +686,8 @@ static struct clockdomain *_get_clkdm(struct omap_hwmod *oh)
 	if (oh->clkdm) {
 		return oh->clkdm;
 	} else if (oh->_clk) {
+		if (__clk_get_flags(oh->_clk) & CLK_IS_BASIC)
+			return NULL;
 		clk = to_clk_hw_omap(__clk_get_hw(oh->_clk));
 		return  clk->clkdm;
 	}
-- 
1.7.9.5
