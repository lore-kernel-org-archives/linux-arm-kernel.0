From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri,  4 Dec 2015 18:03:40 +0100
Subject: [PATCH v3 05/13] clk: at91: only disable available IRQs
In-Reply-To: <1449248628-3486-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1449248628-3486-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1449248628-3486-6-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris Brezillon <boris.brezillon@free-electrons.com>

Only disable available IRQs in case writing to a reserved bit has a harmful
effect.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clk/at91/pmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 296d20a29c6c..2f8b9503176f 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -296,7 +296,7 @@ static int __init atmel_pmc_probe(struct platform_device *pdev)
 	if (!pmc->irqdomain)
 		return 0;
 
-	regmap_write(pmc->regmap, AT91_PMC_IDR, 0xffffffff);
+	regmap_write(pmc->regmap, AT91_PMC_IDR, pmc->caps->available_irqs);
 	ret = request_irq(pmc->virq, pmc_irq_handler,
 			  IRQF_SHARED | IRQF_COND_SUSPEND, "pmc", pmc);
 	if (ret)
-- 
2.5.0
