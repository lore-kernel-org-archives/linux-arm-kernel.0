From: cavokz@gmail.com (Domenico Andreoli)
Date: Thu, 5 Apr 2012 10:48:08 +0200
Subject: common clk: fix clk_register_fixed_rate() under memory pressure
Message-ID: <20120405084808.GA21060@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Domenico Andreoli <cavokz@gmail.com>

Under memory pressure clk_register_fixed_rate() fails to manage
allocation errors and prepares land for a later WARN_ON at best.

This fix leaves parent_names correctly initialized or NULL, intermediate
half initialized states are cleaned up and not propagated to the clock
framework.

Signed-off-by: Domenico Andreoli <cavokz@gmail.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Arnd Bergman <arnd.bergmann@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Andrew Lunn <andrew@lunn.ch>

---
 drivers/clk/clk-fixed-rate.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

Index: b/drivers/clk/clk-fixed-rate.c
===================================================================
--- a/drivers/clk/clk-fixed-rate.c
+++ b/drivers/clk/clk-fixed-rate.c
@@ -67,8 +67,11 @@ struct clk *clk_register_fixed_rate(stru
 
 		parent_names[0] = kmalloc(len, GFP_KERNEL);
 
-		if (!parent_names[0])
+		if (!parent_names[0]) {
+			kfree(parent_names);
+			parent_names = NULL;
 			goto out;
+		}
 
 		strncpy(parent_names[0], parent_name, len);
 	}
@@ -77,6 +80,6 @@ out:
 	return clk_register(dev, name,
 			&clk_fixed_rate_ops, &fixed->hw,
 			parent_names,
-			(parent_name ? 1 : 0),
+			(parent_names ? 1 : 0),
 			flags);
 }
