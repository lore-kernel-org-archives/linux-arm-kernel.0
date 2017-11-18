From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 18 Nov 2017 14:20:47 +0530
Subject: [PATCH 1/3 v2] mfd: ipaq-micro: Fix platform_get_irq's error checking
Message-ID: <4f12b680d2f0d7554e6a1812f15037185a5a9a2a.1510994294.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
              Add failure case '<= 0' instead of '< 0'. If IRQ0 is not valid.

 drivers/mfd/ipaq-micro.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/ipaq-micro.c b/drivers/mfd/ipaq-micro.c
index cd762d0..ea729db 100644
--- a/drivers/mfd/ipaq-micro.c
+++ b/drivers/mfd/ipaq-micro.c
@@ -410,8 +410,8 @@ static int __init micro_probe(struct platform_device *pdev)
 	micro_reset_comm(micro);
 
 	irq = platform_get_irq(pdev, 0);
-	if (!irq)
-		return -EINVAL;
+	if (irq <= 0)
+		return irq;
 	ret = devm_request_irq(&pdev->dev, irq, micro_serial_isr,
 			       IRQF_SHARED, "ipaq-micro",
 			       micro);
-- 
2.7.4
