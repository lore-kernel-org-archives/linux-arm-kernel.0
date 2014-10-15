From: ssreedharan@mvista.com (Sudhir Sreedharan)
Date: Wed, 15 Oct 2014 12:13:15 +0530
Subject: [PATCH] tty: serial: 8250_core: restore the LCR register in set_sleep
In-Reply-To: <54369F77.5000906@hurleysoftware.com>
References: <54369F77.5000906@hurleysoftware.com>
Message-ID: <1413355395-5871-1-git-send-email-ssreedharan@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In ST16650V2 based serial uarts, while initalizing the PM state,
LCR registers are being initialized to 0 in serial8250_set_sleep().
If console port is already initialized and being used, this will
throws garbage in the console.

Signed-off-by: Sudhir Sreedharan <ssreedharan@mvista.com>
---
 drivers/tty/serial/8250/8250_core.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index ca5cfdc..e054482 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -595,6 +595,7 @@ static void serial8250_rpm_put_tx(struct uart_8250_port *p)
  */
 static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
 {
+	unsigned char lcr, efr;
 	/*
 	 * Exar UARTs have a SLEEP register that enables or disables
 	 * each UART to enter sleep mode separately.  On the XR17V35x the
@@ -611,6 +612,8 @@ static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
 
 	if (p->capabilities & UART_CAP_SLEEP) {
 		if (p->capabilities & UART_CAP_EFR) {
+			lcr = serial_in(p, UART_LCR);
+			efr = serial_in(p, UART_EFR);
 			serial_out(p, UART_LCR, UART_LCR_CONF_MODE_B);
 			serial_out(p, UART_EFR, UART_EFR_ECB);
 			serial_out(p, UART_LCR, 0);
@@ -618,8 +621,8 @@ static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
 		serial_out(p, UART_IER, sleep ? UART_IERX_SLEEP : 0);
 		if (p->capabilities & UART_CAP_EFR) {
 			serial_out(p, UART_LCR, UART_LCR_CONF_MODE_B);
-			serial_out(p, UART_EFR, 0);
-			serial_out(p, UART_LCR, 0);
+			serial_out(p, UART_EFR, sleep ? 0 : efr);
+			serial_out(p, UART_LCR, sleep ? 0 : lcr);
 		}
 	}
 out:
-- 
1.7.0.1
