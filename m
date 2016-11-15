From: weo@reccoware.de (Wolfgang Ocker)
Date: Tue, 15 Nov 2016 12:05:29 +0100
Subject: [PATCH] mxs-auart: count FIFO overrun errors
Message-ID: <1479207929.4985.25.camel@reccoware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mxs-auart driver does not count FIFO overrun errors. These errors never
appear in /proc/tty/driver/ttyAPP. This is because the OERR status bit is
masked by read_status_mask in the rx interrupt function, but the
AUART_STAT_OERR bit is never set in read_status_mask. The patch enables the
counting of overrun errors.

Signed-off-by: Wolfgang Ocker <weo@reccoware.de>
---
?drivers/tty/serial/mxs-auart.c | 2 +-
?1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 770454e0dfa3..8c1c9112b3fd 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1016,7 +1016,7 @@ static void mxs_auart_settermios(struct uart_port *u,
?			ctrl |= AUART_LINECTRL_EPS;
?	}
?
-	u->read_status_mask = 0;
+	u->read_status_mask = AUART_STAT_OERR;
?
?	if (termios->c_iflag & INPCK)
?		u->read_status_mask |= AUART_STAT_PERR;
--?
2.10.0
