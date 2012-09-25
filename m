From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 25 Sep 2012 12:32:45 +0300
Subject: [PATCHv5 10/10] ARM: OMAP4: clock data: flag hw controlled clocks as
 autoidle
In-Reply-To: <1348565565-14744-1-git-send-email-t-kristo@ti.com>
References: <1348565565-14744-1-git-send-email-t-kristo@ti.com>
Message-ID: <1348565565-14744-11-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes sure these clocks are ignored by the clkdm / pwrdm usecounting.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 95834d7..d2fb4e8 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3356,8 +3356,11 @@ int __init omap4xxx_clk_init(void)
 	 */
 
 	for (c = omap44xx_clks; c < omap44xx_clks + ARRAY_SIZE(omap44xx_clks);
-									  c++)
+									  c++) {
+		if (c->lk.clk->enable_bit == OMAP4430_MODULEMODE_HWCTRL)
+			c->lk.clk->autoidle = true;
 		clk_preinit(c->lk.clk);
+	}
 
 	for (c = omap44xx_clks; c < omap44xx_clks + ARRAY_SIZE(omap44xx_clks);
 									  c++)
-- 
1.7.4.1
