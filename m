From: richard.genoud@gmail.com (Richard Genoud)
Date: Fri,  3 Mar 2017 15:20:31 +0100
Subject: [PATCH 3/4] tty/serial: mxs-auart: remove uneeded IS_ERR_OR_NULL calls
Message-ID: <20170303142031.16101-1-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 1d267ea6539f ("serial: mctrl-gpio: simplify init routine"),
the mctrl_gpio_to_gpiod() function can't return an error anymore.
So, just testing for a NULL pointer is ok.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/tty/serial/mxs-auart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 6989b227d134..541933d8a5c6 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -973,10 +973,8 @@ static int mxs_auart_dma_init(struct mxs_auart_port *s)
 
 }
 
-#define RTS_AT_AUART()	IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(s->gpios,	\
-							UART_GPIO_RTS))
-#define CTS_AT_AUART()	IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(s->gpios,	\
-							UART_GPIO_CTS))
+#define RTS_AT_AUART() (mctrl_gpio_to_gpiod(s->gpios, UART_GPIO_RTS) == NULL)
+#define CTS_AT_AUART() (mctrl_gpio_to_gpiod(s->gpios, UART_GPIO_CTS) == NULL)
 static void mxs_auart_settermios(struct uart_port *u,
 				 struct ktermios *termios,
 				 struct ktermios *old)
