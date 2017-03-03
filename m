From: richard.genoud@gmail.com (Richard Genoud)
Date: Fri,  3 Mar 2017 15:17:02 +0100
Subject: [PATCH 2/4] tty/serial: atmel: remove uneeded IS_ERR_OR_NULL calls
Message-ID: <20170303141702.15331-1-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 1d267ea6539f ("serial: mctrl-gpio: simplify init routine"),
the mctrl_gpio_to_gpiod() function can't return an error anymore.
So, just testing for a NULL pointer is ok.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/tty/serial/atmel_serial.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index ad6c2bdea481..e0f1955b3c7e 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -315,32 +315,28 @@ static unsigned int atmel_get_lines_status(struct uart_port *port)
 
 	mctrl_gpio_get(atmel_port->gpios, &ret);
 
-	if (!IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(atmel_port->gpios,
-						UART_GPIO_CTS))) {
+	if (mctrl_gpio_to_gpiod(atmel_port->gpios, UART_GPIO_CTS)) {
 		if (ret & TIOCM_CTS)
 			status &= ~ATMEL_US_CTS;
 		else
 			status |= ATMEL_US_CTS;
 	}
 
-	if (!IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(atmel_port->gpios,
-						UART_GPIO_DSR))) {
+	if (mctrl_gpio_to_gpiod(atmel_port->gpios, UART_GPIO_DSR)) {
 		if (ret & TIOCM_DSR)
 			status &= ~ATMEL_US_DSR;
 		else
 			status |= ATMEL_US_DSR;
 	}
 
-	if (!IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(atmel_port->gpios,
-						UART_GPIO_RI))) {
+	if (mctrl_gpio_to_gpiod(atmel_port->gpios, UART_GPIO_RI)) {
 		if (ret & TIOCM_RI)
 			status &= ~ATMEL_US_RI;
 		else
 			status |= ATMEL_US_RI;
 	}
 
-	if (!IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(atmel_port->gpios,
-						UART_GPIO_DCD))) {
+	if (mctrl_gpio_to_gpiod(atmel_port->gpios, UART_GPIO_DCD)) {
 		if (ret & TIOCM_CD)
 			status &= ~ATMEL_US_DCD;
 		else
