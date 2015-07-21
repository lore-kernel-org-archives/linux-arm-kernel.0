From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Tue, 21 Jul 2015 18:11:06 +0530
Subject: [PATCH-v5 5/5] i2c: pxa: Add ILCR (tLow & tHigh) configuration support
In-Reply-To: <1437482466-16126-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1437482466-16126-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1437482466-16126-6-git-send-email-vaibhav.hiremath@linaro.org>
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

Also, brought up devm_clk_get() fn above i2c_pxa_probe_dt(), as it
uses clk rate for timing calculations.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
Signed-off-by: Yi Zhang <yizhang@marvell.com>
---
 drivers/i2c/busses/i2c-pxa.c | 69 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 8d76197..6012ae5 100644
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
@@ -507,6 +510,36 @@ static void i2c_pxa_set_slave(struct pxa_i2c *i2c, int errcode)
 #define i2c_pxa_set_slave(i2c, err)	do { } while (0)
 #endif
 
+static void i2c_pxa_do_sclk_adj(struct pxa_i2c *i2c)
+{
+	unsigned int reg_ilcr;
+
+	if (!i2c->reg_ilcr)
+		return;
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
@@ -526,6 +559,8 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
 	writel(I2C_ICR_INIT | (i2c->fast_mode ? ICR_FM : 0), _ICR(i2c));
 	writel(readl(_ICR(i2c)) | (i2c->high_mode ? ICR_HS : 0), _ICR(i2c));
 
+	i2c_pxa_do_sclk_adj(i2c);
+
 #ifdef CONFIG_I2C_PXA_SLAVE
 	dev_info(&i2c->adap.dev, "Enabling slave mode\n");
 	writel(readl(_ICR(i2c)) | ICR_SADIE | ICR_ALDIE | ICR_SSDIE, _ICR(i2c));
@@ -1198,6 +1233,26 @@ static int i2c_pxa_probe_dt(struct platform_device *pdev, struct pxa_i2c *i2c,
 
 	*i2c_types = (enum pxa_i2c_types)(of_id->data);
 
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
 
@@ -1248,6 +1303,14 @@ static int i2c_pxa_probe(struct platform_device *dev)
 		return irq;
 	}
 
+	i2c->clk = devm_clk_get(&dev->dev, NULL);
+	if (IS_ERR(i2c->clk)) {
+		dev_err(&dev->dev, "failed to get the clk: %ld\n", PTR_ERR(i2c->clk));
+		return PTR_ERR(i2c->clk);
+	}
+
+	i2c->rate = clk_get_rate(i2c->clk);
+
 	/* Default adapter num to device id; i2c_pxa_probe_dt can override. */
 	i2c->adap.nr = dev->id;
 
@@ -1265,12 +1328,6 @@ static int i2c_pxa_probe(struct platform_device *dev)
 
 	strlcpy(i2c->adap.name, "pxa_i2c-i2c", sizeof(i2c->adap.name));
 
-	i2c->clk = devm_clk_get(&dev->dev, NULL);
-	if (IS_ERR(i2c->clk)) {
-		dev_err(&dev->dev, "failed to get the clk: %ld\n", PTR_ERR(i2c->clk));
-		return PTR_ERR(i2c->clk);
-	}
-
 	i2c->reg_ibmr = i2c->reg_base + pxa_reg_layout[i2c_type].ibmr;
 	i2c->reg_idbr = i2c->reg_base + pxa_reg_layout[i2c_type].idbr;
 	i2c->reg_icr = i2c->reg_base + pxa_reg_layout[i2c_type].icr;
-- 
1.9.1
