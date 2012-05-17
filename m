From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 17 May 2012 14:45:20 +0100
Subject: [PATCH 15/18] mfd: Prevent unassigned pointer from being used in
 ab8500-gpadc driver
In-Reply-To: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
References: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1337262323-27692-16-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before this patch if probe failed to find the platform IRQ it
would attempt to print a message out using dev_err, which in
turn was being passed an unassigned pointer. This patch
ensures the information passed to dev_err is correct.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ab8500-gpadc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ab8500-gpadc.c b/drivers/mfd/ab8500-gpadc.c
index c39fc71..c1656ab 100644
--- a/drivers/mfd/ab8500-gpadc.c
+++ b/drivers/mfd/ab8500-gpadc.c
@@ -584,7 +584,7 @@ static int __devinit ab8500_gpadc_probe(struct platform_device *pdev)
 
 	gpadc->irq = platform_get_irq_byname(pdev, "SW_CONV_END");
 	if (gpadc->irq < 0) {
-		dev_err(gpadc->dev, "failed to get platform irq-%d\n",
+		dev_err(&pdev->dev, "failed to get platform irq-%d\n",
 			gpadc->irq);
 		ret = gpadc->irq;
 		goto fail;
-- 
1.7.9.5
