From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 23 Apr 2015 10:51:04 +0200
Subject: [PATCH 2/4] tty: serial: 8250_mtk: remove unnecessary test
In-Reply-To: <1429779066-21406-1-git-send-email-s.hauer@pengutronix.de>
References: <1429779066-21406-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1429779066-21406-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the driver has probed successfully the clk pointer is always valid,
so no need to test for it.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/tty/serial/8250/8250_mtk.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index c6901dc..bcfaa8dc 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -212,9 +212,7 @@ static int mtk8250_remove(struct platform_device *pdev)
 	pm_runtime_get_sync(&pdev->dev);
 
 	serial8250_unregister_port(data->line);
-	if (!IS_ERR(data->uart_clk)) {
-		clk_disable_unprepare(data->uart_clk);
-	}
+	clk_disable_unprepare(data->uart_clk);
 
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
@@ -246,8 +244,7 @@ static int mtk8250_runtime_suspend(struct device *dev)
 {
 	struct mtk8250_data *data = dev_get_drvdata(dev);
 
-	if (!IS_ERR(data->uart_clk))
-		clk_disable_unprepare(data->uart_clk);
+	clk_disable_unprepare(data->uart_clk);
 
 	return 0;
 }
@@ -256,8 +253,7 @@ static int mtk8250_runtime_resume(struct device *dev)
 {
 	struct mtk8250_data *data = dev_get_drvdata(dev);
 
-	if (!IS_ERR(data->uart_clk))
-		clk_prepare_enable(data->uart_clk);
+	clk_prepare_enable(data->uart_clk);
 
 	return 0;
 }
-- 
2.1.4
