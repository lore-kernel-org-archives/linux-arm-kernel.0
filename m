From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Tue, 9 Dec 2014 14:31:33 +0100
Subject: [PATCH 2/5] tty/serial: at91: enable peripheral clock before
 accessing I/O registers
In-Reply-To: <cover.1418131298.git.cyrille.pitchen@atmel.com>
References: <cover.1418131298.git.cyrille.pitchen@atmel.com>
Message-ID: <01544ce7fecbc7323106666f91fdeffe35eef33a.1418131298.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

atmel_serial_probe() calls atmel_init_port(). In turn, atmel_init_port() calls
clk_disable_unprepare() to disable the peripheral clock before returning.

Later atmel_serial_probe() accesses some I/O registers such as the Mode and
Control registers for RS485 support then the Name and Version registers, through a call to
atmel_get_ip_name(), but at that moment the peripheral clock was still
disabled.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/tty/serial/atmel_serial.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 756f567..c6621dc 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2596,6 +2596,12 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	device_init_wakeup(&pdev->dev, 1);
 	platform_set_drvdata(pdev, port);
 
+	/*
+	 * The peripheral clock has been disabled by atmel_init_port():
+	 * enable it before accessing I/O registers
+	 */
+	clk_prepare_enable(port->clk);
+
 	if (rs485_enabled) {
 		UART_PUT_MR(&port->uart, ATMEL_US_USMODE_NORMAL);
 		UART_PUT_CR(&port->uart, ATMEL_US_RTSEN);
@@ -2606,6 +2612,12 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	 */
 	atmel_get_ip_name(&port->uart);
 
+	/*
+	 * The peripheral clock can now safely be disabled till the port
+	 * is used
+	 */
+	clk_disable_unprepare(port->clk);
+
 	return 0;
 
 err_add_port:
-- 
1.8.2.2
