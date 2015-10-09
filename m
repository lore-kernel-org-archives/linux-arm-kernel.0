From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri,  9 Oct 2015 07:54:52 +0100
Subject: [PATCH 3/4] i2c: s3c2410: enable RuntimePM before registering to the
 core
In-Reply-To: <1444373693-2372-1-git-send-email-wsa@the-dreams.de>
References: <1444373693-2372-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1444373693-2372-3-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

The core may register clients attached to this master which may use
funtionality from the master. So, RuntimePM must be enabled before, otherwise
this will fail. While here, move drvdata, too.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Not tested on HW. Found by code review.

 drivers/i2c/busses/i2c-s3c2410.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 50bfd8cef5f224..75f76cd644728a 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -1243,6 +1243,11 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
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
@@ -1251,11 +1256,6 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
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
