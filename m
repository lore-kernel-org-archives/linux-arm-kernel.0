From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 27 Mar 2012 15:23:27 +0800
Subject: [PATCH 08/10] clk: fixed-rate: registration error handling fixup
In-Reply-To: <1332833009-4121-1-git-send-email-shawn.guo@linaro.org>
References: <1332833009-4121-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1332833009-4121-9-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clk_register_fixed_rate should not call clk_register on "out:"
path.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/clk/clk-fixed-rate.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
index 295f0d5..0d80827 100644
--- a/drivers/clk/clk-fixed-rate.c
+++ b/drivers/clk/clk-fixed-rate.c
@@ -43,6 +43,7 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
 		unsigned long fixed_rate)
 {
 	struct clk_fixed_rate *fixed;
+	struct clk *clk;
 	const char **parent_names = NULL;
 
 	fixed = kzalloc(sizeof(struct clk_fixed_rate), GFP_KERNEL);
@@ -56,21 +57,27 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
 	fixed->fixed_rate = fixed_rate;
 
 	if (parent_name) {
-		parent_names = kmalloc(sizeof(char *), GFP_KERNEL);
-
-		if (! parent_names)
+		parent_names = kzalloc(sizeof(char *), GFP_KERNEL);
+		if (!parent_names)
 			goto out;
 
 		parent_names[0] = kstrdup(parent_name, GFP_KERNEL);
-
 		if (!parent_names[0])
 			goto out;
 	}
 
-out:
-	return clk_register(dev, name,
+	clk = clk_register(dev, name,
 			&clk_fixed_rate_ops, &fixed->hw,
 			parent_names,
 			(parent_name ? 1 : 0),
 			flags);
+	if (clk)
+		return clk;
+
+out:
+	kfree(parent_names[0]);
+	kfree(parent_names);
+	kfree(fixed);
+
+	return NULL;
 }
-- 
1.7.5.4
