From: eric.miao@linaro.org (Eric Miao)
Date: Fri, 23 Dec 2011 05:39:27 +0800
Subject: [PATCH] tty: serial: imx: move del_timer_sync() to avoid potential
 deadlock
Message-ID: <1324589967-25365-1-git-send-email-eric.miao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

del_timer_sync() acquires its own lock and doesn't have to be nested
within the spinlock of sport->port.lock in imx_set_termios(),  which
will cause potential deadlock.  Fix this by moving it outside.

Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Eric Miao <eric.miao@linaro.org>
---
 drivers/tty/serial/imx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 39bbce4..0f4ba21 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -904,6 +904,8 @@ imx_set_termios(struct uart_port *port, struct ktermios *termios,
 			ucr2 |= UCR2_PROE;
 	}
 
+	del_timer_sync(&sport->timer);
+
 	/*
 	 * Ask the core to calculate the divisor for us.
 	 */
@@ -934,8 +936,6 @@ imx_set_termios(struct uart_port *port, struct ktermios *termios,
 			sport->port.ignore_status_mask |= URXD_OVRRUN;
 	}
 
-	del_timer_sync(&sport->timer);
-
 	/*
 	 * Update the per-port timeout.
 	 */
-- 
1.7.5.4
