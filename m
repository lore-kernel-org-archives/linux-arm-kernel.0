From: davidb@codeaurora.org (David Brown)
Date: Wed,  2 Nov 2011 11:36:05 -0700
Subject: [RFC PATCH 08/34] msm: clock: Enable/disable parent clocks generically
In-Reply-To: <1320258991-22325-1-git-send-email-davidb@codeaurora.org>
References: <1320258991-22325-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1320258991-22325-9-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Boyd <sboyd@codeaurora.org>

Enable the parent clocks whenever a clock is enabled and disable
a parent clock whenever a clock is disabled. This simplifies
sub-driver code by centralizing the parent enabling in the
top-level.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: David Brown <davidb@codeaurora.org>
---
 arch/arm/mach-msm/clock.c |   33 +++++++++++++++++++++++++++++----
 1 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-msm/clock.c b/arch/arm/mach-msm/clock.c
index 8508c17..026bdc0 100644
--- a/arch/arm/mach-msm/clock.c
+++ b/arch/arm/mach-msm/clock.c
@@ -31,24 +31,49 @@
  */
 int clk_enable(struct clk *clk)
 {
+	int ret = 0;
 	unsigned long flags;
+	struct clk *parent;
+
+	if (!clk)
+		return 0;
+
 	spin_lock_irqsave(&clk->lock, flags);
+	if (clk->count == 0) {
+		parent = clk_get_parent(clk);
+		ret = clk_enable(parent);
+		if (ret)
+			goto out;
+
+		ret = clk->ops->enable(clk);
+		if (ret) {
+			clk_disable(parent);
+			goto out;
+		}
+	}
 	clk->count++;
-	if (clk->count == 1)
-		clk->ops->enable(clk);
+out:
 	spin_unlock_irqrestore(&clk->lock, flags);
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL(clk_enable);
 
 void clk_disable(struct clk *clk)
 {
 	unsigned long flags;
+	struct clk *parent;
+
+	if (!clk)
+		return;
+
 	spin_lock_irqsave(&clk->lock, flags);
 	BUG_ON(clk->count == 0);
 	clk->count--;
-	if (clk->count == 0)
+	if (clk->count == 0) {
 		clk->ops->disable(clk);
+		parent = clk_get_parent(clk);
+		clk_disable(parent);
+	}
 	spin_unlock_irqrestore(&clk->lock, flags);
 }
 EXPORT_SYMBOL(clk_disable);
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
