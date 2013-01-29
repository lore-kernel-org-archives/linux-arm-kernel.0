From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Tue, 29 Jan 2013 16:46:14 +0100
Subject: [PATCH V3 3/5] W1: Convert MXC onewire master to devm_ functions.
In-Reply-To: <20130129154608.5184.46101.stgit@localhost>
References: <20130129154608.5184.46101.stgit@localhost>
Message-ID: <20130129154614.5184.4140.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While doing this fix missing clk_disable_unprepare in error path.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Evgeniy Polyakov <zbr@ioremap.net>
---
 drivers/w1/masters/mxc_w1.c |   26 ++++++--------------------
 1 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/w1/masters/mxc_w1.c b/drivers/w1/masters/mxc_w1.c
index 949e566..317b2bc 100644
--- a/drivers/w1/masters/mxc_w1.c
+++ b/drivers/w1/masters/mxc_w1.c
@@ -117,7 +117,7 @@ static int mxc_w1_probe(struct platform_device *pdev)
 	if (!mdev)
 		return -ENOMEM;
 
-	mdev->clk = clk_get(&pdev->dev, NULL);
+	mdev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(mdev->clk)) {
 		err = PTR_ERR(mdev->clk);
 		goto failed_clk;
@@ -125,17 +125,11 @@ static int mxc_w1_probe(struct platform_device *pdev)
 
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
+		goto failed_req;
 	}
 
 	clk_prepare_enable(mdev->clk);
@@ -154,11 +148,9 @@ static int mxc_w1_probe(struct platform_device *pdev)
 	return 0;
 
 failed_add:
-	iounmap(mdev->regs);
-failed_ioremap:
-	release_mem_region(res->start, resource_size(res));
+	clk_disable_unprepare(mdev->clk);
+
 failed_req:
-	clk_put(mdev->clk);
 failed_clk:
 	kfree(mdev);
 	return err;
@@ -170,16 +162,10 @@ failed_clk:
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
 
