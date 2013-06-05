From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:24:52 +0900
Subject: [PATCH 001/130] gpio-rcar: R-Car GPIO IRQ share interrupt
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

R-Car H1 or Gen2 GPIO interrupts are assigned per each GPIO domain,
but, Gen1 E1/M1 GPIO interrupts are shared for all GPIO domain.
gpio-rcar driver needs IRQF_SHARED flags for these.
This patch was tested on Bock-W board

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/gpio/gpio-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index b4ca450..0f3d647 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -333,7 +333,7 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 	}
 
 	if (devm_request_irq(&pdev->dev, irq->start,
-			     gpio_rcar_irq_handler, 0, name, p)) {
+			     gpio_rcar_irq_handler, IRQF_SHARED, name, p)) {
 		dev_err(&pdev->dev, "failed to request IRQ\n");
 		ret = -ENOENT;
 		goto err1;
-- 
1.8.2.1
