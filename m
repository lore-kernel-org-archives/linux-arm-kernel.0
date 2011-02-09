From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Wed, 09 Feb 2011 14:41:33 +0800
Subject: [RFC,
	PATCH 3/3] clk: add warnings for incorrect enable/prepare semantics
In-Reply-To: <1297233693.241680.897691111624.0.gpush@pororo>
Message-ID: <1297233693.243373.411051105619.3.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change adds warnings to check for:

 1) enabling a clock that hasn't been prepared; and

 2) unpreparing a clock that is still enabled

While the correctness can't be guaranteed, the warnings should cover
most situations, and won't indicate false positives.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 drivers/clk/clk.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index bbbdb0d..8c96623 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -29,6 +29,8 @@ EXPORT_SYMBOL_GPL(clk_prepare);
 
 void clk_unprepare(struct clk *clk)
 {
+	WARN_ON(clk->enable_count != 0);
+
 	mutex_lock(&clk->prepare_lock);
 
 	WARN_ON(clk->prepare_count == 0);
@@ -45,6 +47,8 @@ int clk_enable(struct clk *clk)
 	unsigned long flags;
 	int ret = 0;
 
+	WARN_ON(clk->prepare_count == 0);
+
 	spin_lock_irqsave(&clk->enable_lock, flags);
 	if (clk->enable_count == 0 && clk->ops->enable)
 		ret = clk->ops->enable(clk);
