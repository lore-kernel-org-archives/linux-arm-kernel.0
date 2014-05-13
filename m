From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 13 May 2014 17:08:57 +0100
Subject: [PATCH] serial: st-asc: Fix data corruption during long console bursts
Message-ID: <1399997337-27950-1-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On my test platform (B2020/STiH416) the serial port issues bad characters
during the initial message avalanche as the console comes up. The problem
also occurs when dense(ish) I/O is done using the polled I/O interface.

The problem is fixed for me by using the FIFO half-empty bit rather than
FIFO full bit. Note that using the half-empty bit causes the FIFO to be
managed in a similar way to interrupt based I/O (i.e. where the hardware
gets best test coverage).

Running the FIFO half full will have no impact (good or bad) on console
performance. The UART will still remain fully saturated and the busy-wait
until the FIFO is empty in asc_console_write() will complete at the same
time.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/tty/serial/st-asc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index dd3a96e..c7f61ac 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -194,9 +194,9 @@ static inline u32 asc_txfifo_is_empty(struct uart_port *port)
 	return asc_in(port, ASC_STA) & ASC_STA_TE;
 }
 
-static inline int asc_txfifo_is_full(struct uart_port *port)
+static inline u32 asc_txfifo_is_half_empty(struct uart_port *port)
 {
-	return asc_in(port, ASC_STA) & ASC_STA_TF;
+	return asc_in(port, ASC_STA) & ASC_STA_THE;
 }
 
 static inline const char *asc_port_name(struct uart_port *port)
@@ -628,7 +628,7 @@ static int asc_get_poll_char(struct uart_port *port)
 
 static void asc_put_poll_char(struct uart_port *port, unsigned char c)
 {
-	while (asc_txfifo_is_full(port))
+	while (!asc_txfifo_is_half_empty(port))
 		cpu_relax();
 	asc_out(port, ASC_TXBUF, c);
 }
@@ -783,7 +783,7 @@ static void asc_console_putchar(struct uart_port *port, int ch)
 	unsigned int timeout = 1000000;
 
 	/* Wait for upto 1 second in case flow control is stopping us. */
-	while (--timeout && asc_txfifo_is_full(port))
+	while (--timeout && !asc_txfifo_is_half_empty(port))
 		udelay(1);
 
 	asc_out(port, ASC_TXBUF, ch);
-- 
1.9.0
