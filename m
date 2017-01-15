From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 15 Jan 2017 23:32:52 +0100
Subject: [PATCH 1/4] tty: serial: meson: allow baud-rates higher than 115200
In-Reply-To: <20170115223255.10350-1-martin.blumenstingl@googlemail.com>
References: <20170115223255.10350-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170115223255.10350-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vendor driver allows setting baud-rates higher than 115200 baud.
There is a check in the vendor driver which prevents using more than
115200 baud during startup, however it does not have such a check in
.set_termios.
Higher baud-rates are often used by the bluetooth modules embedded into
the SDIO wifi chips (Amlogic devices use brcmfmac based wifi chips quite
often, 2000000 baud seems to be a common value for the UART baud-rate in
Amlogic's "libbt").

I have tested this on a Meson GXL device with uart_A (to which the
bluetooth module is connected, where initialization times out with
115200 baud) and uart_AO (which I manually set to 2000000 baud  and then
connected with my USB UART adapter to that).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/tty/serial/meson_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 6aea0f4a9165..60f16795d16b 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -364,7 +364,7 @@ static void meson_uart_set_termios(struct uart_port *port,
 
 	writel(val, port->membase + AML_UART_CONTROL);
 
-	baud = uart_get_baud_rate(port, termios, old, 9600, 115200);
+	baud = uart_get_baud_rate(port, termios, old, 9600, 4000000);
 	meson_uart_change_speed(port, baud);
 
 	port->read_status_mask = AML_UART_TX_FIFO_WERR;
-- 
2.11.0
