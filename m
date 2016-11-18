From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 18 Nov 2016 19:40:10 +0000
Subject: [PATCH 2/2] i2c: designware: fix rx fifo depth tracking
In-Reply-To: <20161118193542.GO1041@n2100.armlinux.org.uk>
References: <20161118193542.GO1041@n2100.armlinux.org.uk>
Message-ID: <E1c7p18-0000R6-4w@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When loading the TX fifo to receive bytes on the I2C bus, we incorrectly
count the number of bytes:

	rx_limit = dev->rx_fifo_depth - dw_readl(dev, DW_IC_RXFLR);

	while (buf_len > 0 && tx_limit > 0 && rx_limit > 0) {
		if (rx_limit - dev->rx_outstanding <= 0)
			break;
		rx_limit--;
		dev->rx_outstanding++;
	}

DW_IC_RXFLR indicates how many bytes are available to be read in the
FIFO, dev->rx_fifo_depth is the FIFO size, and dev->rx_outstanding is
the number of bytes that we've requested to be read so far, but which
have not been read.

Firstly, increasing dev->rx_outstanding and decreasing rx_limit and then
comparing them results in each byte consuming "two" bytes in this
tracking, so this is obviously wrong.

Secondly, the number of bytes that _could_ be received into the FIFO at
any time is the number of bytes we have so far requested but not yet
read from the FIFO - in other words dev->rx_outstanding.

So, in order to request enough bytes to fill the RX FIFO, we need to
request dev->rx_fifo_depth - dev->rx_outstanding bytes.

Modifying the code thusly results in us reaching the maximum number of
bytes outstanding each time we queue more "receive" operations, provided
the transfer allows that to happen.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
With this applied, I now get:

[    1.726388] i2c_designware 7ffa0000.i2c: transfer terminated early - interrupt latency too high?
[    1.733813] tda998x 0-0070: Error -5 reading from 0x900
[    1.737708] tda998x 0-0070: failed to read edid block 0: -5
[    1.743683] tda998x 0-0070: failed to read EDID

which is a more graceful failure than letting DRM detect the bad
transfer by checking the EDID checksum and hoping that the untransferred
bytes don't result in the EDID checksum succeeding.

 drivers/i2c/busses/i2c-designware-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 11e866d05368..9703fe392543 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -611,7 +611,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 			if (msgs[dev->msg_write_idx].flags & I2C_M_RD) {
 
 				/* avoid rx buffer overrun */
-				if (rx_limit - dev->rx_outstanding <= 0)
+				if (dev->rx_outstanding >= dev->rx_fifo_depth)
 					break;
 
 				dw_writel(dev, cmd | 0x100, DW_IC_DATA_CMD);
-- 
2.7.4
