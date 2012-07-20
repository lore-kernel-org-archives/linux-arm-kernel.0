From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 20 Jul 2012 16:36:37 +0300
Subject: [PATCH] clk: fix return value check in clk_get
Message-ID: <1342791397-11732-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_clk_get_by_name returns an ERR_PTR on failure. Hence we should use IS_ERR()
and not just check for a non NULL value.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/clk/clkdev.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 8f87b0f..d423c9b 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -157,7 +157,7 @@ struct clk *clk_get(struct device *dev, const char *con_id)
 
 	if (dev) {
 		clk = of_clk_get_by_name(dev->of_node, con_id);
-		if (clk && __clk_get(clk))
+		if (!IS_ERR(clk) && __clk_get(clk))
 			return clk;
 	}
 
-- 
1.7.7.rc0.72.g4b5ea.dirty
