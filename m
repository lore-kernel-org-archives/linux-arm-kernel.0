From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 21 Mar 2012 20:01:19 +0000
Subject: [PATCH 1/4] clk: fixed-rate: Don't open code kstrdup()
Message-ID: <1332360082-25092-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Save a little code by using the library function.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/clk/clk-fixed-rate.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
index 90c79fb..cf84e41 100644
--- a/drivers/clk/clk-fixed-rate.c
+++ b/drivers/clk/clk-fixed-rate.c
@@ -45,7 +45,6 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
 {
 	struct clk_fixed_rate *fixed;
 	char **parent_names = NULL;
-	u8 len;
 
 	fixed = kzalloc(sizeof(struct clk_fixed_rate), GFP_KERNEL);
 
@@ -63,14 +62,10 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
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
1.7.9.1
