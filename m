From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Apr 2012 15:45:29 +0200
Subject: [PATCH 16/40] dmaengine i.MX ipu: clk_prepare/unprepare clock
In-Reply-To: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1334065553-7565-17-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/dma/ipu/ipu_idmac.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ipu/ipu_idmac.c b/drivers/dma/ipu/ipu_idmac.c
index 62e3f8e..5ec7204 100644
--- a/drivers/dma/ipu/ipu_idmac.c
+++ b/drivers/dma/ipu/ipu_idmac.c
@@ -1715,7 +1715,7 @@ static int __init ipu_probe(struct platform_device *pdev)
 	}
 
 	/* Make sure IPU HSP clock is running */
-	clk_enable(ipu_data.ipu_clk);
+	clk_prepare_enable(ipu_data.ipu_clk);
 
 	/* Disable all interrupts */
 	idmac_write_ipureg(&ipu_data, 0, IPU_INT_CTRL_1);
@@ -1747,7 +1747,7 @@ static int __init ipu_probe(struct platform_device *pdev)
 err_idmac_init:
 err_attach_irq:
 	ipu_irq_detach_irq(&ipu_data, pdev);
-	clk_disable(ipu_data.ipu_clk);
+	clk_disable_unprepare(ipu_data.ipu_clk);
 	clk_put(ipu_data.ipu_clk);
 err_clk_get:
 	iounmap(ipu_data.reg_ic);
@@ -1765,7 +1765,7 @@ static int __exit ipu_remove(struct platform_device *pdev)
 
 	ipu_idmac_exit(ipu);
 	ipu_irq_detach_irq(ipu, pdev);
-	clk_disable(ipu->ipu_clk);
+	clk_disable_unprepare(ipu->ipu_clk);
 	clk_put(ipu->ipu_clk);
 	iounmap(ipu->reg_ic);
 	iounmap(ipu->reg_ipu);
-- 
1.7.9.5
