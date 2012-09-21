From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Fri, 21 Sep 2012 20:07:19 +0530
Subject: [PATCH v2] serial: omap: fix the reciever line error case
Message-ID: <1348238239-18510-1-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch does the following
- In case of errors if there least one data character in the RX FIFO
read it otherwise it may stall the receiver.

This is recommended in the interrupt reset method in the table 23-246 of
the omap4 TRM.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
- Tested on omap4sdp.
- pm tested hitting off in idle and suspend.
- v2 changes update the changelogs.
- Also remove the dummy check as FE , PE , BI and OE are the only
receiver errors.

 drivers/tty/serial/omap-serial.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index a0d4460..4fea16b 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -334,6 +334,10 @@ static unsigned int check_modem_status(struct uart_omap_port *up)
 static void serial_omap_rlsi(struct uart_omap_port *up, unsigned int lsr)
 {
 	unsigned int flag;
+	unsigned char ch = 0;
+
+	if (likely(lsr & UART_LSR_DR))
+		ch = serial_in(up, UART_RX);
 
 	up->port.icount.rx++;
 	flag = TTY_NORMAL;
-- 
1.7.5.4
