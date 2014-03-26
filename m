From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 26 Mar 2014 16:39:22 +0000
Subject: [PATCH 08/15] mtd: st_spi_fsm: Obtain and use EMI clock if provided
In-Reply-To: <1395851969-13520-1-git-send-email-lee.jones@linaro.org>
References: <1395851969-13520-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1395851969-13520-9-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ST's Common Clk Framework is now available. This patch ensures the FSM
makes use of it by obtaining and enabling the EMI clock if provided. If
system fails to provide the EMI clock FSM uses its original default
rate.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/devices/st_spi_fsm.c | 45 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index 9df59e7..2443757 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/clk.h>
 
 #include "serial_flash_cmds.h"
 
@@ -297,6 +298,7 @@ struct stfsm {
 	struct mtd_info		mtd;
 	struct mutex		lock;
 	struct flash_info       *info;
+	struct clk              *clk;
 
 	uint32_t                configuration;
 	uint32_t                fifo_dir_delay;
@@ -1941,8 +1943,13 @@ static void stfsm_set_freq(struct stfsm *fsm, uint32_t spi_freq)
 	uint32_t emi_freq;
 	uint32_t clk_div;
 
-	/* TODO: Make this dynamic */
-	emi_freq = STFSM_DEFAULT_EMI_FREQ;
+	if (!fsm->clk) {
+		dev_warn(fsm->dev,
+			 "No EMI clock available. Using default 100MHz.\n");
+
+		emi_freq = STFSM_DEFAULT_EMI_FREQ;
+	} else
+		emi_freq = clk_get_rate(fsm->clk);
 
 	/*
 	 * Calculate clk_div - values between 2 and 128
@@ -2092,6 +2099,15 @@ static int stfsm_probe(struct platform_device *pdev)
 		return PTR_ERR(fsm->base);
 	}
 
+	fsm->clk = devm_clk_get(&pdev->dev, "emi_clk");
+	if (IS_ERR(fsm->clk)) {
+		dev_warn(fsm->dev, "Couldn't find EMI clock.\n");
+		fsm->clk = NULL;
+	} else if (clk_prepare_enable(fsm->clk)) {
+		dev_warn(fsm->dev, "Failed to enable EMI clock.\n");
+		fsm->clk = NULL;
+	}
+
 	mutex_init(&fsm->lock);
 
 	ret = stfsm_init(fsm);
@@ -2156,6 +2172,30 @@ static int stfsm_remove(struct platform_device *pdev)
 	return mtd_device_unregister(&fsm->mtd);
 }
 
+#ifdef CONFIG_PM
+static int stfsmfsm_suspend(struct device *dev)
+{
+	struct stfsm *fsm = dev_get_drvdata(dev);
+
+	if (fsm->clk)
+		clk_disable_unprepare(fsm->clk);
+
+	return 0;
+}
+
+static int stfsmfsm_resume(struct device *dev)
+{
+	struct stfsm *fsm = dev_get_drvdata(dev);
+
+	if (fsm->clk)
+		clk_prepare_enable(fsm->clk);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(stfsm_pm_ops, stfsmfsm_suspend, stfsmfsm_resume);
+
 static struct of_device_id stfsm_match[] = {
 	{ .compatible = "st,spi-fsm", },
 	{},
@@ -2169,6 +2209,7 @@ static struct platform_driver stfsm_driver = {
 		.name	= "st-spi-fsm",
 		.owner	= THIS_MODULE,
 		.of_match_table = stfsm_match,
+		.pm     = &stfsm_pm_ops,
 	},
 };
 module_platform_driver(stfsm_driver);
-- 
1.8.3.2
