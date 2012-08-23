From: hachimi.samir@gmail.com (hachimi.samir at gmail.com)
Date: Thu, 23 Aug 2012 17:32:39 +0200
Subject: [PATCH 2/2] imx6q: Set pwm control register during enable and config
 call
In-Reply-To: <[PATCH 0/2] imx6q: pwm: Activate stop_mode and remove auto
 enable after configuration>
References: <[PATCH 0/2] imx6q: pwm: Activate stop_mode and remove auto enable
 after configuration>
Message-ID: <1345735959-12964-3-git-send-email-hachimi.samir@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Samir Hachimi <hachimi.samir@gmail.com>

Bind pwm node with driver.
Activate stop_enable mode when imx_pwm_config and set enable bit in pwm
CR register during imx_pwm_enable.

Signed-off-by: Samir Hachimi <shachimi@adeneo-embedded.com>
---
 arch/arm/boot/dts/imx6q.dtsi  |    8 ++++++++
 arch/arm/mach-imx/clk-imx6q.c |    4 ++++
 drivers/pwm/pwm-imx.c         |   34 +++++++++++++++++++++++-----------
 3 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index c913b99..7ce9dc1 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -248,6 +248,8 @@
 			};
 
 			pwm at 02080000 { /* PWM1 */
+				compatible = "fsl,imx6q-pwm";
+				#pwm-cells = <2>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_pwm1_1>;
 				reg = <0x02080000 0x4000>;
@@ -256,6 +258,8 @@
 			};
 
 			pwm at 02084000 { /* PWM2 */
+				compatible = "fsl,imx6q-pwm";
+				#pwm-cells = <2>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_pwm2_1>;
 				reg = <0x02084000 0x4000>;
@@ -264,6 +268,8 @@
 			};
 
 			pwm at 02088000 { /* PWM3 */
+				compatible = "fsl,imx6q-pwm";
+				#pwm-cells = <2>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_pwm3_1>;
 				reg = <0x02088000 0x4000>;
@@ -272,6 +278,8 @@
 			};
 
 			pwm at 0208c000 { /* PWM4 */
+				compatible = "fsl,imx6q-pwm";
+				#pwm-cells = <2>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_pwm4_1>;
 				reg = <0x0208c000 0x4000>;
diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index ea89520..057740b 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -430,6 +430,10 @@ int __init mx6q_clocks_init(void)
 	clk_register_clkdev(clk[ecspi3], NULL, "2010000.ecspi");
 	clk_register_clkdev(clk[ecspi4], NULL, "2014000.ecspi");
 	clk_register_clkdev(clk[ecspi5], NULL, "2018000.ecspi");
+	clk_register_clkdev(clk[pwm1], "pwm", "2080000.pwm");
+	clk_register_clkdev(clk[pwm2], "pwm", "2084000.pwm");
+	clk_register_clkdev(clk[pwm3], "pwm", "2088000.pwm");
+	clk_register_clkdev(clk[pwm4], "pwm", "208c000.pwm");
 	clk_register_clkdev(clk[sdma], NULL, "20ec000.sdma");
 	clk_register_clkdev(clk[dummy], NULL, "20bc000.wdog");
 	clk_register_clkdev(clk[dummy], NULL, "20c0000.wdog");
diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 2a0b353..0b13f34 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -32,6 +33,7 @@
 #define MX3_PWMSAR                0x0C    /* PWM Sample Register */
 #define MX3_PWMPR                 0x10    /* PWM Period Register */
 #define MX3_PWMCR_PRESCALER(x)    (((x - 1) & 0xFFF) << 4)
+#define MX3_PWMCR_STOPEN		(1 << 25)
 #define MX3_PWMCR_DOZEEN                (1 << 24)
 #define MX3_PWMCR_WAITEN                (1 << 23)
 #define MX3_PWMCR_DBGEN			(1 << 22)
@@ -68,25 +70,21 @@ static int imx_pwm_config(struct pwm_chip *chip,
 		prescale = period_cycles / 0x10000 + 1;
 
 		period_cycles /= prescale;
-		c = (unsigned long long)period_cycles * duty_ns;
-		do_div(c, period_ns);
-		duty_cycles = c;
 
-		/*
-		 * according to imx pwm RM, the real period value should be
-		 * PERIOD value in PWMPR plus 2.
+		/* the chip documentation says the counter counts up to
+		 * period_cycles + 1 and then is reset to 0, so the
+		 *  actual period of the PWM wave is period_cycles + 2
 		 */
-		if (period_cycles > 2)
-			period_cycles -= 2;
-		else
-			period_cycles = 0;
+		c = (unsigned long long)(period_cycles + 2) * duty_ns;
+		do_div(c, period_ns);
+		duty_cycles = c;
 
 		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
 		writel(period_cycles, imx->mmio_base + MX3_PWMPR);
 
 		cr = MX3_PWMCR_PRESCALER(prescale) |
 			MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
-			MX3_PWMCR_DBGEN | MX3_PWMCR_EN;
+			MX3_PWMCR_DBGEN | MX3_PWMCR_STOPEN;
 
 		if (cpu_is_mx25())
 			cr |= MX3_PWMCR_CLKSRC_IPG;
@@ -124,6 +122,7 @@ static int imx_pwm_config(struct pwm_chip *chip,
 static int imx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct imx_chip *imx = to_imx_chip(chip);
+	unsigned long reg;
 	int rc = 0;
 
 	if (!imx->clk_enabled) {
@@ -131,6 +130,11 @@ static int imx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 		if (!rc)
 			imx->clk_enabled = 1;
 	}
+
+	reg = readl(imx->mmio_base + MX3_PWMCR);
+	reg |= MX3_PWMCR_EN;
+	writel(reg, imx->mmio_base + MX3_PWMCR);
+
 	return rc;
 }
 
@@ -206,9 +212,15 @@ static int __devexit imx_pwm_remove(struct platform_device *pdev)
 	return pwmchip_remove(&imx->chip);
 }
 
+static const struct of_device_id mxc_pwm_dt_ids[] = {
+	{ .compatible = "fsl,imx6q-pwm", },
+	{ /* sentinel */ }
+};
+
 static struct platform_driver imx_pwm_driver = {
 	.driver		= {
 		.name	= "mxc_pwm",
+		.of_match_table = of_match_ptr(mxc_pwm_dt_ids),
 	},
 	.probe		= imx_pwm_probe,
 	.remove		= __devexit_p(imx_pwm_remove),
-- 
1.7.1
