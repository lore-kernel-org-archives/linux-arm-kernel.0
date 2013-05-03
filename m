From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 3 May 2013 12:15:37 +0100
Subject: [PATCH 2/4 v2] mfd: ab8500-gpadc: Suppress 'ignoring
 regulator_enable() return value' warning
In-Reply-To: <1367509690-24022-3-git-send-email-lee.jones@linaro.org>
References: <1367509690-24022-1-git-send-email-lee.jones@linaro.org>
 <1367509690-24022-3-git-send-email-lee.jones@linaro.org>
Message-ID: <20130503111537.GH24153@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/mfd/ab8500-gpadc.c: In function ?ab8500_gpadc_resume?:
drivers/mfd/ab8500-gpadc.c:911:18: warning: ignoring return value of
        ?regulator_enable?, declared with attribute warn_unused_result
        [-Wunused-result]

Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>

diff --git a/drivers/mfd/ab8500-gpadc.c b/drivers/mfd/ab8500-gpadc.c
index 5e65b28..13f7866 100644
--- a/drivers/mfd/ab8500-gpadc.c
+++ b/drivers/mfd/ab8500-gpadc.c
@@ -907,14 +907,17 @@ static int ab8500_gpadc_suspend(struct device *dev)
 static int ab8500_gpadc_resume(struct device *dev)
 {
 	struct ab8500_gpadc *gpadc = dev_get_drvdata(dev);
+	int ret;
 
-	regulator_enable(gpadc->regu);
+	ret = regulator_enable(gpadc->regu);
+	if (ret)
+		dev_err(dev, "Failed to enable vtvout LDO: %d\n", ret);
 
 	pm_runtime_mark_last_busy(gpadc->dev);
 	pm_runtime_put_autosuspend(gpadc->dev);
 
 	mutex_unlock(&gpadc->ab8500_gpadc_lock);
-	return 0;
+	return ret;
 }
 
 static int ab8500_gpadc_probe(struct platform_device *pdev)
