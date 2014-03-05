From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Wed, 5 Mar 2014 11:29:01 +0800
Subject: [PATCH] spi: atmel: add missing spi_master_{resume,
 suspend} calls to PM callbacks
Message-ID: <1393990141-3157-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PM callbacks implemented by the spi-atmel driver don't call
spi_master_{resume,suspend}, fix that.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
Hi Mark, 

The patch is based on the branch: for-next
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git

Best Regards,
Wenyou Yang

 drivers/spi/spi-atmel.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 47e7aeb..bda961e 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1440,6 +1440,14 @@ static int atmel_spi_suspend(struct device *dev)
 {
 	struct spi_master	*master = dev_get_drvdata(dev);
 	struct atmel_spi	*as = spi_master_get_devdata(master);
+	int ret;
+
+	/* Stop the queue running */
+	ret = spi_master_suspend(master);
+	if (ret) {
+		dev_warn(dev, "cannot suspend master\n");
+		return ret;
+	}
 
 	clk_disable_unprepare(as->clk);
 
@@ -1452,11 +1460,18 @@ static int atmel_spi_resume(struct device *dev)
 {
 	struct spi_master	*master = dev_get_drvdata(dev);
 	struct atmel_spi	*as = spi_master_get_devdata(master);
+	int ret;
 
 	pinctrl_pm_select_default_state(dev);
 
 	clk_prepare_enable(as->clk);
-	return 0;
+
+	/* Start the queue running */
+	ret = spi_master_resume(master);
+	if (ret)
+		dev_err(dev, "problem starting queue (%d)\n", ret);
+
+	return ret;
 }
 
 static SIMPLE_DEV_PM_OPS(atmel_spi_pm_ops, atmel_spi_suspend, atmel_spi_resume);
-- 
1.7.9.5
