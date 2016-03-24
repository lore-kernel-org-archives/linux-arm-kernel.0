From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Mar 2016 14:24:20 +0100
Subject: [PATCH v2 1/6] serial: imx: fix polarity of RI
In-Reply-To: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1458825865-7434-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When in DTE mode, the bit USR2_RIIN is active low. So invert the logic
accordingly.

Fixes: 90ebc4838666 ("serial: imx: repair and complete handshaking")
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/imx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 231e7d5caf6c..bfc4555c63d1 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -797,9 +797,9 @@ static unsigned int imx_get_hwmctrl(struct imx_port *sport)
 	if (!(usr1 & USR2_DCDIN))
 		tmp |= TIOCM_CAR;
 
-	/* in DCE mode RIIN is always 0 */
-	if (readl(sport->port.membase + USR2) & USR2_RIIN)
-		tmp |= TIOCM_RI;
+	if (sport->dte_mode)
+		if (!(readl(sport->port.membase + USR2) & USR2_RIIN))
+			tmp |= TIOCM_RI;
 
 	return tmp;
 }
-- 
2.7.0
