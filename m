From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 Jun 2012 09:58:54 +0100
Subject: [PATCH 03/14] mfd: ab8500-gpadc: Enable IRQF_ONESHOT when
 requesting a threaded IRQ
In-Reply-To: <1339428307-3850-4-git-send-email-lee.jones@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-4-git-send-email-lee.jones@linaro.org>
Message-ID: <4FD704CE.5010300@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515 
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 22 May 2012 15:13:13 +0100
Subject: [PATCH 03/14] mfd: ab8500-gpadc: Enable IRQF_ONESHOT when requesting
 a threaded IRQ

The kernel now forces IRQs to be ONESHOT if no IRQ handler is passed.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: stable at vger.kernel.org
Acked-by: Linus Walleij <linus.walleij@linaro.org>
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
