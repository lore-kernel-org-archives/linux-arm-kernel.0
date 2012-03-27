From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 27 Mar 2012 15:23:25 +0800
Subject: [PATCH 06/10] clk: fixed-rate: Don't open code kstrdup()
In-Reply-To: <1332833009-4121-1-git-send-email-shawn.guo@linaro.org>
References: <1332833009-4121-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1332833009-4121-7-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@opensource.wolfsonmicro.com>

Save a little code by using the library function.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/clk/clk-fixed-rate.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
index d268439..1f87a03 100644
--- a/drivers/clk/clk-fixed-rate.c
+++ b/drivers/clk/clk-fixed-rate.c
@@ -44,7 +44,6 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
 {
 	struct clk_fixed_rate *fixed;
 	char **parent_names = NULL;
-	u8 len;
 
 	fixed = kzalloc(sizeof(struct clk_fixed_rate), GFP_KERNEL);
 
@@ -62,14 +61,10 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
 		if (! parent_names)
 			goto out;
 
-		len = sizeof(char) * strlen(parent_name);
-
-		parent_names[0] = kmalloc(len, GFP_KERNEL);
+		parent_names[0] = kstrdup(parent_name, GFP_KERNEL);
 
 		if (!parent_names[0])
 			goto out;
-
-		strncpy(parent_names[0], parent_name, len);
 	}
 
 out:
-- 
1.7.5.4
