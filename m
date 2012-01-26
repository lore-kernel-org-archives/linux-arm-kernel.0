From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 25 Jan 2012 19:50:36 -0700
Subject: [PATCH v2 1/3] tty: serial: OMAP: use a 1-byte RX FIFO threshold in
 PIO mode
In-Reply-To: <20120126024903.31613.24730.stgit@dusk>
References: <20120126024903.31613.24730.stgit@dusk>
Message-ID: <20120126025032.31613.95905.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the (default) PIO mode, use a one-byte RX FIFO threshold.  The OMAP
UART IP blocks do not appear to be capable of waking the system under
an RX timeout condition.  Since the previous RX FIFO threshold was 16
bytes, this meant that omap-serial.c did not become aware of any
received data until all those bytes arrived or until another UART
interrupt occurred.  This made the serial console and presumably other
serial applications (GPS, serial Bluetooth) unusable or extremely
slow.  A 1-byte RX FIFO threshold also allows the MPU to enter a
low-power consumption state while waiting for the FIFO to fill.

This can be verified using the serial console by comparing the
behavior when "0123456789abcde" is pasted in from another window, with
the behavior when "0123456789abcdef" is pasted in.  Since the former
string is less than sixteen bytes long, the string is not echoed for
some time, while the latter string is echoed immediately.

DMA operation is unaffected by this patch.

Thanks to Russell King - ARM Linux <linux@arm.linux.org.uk> for some
additional information on the standard behavior of the RX timeout
event, which was used to improve this commit description.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Govindraj Raja <govindraj.r@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
---
 drivers/tty/serial/omap-serial.c |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index d192dcb..c9c9ba2 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -46,6 +46,13 @@
 
 #define DEFAULT_CLK_SPEED 48000000 /* 48Mhz*/
 
+/* SCR register bitmasks */
+#define OMAP_UART_SCR_RX_TRIG_GRANU1_MASK		(1 << 7)
+
+/* FCR register bitmasks */
+#define OMAP_UART_FCR_RX_FIFO_TRIG_SHIFT		6
+#define OMAP_UART_FCR_RX_FIFO_TRIG_MASK			(0x3 << 6)
+
 static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
 
 /* Forward declaration of functions */
@@ -811,14 +818,21 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	up->mcr = serial_in(up, UART_MCR);
 	serial_out(up, UART_MCR, up->mcr | UART_MCR_TCRTLR);
 	/* FIFO ENABLE, DMA MODE */
-	serial_out(up, UART_FCR, up->fcr);
-	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+
+	up->scr |= OMAP_UART_SCR_RX_TRIG_GRANU1_MASK;
 
 	if (up->use_dma) {
 		serial_out(up, UART_TI752_TLR, 0);
-		up->scr |= (UART_FCR_TRIGGER_4 | UART_FCR_TRIGGER_8);
+		up->scr |= UART_FCR_TRIGGER_4;
+	} else {
+		/* Set receive FIFO threshold to 1 byte */
+		up->fcr &= ~OMAP_UART_FCR_RX_FIFO_TRIG_MASK;
+		up->fcr |= (0x1 << OMAP_UART_FCR_RX_FIFO_TRIG_SHIFT);
 	}
 
+	serial_out(up, UART_FCR, up->fcr);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+
 	serial_out(up, UART_OMAP_SCR, up->scr);
 
 	serial_out(up, UART_EFR, up->efr);
