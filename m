From: petr.cvek@tul.cz (Petr Cvek)
Date: Sun, 23 Nov 2014 23:21:22 +0100
Subject: [PATCH v2] Add support for SCCB devices into PXA27x I2C controller
In-Reply-To: <20141123083112.GA1932@katana>
References: <54711397.9060601@tul.cz> <20141123083112.GA1932@katana>
Message-ID: <54725DE2.9090800@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm sorry for spacing, I didn't realize thunderbird automatically replaces tabs with spaces. Now it should be OK. 

I created this patch by fixing both I2C controller and SCCB device, so it seems I incorrectly used I2C_M_NOSTART instead I2C_M_STOP. Problem with I2C_M_STOP is that it causes bus freeze when using userspace utility "i2cget" on SCCB device (unfreeze can be done with i2c-pxa module reload). But this can be probably repaired in i2cget.

Patched kernel was from vanilla 3.18.0-rc5 commit fc14f9c1272f62c3e8d01300f52467c0d9af50f9

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 drivers/i2c/busses/i2c-pxa.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index be671f7..f80df8f 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -885,7 +885,9 @@ static void i2c_pxa_irq_txempty(struct pxa_i2c *i2c, u32 isr)
 		return; /* ignore */
 	}
 
-	if (isr & ISR_BED) {
+	if ((isr & ISR_BED) &&
+		(!((i2c->msg->flags & I2C_M_IGNORE_NAK) &&
+			(isr & ISR_ACKNAK)))) {
 		int ret = BUS_ERROR;
 
 		/*
@@ -919,12 +921,14 @@ static void i2c_pxa_irq_txempty(struct pxa_i2c *i2c, u32 isr)
 		icr |= ICR_ALDIE | ICR_TB;
 
 		/*
-		 * If this is the last byte of the last message, send
-		 * a STOP.
+		 * If this is the last byte of the last message or last byte
+		 * of any message with I2C_M_STOP (e.g. SCCB), send a STOP.
 		 */
-		if (i2c->msg_ptr == i2c->msg->len &&
-		    i2c->msg_idx == i2c->msg_num - 1)
-			icr |= ICR_STOP;
+		if ((i2c->msg_ptr == i2c->msg->len) &&
+			((i2c->msg->flags & I2C_M_STOP) ||
+			(i2c->msg_idx == i2c->msg_num - 1)))
+				icr |= ICR_STOP;
+
 	} else if (i2c->msg_idx < i2c->msg_num - 1) {
 		/*
 		 * Next segment of the message.
@@ -1071,7 +1075,8 @@ static int i2c_pxa_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num
 
 static u32 i2c_pxa_functionality(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL |
+		I2C_FUNC_PROTOCOL_MANGLING | I2C_FUNC_NOSTART;
 }
 
 static const struct i2c_algorithm i2c_pxa_algorithm = {
-- 
1.7.12.1
