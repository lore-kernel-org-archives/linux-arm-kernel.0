From: andre.przywara@arm.com (Andre Przywara)
Date: Thu,  9 Apr 2015 12:29:19 +0100
Subject: [PATCH v3 08/10] drivers: PL011: allow avoiding UART
 enabling/disabling
In-Reply-To: <1428578961-6896-1-git-send-email-andre.przywara@arm.com>
References: <1428578961-6896-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1428578961-6896-9-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SBSA UART should not be enabled or disabled (it is always on),
and consequently the spec lacks the UART_CR register.
Add a vendor specific property to skip disabling or enabling of the
UART. This will be used later by the SBSA UART support.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/tty/serial/amba-pl011.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 34dfccd..98cb889 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -78,6 +78,7 @@ struct vendor_data {
 	bool			oversampling;
 	bool			dma_threshold;
 	bool			cts_event_workaround;
+	bool			always_enabled;
 
 	unsigned int (*get_fifosize)(struct amba_device *dev);
 };
@@ -94,6 +95,7 @@ static struct vendor_data vendor_arm = {
 	.oversampling		= false,
 	.dma_threshold		= false,
 	.cts_event_workaround	= false,
+	.always_enabled		= false,
 	.get_fifosize		= get_fifosize_arm,
 };
 
@@ -109,6 +111,7 @@ static struct vendor_data vendor_st = {
 	.oversampling		= true,
 	.dma_threshold		= true,
 	.cts_event_workaround	= true,
+	.always_enabled		= false,
 	.get_fifosize		= get_fifosize_st,
 };
 
@@ -1959,7 +1962,7 @@ static void
 pl011_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct uart_amba_port *uap = amba_ports[co->index];
-	unsigned int status, old_cr, new_cr;
+	unsigned int status, old_cr = 0, new_cr;
 	unsigned long flags;
 	int locked = 1;
 
@@ -1976,10 +1979,12 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 	/*
 	 *	First save the CR then disable the interrupts
 	 */
-	old_cr = readw(uap->port.membase + UART011_CR);
-	new_cr = old_cr & ~UART011_CR_CTSEN;
-	new_cr |= UART01x_CR_UARTEN | UART011_CR_TXE;
-	writew(new_cr, uap->port.membase + UART011_CR);
+	if (!uap->vendor->always_enabled) {
+		old_cr = readw(uap->port.membase + UART011_CR);
+		new_cr = old_cr & ~UART011_CR_CTSEN;
+		new_cr |= UART01x_CR_UARTEN | UART011_CR_TXE;
+		writew(new_cr, uap->port.membase + UART011_CR);
+	}
 
 	uart_console_write(&uap->port, s, count, pl011_console_putchar);
 
@@ -1990,7 +1995,8 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 	do {
 		status = readw(uap->port.membase + UART01x_FR);
 	} while (status & UART01x_FR_BUSY);
-	writew(old_cr, uap->port.membase + UART011_CR);
+	if (!uap->vendor->always_enabled)
+		writew(old_cr, uap->port.membase + UART011_CR);
 
 	if (locked)
 		spin_unlock(&uap->port.lock);
-- 
1.7.9.5
