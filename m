From: leilei.zhao@atmel.com (Leilei Zhao)
Date: Fri, 27 Feb 2015 16:07:17 +0800
Subject: [PATCH v2 4/5] tty/serial: at91: set ops in property init each time
In-Reply-To: <1425024438-31355-1-git-send-email-leilei.zhao@atmel.com>
References: <1425024438-31355-1-git-send-email-leilei.zhao@atmel.com>
Message-ID: <1425024438-31355-5-git-send-email-leilei.zhao@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The property in device tree will be reading each time when tty is opened,
so the ops of serial port should be set after that instead of setting once
in probe. Otherwise, the ops of serial port is inconsistent with the state
of serial work manner. For example, the atmel serial driver can't work when
switching to PIO mode due to DMA channel is not available.

Signed-off-by: Leilei Zhao <leilei.zhao@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/tty/serial/atmel_serial.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 2667656..777c196 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1759,6 +1759,7 @@ static int atmel_startup(struct uart_port *port)
 	 * Initialize DMA (if necessary)
 	 */
 	atmel_init_property(atmel_port, pdev);
+	atmel_set_ops(port);
 
 	if (atmel_port->prepare_rx) {
 		retval = atmel_port->prepare_rx(port);
-- 
1.7.9.5
