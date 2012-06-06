From: rnayak@ti.com (Rajendra Nayak)
Date: Wed, 6 Jun 2012 14:41:30 +0530
Subject: [PATCH 1/2] clk: cache parent clocks only for muxes
In-Reply-To: <1338973891-28719-1-git-send-email-rnayak@ti.com>
References: <1338973891-28719-1-git-send-email-rnayak@ti.com>
Message-ID: <1338973891-28719-2-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

caching parent clocks makes sense only when a clock has more
than one parent (mux clocks).
Avoid doing this for every other clock.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 drivers/clk/clk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 687b00d..40568e9 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1229,7 +1229,7 @@ int __clk_init(struct device *dev, struct clk *clk)
 	 * If clk->parents is not NULL we skip this entire block.  This allows
 	 * for clock drivers to statically initialize clk->parents.
 	 */
-	if (clk->num_parents && !clk->parents) {
+	if ((clk->num_parents > 1) && !clk->parents) {
 		clk->parents = kmalloc((sizeof(struct clk*) * clk->num_parents),
 				GFP_KERNEL);
 		/*
-- 
1.7.1
