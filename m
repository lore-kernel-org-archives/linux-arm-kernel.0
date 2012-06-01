From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 1 Jun 2012 17:37:59 +0530
Subject: [RFC 18/24] ARM: omap: hwmod: Cleanup !CONFIG_COMMON_CLK parts
In-Reply-To: <1338552485-31325-1-git-send-email-rnayak@ti.com>
References: <1338552485-31325-1-git-send-email-rnayak@ti.com>
Message-ID: <1338552485-31325-19-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clean all #ifdef's added as part of fixing the clkdm
accesses from hwmod.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index e153298..0085353 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -130,11 +130,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/io.h>
-#ifdef CONFIG_COMMON_CLK
 #include <linux/clk-provider.h>
-#else
-#include <linux/clk.h>
-#endif
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/list.h>
@@ -507,12 +503,8 @@ struct clockdomain *_get_clkdm(struct omap_hwmod *oh)
 	if (oh->clkdm) {
 		return oh->clkdm;
 	} else if (oh->_clk) {
-#ifdef CONFIG_COMMON_CLK
 		clk = to_clk_hw_omap(__clk_get_hw(oh->_clk));
 		return  clk->clkdm;
-#else
-		return oh->_clk->clkdm;
-#endif
 	}
 
 	pr_err("%s: %s does not have .clkdm\n", __func__, oh->name);
@@ -2404,9 +2396,7 @@ struct powerdomain *omap_hwmod_get_pwrdm(struct omap_hwmod *oh)
 {
 	struct clk *c;
 	struct clockdomain *clkdm;
-#ifdef CONFIG_COMMON_CLK
 	struct clk_hw_omap *clk;
-#endif
 
 	if (!oh)
 		return NULL;
@@ -2422,12 +2412,8 @@ struct powerdomain *omap_hwmod_get_pwrdm(struct omap_hwmod *oh)
 		c = oh->slaves[oh->_mpu_port_index]->_clk;
 	}
 
-#ifdef CONFIG_COMMON_CLK
 	clk = to_clk_hw_omap(__clk_get_hw(c));
 	clkdm = clk->clkdm;
-#else
-	clkdm = c->clkdm;
-#endif
 	if (!clkdm)
 		return NULL;
 
-- 
1.7.1
