From: chao.xie@marvell.com (Chao Xie)
Date: Mon, 25 Mar 2013 03:06:53 -0400
Subject: [PATCH V2 2/6] usb: otg: mv_otg: remove unused clock
In-Reply-To: <1364195217-1226-1-git-send-email-chao.xie@marvell.com>
References: <1364195217-1226-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1364195217-1226-3-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The origianl understanding of clock is wrong. The OTG controller
only have one clock input.
Passing clock name by pdata is wrong. The clock is defined by device
iteself.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/usb/phy/phy-mv-usb.c |   28 +++++++---------------------
 drivers/usb/phy/phy-mv-usb.h |    3 +--
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/phy/phy-mv-usb.c b/drivers/usb/phy/phy-mv-usb.c
index 6872bf0..c987bbe 100644
--- a/drivers/usb/phy/phy-mv-usb.c
+++ b/drivers/usb/phy/phy-mv-usb.c
@@ -237,18 +237,12 @@ static void mv_otg_start_periphrals(struct mv_otg *mvotg, int on)
 
 static void otg_clock_enable(struct mv_otg *mvotg)
 {
-	unsigned int i;
-
-	for (i = 0; i < mvotg->clknum; i++)
-		clk_prepare_enable(mvotg->clk[i]);
+	clk_prepare_enable(mvotg->clk);
 }
 
 static void otg_clock_disable(struct mv_otg *mvotg)
 {
-	unsigned int i;
-
-	for (i = 0; i < mvotg->clknum; i++)
-		clk_disable_unprepare(mvotg->clk[i]);
+	clk_disable_unprepare(mvotg->clk);
 }
 
 static int mv_otg_enable_internal(struct mv_otg *mvotg)
@@ -684,16 +678,14 @@ static int mv_otg_probe(struct platform_device *pdev)
 	struct mv_otg *mvotg;
 	struct usb_otg *otg;
 	struct resource *r;
-	int retval = 0, clk_i, i;
-	size_t size;
+	int retval = 0, i;
 
 	if (pdata == NULL) {
 		dev_err(&pdev->dev, "failed to get platform data\n");
 		return -ENODEV;
 	}
 
-	size = sizeof(*mvotg) + sizeof(struct clk *) * pdata->clknum;
-	mvotg = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
+	mvotg = devm_kzalloc(&pdev->dev, sizeof(*mvotg), GFP_KERNEL);
 	if (!mvotg) {
 		dev_err(&pdev->dev, "failed to allocate memory!\n");
 		return -ENOMEM;
@@ -708,15 +700,9 @@ static int mv_otg_probe(struct platform_device *pdev)
 	mvotg->pdev = pdev;
 	mvotg->pdata = pdata;
 
-	mvotg->clknum = pdata->clknum;
-	for (clk_i = 0; clk_i < mvotg->clknum; clk_i++) {
-		mvotg->clk[clk_i] = devm_clk_get(&pdev->dev,
-						pdata->clkname[clk_i]);
-		if (IS_ERR(mvotg->clk[clk_i])) {
-			retval = PTR_ERR(mvotg->clk[clk_i]);
-			return retval;
-		}
-	}
+	mvotg->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(mvotg->clk))
+		return PTR_ERR(mvotg->clk);
 
 	mvotg->qwork = create_singlethread_workqueue("mv_otg_queue");
 	if (!mvotg->qwork) {
diff --git a/drivers/usb/phy/phy-mv-usb.h b/drivers/usb/phy/phy-mv-usb.h
index 8a9e351..551da6e 100644
--- a/drivers/usb/phy/phy-mv-usb.h
+++ b/drivers/usb/phy/phy-mv-usb.h
@@ -158,8 +158,7 @@ struct mv_otg {
 
 	unsigned int active;
 	unsigned int clock_gating;
-	unsigned int clknum;
-	struct clk *clk[0];
+	struct clk *clk;
 };
 
 #endif
-- 
1.7.4.1
