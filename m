From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 22 Jun 2012 19:18:06 +0530
Subject: [PATCH 07/11] w1: omap_hdq: add clk_prepare and clk_unprepare
In-Reply-To: <1340372890-10091-1-git-send-email-rnayak@ti.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
Message-ID: <1340372890-10091-8-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
and clk_unprepare() for the hdq clocks.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Evgeniy Polyakov <zbr@ioremap.net>
---
 drivers/w1/masters/omap_hdq.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_hdq.c
index 5ef385b..1892daf 100644
--- a/drivers/w1/masters/omap_hdq.c
+++ b/drivers/w1/masters/omap_hdq.c
@@ -609,13 +609,13 @@ static int __devinit omap_hdq_probe(struct platform_device *pdev)
 	hdq_data->hdq_usecount = 0;
 	mutex_init(&hdq_data->hdq_mutex);
 
-	if (clk_enable(hdq_data->hdq_ick)) {
+	if (clk_prepare_enable(hdq_data->hdq_ick)) {
 		dev_dbg(&pdev->dev, "Can not enable ick\n");
 		ret = -ENODEV;
 		goto err_intfclk;
 	}
 
-	if (clk_enable(hdq_data->hdq_fck)) {
+	if (clk_prepare_enable(hdq_data->hdq_fck)) {
 		dev_dbg(&pdev->dev, "Can not enable fck\n");
 		ret = -ENODEV;
 		goto err_fnclk;
@@ -657,10 +657,10 @@ static int __devinit omap_hdq_probe(struct platform_device *pdev)
 
 err_w1:
 err_irq:
-	clk_disable(hdq_data->hdq_fck);
+	clk_disable_unprepare(hdq_data->hdq_fck);
 
 err_fnclk:
-	clk_disable(hdq_data->hdq_ick);
+	clk_disable_unprepare(hdq_data->hdq_ick);
 
 err_intfclk:
 	clk_put(hdq_data->hdq_fck);
-- 
1.7.1
