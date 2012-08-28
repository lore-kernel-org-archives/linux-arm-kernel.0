From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 28 Aug 2012 15:03:14 +0800
Subject: [PATCH v2 08/11] USB: chipidea: convert to use devm_request_irq
In-Reply-To: <1346137397-32374-1-git-send-email-richard.zhao@freescale.com>
References: <1346137397-32374-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1346137397-32374-9-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 drivers/usb/chipidea/core.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 8fd390a..7485c84 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -481,8 +481,8 @@ static int __devinit ci_hdrc_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, ci);
-	ret = request_irq(ci->irq, ci_irq, IRQF_SHARED, ci->platdata->name,
-			  ci);
+	ret = devm_request_irq(dev, ci->irq, ci_irq, IRQF_SHARED,
+				ci->platdata->name, ci);
 	if (ret)
 		goto stop;
 
@@ -513,7 +513,6 @@ static int __devexit ci_hdrc_remove(struct platform_device *pdev)
 	flush_workqueue(ci->wq);
 	destroy_workqueue(ci->wq);
 	device_remove_file(ci->dev, &dev_attr_role);
-	free_irq(ci->irq, ci);
 	ci_role_stop(ci);
 
 	return 0;
-- 
1.7.9.5
