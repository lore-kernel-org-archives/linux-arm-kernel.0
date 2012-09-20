From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Thu, 20 Sep 2012 17:20:47 +0200
Subject: [PATCH] i2c-nomadik: Fixup clock handling
Message-ID: <1348154447-3815-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philippe Begnic <philippe.begnic@stericsson.com>

Make sure to clk_prepare as well as clk_enable.

Signed-off-by: Philippe Begnic <philippe.begnic@stericsson.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/i2c/busses/i2c-nomadik.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 1b898b6..3eeae52 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -642,7 +642,11 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 
 	pm_runtime_get_sync(&dev->adev->dev);
 
-	clk_enable(dev->clk);
+	status = clk_prepare_enable(dev->clk);
+	if (status) {
+		dev_err(&dev->adev->dev, "can't prepare_enable clock\n");
+		goto out_clk;
+	}
 
 	status = init_hw(dev);
 	if (status)
@@ -669,7 +673,8 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 	}
 
 out:
-	clk_disable(dev->clk);
+	clk_disable_unprepare(dev->clk);
+out_clk:
 	pm_runtime_put_sync(&dev->adev->dev);
 
 	dev->busy = false;
-- 
1.7.10
