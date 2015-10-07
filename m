From: timur@codeaurora.org (Timur Tabi)
Date: Wed,  7 Oct 2015 15:27:16 -0500
Subject: [PATCH] serial: amba-pl011: fix incorrect integer size in
 pl011_fifo_to_tty()
Message-ID: <1444249636-25661-1-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UART_DUMMY_DR_RX status bit is equal to (1 << 16), so a u16 is too small
to hold that value.  The result is that UART_DUMMY_DR_RX is never passed
to uart_insert_char().  This means that we're always accepting characters,
even when CREAD (in termios) is not set.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 drivers/tty/serial/amba-pl011.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index fd27e98..899a771 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -191,8 +191,8 @@ struct uart_amba_port {
  */
 static int pl011_fifo_to_tty(struct uart_amba_port *uap)
 {
-	u16 status, ch;
-	unsigned int flag, max_count = 256;
+	u16 status;
+	unsigned int ch, flag, max_count = 256;
 	int fifotaken = 0;
 
 	while (max_count--) {
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
