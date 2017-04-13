From: robh@kernel.org (Rob Herring)
Date: Thu, 13 Apr 2017 10:03:51 -0500
Subject: [PATCH v3 2/4] bluetooth: hci_uart: remove unused hci_uart_init_tty
In-Reply-To: <20170413150353.7389-1-robh@kernel.org>
References: <20170413150353.7389-1-robh@kernel.org>
Message-ID: <20170413150353.7389-3-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are no users of hci_uart_init_tty, so remove it.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth at vger.kernel.org
---
v3:
- rebase on bluetooth-next

 drivers/bluetooth/hci_ldisc.c | 19 -------------------
 drivers/bluetooth/hci_uart.h  |  1 -
 2 files changed, 20 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 17bcbc13623f..cec4438ede01 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -319,25 +319,6 @@ void hci_uart_set_speeds(struct hci_uart *hu, unsigned int init_speed,
 	hu->oper_speed = oper_speed;
 }
 
-void hci_uart_init_tty(struct hci_uart *hu)
-{
-	struct tty_struct *tty = hu->tty;
-	struct ktermios ktermios;
-
-	/* Bring the UART into a known 8 bits no parity hw fc state */
-	ktermios = tty->termios;
-	ktermios.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP |
-			      INLCR | IGNCR | ICRNL | IXON);
-	ktermios.c_oflag &= ~OPOST;
-	ktermios.c_lflag &= ~(ECHO | ECHONL | ICANON | ISIG | IEXTEN);
-	ktermios.c_cflag &= ~(CSIZE | PARENB);
-	ktermios.c_cflag |= CS8;
-	ktermios.c_cflag |= CRTSCTS;
-
-	/* tty_set_termios() return not checked as it is always 0 */
-	tty_set_termios(tty, &ktermios);
-}
-
 void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed)
 {
 	struct tty_struct *tty = hu->tty;
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 1b41c661bbb8..2b05e557fad0 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -114,7 +114,6 @@ int hci_uart_register_device(struct hci_uart *hu, const struct hci_uart_proto *p
 
 int hci_uart_tx_wakeup(struct hci_uart *hu);
 int hci_uart_init_ready(struct hci_uart *hu);
-void hci_uart_init_tty(struct hci_uart *hu);
 void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed);
 void hci_uart_set_flow_control(struct hci_uart *hu, bool enable);
 void hci_uart_set_speeds(struct hci_uart *hu, unsigned int init_speed,
-- 
2.11.0
