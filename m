From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 17 Dec 2009 21:20:17 -0700
Subject: [PATCH 2/8] ARM: OMAP3: PM: Fix the Invalid CM_CLKSTCTRL reg access.
In-Reply-To: <20091218041912.27280.92152.stgit@localhost.localdomain>
References: <20091218041912.27280.92152.stgit@localhost.localdomain>
Message-ID: <20091218042015.27280.14688.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Abhijit Pagare <abhijitpagare@ti.com>

In OMAP2/3 some of the clock-domains which did not have control
facility were being falsely written to and read using the CM_CLKSTCTRL
register though it did not exist for them. One check is added to remove
this flaw.

Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
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
