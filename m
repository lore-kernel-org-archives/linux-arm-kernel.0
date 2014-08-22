From: addy.ke@rock-chips.com (Addy Ke)
Date: Sat, 23 Aug 2014 02:00:52 +0800
Subject: [PATCH v4] i2c: rk3x: fix bug that cause transfer fails in master
 receive mode
In-Reply-To: <1408669991-9703-1-git-send-email-addy.ke@rock-chips.com>
References: <1408669991-9703-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <1408730452-3552-1-git-send-email-addy.ke@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In rk3x SOC, the I2C controller can receive/transmit up to 32 bytes data
in one chunk, so the size of data to be write/read to/from TXDATAx/RXDATAx
must be less than or equal 32 bytes at a time.

Tested on rk3288-pinky board, elan receive 158 bytes data.

Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
Acked-by: Max Schwarz <max.schwarz@online.de>
---
Changes in v2:
- Use cleaner syntax as suggested by Sergei.
- Update commit message as suggested by Wolfram.

Changes in v3:
- fix typo: maste --> master and double spaces after 'len'
 drivers/i2c/busses/i2c-rk3x.c | 4 ++++

Changes in v4:
- remove unlikely() annotations, suggested by Dmitry Torokhov

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index b8b2b89..31de730 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -323,6 +323,10 @@ static void rk3x_i2c_handle_read(struct rk3x_i2c *i2c, unsigned int ipd)
 	/* ack interrupt */
 	i2c_writel(i2c, REG_INT_MBRF, REG_IPD);
 
+	/* Can only handle a maximum of 32 bytes at a time */
+	if (len > 32)
+		len = 32;
+
 	/* read the data from receive buffer */
 	for (i = 0; i < len; ++i) {
 		if (i % 4 == 0)
-- 
1.8.3.2
