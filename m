From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 4 Mar 2014 14:48:13 +0200
Subject: [PATCH v3 5/5] drivers: bus: omap_l3: Change pr_crit() to dev_err()
 when IRQ request fails
In-Reply-To: <1393937293-6036-1-git-send-email-peter.ujfalusi@ti.com>
References: <1393937293-6036-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1393937293-6036-6-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use dev_err() which will going to print the driver's name as well and the
KERN_ERR level is sufficient in this case (we also print via dev_err when
there is an error with the mem resources)

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/bus/omap_l3_noc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
index 0eff48585ae3..972691a668a3 100644
--- a/drivers/bus/omap_l3_noc.c
+++ b/drivers/bus/omap_l3_noc.c
@@ -158,8 +158,8 @@ static int omap4_l3_probe(struct platform_device *pdev)
 	ret = devm_request_irq(&pdev->dev, l3->debug_irq, l3_interrupt_handler,
 			       IRQF_DISABLED, "l3-dbg-irq", l3);
 	if (ret) {
-		pr_crit("L3: request_irq failed to register for 0x%x\n",
-						l3->debug_irq);
+		dev_err(&pdev->dev, "request_irq failed for %d\n",
+			l3->debug_irq);
 		return ret;
 	}
 
@@ -167,8 +167,7 @@ static int omap4_l3_probe(struct platform_device *pdev)
 	ret = devm_request_irq(&pdev->dev, l3->app_irq, l3_interrupt_handler,
 			       IRQF_DISABLED, "l3-app-irq", l3);
 	if (ret)
-		pr_crit("L3: request_irq failed to register for 0x%x\n",
-						l3->app_irq);
+		dev_err(&pdev->dev, "request_irq failed for %d\n", l3->app_irq);
 
 	return ret;
 }
-- 
1.9.0
