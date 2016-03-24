From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Mar 2016 14:24:23 +0100
Subject: [PATCH v2 4/6] serial: imx: only count 0->1 transitions for RNG
In-Reply-To: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1458825865-7434-5-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to tty_ioctl(4) (from man-pages 4.04) the rng member only
counts 0->1 transitions. For the other signals (DSR, CD, CTS) both edges
are supposed to be counted.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index fcd48fd78bf5..1bf7b86acf66 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -884,7 +884,7 @@ static void imx_mctrl_check(struct imx_port *sport)
 
 	sport->old_status = status;
 
-	if (changed & TIOCM_RI)
+	if (changed & TIOCM_RI && status & TIOCM_RI)
 		sport->port.icount.rng++;
 	if (changed & TIOCM_DSR)
 		sport->port.icount.dsr++;
-- 
2.7.0
