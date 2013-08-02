From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 2 Aug 2013 19:25:42 +0300
Subject: [PATCHv5 23/31] ARM: OMAP: hwmod: fix an incorrect clk type cast with
 _get_clkdm
In-Reply-To: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
References: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
Message-ID: <1375460751-23676-24-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the main clock for a hwmod is of basic clock type, it is illegal to type
cast this to clk_hw_omap and will result in bogus data. Fixed by checking
the clock flags before attempting the type cast.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 5cc5123..a6a59bd 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -656,6 +656,8 @@ static struct clockdomain *_get_clkdm(struct omap_hwmod *oh)
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
