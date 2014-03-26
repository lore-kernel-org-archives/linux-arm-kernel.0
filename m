From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Mar 2014 16:06:35 -0700
Subject: [PATCH 1/3] clk: Don't check for missing ops in clk_set_parent()
In-Reply-To: <1395875197-16816-1-git-send-email-sboyd@codeaurora.org>
References: <1395875197-16816-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1395875197-16816-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We dereference clk->ops during clock registration so this check
for NULL ops can't possibly ever be true.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/clk.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index fb3c40b4fbe2..10e0afaefe2f 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1712,9 +1712,6 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	if (!clk)
 		return 0;
 
-	if (!clk->ops)
-		return -EINVAL;
-
 	/* verify ops for for multi-parent clks */
 	if ((clk->num_parents > 1) && (!clk->ops->set_parent))
 		return -ENOSYS;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
