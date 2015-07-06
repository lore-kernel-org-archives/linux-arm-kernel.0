From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Tue,  7 Jul 2015 00:54:45 +0530
Subject: [PATCH-v3 01/11] i2c: pxa: keep i2c irq ON in suspend
In-Reply-To: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1436210695-19159-2-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leilei Shang <shangll@marvell.com>

During suspend there may still be some i2c access happening, as the
interrupt is shared between multiple drivers.
And if we don't keep i2c irq ON, there may be i2c access timeout if
i2c is in irq mode of operation.

Signed-off-by: Raul Xiong <xjian@marvell.com>
Signed-off-by: Xiaofan Tian <tianxf@marvell.com>
[vaibhav.hiremath at linaro.org: updated Changelog]
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-pxa.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index d9c0d6a..f4ac8c5 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1232,8 +1232,9 @@ static int i2c_pxa_probe(struct platform_device *dev)
 		i2c->adap.algo = &i2c_pxa_pio_algorithm;
 	} else {
 		i2c->adap.algo = &i2c_pxa_algorithm;
-		ret = request_irq(irq, i2c_pxa_handler, IRQF_SHARED,
-				  dev_name(&dev->dev), i2c);
+		ret = request_irq(irq, i2c_pxa_handler,
+				IRQF_SHARED | IRQF_NO_SUSPEND,
+				dev_name(&dev->dev), i2c);
 		if (ret)
 			goto ereqirq;
 	}
-- 
1.9.1
