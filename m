From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Wed, 16 Jan 2013 10:48:31 +0100
Subject: [PATCH 5/5] W1: Convert MXC onewire master to devm_ functions.
In-Reply-To: <20130116094821.9660.18278.stgit@localhost>
References: <20130116094821.9660.18278.stgit@localhost>
Message-ID: <20130116094831.9660.15981.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 drivers/w1/masters/mxc_w1.c |   35 ++++++++---------------------------
 1 files changed, 8 insertions(+), 27 deletions(-)

diff --git a/drivers/w1/masters/mxc_w1.c b/drivers/w1/masters/mxc_w1.c
index 7454938..5b0c700 100644
--- a/drivers/w1/masters/mxc_w1.c
+++ b/drivers/w1/masters/mxc_w1.c
@@ -123,28 +123,22 @@ static int mxc_w1_probe(struct platform_device *pdev)
 	if (IS_ERR(pinctrl)) {
 		err = PTR_ERR(pinctrl);
 		dev_err(&pdev->dev, "failed to get default pinctrl: %d\n", err);
-		goto failed_pin;
+		goto failed;
 	}
 
-	mdev->clk = clk_get(&pdev->dev, NULL);
+	mdev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(mdev->clk)) {
 		err = PTR_ERR(mdev->clk);
-		goto failed_clk;
+		goto failed;
 	}
 
 	mdev->clkdiv = (clk_get_rate(mdev->clk) / 1000000) - 1;
 
-	res = request_mem_region(res->start, resource_size(res),
-				"mxc_w1");
-	if (!res) {
-		err = -EBUSY;
-		goto failed_req;
-	}
-
-	mdev->regs = ioremap(res->start, resource_size(res));
+	mdev->regs = devm_request_and_ioremap(&pdev->dev, res);
 	if (!mdev->regs) {
 		dev_err(&pdev->dev, "Cannot map mxc_w1 registers\n");
-		goto failed_ioremap;
+		err = -ENXIO;
+		goto failed;
 	}
 
 	clk_prepare_enable(mdev->clk);
@@ -157,19 +151,12 @@ static int mxc_w1_probe(struct platform_device *pdev)
 	err = w1_add_master_device(&mdev->bus_master);
 
 	if (err)
-		goto failed_add;
+		goto failed;
 
 	platform_set_drvdata(pdev, mdev);
 	return 0;
 
-failed_add:
-	iounmap(mdev->regs);
-failed_ioremap:
-	release_mem_region(res->start, resource_size(res));
-failed_req:
-	clk_put(mdev->clk);
-failed_pin:
-failed_clk:
+failed:
 	kfree(mdev);
 	return err;
 }
@@ -180,16 +167,10 @@ failed_clk:
 static int mxc_w1_remove(struct platform_device *pdev)
 {
 	struct mxc_w1_device *mdev = platform_get_drvdata(pdev);
-	struct resource *res;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
 	w1_remove_master_device(&mdev->bus_master);
 
-	iounmap(mdev->regs);
-	release_mem_region(res->start, resource_size(res));
 	clk_disable_unprepare(mdev->clk);
-	clk_put(mdev->clk);
 
 	platform_set_drvdata(pdev, NULL);
 
