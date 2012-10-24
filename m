From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Wed, 24 Oct 2012 19:58:10 +0900
Subject: [PATCH 4/5] i2c: i2c-sh_mobile: support I2C hardware block with a
 faster operating clock
In-Reply-To: <5087C93F.6080601@renesas.com>
References: <5087C93F.6080601@renesas.com>
Message-ID: <5087C9C2.7010000@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On newer SH-/R-Mobile SoCs, a clock supply to the I2C hardware block,
which is used to generate the SCL clock output, is getting faster than
before, while on the other hand, the SCL clock control registers, ICCH
and ICCL, stay unchanged in 9-bit-wide (8+1).

On such silicons, the internal SCL clock counter gets incremented every
2 clocks of the operating clock.

This patch makes it configurable through platform data.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 5 +++++
 include/linux/i2c/i2c-sh_mobile.h  | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 4dc0cc3..4c28358 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -120,6 +120,7 @@ struct sh_mobile_i2c_data {
 	void __iomem *reg;
 	struct i2c_adapter adap;
 	unsigned long bus_speed;
+	unsigned int clks_per_count;
 	struct clk *clk;
 	u_int8_t icic;
 	u_int8_t flags;
@@ -231,6 +232,7 @@ static void sh_mobile_i2c_init(struct sh_mobile_i2c_data *pd)
 	/* Get clock rate after clock is enabled */
 	clk_enable(pd->clk);
 	i2c_clk_khz = clk_get_rate(pd->clk) / 1000;
+	i2c_clk_khz /= pd->clks_per_count;
 
 	if (pd->bus_speed == STANDARD_MODE) {
 		tLOW	= 47;	/* tLOW = 4.7 us */
@@ -658,6 +660,9 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 	pd->bus_speed = STANDARD_MODE;
 	if (pdata && pdata->bus_speed)
 		pd->bus_speed = pdata->bus_speed;
+	pd->clks_per_count = 1;
+	if (pdata && pdata->clks_per_count)
+		pd->clks_per_count = pdata->clks_per_count;
 
 	/* The IIC blocks on SH-Mobile ARM processors
 	 * come with two new bits in ICIC.
diff --git a/include/linux/i2c/i2c-sh_mobile.h b/include/linux/i2c/i2c-sh_mobile.h
index beda708..06e3089 100644
--- a/include/linux/i2c/i2c-sh_mobile.h
+++ b/include/linux/i2c/i2c-sh_mobile.h
@@ -5,6 +5,7 @@
 
 struct i2c_sh_mobile_platform_data {
 	unsigned long bus_speed;
+	unsigned int clks_per_count;
 };
 
 #endif /* __I2C_SH_MOBILE_H__ */
-- 
1.7.12.4
