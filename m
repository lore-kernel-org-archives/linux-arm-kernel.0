From: maxime.coquelin@st.com (Maxime COQUELIN)
Date: Thu, 24 Jul 2014 14:02:56 +0200
Subject: [PATCH 2/2] serial: st-asc: Fix overflow in baudrate calculation
In-Reply-To: <1406203376-18203-1-git-send-email-maxime.coquelin@st.com>
References: <1406203376-18203-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <1406203376-18203-3-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the current calculation, if the required baud rate is above 262143,
we get an overflow.

This patch uses a 64bits variable to do the maths.
Also, we remove the '+1' to avoid a divide by zero if the input clock
rate is something unexpected.
Indeed, if the input clock rate is zero, it is preferable to be notified,
since the UART won't work anyway.

Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 drivers/tty/serial/st-asc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index 2369bc0..7ac9902 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -533,12 +533,12 @@ static void asc_set_termios(struct uart_port *port, struct ktermios *termios,
 		 * ASCBaudRate =   ------------------------
 		 *                          inputclock
 		 *
-		 * However to keep the maths inside 32bits we divide top and
-		 * bottom by 64. The +1 is to avoid a divide by zero if the
-		 * input clock rate is something unexpected.
+		 * To keep maths inside 64bits, we divide inputclock by 16.
 		 */
-		u32 counter = (baud * 16384) / ((port->uartclk / 64) + 1);
-		asc_out(port, ASC_BAUDRATE, counter);
+		u64 dividend = (u64)baud * (1 << 16);
+
+		do_div(dividend, port->uartclk / 16);
+		asc_out(port, ASC_BAUDRATE, dividend);
 		ctrl_val |= ASC_CTL_BAUDMODE;
 	}
 
-- 
1.9.1
