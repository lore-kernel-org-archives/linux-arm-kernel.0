From: harinik@xilinx.com (Harini Katakam)
Date: Fri,  5 Dec 2014 13:38:04 +0530
Subject: [PATCH v3 2/2] i2c: cadence: Check for errata condition involving
 master receive
In-Reply-To: <1417766884-8383-1-git-send-email-harinik@xilinx.com>
References: <1417766884-8383-1-git-send-email-harinik@xilinx.com>
Message-ID: <1417766884-8383-3-git-send-email-harinik@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cadence I2C controller has the following bugs:
- completion indication is not given to the driver at the end of
a read/receive transfer with HOLD bit set.
- Invalid read transaction are generated on the bus when HW timeout
condition occurs with HOLD bit set.

As a result of the above, if a set of messages to be transferred with
repeated start includes any transfer following a read transfer,
completion is never indicated and timeout occurs.
Hence a check is implemented to return -EOPNOTSUPP for such sequences.

Signed-off-by: Harini Katakam <harinik@xilinx.com>
Signed-off-by: Vishnu Motghare <vishnum@xilinx.com>
---

v3:
Add warning in case of unsupported transfer.

v2:
Dont defeteature repeated start. Just check for unsupported conditions in the
driver and return error.

---
 drivers/i2c/busses/i2c-cadence.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 5f5d4fa..3ea3b7a 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -541,6 +541,21 @@ static int cdns_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	 * processed with a repeated start.
 	 */
 	if (num > 1) {
+		/*
+		 * This controller does not give completion interrupt after a
+		 * master receive transfer if HOLD bit is set (repeated start),
+		 * resulting in SW timeout. Hence, if a receive transfer is
+		 * followed by any other transfer, an error is returned
+		 * indicating that this sequence is not supported.
+		 */
+		for (count = 0; count < num-1; count++) {
+			if (msgs[count].flags & I2C_M_RD)
+				dev_warn(adap->dev.parent,
+					"No support for repeated start when\t");
+				dev_warn(adap->dev.parent,
+					"receive is followed by a transfer\n");
+				return -EOPNOTSUPP;
+		}
 		id->bus_hold_flag = 1;
 		reg = cdns_i2c_readreg(CDNS_I2C_CR_OFFSET);
 		reg |= CDNS_I2C_CR_HOLD;
-- 
1.7.9.5
