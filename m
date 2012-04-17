From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 17 Apr 2012 11:43:56 +0100
Subject: [PATCH 04/16] drivers/net: Do not free an IRQ if its request failed
In-Reply-To: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
References: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1334659448-11521-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Refrain from attempting to free an interrupt line if the request
fails and hence, there is no IRQ to free.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/ethernet/smsc/smsc911x.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index 4a69710..f17a76e 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -2382,7 +2382,6 @@ static int __devinit smsc911x_drv_probe(struct platform_device *pdev)
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
 	pdata = netdev_priv(dev);
-
 	dev->irq = irq_res->start;
 	irq_flags = irq_res->flags & IRQF_TRIGGER_MASK;
 	pdata->ioaddr = ioremap_nocache(res->start, res_size);
@@ -2446,7 +2445,7 @@ static int __devinit smsc911x_drv_probe(struct platform_device *pdev)
 	if (retval) {
 		SMSC_WARN(pdata, probe,
 			  "Unable to claim requested irq: %d", dev->irq);
-		goto out_free_irq;
+		goto out_disable_resources;
 	}
 
 	retval = register_netdev(dev);
-- 
1.7.9.1
