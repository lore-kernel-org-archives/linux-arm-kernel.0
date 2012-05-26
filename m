From: stigge@antcom.de (Roland Stigge)
Date: Sat, 26 May 2012 18:11:18 +0200
Subject: [PATCH RFC] serial/8250: Adjusting FIFO parameters for LPC32xx
Message-ID: <1338048678-23991-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this is how the modified FIFO is handled in the repositories at
git.lpclinux.com. Is there a better way for doing this (without ifdef)?  Looks
like registering additional types (like PORT_16550A) isn't encouraged.  Maybe
extending of_serial.c? The latter currently doesn't handle .fifosize and
.tx_loadsz, though.

Any suggestions appreciated.

Thanks in advance,

Roland
 
---
 drivers/tty/serial/8250/8250.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- linux-2.6.orig/drivers/tty/serial/8250/8250.c
+++ linux-2.6/drivers/tty/serial/8250/8250.c
@@ -158,9 +158,16 @@ static const struct serial8250_config ua
 	},
 	[PORT_16550A] = {
 		.name		= "16550A",
+#ifdef CONFIG_ARCH_LPC32XX
+		.fifo_size	= 64,
+		.tx_loadsz	= 32,
+		.fcr		= UART_FCR_DMA_SELECT | UART_FCR_ENABLE_FIFO |
+				  UART_FCR_R_TRIG_00 | UART_FCR_T_TRIG_00,
+#else
 		.fifo_size	= 16,
 		.tx_loadsz	= 16,
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
+#endif
 		.flags		= UART_CAP_FIFO,
 	},
 	[PORT_CIRRUS] = {
