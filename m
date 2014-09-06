From: gael.portay@gmail.com (=?UTF-8?q?Ga=C3=ABl=20PORTAY?=)
Date: Sat,  6 Sep 2014 19:52:34 +0200
Subject: [PATCHv4 1/4] ARM: at91/tclib: prefer using of devm_* functions
In-Reply-To: <1410025957-5952-1-git-send-email-gael.portay@gmail.com>
References: <1410025957-5952-1-git-send-email-gael.portay@gmail.com>
Message-ID: <1410025957-5952-2-git-send-email-gael.portay@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ga?l PORTAY <gael.portay@gmail.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/misc/atmel_tclib.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/atmel_tclib.c b/drivers/misc/atmel_tclib.c
index c8d8e38..b514a2d 100644
--- a/drivers/misc/atmel_tclib.c
+++ b/drivers/misc/atmel_tclib.c
@@ -150,17 +150,15 @@ static int __init tc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return -EINVAL;
 
-	tc = kzalloc(sizeof(struct atmel_tc), GFP_KERNEL);
+	tc = devm_kzalloc(&pdev->dev, sizeof(struct atmel_tc), GFP_KERNEL);
 	if (!tc)
 		return -ENOMEM;
 
 	tc->pdev = pdev;
 
-	clk = clk_get(&pdev->dev, "t0_clk");
-	if (IS_ERR(clk)) {
-		kfree(tc);
-		return -EINVAL;
-	}
+	clk = devm_clk_get(&pdev->dev, "t0_clk");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 
 	/* Now take SoC information if available */
 	if (pdev->dev.of_node) {
@@ -171,10 +169,10 @@ static int __init tc_probe(struct platform_device *pdev)
 	}
 
 	tc->clk[0] = clk;
-	tc->clk[1] = clk_get(&pdev->dev, "t1_clk");
+	tc->clk[1] = devm_clk_get(&pdev->dev, "t1_clk");
 	if (IS_ERR(tc->clk[1]))
 		tc->clk[1] = clk;
-	tc->clk[2] = clk_get(&pdev->dev, "t2_clk");
+	tc->clk[2] = devm_clk_get(&pdev->dev, "t2_clk");
 	if (IS_ERR(tc->clk[2]))
 		tc->clk[2] = clk;
 
-- 
1.9.3
