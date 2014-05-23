From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 23 May 2014 12:30:41 +0200
Subject: [PATCH 01/71] clocksource: sh_cmt: Use request_irq() instead of
 setup_irq()
In-Reply-To: <537F214C.8000700@linaro.org>
References: <537F214C.8000700@linaro.org>
Message-ID: <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The driver claims it needs to register an interrupt handler too early
for request_irq(). This might have been true in the past, but the only
meaningful difference between request_irq() and setup_irq() today is an
additional kzalloc() call in request_irq(). As the driver calls
kmalloc() itself we know that the slab allocator is available, we can
thus switch to request_irq().

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_cmt.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 0b1836a..a3103b8 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -728,12 +728,6 @@ static int sh_cmt_setup(struct sh_cmt_priv *p, struct platform_device *pdev)
 		goto err1;
 	}
 
-	/* request irq using setup_irq() (too early for request_irq()) */
-	p->irqaction.name = dev_name(&p->pdev->dev);
-	p->irqaction.handler = sh_cmt_interrupt;
-	p->irqaction.dev_id = p;
-	p->irqaction.flags = IRQF_TIMER | IRQF_IRQPOLL | IRQF_NOBALANCING;
-
 	/* get hold of clock */
 	p->clk = clk_get(&p->pdev->dev, "cmt_fck");
 	if (IS_ERR(p->clk)) {
@@ -786,7 +780,9 @@ static int sh_cmt_setup(struct sh_cmt_priv *p, struct platform_device *pdev)
 	}
 	p->cs_enabled = false;
 
-	ret = setup_irq(irq, &p->irqaction);
+	ret = request_irq(irq, sh_cmt_interrupt,
+			  IRQF_TIMER | IRQF_IRQPOLL | IRQF_NOBALANCING,
+			  dev_name(&p->pdev->dev), p);
 	if (ret) {
 		dev_err(&p->pdev->dev, "failed to request irq %d\n", irq);
 		goto err4;
-- 
1.7.9.5
