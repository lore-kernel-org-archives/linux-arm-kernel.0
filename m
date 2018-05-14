From: peda@axentia.se (Peter Rosin)
Date: Mon, 14 May 2018 16:53:13 +0200
Subject: [PATCH 04/21] i2c: aspeed: make use of i2c_8bit_addr_from_msg
In-Reply-To: <20180514145330.4857-1-peda@axentia.se>
References: <20180514145330.4857-1-peda@axentia.se>
Message-ID: <20180514145330.4857-5-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because it looks neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-aspeed.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 7d4aeb4465b3..60e4d0e939a3 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -335,13 +335,12 @@ static void aspeed_i2c_do_start(struct aspeed_i2c_bus *bus)
 {
 	u32 command = ASPEED_I2CD_M_START_CMD | ASPEED_I2CD_M_TX_CMD;
 	struct i2c_msg *msg = &bus->msgs[bus->msgs_index];
-	u8 slave_addr = msg->addr << 1;
+	u8 slave_addr = i2c_8bit_addr_from_msg(msg);
 
 	bus->master_state = ASPEED_I2C_MASTER_START;
 	bus->buf_index = 0;
 
 	if (msg->flags & I2C_M_RD) {
-		slave_addr |= 1;
 		command |= ASPEED_I2CD_M_RX_CMD;
 		/* Need to let the hardware know to NACK after RX. */
 		if (msg->len == 1 && !(msg->flags & I2C_M_RECV_LEN))
-- 
2.11.0
