From: richard.genoud@gmail.com (Richard Genoud)
Date: Fri,  3 Mar 2017 15:22:01 +0100
Subject: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL calls
Message-ID: <20170303142201.16452-1-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 1d267ea6539f ("serial: mctrl-gpio: simplify init routine"),
the mctrl_gpio_to_gpiod() function can't return an error anymore.
So, just testing for a NULL pointer is ok.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/tty/serial/sh-sci.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 9a47cc4f16a2..36fde6f24040 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1934,12 +1934,12 @@ static unsigned int sci_get_mctrl(struct uart_port *port)
 	if (s->autorts) {
 		if (sci_get_cts(port))
 			mctrl |= TIOCM_CTS;
-	} else if (IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(gpios, UART_GPIO_CTS))) {
+	} else if (!mctrl_gpio_to_gpiod(gpios, UART_GPIO_CTS)) {
 		mctrl |= TIOCM_CTS;
 	}
-	if (IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(gpios, UART_GPIO_DSR)))
+	if (!mctrl_gpio_to_gpiod(gpios, UART_GPIO_DSR))
 		mctrl |= TIOCM_DSR;
-	if (IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(gpios, UART_GPIO_DCD)))
+	if (!mctrl_gpio_to_gpiod(gpios, UART_GPIO_DCD))
 		mctrl |= TIOCM_CAR;
 
 	return mctrl;
@@ -3072,10 +3072,8 @@ static int sci_probe_single(struct platform_device *dev,
 		return PTR_ERR(sciport->gpios);
 
 	if (sciport->has_rtscts) {
-		if (!IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(sciport->gpios,
-							UART_GPIO_CTS)) ||
-		    !IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(sciport->gpios,
-							UART_GPIO_RTS))) {
+		if (mctrl_gpio_to_gpiod(sciport->gpios, UART_GPIO_CTS) ||
+		    mctrl_gpio_to_gpiod(sciport->gpios, UART_GPIO_RTS)) {
 			dev_err(&dev->dev, "Conflicting RTS/CTS config\n");
 			return -EINVAL;
 		}
