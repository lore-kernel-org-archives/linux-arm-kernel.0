From: andre.przywara@arm.com (Andre Przywara)
Date: Wed,  4 Mar 2015 17:59:50 +0000
Subject: [PATCH v2 06/10] drivers: PL011: replace UART_MIS reading with _RIS &
 _IMSC
In-Reply-To: <1425491994-23913-1-git-send-email-andre.przywara@arm.com>
References: <1425491994-23913-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1425491994-23913-7-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PL011 register UART_MIS is actually a bitwise AND of the
UART_RIS and the UART_MISC register.
Since the SBSA UART does not include the _MIS register, use the
two separate registers to get the same behaviour. Since we are
inside the spinlock and we read the _IMSC register only once, there
should be no race issue.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/tty/serial/amba-pl011.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 4fe0a0a..b8f46f3 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1418,11 +1418,13 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 	struct uart_amba_port *uap = dev_id;
 	unsigned long flags;
 	unsigned int status, pass_counter = AMBA_ISR_PASS_LIMIT;
+	u16 imsc;
 	int handled = 0;
 	unsigned int dummy_read;
 
 	spin_lock_irqsave(&uap->port.lock, flags);
-	status = readw(uap->port.membase + UART011_MIS);
+	imsc = readw(uap->port.membase + UART011_IMSC);
+	status = readw(uap->port.membase + UART011_RIS) & imsc;
 	if (status) {
 		do {
 			if (uap->vendor->cts_event_workaround) {
@@ -1459,7 +1461,7 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 			if (pass_counter-- == 0)
 				break;
 
-			status = readw(uap->port.membase + UART011_MIS);
+			status = readw(uap->port.membase + UART011_RIS) & imsc;
 		} while (status != 0);
 		handled = 1;
 	}
-- 
1.7.9.5
