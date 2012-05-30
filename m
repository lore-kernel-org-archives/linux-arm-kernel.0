From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 30 May 2012 12:47:37 +0800
Subject: [PATCH 19/22] net/smsc911x: Repair broken failure paths
In-Reply-To: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1338353260-10097-20-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current failure paths attempt to free resources which we failed to request
and disable resources which we failed to enable ones. This leads to kernel
oops/panic. This patch does some simple re-ordering to prevent this from
happening.

Cc: netdev at vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/ethernet/smsc/smsc911x.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index dab9c6f..1466e5d 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -2390,11 +2390,11 @@ static int __devinit smsc911x_drv_probe(struct platform_device *pdev)
 
 	retval = smsc911x_request_resources(pdev);
 	if (retval)
-		goto out_return_resources;
+		goto out_request_resources_fail;
 
 	retval = smsc911x_enable_resources(pdev);
 	if (retval)
-		goto out_disable_resources;
+		goto out_enable_resources_fail;
 
 	if (pdata->ioaddr == NULL) {
 		SMSC_WARN(pdata, probe, "Error smsc911x base address invalid");
@@ -2501,8 +2501,9 @@ out_free_irq:
 	free_irq(dev->irq, dev);
 out_disable_resources:
 	(void)smsc911x_disable_resources(pdev);
-out_return_resources:
+out_enable_resources_fail:
 	smsc911x_free_resources(pdev);
+out_request_resources_fail:
 	platform_set_drvdata(pdev, NULL);
 	iounmap(pdata->ioaddr);
 	free_netdev(dev);
-- 
1.7.9.5
