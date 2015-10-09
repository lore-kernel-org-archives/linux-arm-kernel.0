From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri,  9 Oct 2015 10:39:26 +0100
Subject: [PATCH v2 3/4] i2c: s3c2410: enable RuntimePM before registering to
 the core
In-Reply-To: <1444383567-18113-1-git-send-email-wsa@the-dreams.de>
References: <1444383567-18113-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1444383567-18113-3-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

The core may register clients attached to this master which may use
funtionality from the master. So, RuntimePM must be enabled before, otherwise
this will fail. While here, move drvdata, too.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-s3c2410.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 50bfd8cef5f224..336e34e1ca597d 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -1243,19 +1243,21 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 	i2c->adap.nr = i2c->pdata->bus_num;
 	i2c->adap.dev.of_node = pdev->dev.of_node;
 
+	platform_set_drvdata(pdev, i2c);
+
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_enable(&i2c->adap.dev);
+
 	ret = i2c_add_numbered_adapter(&i2c->adap);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add bus to i2c core\n");
+		pm_runtime_disable(&i2c->adap.dev);
+		pm_runtime_disable(&pdev->dev);
 		s3c24xx_i2c_deregister_cpufreq(i2c);
 		clk_unprepare(i2c->clk);
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, i2c);
-
-	pm_runtime_enable(&pdev->dev);
-	pm_runtime_enable(&i2c->adap.dev);
-
 	dev_info(&pdev->dev, "%s: S3C I2C adapter\n", dev_name(&i2c->adap.dev));
 	return 0;
 }
-- 
2.1.4
