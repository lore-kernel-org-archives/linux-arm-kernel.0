From: petr.cvek@tul.cz (Petr Cvek)
Date: Tue, 25 Nov 2014 06:05:33 +0100
Subject: [PATCH v3] i2c-pxa: add support for SCCB devices
In-Reply-To: <20141124172753.GA25434@katana>
References: <54711397.9060601@tul.cz> <20141123083112.GA1932@katana>
 <54725DE2.9090800@tul.cz> <20141124172753.GA25434@katana>
Message-ID: <54740E1D.9060508@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed missing functionality flag I2C_FUNC_NOSTART.

Added support for SCCB by implementing I2C_M_IGNORE_NAK and I2C_M_STOP flag and belonging functionality flag I2C_FUNC_PROTOCOL_MANGLING.

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
