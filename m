From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 3 Jun 2013 09:36:56 +0000 (UTC)
Subject: [PATCH v2 1/1] ARM : omap3 : fix wrong container_of in clock36xx.c
In-Reply-To: <1369903827-2025-1-git-send-email-jp.francois@cynove.com>
References: <1369903827-2025-1-git-send-email-jp.francois@cynove.com>
Message-ID: <alpine.DEB.2.02.1306030932520.4435@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 May 2013, Jean-Philippe Francois wrote:

> omap36xx_pwrdn_clk_enable_with_hsdiv_restore expects the parent hw of the clock
> to be a clk_hw_omap. However, looking at cclock3xxx_data.c, all concerned clock
> have parent defined as clk_divider. Instead of using container_of to eventually get
> to the register and directly mess with the divider, change freq via clk_set_rate, 
> and let the clock framework toggle the divider value.
> Tested with  3.9 on dm3730.
> 
> Signed-off-by: Jean-Philippe Fran??ois <jp.francois@cynove.com>

Queued for 3.10-rc fixes with Mike's ack, after fixing the checkpatch.pl 
errors listed below.  Please don't forget to run scripts/checkpatch.pl on 
future patches -- Documentation/SubmittingPatches has more info about 
this.


ERROR: space required before the open parenthesis '('
#59: FILE: arch/arm/mach-omap2/clock36xx.c:52:
+		if(ret)

ERROR: space required before the open parenthesis '('
#62: FILE: arch/arm/mach-omap2/clock36xx.c:55:
+		if(ret)

WARNING: please, no spaces at the start of a line
#67: FILE: arch/arm/mach-omap2/clock36xx.c:60:
+ badfreq :$

ERROR: space prohibited before that ':' (ctx:WxE)
#67: FILE: arch/arm/mach-omap2/clock36xx.c:60:
+ badfreq :
          ^

Updated patch follows.


- Paul

From: Jean-Philippe Francois <jp.francois@cynove.com>
Date: Thu, 30 May 2013 10:50:27 +0200
Subject: [PATCH] ARM: omap3: clock: fix wrong container_of in clock36xx.c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

omap36xx_pwrdn_clk_enable_with_hsdiv_restore expects the parent hw of
the clock to be a clk_hw_omap. However, looking at cclock3xxx_data.c,
all concerned clock have parent defined as clk_divider. Instead of
using container_of to eventually get to the register and directly mess
with the divider, change freq via clk_set_rate, and let the clock
framework toggle the divider value.
Tested with 3.9 on dm3730.

Signed-off-by: Jean-Philippe Fran?ois <jp.francois@cynove.com>
Acked-by: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock36xx.c |   29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/clock36xx.c b/arch/arm/mach-omap2/clock36xx.c
index 8f3bf4e..7f69fbb 100644
--- a/arch/arm/mach-omap2/clock36xx.c
+++ b/arch/arm/mach-omap2/clock36xx.c
@@ -39,30 +39,25 @@
  */
 int omap36xx_pwrdn_clk_enable_with_hsdiv_restore(struct clk_hw *clk)
 {
-	struct clk_hw_omap *parent;
-	struct clk_hw *parent_hw;
-	u32 dummy_v, orig_v, clksel_shift;
 	int ret;
 
 	/* Clear PWRDN bit of HSDIVIDER */
 	ret = omap2_dflt_clk_enable(clk);
 
-	parent_hw = __clk_get_hw(__clk_get_parent(clk->clk));
-	parent = to_clk_hw_omap(parent_hw);
-
-	/* Restore the dividers */
+	/* kick parent's clksel register after toggling PWRDN bit */
 	if (!ret) {
-		clksel_shift = __ffs(parent->clksel_mask);
-		orig_v = __raw_readl(parent->clksel_reg);
-		dummy_v = orig_v;
-
-		/* Write any other value different from the Read value */
-		dummy_v ^= (1 << clksel_shift);
-		__raw_writel(dummy_v, parent->clksel_reg);
-
-		/* Write the original divider */
-		__raw_writel(orig_v, parent->clksel_reg);
+		struct clk *parent = clk_get_parent(clk->clk);
+		unsigned long parent_rate = clk_get_rate(parent);
+		ret = clk_set_rate(parent, parent_rate/2);
+		if (ret)
+			goto badfreq;
+		ret = clk_set_rate(parent, parent_rate);
+		if (ret)
+			goto badfreq;
 	}
+	return ret;
 
+badfreq:
+	omap2_dflt_clk_disable(clk);
 	return ret;
 }
-- 
1.7.10.4
