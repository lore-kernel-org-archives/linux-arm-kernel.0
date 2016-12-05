From: david.wu@rock-chips.com (David Wu)
Date: Mon,  5 Dec 2016 16:02:59 +0800
Subject: [PATCH] i2c: rk3x: keep i2c irq ON in suspend
Message-ID: <1480924979-13450-1-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During suspend there may still be some i2c access happening.
And if we don't keep i2c irq ON, there may be i2c access timeout if
i2c is in irq mode of operation.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 drivers/i2c/busses/i2c-rk3x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index df22066..67af32a 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -1261,7 +1261,7 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, rk3x_i2c_irq,
-			       0, dev_name(&pdev->dev), i2c);
+			       IRQF_NO_SUSPEND, dev_name(&pdev->dev), i2c);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "cannot request IRQ\n");
 		return ret;
-- 
1.9.1
