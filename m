From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 21 Jun 2011 16:31:19 +0200
Subject: [PATCH] atmel_serial: fix internal port num
In-Reply-To: <1307541740.10626.15.camel@hcegtvedt.norway.atmel.com>
References: <1307541740.10626.15.camel@hcegtvedt.norway.atmel.com>
Message-ID: <1308666679-12111-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the atmel_ports is link to the console number and not the device id

this was not detected on at91 as we always register the dbgu on the console
as ttyS0

tested on at91sam9263 by setting the dbgu as ttyS1 and use as console

diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
index 70e5646..9b8a14f 100644
- a/arch/arm/mach-at91/board-sam9263ek.c
+ b/arch/arm/mach-at91/board-sam9263ek.c
@@ -58,14 +58,14 @@ static void __init ek_init_early(void)
        /* Initialize processor: 16.367 MHz crystal */
        at91_initialize(16367660);

-       /* DBGU on ttyS0. (Rx & Tx only) */
-       at91_register_uart(0, 0, 0);
+       /* DBGU on ttyS1. (Rx & Tx only) */
+       at91_register_uart(0, 1, 0);

-       /* USART0 on ttyS1. (Rx, Tx, RTS, CTS) */
-       at91_register_uart(AT91SAM9263_ID_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS);
+       /* USART0 on ttyS0. (Rx, Tx, RTS, CTS) */
+       at91_register_uart(AT91SAM9263_ID_US0, 0, ATMEL_UART_CTS | ATMEL_UART_RTS);

-       /* set serial console to ttyS0 (ie, DBGU) */
-       at91_set_serial_console(0);
+       /* set serial console to ttyS1 (ie, DBGU) */
+       at91_set_serial_console(1);
 }

 /*

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
---
 drivers/tty/serial/atmel_serial.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 6d5d6e6..af9b781 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1709,12 +1709,13 @@ static int atmel_serial_resume(struct platform_device *pdev)
 static int __devinit atmel_serial_probe(struct platform_device *pdev)
 {
 	struct atmel_uart_port *port;
+	struct atmel_uart_data *pdata = pdev->dev.platform_data;
 	void *data;
 	int ret;
 
 	BUILD_BUG_ON(ATMEL_SERIAL_RINGSIZE & (ATMEL_SERIAL_RINGSIZE - 1));
 
-	port = &atmel_ports[pdev->id];
+	port = &atmel_ports[pdata->num];
 	port->backup_imr = 0;
 
 	atmel_init_port(port, pdev);
-- 
1.7.4.1
