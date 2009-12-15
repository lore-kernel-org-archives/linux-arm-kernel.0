From: abhijitpagare@ti.com (Abhijit Pagare)
Date: Tue, 15 Dec 2009 19:01:12 +0530
Subject: [PATCH 1/1] ARM: OMAP3: PM: Fix the Invalid CM_CLKSTCTRL reg access.
Message-ID: <1260883872-22299-1-git-send-email-abhijitpagare@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In OMAP2/3 some of the clock-domains which did not have control
facility were being falsely written to and read using the CM_CLKSTCTRL
register though it did not exist for them. One check is added to remove
this flaw.

Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 1a45ed1..dd285f0 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -559,7 +559,7 @@ int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 	 * downstream clocks for debugging purposes?
 	 */
 
-	if (!clkdm || !clk)
+	if (!clkdm || !clk || !clkdm->clktrctrl_mask)
 		return -EINVAL;
 
 	if (atomic_inc_return(&clkdm->usecount) > 1)
@@ -610,7 +610,7 @@ int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
 	 * downstream clocks for debugging purposes?
 	 */
 
-	if (!clkdm || !clk)
+	if (!clkdm || !clk || !clkdm->clktrctrl_mask)
 		return -EINVAL;
 
 #ifdef DEBUG
-- 
1.5.4.7
