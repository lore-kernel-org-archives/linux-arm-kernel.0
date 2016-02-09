From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Tue,  9 Feb 2016 11:47:16 +0000
Subject: [PATCH] serial: bcm2835: fix unsigned int issue with irq
Message-ID: <1455018437-2405-1-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Fixes error condition check when requesting the irq,
that would not trigger because of uart_port.irq being
defined as unsigned int.

Reported by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/tty/serial/8250/8250_bcm2835aux.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index ecf89f1..e10f124 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -59,12 +59,12 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 	}
 
 	/* get the interrupt */
-	data->uart.port.irq = platform_get_irq(pdev, 0);
-	if (data->uart.port.irq < 0) {
-		dev_err(&pdev->dev, "irq not found - %i",
-			data->uart.port.irq);
-		return data->uart.port.irq;
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "irq not found - %i", ret);
+		return ret;
 	}
+	data->uart.port.irq = ret;
 
 	/* map the main registers */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.7.10.4
