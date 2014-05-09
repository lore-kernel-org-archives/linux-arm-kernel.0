From: dean_jenkins@mentor.com (dean_jenkins at mentor.com)
Date: Fri,  9 May 2014 16:19:45 +0100
Subject: [PATCH 2/5] serial: imx: remove uart_write_wakeup() from
 imx_transmit_buffer()
In-Reply-To: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com>
References: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com>
Message-ID: <1399648788-26061-3-git-send-email-dean_jenkins@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dirk Behme <dirk.behme@de.bosch.com>

At the moment we have

imx_transmit_buffer() {
    ...
    if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
        uart_write_wakeup();
    ...
}

imx_txint() {
    ...
    imx_transmit_buffer();

    if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
        uart_write_wakeup();
    ...
}

With this, we are calling uart_write_wakeup() at the end of
imx_transmit_buffer() and immediately again after returning
from imx_transmit_buffer() in imx_txint(). Instead of calling
uart_write_wakeup() two times this way, remove the first call
and call uart_write_wakeup() only once in imx_txint().

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
Signed-off-by: Andy Lowe <andy_lowe@mentor.com>
---
 drivers/tty/serial/imx.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 7b813b3..abe31ad 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -470,9 +470,6 @@ static inline void imx_transmit_buffer(struct imx_port *sport)
 		sport->port.icount.tx++;
 	}
 
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(&sport->port);
-
 	if (uart_circ_empty(xmit))
 		imx_stop_tx(&sport->port);
 }
-- 
1.7.9.5
