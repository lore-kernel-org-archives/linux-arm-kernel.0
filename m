From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sun, 19 Nov 2017 09:56:32 +0530
Subject: [PATCH 1/3 v3] mfd: ipaq-micro: Fix platform_get_irq's error checking
Message-ID: <1bdd59d511e4acd23aea6af51d06b1cadf09a1b2.1511065331.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
              Add failure case '<= 0' instead of '< 0'. If IRQ0 is not valid.
changes in v3 :
              return -EINVAL insted of irq.

 drivers/mfd/ipaq-micro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ipaq-micro.c b/drivers/mfd/ipaq-micro.c
index cd762d0..176cf65 100644
--- a/drivers/mfd/ipaq-micro.c
+++ b/drivers/mfd/ipaq-micro.c
@@ -410,7 +410,7 @@ static int __init micro_probe(struct platform_device *pdev)
 	micro_reset_comm(micro);
 
 	irq = platform_get_irq(pdev, 0);
-	if (!irq)
+	if (irq <= 0)
 		return -EINVAL;
 	ret = devm_request_irq(&pdev->dev, irq, micro_serial_isr,
 			       IRQF_SHARED, "ipaq-micro",
-- 
2.7.4
