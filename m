From: addy.ke@rock-chips.com (Addy Ke)
Date: Fri, 22 Aug 2014 05:38:27 +0800
Subject: [PATCH v2] i2c: rk3x: fix bug that cause transfer fails in maste
 receive mode
In-Reply-To: <0001-i2c-rk3x-fix-bug-that-cause-transfer-fails-in-master.patch>
References: <0001-i2c-rk3x-fix-bug-that-cause-transfer-fails-in-master.patch>
Message-ID: <1408657107-8715-1-git-send-email-addy.ke@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In rk3x SOC, the I2C controller can receive/transmit up to 32 bytes data
in one chunk, so the size of data to be write/read to/from TXDATAx/RXDATAx
must be less than or equal 32 bytes at a time.

Tested on rk3288-pinky board, elan receive 158 bytes data.

Acked-by: Max Schwarz <max.schwarz@online.de>
Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
---
Changes in v2:
- Use cleaner syntax as suggested by Sergei.
- Update commit message as suggested by Wolfram.

 drivers/i2c/busses/i2c-rk3x.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 69e1185..806724a 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -323,6 +323,10 @@ static void rk3x_i2c_handle_read(struct rk3x_i2c *i2c, unsigned int ipd)
 	/* ack interrupt */
 	i2c_writel(i2c, REG_INT_MBRF, REG_IPD);
 
+	/* Can only handle a maximum of 32 bytes at a time */
+	if (unlikely(len > 32))
+		len  = 32;
+
 	/* read the data from receive buffer */
 	for (i = 0; i < len; ++i) {
 		if (i % 4 == 0)
-- 
1.8.3.2
