From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue,  3 Nov 2009 20:03:20 +0100
Subject: [PATCH 2/2] [ARM] i2c/pxa: only define 'blue_murder'-function if
	DEBUG is #defined
In-Reply-To: <1257275000-18866-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1257275000-18866-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1257275000-18866-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <w.sang@pengutronix.de>

This talkative function is also called on timeouts. As timeouts can
happen on regular writes to EEPROMs (no error case), this creates false
positives.  Giving lots of details is interesting only for developers
anyhow, so just use the function if DEBUG is #defined.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Jean Delvare <khali@linux-fr.org>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Eric Miao <eric.miao@marvell.com>
Cc: Roel Kluin <roel.kluin@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>
---
 drivers/i2c/busses/i2c-pxa.c |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 40052c0..009e52e 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -208,16 +208,6 @@ static void i2c_pxa_show_state(struct pxa_i2c *i2c, int lno, const char *fname)
 }
 
 #define show_state(i2c) i2c_pxa_show_state(i2c, __LINE__, __func__)
-#else
-#define i2c_debug	0
-
-#define show_state(i2c) do { } while (0)
-#define decode_ISR(val) do { } while (0)
-#define decode_ICR(val) do { } while (0)
-#endif
-
-static void i2c_pxa_master_complete(struct pxa_i2c *i2c, int ret);
-static irqreturn_t i2c_pxa_handler(int this_irq, void *dev_id);
 
 static void i2c_pxa_scream_blue_murder(struct pxa_i2c *i2c, const char *why)
 {
@@ -233,6 +223,20 @@ static void i2c_pxa_scream_blue_murder(struct pxa_i2c *i2c, const char *why)
 	printk("\n");
 }
 
+#else /* ifdef DEBUG */
+
+#define i2c_debug	0
+
+#define show_state(i2c) do { } while (0)
+#define decode_ISR(val) do { } while (0)
+#define decode_ICR(val) do { } while (0)
+#define i2c_pxa_scream_blue_murder(i2c, why) do { } while (0)
+
+#endif /* ifdef DEBUG / else */
+
+static void i2c_pxa_master_complete(struct pxa_i2c *i2c, int ret);
+static irqreturn_t i2c_pxa_handler(int this_irq, void *dev_id);
+
 static inline int i2c_pxa_is_slavemode(struct pxa_i2c *i2c)
 {
 	return !(readl(_ICR(i2c)) & ICR_SCLE);
-- 
1.6.5.2
