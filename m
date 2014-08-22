From: dianders@chromium.org (Doug Anderson)
Date: Fri, 22 Aug 2014 10:43:44 -0700
Subject: [PATCH] i2c: rk3x: Remove unlikely() annotations
Message-ID: <1408729424-11433-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Having a transfer more than 32 bits is not all that unlikely.  Remove
the annotation.

The unlikely in the IRQ handler can't gain us much.  It's not in a
loop, so at most it would save 1 instruction per IRQ, which isn't
much.  In fact on the compiler I tested it produced the exact same
code.  Remove it too.

Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/i2c/busses/i2c-rk3x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 69e1185..b8b2b89 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -208,7 +208,7 @@ static void rk3x_i2c_prepare_read(struct rk3x_i2c *i2c)
 	 * The hw can read up to 32 bytes at a time. If we need more than one
 	 * chunk, send an ACK after the last byte of the current chunk.
 	 */
-	if (unlikely(len > 32)) {
+	if (len > 32) {
 		len = 32;
 		con &= ~REG_CON_LASTACK;
 	} else {
@@ -399,7 +399,7 @@ static irqreturn_t rk3x_i2c_irq(int irqno, void *dev_id)
 	}
 
 	/* is there anything left to handle? */
-	if (unlikely((ipd & REG_INT_ALL) == 0))
+	if ((ipd & REG_INT_ALL) == 0)
 		goto out;
 
 	switch (i2c->state) {
-- 
2.1.0.rc2.206.gedb03e5
