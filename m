From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Wed, 24 Oct 2012 19:56:51 +0900
Subject: [PATCH 1/5] i2c: i2c-sh_mobile: calculate clock parameters at driver
 probing time
In-Reply-To: <5087C93F.6080601@renesas.com>
References: <5087C93F.6080601@renesas.com>
Message-ID: <5087C973.4010305@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently SCL clock parameters (ICCH/ICCL) are calculated in
activate_ch(), which gets called every time sh_mobile_i2c_xfer() is
processed, while each I2C bus speed is system-defined and in general
those parameters do not have to be updated over I2C transactions.

The only reason I could see having it transaction-time is to adjust
ICCH/ICCL values according to the operating frequency of the I2C
hardware block, in the face of DFS (Dynamic Frequency Scaling).

However, this won't be necessary.

The operating frequency of the I2C hardware block can change _even_
in the middle of I2C transactions.  There is no way to prevent it
from happening, and I2C hardware block can work with such dynamic
frequency change, of course.

Another is that ICCH/ICCL clock parameters optimized for the faster
operating frequency, can also be applied to the slower operating
frequency, as long as slave devices work.  However, the converse is
not true.  It would violate SCL timing specs of the I2C standard.

What we can do now is to calculate the ICCH/ICCL clock parameters
according to the fastest operating clock of the I2C hardware block.
And if that's the case, that calculation should be done just once
at driver-module-init time.

This patch moves ICCH/ICCL calculating part from activate_ch() into
sh_mobile_i2c_init(), and call it from sh_mobile_i2c_probe().

Note that sh_mobile_i2c_init() just prepares clock parameters using
the clock rate and platform data provided, but does _not_ make any
hardware I/O accesses.  We don't have to care about run-time PM
maintenance here.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 8110ca4..309d0d5 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -187,18 +187,15 @@ static void iic_set_clr(struct sh_mobile_i2c_data *pd, int offs,
 	iic_wr(pd, offs, (iic_rd(pd, offs) | set) & ~clr);
 }
 
-static void activate_ch(struct sh_mobile_i2c_data *pd)
+static void sh_mobile_i2c_init(struct sh_mobile_i2c_data *pd)
 {
 	unsigned long i2c_clk;
 	u_int32_t num;
 	u_int32_t denom;
 	u_int32_t tmp;
 
-	/* Wake up device and enable clock */
-	pm_runtime_get_sync(pd->dev);
-	clk_enable(pd->clk);
-
 	/* Get clock rate after clock is enabled */
+	clk_enable(pd->clk);
 	i2c_clk = clk_get_rate(pd->clk);
 
 	/* Calculate the value for iccl. From the data sheet:
@@ -239,6 +236,15 @@ static void activate_ch(struct sh_mobile_i2c_data *pd)
 			pd->icic &= ~ICIC_ICCHB8;
 	}
 
+	clk_disable(pd->clk);
+}
+
+static void activate_ch(struct sh_mobile_i2c_data *pd)
+{
+	/* Wake up device and enable clock */
+	pm_runtime_get_sync(pd->dev);
+	clk_enable(pd->clk);
+
 	/* Enable channel and configure rx ack */
 	iic_set_clr(pd, ICCR, ICCR_ICE, 0);
 
@@ -632,6 +638,8 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 	if (size > 0x17)
 		pd->flags |= IIC_FLAG_HAS_ICIC67;
 
+	sh_mobile_i2c_init(pd);
+
 	/* Enable Runtime PM for this device.
 	 *
 	 * Also tell the Runtime PM core to ignore children
-- 
1.7.12.4
