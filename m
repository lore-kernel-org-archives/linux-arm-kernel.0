From: balbi@ti.com (Felipe Balbi)
Date: Mon, 5 Nov 2012 10:04:43 +0200
Subject: [PATCH v2] i2c: omap: ensure writes to dev->buf_len are ordered
In-Reply-To: <20121102085447.GE17063@arwen.pp.htv.fi>
References: <20121102085447.GE17063@arwen.pp.htv.fi>
Message-ID: <1352102683-2243-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

if we allow compiler reorder our writes, we could
fall into a situation where dev->buf_len is reset
for no apparent reason.

This bug was found with a simple script which would
transfer data to an i2c client from 1 to 1024 bytes
(a simple for loop), when we got to transfer sizes
bigger than the fifo size, dev->buf_len was reset
to zero before we had an oportunity to handle XDR
Interrupt. Because dev->buf_len was zero, we entered
omap_i2c_transmit_data() to transfer zero bytes,
which would mean we would just silently exit
omap_i2c_transmit_data() without actually writing
anything to DATA register. That would cause XDR
IRQ to trigger forever and we would never transfer
the remaining bytes.

After adding the memory barrier, we also drop resetting
dev->buf_len to zero in omap_i2c_xfer_msg() because
both omap_i2c_transmit_data() and omap_i2c_receive_data()
will act until dev->buf_len reaches zero, rendering the
other write in omap_i2c_xfer_msg() redundant.

This patch has been tested with pandaboard for a few
iterations of the script mentioned above.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

Changes since v1:
	- use barrier() instead of wmb()

Note: this version was compile-tested only

 drivers/i2c/busses/i2c-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index db31eae..ba03bec 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -521,6 +521,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	/* REVISIT: Could the STB bit of I2C_CON be used with probing? */
 	dev->buf = msg->buf;
 	dev->buf_len = msg->len;
+	barrier();
 
 	omap_i2c_write_reg(dev, OMAP_I2C_CNT_REG, dev->buf_len);
 
@@ -579,7 +580,6 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	 */
 	timeout = wait_for_completion_timeout(&dev->cmd_complete,
 						OMAP_I2C_TIMEOUT);
-	dev->buf_len = 0;
 	if (timeout == 0) {
 		dev_err(dev->dev, "controller timed out\n");
 		omap_i2c_init(dev);
-- 
1.8.0
