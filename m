From: claudio@evidence.eu.com (Claudio Scordino)
Date: Mon, 31 May 2010 15:39:37 +0200
Subject: [PATCH] General fixes in the serial_rs485 structure
In-Reply-To: <20100531113429.5efd6de9@lxorguk.ukuu.org.uk>
References: <4BFE66CA.5050500@evidence.eu.com>	<20100529000839.158dedd3@lxorguk.ukuu.org.uk>	<4C0375C1.5030305@evidence.eu.com>
	<20100531113429.5efd6de9@lxorguk.ukuu.org.uk>
Message-ID: <4C03BC19.5060402@evidence.eu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

	this patch fixes two different issues:

- It adds the flag SER_RS485_RTS_BEFORE_SEND that somehow was missing from the serial_rs485 structure (even if "delay_rts_before_send" was existing)

- It adds a further "delay_rts_after_send" field for those drivers that can have a delay after send (e.g., atmel_serial)

Then, it fixes the usage of the structure in the atmel_serial driver (where "delay_rts_before_send" should be used instead of "delay_rts_after_send").

Best regards,

           Claudio


New fields in structure serial_rs485.

This patch fixes several issues related to the RS485 interface:

 - It adds the flag SER_RS485_RTS_BEFORE_SEND that was missing from the 
   serial_rs485 structure (even if "delay_rts_before_send" was existing)

 - It adds a further "delay_rts_after_send" field for those drivers that 
   can have a delay after send (e.g., atmel_serial)

 - It fixes the usage of the structure in the atmel_serial driver (where
   "delay_rts_before_send" should be used instead of "delay_rts_after_send").


Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
Signed-off-by: Bernhard Roth <br@pwrnet.de>
---
 drivers/serial/atmel_serial.c |    6 +++---
 include/linux/serial.h        |    4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/serial/atmel_serial.c b/drivers/serial/atmel_serial.c
index eed3c2d..1adb1bf 100644
--- a/drivers/serial/atmel_serial.c
+++ b/drivers/serial/atmel_serial.c
@@ -216,7 +216,7 @@ void atmel_config_rs485(struct uart_port *port, struct serial_rs485 *rs485conf)
 	if (rs485conf->flags & SER_RS485_ENABLED) {
 		dev_dbg(port->dev, "Setting UART to RS485\n");
 		atmel_port->tx_done_mask = ATMEL_US_TXEMPTY;
-		UART_PUT_TTGR(port, rs485conf->delay_rts_before_send);
+		UART_PUT_TTGR(port, rs485conf->delay_rts_after_send);
 		mode |= ATMEL_US_USMODE_RS485;
 	} else {
 		dev_dbg(port->dev, "Setting UART to RS232\n");
@@ -291,7 +291,7 @@ static void atmel_set_mctrl(struct uart_port *port, u_int mctrl)
 
 	if (atmel_port->rs485.flags & SER_RS485_ENABLED) {
 		dev_dbg(port->dev, "Setting UART to RS485\n");
-		UART_PUT_TTGR(port, atmel_port->rs485.delay_rts_before_send);
+		UART_PUT_TTGR(port, atmel_port->rs485.delay_rts_after_send);
 		mode |= ATMEL_US_USMODE_RS485;
 	} else {
 		dev_dbg(port->dev, "Setting UART to RS232\n");
@@ -1210,7 +1210,7 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	if (atmel_port->rs485.flags & SER_RS485_ENABLED) {
 		dev_dbg(port->dev, "Setting UART to RS485\n");
-		UART_PUT_TTGR(port, atmel_port->rs485.delay_rts_before_send);
+		UART_PUT_TTGR(port, atmel_port->rs485.delay_rts_after_send);
 		mode |= ATMEL_US_USMODE_RS485;
 	} else {
 		dev_dbg(port->dev, "Setting UART to RS232\n");
diff --git a/include/linux/serial.h b/include/linux/serial.h
index c8613c3..f9a0b67 100644
--- a/include/linux/serial.h
+++ b/include/linux/serial.h
@@ -210,8 +210,10 @@ struct serial_rs485 {
 #define SER_RS485_ENABLED		(1 << 0)
 #define SER_RS485_RTS_ON_SEND		(1 << 1)
 #define SER_RS485_RTS_AFTER_SEND	(1 << 2)
+#define SER_RS485_RTS_BEFORE_SEND	(1 << 3)
 	__u32	delay_rts_before_send;	/* Milliseconds */
-	__u32	padding[6];		/* Memory is cheap, new structs
+	__u32	delay_rts_after_send;	/* Milliseconds */
+	__u32	padding[5];		/* Memory is cheap, new structs
 					   are a royal PITA .. */
 };
 
-- 
1.6.0.4
