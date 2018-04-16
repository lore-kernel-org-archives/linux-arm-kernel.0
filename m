From: amworsley@gmail.com (Andrew Worsley)
Date: Mon, 16 Apr 2018 11:22:48 +1000
Subject: [PATCH] Further cadence i2c buffer overrun fixes
In-Reply-To: <20180416012248.25891-1-amworsley@gmail.com>
References: <20180416012248.25891-1-amworsley@gmail.com>
Message-ID: <20180416012248.25891-2-amworsley@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After this set of changes ran over 2 days 17 hours with no i2c failures
at 200kHz. Previously would lock up with BA (Bus Active) bit set
continously with in a few hours

Set the transfer size register *before* triggering the operation by
setting the i2c address register with the slave address.

If the transfer is less than one FIFO length clear the hold bit before
starting the transfer by writing to the i2c address register.

Finally for transfer larger than a FIFO in size clear the hold bit
just before removing the byte that allows the rest of the transfer
to fit into the FIFO and then complete.
---
 drivers/i2c/busses/i2c-cadence.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 925f77dfded8..260bd6c67e1f 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -449,10 +449,10 @@ static irqreturn_t cdns_i2c_master_isr(void *ptr)
 				break;
 			}
 
-			*(id->p_recv_buf)++ =
-				cdns_i2c_readreg(CDNS_I2C_DATA_OFFSET);
 			if (check_hold && id->recv_count == CDNS_I2C_FIFO_DEPTH + 1)
 				cdns_i2c_clear_bus_hold(id);
+			*(id->p_recv_buf)++ =
+				cdns_i2c_readreg(CDNS_I2C_DATA_OFFSET);
 			id->recv_count--;
 			id->curr_recv_count--;
 
@@ -492,10 +492,6 @@ static irqreturn_t cdns_i2c_master_isr(void *ptr)
 		} else if (id->recv_count && !hold_quirk &&
 						!id->curr_recv_count) {
 
-			/* Set the slave address in address register*/
-			cdns_i2c_writereg(id->p_msg->addr & CDNS_I2C_ADDR_MASK,
-						CDNS_I2C_ADDR_OFFSET);
-
 			if (id->recv_count > CDNS_I2C_TRANSFER_SIZE) {
 				cdns_i2c_writereg(CDNS_I2C_TRANSFER_SIZE,
 						CDNS_I2C_XFER_SIZE_OFFSET);
@@ -505,6 +501,10 @@ static irqreturn_t cdns_i2c_master_isr(void *ptr)
 						CDNS_I2C_XFER_SIZE_OFFSET);
 				id->curr_recv_count = id->recv_count;
 			}
+
+			/* write the address register - triggers operation */
+			cdns_i2c_writereg(id->p_msg->addr & CDNS_I2C_ADDR_MASK,
+						CDNS_I2C_ADDR_OFFSET);
 		}
 
 		/* Clear hold (if not repeated start) and signal completion */
@@ -661,15 +661,15 @@ static void cdns_i2c_mrecv(struct cdns_i2c *id)
 		cdns_i2c_writereg(id->recv_count, CDNS_I2C_XFER_SIZE_OFFSET);
 	}
 
-	/* Set the slave address in address register - triggers operation */
-	cdns_i2c_writereg(CDNS_I2C_ENABLED_INTR_MASK, CDNS_I2C_IER_OFFSET);
-	cdns_i2c_writereg(id->p_msg->addr & CDNS_I2C_ADDR_MASK,
-						CDNS_I2C_ADDR_OFFSET);
 	/* Clear the bus hold flag if bytes to receive is less than FIFO size */
 	if (!id->bus_hold_flag &&
 		((id->p_msg->flags & I2C_M_RECV_LEN) != I2C_M_RECV_LEN) &&
 		(id->recv_count <= CDNS_I2C_FIFO_DEPTH))
 			cdns_i2c_clear_bus_hold(id);
+	/* Set the slave address in address register - triggers operation */
+	cdns_i2c_writereg(CDNS_I2C_ENABLED_INTR_MASK, CDNS_I2C_IER_OFFSET);
+	cdns_i2c_writereg(id->p_msg->addr & CDNS_I2C_ADDR_MASK,
+						CDNS_I2C_ADDR_OFFSET);
 }
 
 /**
-- 
2.11.0
