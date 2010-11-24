From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 24 Nov 2010 22:20:16 +0100
Subject: [PATCH 6/7] i2c/pxa2xx: reset the chip if the bus is not free
In-Reply-To: <1290633617-15311-1-git-send-email-bigeasy@linutronix.de>
References: <1290633617-15311-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <1290633617-15311-7-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I haven't seen this (yet) during a normal transfer but starting
i2cdetect seems to hang the bus. On my Sodaville board, i2cdetect runs
fine on bus zero and runs into timeouts on bus one and two. The chip
never recovers from this condition. The following transfers hang as
well. The ISR_UB never disappears.
Issuing a chip reset fixes the timeout and following transfer succeed.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
---
 drivers/i2c/busses/i2c-pxa.c |   35 +++++++++++++++++++----------------
 1 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index bd4b885..1a48470 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -257,23 +257,7 @@ static void i2c_pxa_abort(struct pxa_i2c *i2c)
 	       _ICR(i2c));
 }
 
-static int i2c_pxa_wait_bus_not_busy(struct pxa_i2c *i2c)
-{
-	int timeout = DEF_TIMEOUT;
 
-	while (timeout-- && readl(_ISR(i2c)) & (ISR_IBB | ISR_UB)) {
-		if ((readl(_ISR(i2c)) & ISR_SAD) != 0)
-			timeout += 4;
-
-		msleep(2);
-		show_state(i2c);
-	}
-
-	if (timeout < 0)
-		show_state(i2c);
-
-	return timeout < 0 ? I2C_RETRY : 0;
-}
 
 static int i2c_pxa_wait_master(struct pxa_i2c *i2c)
 {
@@ -425,6 +409,25 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
 	udelay(100);
 }
 
+static int i2c_pxa_wait_bus_not_busy(struct pxa_i2c *i2c)
+{
+	int timeout = DEF_TIMEOUT;
+
+	while (timeout-- && readl(_ISR(i2c)) & (ISR_IBB | ISR_UB)) {
+		if ((readl(_ISR(i2c)) & ISR_SAD) != 0)
+			timeout += 4;
+
+		msleep(2);
+		show_state(i2c);
+	}
+
+	if (timeout < 0) {
+		show_state(i2c);
+		i2c_pxa_reset(i2c);
+	}
+
+	return timeout < 0 ? I2C_RETRY : 0;
+}
 
 #ifdef CONFIG_I2C_PXA_SLAVE
 /*
-- 
1.7.3.2
