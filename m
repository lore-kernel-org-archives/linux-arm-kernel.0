From: frowand.list@gmail.com (Frank Rowand)
Date: Wed, 06 Aug 2014 17:16:51 -0700
Subject: [PATCH to be tested] serial: msm_serial: add missing sysrq handling
Message-ID: <53E2C573.7090709@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen,

Can you test this patch on v 1.3 hardware?  It works on my v 1.4.

If you use kdmx2, the way to send a break is '~B'.  The previous
key pressed must be <enter> for the '~' escape to be recognized.

Thanks!

-Frank



From: Frank Rowand <frank.rowand@sonymobile.com>

Add missing sysrq handling to msm_serial.

Signed-off-by: Frank Rowand <frank.rowand@sonymobile.com>

---
 drivers/tty/serial/msm_serial.c |   26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

Index: b/drivers/tty/serial/msm_serial.c
===================================================================
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -126,6 +126,8 @@ static void handle_rx_dm(struct uart_por
 
 	while (count > 0) {
 		unsigned int c;
+		unsigned char *cp;
+		int res;
 
 		sr = msm_read(port, UART_SR);
 		if ((sr & UART_SR_RX_READY) == 0) {
@@ -135,15 +137,29 @@ static void handle_rx_dm(struct uart_por
 		c = msm_read(port, UARTDM_RF);
 		if (sr & UART_SR_RX_BREAK) {
 			port->icount.brk++;
-			if (uart_handle_break(port))
+			if (uart_handle_break(port)) {
+				count -= 1;
 				continue;
+			}
 		} else if (sr & UART_SR_PAR_FRAME_ERR)
 			port->icount.frame++;
 
-		/* TODO: handle sysrq */
-		tty_insert_flip_string(tport, (char *)&c,
-				       (count > 4) ? 4 : count);
-		count -= 4;
+		spin_unlock(&port->lock);
+		res = uart_handle_sysrq_char(port, c);
+		spin_lock(&port->lock);
+
+		cp = (unsigned char *)&c;
+		if (res) {
+			count -= 1;
+			tty_insert_flip_string(tport, cp + 1,
+					       (count > 3) ? 3 : count);
+			count -= (count > 3) ? 3 : count;
+		} else {
+			tty_insert_flip_string(tport, cp,
+					       (count > 4) ? 4 : count);
+			count -= (count > 4) ? 4 : count;
+		}
+
 	}
 
 	spin_unlock(&port->lock);
