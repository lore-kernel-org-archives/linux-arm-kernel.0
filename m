From: yao.yuan@freescale.com (Yuan Yao)
Date: Wed, 21 Jan 2015 16:32:10 +0800
Subject: [PATCH] serial: fsl-lpuart: disable interrupt when suspend
Message-ID: <1421829130-32985-1-git-send-email-yao.yuan@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For power management support, we should disable TX/RX
interrupts so that kernel can prepare for deep sleep.

Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
---
 drivers/tty/serial/fsl_lpuart.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 1c5d020..bfd6ea2 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1449,6 +1449,21 @@ static int lpuart_remove(struct platform_device *pdev)
 static int lpuart_suspend(struct device *dev)
 {
 	struct lpuart_port *sport = dev_get_drvdata(dev);
+	unsigned long temp;
+
+	if (sport->lpuart32) {
+		/* disable Rx/Tx and interrupts */
+		temp = lpuart32_read(sport->port.membase + UARTCTRL);
+		temp &= ~(UARTCTRL_TE | UARTCTRL_RE |
+				UARTCTRL_TIE | UARTCTRL_TCIE | UARTCTRL_RIE);
+		lpuart32_write(temp, sport->port.membase + UARTCTRL);
+	} else {
+		/* disable Rx/Tx and interrupts */
+		temp = readb(sport->port.membase + UARTCR2);
+		temp &= ~(UARTCR2_TE | UARTCR2_RE |
+				UARTCR2_TIE | UARTCR2_TCIE | UARTCR2_RIE);
+		writeb(temp, sport->port.membase + UARTCR2);
+	}
 
 	uart_suspend_port(&lpuart_reg, &sport->port);
 
-- 
2.1.0.27.g96db324
