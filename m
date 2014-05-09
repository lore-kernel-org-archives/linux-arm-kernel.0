From: dean_jenkins@mentor.com (dean_jenkins at mentor.com)
Date: Fri,  9 May 2014 16:19:46 +0100
Subject: [PATCH 3/5] serial: imx: avoid spinlock recursion deadlock
In-Reply-To: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com>
References: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com>
Message-ID: <1399648788-26061-4-git-send-email-dean_jenkins@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andy Lowe <andy_lowe@mentor.com>

The following deadlock has been observed:

imx_int() {
  imx_txint() {
    spin_lock_irqsave(&sport->port.lock,flags);
    /* ^^^uart_port spinlock taken in imx_txint */
    imx_transmit_buffer() {
      uart_write_wakeup(&sport->port) {
        tty_wakeup() {
          hci_uart_tty_wakeup() {
            hci_uart_tx_wakeup() {
              uart_write() {
                spin_lock_irqsave(&port->lock, flags);
                /* ^^^deadlock here when spinlock is taken again */
                  .
                  .
                  .
                spin_unlock_irqrestore(&port->lock, flags);
              }
            }
          }
        }
      }
    }
    spin_unlock_irqrestore(&sport->port.lock,flags);
  }
}

To correct this call uart_write_wakeup() at the end of imx_txint() after
the uart_port spinlock is unlocked.

Signed-off-by: Andy Lowe <andy_lowe@mentor.com>
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 drivers/tty/serial/imx.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index abe31ad..cc79706 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -636,8 +636,13 @@ static irqreturn_t imx_txint(int irq, void *dev_id)
 
 	imx_transmit_buffer(sport);
 
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS) {
+		spin_unlock_irqrestore(&sport->port.lock, flags);
 		uart_write_wakeup(&sport->port);
+	} else
+		spin_unlock_irqrestore(&sport->port.lock, flags);
+
+	return IRQ_HANDLED;
 
 out:
 	spin_unlock_irqrestore(&sport->port.lock, flags);
-- 
1.7.9.5
