From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Thu, 12 Jul 2018 09:58:14 +0800
Subject: [PATCH v6 2/3] serial: 8250: export serial8250_do_set_divisor()
In-Reply-To: <20180712095504.4d9583ce@xhacker.debian>
References: <20180712095504.4d9583ce@xhacker.debian>
Message-ID: <20180712095814.76b0f159@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some drivers could call serial8250_do_set_divisor() to complete its
own set_divisor routine. Export this symbol for code reusing.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 5 +++--
 include/linux/serial_8250.h         | 3 +++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index ce0dc17f18ee..945f8dc2d50f 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2580,8 +2580,8 @@ static unsigned char serial8250_compute_lcr(struct uart_8250_port *up,
 	return cval;
 }
 
-static void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
-			    unsigned int quot, unsigned int quot_frac)
+void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
+			       unsigned int quot, unsigned int quot_frac)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 
@@ -2612,6 +2612,7 @@ static void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
 		serial_port_out(port, 0x2, quot_frac);
 	}
 }
+EXPORT_SYMBOL_GPL(serial8250_do_set_divisor);
 
 static void serial8250_set_divisor(struct uart_port *port, unsigned int baud,
 				   unsigned int quot, unsigned int quot_frac)
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 76b9db71e489..18e21427bce4 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -160,6 +160,9 @@ extern void serial8250_do_shutdown(struct uart_port *port);
 extern void serial8250_do_pm(struct uart_port *port, unsigned int state,
 			     unsigned int oldstate);
 extern void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl);
+extern void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
+				      unsigned int quot,
+				      unsigned int quot_frac);
 extern int fsl8250_handle_irq(struct uart_port *port);
 int serial8250_handle_irq(struct uart_port *port, unsigned int iir);
 unsigned char serial8250_rx_chars(struct uart_8250_port *up, unsigned char lsr);
-- 
2.18.0
