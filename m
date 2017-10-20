From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 20 Oct 2017 15:17:51 +0200
Subject: [PATCH] ARM: mvebu: Use common error handling code in
 mvebu_armada_pm_init()
Message-ID: <1c378b21-f10a-3a3a-fcee-8f0c0214a8fe@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 20 Oct 2017 14:50:47 +0200

Adjust jump targets so that a bit of exception handling can be better
reused at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-mvebu/pm-board.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-mvebu/pm-board.c b/arch/arm/mach-mvebu/pm-board.c
index db17121d7d63..bef248c76951 100644
--- a/arch/arm/mach-mvebu/pm-board.c
+++ b/arch/arm/mach-mvebu/pm-board.c
@@ -81,6 +81,7 @@ static int __init mvebu_armada_pm_init(void)
 	struct device_node *np;
 	struct device_node *gpio_ctrl_np;
 	int ret = 0, i;
+	char *name;
 
 	if (!of_machine_is_compatible("marvell,axp-gp"))
 		return -ENODEV;
@@ -90,41 +91,32 @@ static int __init mvebu_armada_pm_init(void)
 		return -ENODEV;
 
 	for (i = 0; i < ARMADA_PIC_NR_GPIOS; i++) {
-		char *name;
 		struct of_phandle_args args;
 
 		pic_gpios[i] = of_get_named_gpio(np, "ctrl-gpios", i);
 		if (pic_gpios[i] < 0) {
 			ret = -ENODEV;
-			goto out;
+			goto put_node;
 		}
 
 		name = kasprintf(GFP_KERNEL, "pic-pin%d", i);
 		if (!name) {
 			ret = -ENOMEM;
-			goto out;
+			goto put_node;
 		}
 
 		ret = gpio_request(pic_gpios[i], name);
-		if (ret < 0) {
-			kfree(name);
-			goto out;
-		}
+		if (ret < 0)
+			goto free_name;
 
 		ret = gpio_direction_output(pic_gpios[i], 0);
-		if (ret < 0) {
-			gpio_free(pic_gpios[i]);
-			kfree(name);
-			goto out;
-		}
+		if (ret < 0)
+			goto free_gpio;
 
 		ret = of_parse_phandle_with_fixed_args(np, "ctrl-gpios", 2,
 						       i, &args);
-		if (ret < 0) {
-			gpio_free(pic_gpios[i]);
-			kfree(name);
-			goto out;
-		}
+		if (ret < 0)
+			goto free_gpio;
 
 		gpio_ctrl_np = args.np;
 		pic_raw_gpios[i] = args.args[0];
@@ -135,10 +127,15 @@ static int __init mvebu_armada_pm_init(void)
 		return -ENOMEM;
 
 	mvebu_pm_suspend_init(mvebu_armada_pm_enter);
-
-out:
+put_node:
 	of_node_put(np);
 	return ret;
+
+free_gpio:
+	gpio_free(pic_gpios[i]);
+free_name:
+	kfree(name);
+	goto put_node;
 }
 
 /*
-- 
2.14.2
