From: dianders@chromium.org (Douglas Anderson)
Date: Tue, 30 Oct 2018 15:11:05 -0700
Subject: [PATCH v2 3/5] serial: qcom_geni_serial: Process sysrq at port unlock
 time
In-Reply-To: <20181030221107.79758-1-dianders@chromium.org>
References: <20181030221107.79758-1-dianders@chromium.org>
Message-ID: <20181030221107.79758-4-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's take advantage of the new ("serial: core: Allow processing sysrq
at port unlock time") to handle sysrqs more cleanly.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/tty/serial/qcom_geni_serial.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index b83e3554bced..29ddc1fc65f8 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -499,9 +499,7 @@ static int handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
 					continue;
 			}
 
-			spin_unlock(&uport->lock);
-			sysrq = uart_handle_sysrq_char(uport, buf[c]);
-			spin_lock(&uport->lock);
+			sysrq = uart_prepare_sysrq_char(uport, buf[c]);
 
 			if (!sysrq)
 				tty_insert_flip_char(tport, buf[c], TTY_NORMAL);
@@ -811,7 +809,8 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 		qcom_geni_serial_handle_rx(uport, drop_rx);
 
 out_unlock:
-	spin_unlock_irqrestore(&uport->lock, flags);
+	uart_unlock_and_check_sysrq(uport, flags);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.19.1.568.g152ad8e336-goog
