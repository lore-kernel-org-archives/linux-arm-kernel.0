From: johan@kernel.org (Johan Hovold)
Date: Sun, 24 Jul 2016 14:10:58 +0200
Subject: [PATCH 1/3] memory: omap-gpmc: allow probe of child nodes to fail
In-Reply-To: <1469362260-20066-1-git-send-email-johan@kernel.org>
References: <1469362260-20066-1-git-send-email-johan@kernel.org>
Message-ID: <1469362260-20066-2-git-send-email-johan@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent commit (inadvertently?) changed how failed probe of a gpmc
child node was handled. Instead of proceeding with setting up any other
children as before, a single error now aborts the whole process.

This change broke networking on some Overo boards due to probe failing
for an unrelated nand node. This second issue should obviously be
fixed, but let's restore the old behaviour of allowing child-node
probe to fail to avoid further similar breakage on other systems.

Fixes: d2d00862dfbb ("memory: omap-gpmc: Support general purpose input
for WAITPINs")

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/memory/omap-gpmc.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 15508df24e5d..73ec3200191e 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -2250,7 +2250,7 @@ static int gpmc_probe_dt(struct platform_device *pdev)
 	return 0;
 }
 
-static int gpmc_probe_dt_children(struct platform_device *pdev)
+static void gpmc_probe_dt_children(struct platform_device *pdev)
 {
 	int ret;
 	struct device_node *child;
@@ -2265,11 +2265,11 @@ static int gpmc_probe_dt_children(struct platform_device *pdev)
 		else
 			ret = gpmc_probe_generic_child(pdev, child);
 
-		if (ret)
-			return ret;
+		if (ret) {
+			dev_err(&pdev->dev, "failed to probe DT child '%s': %d\n",
+				child->name, ret);
+		}
 	}
-
-	return 0;
 }
 #else
 static int gpmc_probe_dt(struct platform_device *pdev)
@@ -2277,9 +2277,8 @@ static int gpmc_probe_dt(struct platform_device *pdev)
 	return 0;
 }
 
-static int gpmc_probe_dt_children(struct platform_device *pdev)
+static void gpmc_probe_dt_children(struct platform_device *pdev)
 {
-	return 0;
 }
 #endif
 
@@ -2372,16 +2371,10 @@ static int gpmc_probe(struct platform_device *pdev)
 		goto setup_irq_failed;
 	}
 
-	rc = gpmc_probe_dt_children(pdev);
-	if (rc < 0) {
-		dev_err(gpmc->dev, "failed to probe DT children\n");
-		goto dt_children_failed;
-	}
+	gpmc_probe_dt_children(pdev);
 
 	return 0;
 
-dt_children_failed:
-	gpmc_free_irq(gpmc);
 setup_irq_failed:
 	gpmc_gpio_exit(gpmc);
 gpio_init_failed:
-- 
2.7.3
