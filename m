From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon,  5 Dec 2016 03:47:53 +0200
Subject: [PATCH] Input: lpc32xx-keys - fix invalid error handling of a
 requested irq
Message-ID: <20161205014753.2092-1-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Semantics of NR_IRQS is different on machines with SPARSE_IRQ option
disabled or enabled, in the latter case IRQs are allocated starting
at least from the value specified by NR_IRQS and going upwards, so
the check of (irq >= NR_IRQ) to decide about an error code returned by
platform_get_irq() is completely invalid, don't attempt to overrule
irq subsystem in the driver.

The change fixes lpc32xx_keys driver initialization on boot:

  lpc32xx_keys 40050000.key: failed to get platform irq
  lpc32xx_keys: probe of 40050000.key failed with error -22

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/input/keyboard/lpc32xx-keys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/lpc32xx-keys.c b/drivers/input/keyboard/lpc32xx-keys.c
index 265d641..632523d 100644
--- a/drivers/input/keyboard/lpc32xx-keys.c
+++ b/drivers/input/keyboard/lpc32xx-keys.c
@@ -182,7 +182,7 @@ static int lpc32xx_kscan_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0 || irq >= NR_IRQS) {
+	if (irq < 0) {
 		dev_err(&pdev->dev, "failed to get platform irq\n");
 		return -EINVAL;
 	}
-- 
2.10.2
