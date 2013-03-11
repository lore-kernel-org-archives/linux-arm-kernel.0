From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 11 Mar 2013 20:18:15 -0300
Subject: [PATCH 1/2] w1: mxc_w1: Convert to devm_ioremap_resource()
Message-ID: <1363043896-16140-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

According to Documentation/driver-model/devres.txt:

  devm_request_and_ioremap() : obsoleted by devm_ioremap_resource()

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/w1/masters/mxc_w1.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/w1/masters/mxc_w1.c b/drivers/w1/masters/mxc_w1.c
index 950d354..47e12cf 100644
--- a/drivers/w1/masters/mxc_w1.c
+++ b/drivers/w1/masters/mxc_w1.c
@@ -121,9 +121,9 @@ static int mxc_w1_probe(struct platform_device *pdev)
 	mdev->clkdiv = (clk_get_rate(mdev->clk) / 1000000) - 1;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mdev->regs = devm_request_and_ioremap(&pdev->dev, res);
-	if (!mdev->regs)
-		return -EBUSY;
+	mdev->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(mdev->regs))
+		return PTR_ERR(mdev->regs);
 
 	clk_prepare_enable(mdev->clk);
 	__raw_writeb(mdev->clkdiv, mdev->regs + MXC_W1_TIME_DIVIDER);
-- 
1.7.9.5
