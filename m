From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Fri,  7 Jun 2013 18:26:09 +0200
Subject: [RFC PATCH 28/50] ASoC: atmel-ssc: prepare clk before calling enable
In-Reply-To: <1370615115-16979-1-git-send-email-b.brezillon@overkiz.com>
References: <1370615115-16979-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1370622370-19614-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace clk_enable/disable with clk_prepare_enable/disable_unprepare to
avoid common clk framework warnings.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 drivers/misc/atmel-ssc.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index c09c28f..e619197 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -58,7 +58,7 @@ struct ssc_device *ssc_request(unsigned int ssc_num)
 	ssc->user++;
 	spin_unlock(&user_lock);
 
-	clk_enable(ssc->clk);
+	clk_prepare_enable(ssc->clk);
 
 	return ssc;
 }
@@ -69,7 +69,7 @@ void ssc_free(struct ssc_device *ssc)
 	spin_lock(&user_lock);
 	if (ssc->user) {
 		ssc->user--;
-		clk_disable(ssc->clk);
+		clk_disable_unprepare(ssc->clk);
 	} else {
 		dev_dbg(&ssc->pdev->dev, "device already free\n");
 	}
@@ -172,10 +172,10 @@ static int ssc_probe(struct platform_device *pdev)
 	}
 
 	/* disable all interrupts */
-	clk_enable(ssc->clk);
+	clk_prepare_enable(ssc->clk);
 	ssc_writel(ssc->regs, IDR, -1);
 	ssc_readl(ssc->regs, SR);
-	clk_disable(ssc->clk);
+	clk_disable_unprepare(ssc->clk);
 
 	ssc->irq = platform_get_irq(pdev, 0);
 	if (!ssc->irq) {
-- 
1.7.9.5
