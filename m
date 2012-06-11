From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 11 Jun 2012 16:24:56 +0100
Subject: [PATCH 03/14] mfd: ab8500-gpadc: Enable IRQF_ONESHOT when requesting
 a threaded IRQ
In-Reply-To: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1339428307-3850-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel now forces IRQs to be ONESHOT if no IRQ handler is passed.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ab8500-gpadc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/ab8500-gpadc.c b/drivers/mfd/ab8500-gpadc.c
index b86fd8e..b6cbc3ba 100644
--- a/drivers/mfd/ab8500-gpadc.c
+++ b/drivers/mfd/ab8500-gpadc.c
@@ -599,7 +599,8 @@ static int __devinit ab8500_gpadc_probe(struct platform_device *pdev)
 	/* Register interrupt  - SwAdcComplete */
 	ret = request_threaded_irq(gpadc->irq, NULL,
 		ab8500_bm_gpswadcconvend_handler,
-		IRQF_NO_SUSPEND | IRQF_SHARED, "ab8500-gpadc", gpadc);
+		IRQF_ONESHOT | IRQF_NO_SUSPEND | IRQF_SHARED,
+				"ab8500-gpadc", gpadc);
 	if (ret < 0) {
 		dev_err(gpadc->dev, "Failed to register interrupt, irq: %d\n",
 			gpadc->irq);
-- 
1.7.9.5
