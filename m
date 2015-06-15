From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Mon, 15 Jun 2015 21:19:58 +0530
Subject: [PATCH-V2 11/12] i2c: pxa: Add ILCR (tLow & tHigh) configuration
 support
In-Reply-To: <1434383399-2370-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <vaibhav.hiremath@linaro.org>
 <1434383399-2370-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1434383399-2370-12-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With addition of PXA910 family of devices, the TWSI module supports
SCL clock adjustment using ILCR register.

This patch enables the control and configuration of ICLR through DT
properties,

i2c-sclk-high-time-ns:
  SCLK high time (tHigh), for standard/fast/high speed mode
i2c-sclk-low-time-ns:
  SCLK low time (tLow), for standard/fast/high speed mode

Note that in case of standard and fast mod, the tLow and tHigh counters
are same, and software will use tLow value.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
Signed-off-by: Yi Zhang <yizhang@marvell.com>
---
 drivers/i2c/busses/i2c-pxa.c | 66 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 97f9c7c..03b70f8 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -195,6 +195,9 @@ struct pxa_i2c {
 	unsigned long		rate;
 	bool			highmode_enter;
 	bool			disable_after_xfer;
+
+	unsigned int		sclk_thigh_load_cnt;
+	unsigned int		sclk_tlow_load_cnt;
 };
 
 #define _IBMR(i2c)	((i2c)->reg_ibmr)
@@ -507,6 +510,33 @@ static void i2c_pxa_set_slave(struct pxa_i2c *i2c, int errcode)
 #define i2c_pxa_set_slave(i2c, err)	do { } while (0)
 #endif
 
+static void i2c_pxa_do_sclk_adj(struct pxa_i2c *i2c)
+{
+	unsigned int reg_ilcr;
+
+	reg_ilcr = readl(_ILCR(i2c));
+
+	/* For standard/fast mode tlow and thigh counters are same */
+	if (i2c->sclk_tlow_load_cnt) {
+		unsigned int mask, shift;
+
+		mask = i2c->high_mode ? ILCR_HLVL_MASK :
+			i2c->fast_mode ? ILCR_FLV_MASK : ILCR_SLV_MASK;
+		shift = i2c->high_mode ? ILCR_HLVL_SHIFT :
+			i2c->fast_mode ? ILCR_FLV_SHIFT : ILCR_SLV_SHIFT;
+
+		reg_ilcr &= ~mask;
+		reg_ilcr |= i2c->sclk_tlow_load_cnt << shift;
+	}
+
+	if (i2c->high_mode && i2c->sclk_thigh_load_cnt) {
+		reg_ilcr &= ~ILCR_HLVH_MASK;
+		reg_ilcr |= i2c->sclk_thigh_load_cnt << ILCR_HLVH_SHIFT;
+	}
+
+	writel(reg_ilcr, _ILCR(i2c));
+}
+
 static void i2c_pxa_reset(struct pxa_i2c *i2c)
 {
 	pr_debug("Resetting I2C Controller Unit\n");
@@ -526,6 +556,8 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
 	writel(I2C_ICR_INIT | (i2c->fast_mode ? ICR_FM : 0), _ICR(i2c));
 	writel(readl(_ICR(i2c)) | (i2c->high_mode ? ICR_HS : 0), _ICR(i2c));
 
+	i2c_pxa_do_sclk_adj(i2c);
+
 #ifdef CONFIG_I2C_PXA_SLAVE
 	dev_info(&i2c->adap.dev, "Enabling slave mode\n");
 	writel(readl(_ICR(i2c)) | ICR_SADIE | ICR_ALDIE | ICR_SSDIE, _ICR(i2c));
@@ -1204,6 +1236,26 @@ static int i2c_pxa_probe_dt(struct platform_device *pdev, struct pxa_i2c *i2c,
 
 	*i2c_types = (long)(of_id->data);
 
+	/* optional properties */
+	if (of_device_is_compatible(np, "mrvl,mmp-twsi")) {
+		unsigned int tlow = 0, thigh = 0;
+		unsigned int clk_ns;
+
+		/* clock time in nsec */
+		clk_ns = 1000000 / (i2c->rate / 1000);
+
+		of_property_read_u32(np, "i2c-sclk-high-time-ns", &thigh);
+		i2c->sclk_thigh_load_cnt = thigh / clk_ns;
+
+		of_property_read_u32(np, "i2c-sclk-low-time-ns", &tlow);
+		i2c->sclk_tlow_load_cnt = tlow / clk_ns;
+
+		/* For std/fast mode tlow & thigh have same bit-fields */
+		if (!i2c->high_mode &&
+			(i2c->sclk_tlow_load_cnt != i2c->sclk_thigh_load_cnt))
+			dev_warn(&i2c->adap.dev,
+				"mismatch of tLow & tHigh values, using tLow\n");
+	}
 	return 0;
 }
 
@@ -1253,6 +1305,14 @@ static int i2c_pxa_probe(struct platform_device *dev)
 		return irq;
 	}
 
+	i2c->clk = devm_clk_get(&dev->dev, NULL);
+	if (IS_ERR(i2c->clk)) {
+		dev_err(&dev->dev, "failed to get the clk\n");
+		return PTR_ERR(i2c->clk);
+	}
+
+	i2c->rate = clk_get_rate(i2c->clk);
+
 	/* Default adapter num to device id; i2c_pxa_probe_dt can override. */
 	i2c->adap.nr = dev->id;
 
@@ -1270,12 +1330,6 @@ static int i2c_pxa_probe(struct platform_device *dev)
 
 	strlcpy(i2c->adap.name, "pxa_i2c-i2c", sizeof(i2c->adap.name));
 
-	i2c->clk = devm_clk_get(&dev->dev, NULL);
-	if (IS_ERR(i2c->clk)) {
-		dev_err(&dev->dev, "failed to get the clk\n");
-		return PTR_ERR(i2c->clk);
-	}
-
 	i2c->reg_base = devm_ioremap_resource(&dev->dev, res);
 	if (IS_ERR(i2c->reg_base)) {
 		dev_err(&dev->dev, "failed to map resource: %ld\n",
-- 
1.9.1
