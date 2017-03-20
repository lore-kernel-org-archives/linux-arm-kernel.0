From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Mon, 20 Mar 2017 16:38:57 +0100
Subject: [PATCH] tty/serial: atmel: fix TX path in atmel_console_write()
Message-ID: <20170320153857.28933-1-nicolas.ferre@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A side effect of 89d8232411a8 ("tty/serial: atmel_serial: BUG: stop DMA
from transmitting in stop_tx") is that the console can be called with
TX path disabled. Then the system would hang trying to push charecters
out in atmel_console_putchar().

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Fixes: 89d8232411a8 ("tty/serial: atmel_serial: BUG: stop DMA from transmitting
in stop_tx")
Cc: stable <stable@vger.kernel.org>	#4.4+
Acked-by: Richard Genoud <richard.genoud@gmail.com>
---
Hi,

I resend this patch removing the "RFC" tag and adding the Acked-by: Richard.

Best regards,


 drivers/tty/serial/atmel_serial.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index d9c05e05d896..2a03ad99d219 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2486,6 +2486,9 @@ static void atmel_console_write(struct console *co, const char *s, u_int count)
 	pdc_tx = atmel_uart_readl(port, ATMEL_PDC_PTSR) & ATMEL_PDC_TXTEN;
 	atmel_uart_writel(port, ATMEL_PDC_PTCR, ATMEL_PDC_TXTDIS);
 
+	/* Make sure that tx path is actually able to send characters */
+	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN);
+
 	uart_console_write(port, s, count, atmel_console_putchar);
 
 	/*
-- 
2.9.0
