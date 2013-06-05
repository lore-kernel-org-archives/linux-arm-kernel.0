From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 13:32:30 +0900
Subject: [PATCH 3/4] irqchip: renesas-irqc: Fix irqc_probe error handling
In-Reply-To: <1370406751-3852-1-git-send-email-horms+renesas@verge.net.au>
References: <1370406751-3852-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370406751-3852-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Axel Lin <axel.lin@ingics.com>

The code in goto err3 path is wrong because it will call fee_irq() with k == 0,
which means it does free_irq(p->irq[-1].requested_irq, &p->irq[-1]);

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/irqchip/irq-renesas-irqc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index 649cd69..3651f77 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -252,8 +252,8 @@ static int irqc_probe(struct platform_device *pdev)
 
 	return 0;
 err3:
-	for (; k >= 0; k--)
-		free_irq(p->irq[k - 1].requested_irq, &p->irq[k - 1]);
+	while (--k >= 0)
+		free_irq(p->irq[k].requested_irq, &p->irq[k]);
 
 	irq_domain_remove(p->irq_domain);
 err2:
-- 
1.8.2.1
