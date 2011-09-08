From: eric.miao@linaro.org (Eric Miao)
Date: Thu,  8 Sep 2011 16:22:22 -0700
Subject: [PATCH] ARM: imx: move pwm driver to use platform device id table
Message-ID: <1315524142-10566-1-git-send-email-eric.miao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.miao@linaro.org>
---
 arch/arm/mach-imx/clock-imx25.c              |    8 ++++----
 arch/arm/mach-imx/clock-imx27.c              |    2 +-
 arch/arm/mach-imx/devices-imx25.h            |    2 +-
 arch/arm/mach-mx5/clock-mx51-mx53.c          |    4 ++--
 arch/arm/mach-mx5/devices-imx51.h            |    2 +-
 arch/arm/plat-mxc/devices/platform-mxc_pwm.c |    4 ++--
 arch/arm/plat-mxc/pwm.c                      |   19 ++++++++++++++++---
 7 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-imx/clock-imx25.c b/arch/arm/mach-imx/clock-imx25.c
index b0fec74c..249f1be 100644
--- a/arch/arm/mach-imx/clock-imx25.c
+++ b/arch/arm/mach-imx/clock-imx25.c
@@ -288,10 +288,10 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("imx35-cspi.0", NULL, cspi1_clk)
 	_REGISTER_CLOCK("imx35-cspi.1", NULL, cspi2_clk)
 	_REGISTER_CLOCK("imx35-cspi.2", NULL, cspi3_clk)
-	_REGISTER_CLOCK("mxc_pwm.0", NULL, pwm1_clk)
-	_REGISTER_CLOCK("mxc_pwm.1", NULL, pwm2_clk)
-	_REGISTER_CLOCK("mxc_pwm.2", NULL, pwm3_clk)
-	_REGISTER_CLOCK("mxc_pwm.3", NULL, pwm4_clk)
+	_REGISTER_CLOCK("imx25-pwm.0", NULL, pwm1_clk)
+	_REGISTER_CLOCK("imx25-pwm.1", NULL, pwm2_clk)
+	_REGISTER_CLOCK("imx25-pwm.2", NULL, pwm3_clk)
+	_REGISTER_CLOCK("imx25-pwm.3", NULL, pwm4_clk)
 	_REGISTER_CLOCK("imx-keypad", NULL, kpp_clk)
 	_REGISTER_CLOCK("mx25-adc", NULL, tsc_clk)
 	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c_clk)
diff --git a/arch/arm/mach-imx/clock-imx27.c b/arch/arm/mach-imx/clock-imx27.c
index 88fe00a..3ee46ad 100644
--- a/arch/arm/mach-imx/clock-imx27.c
+++ b/arch/arm/mach-imx/clock-imx27.c
@@ -637,7 +637,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "gpt4", gpt4_clk)
 	_REGISTER_CLOCK(NULL, "gpt5", gpt5_clk)
 	_REGISTER_CLOCK(NULL, "gpt6", gpt6_clk)
-	_REGISTER_CLOCK("mxc_pwm.0", NULL, pwm_clk)
+	_REGISTER_CLOCK("imx25-pwm.0", NULL, pwm_clk)
 	_REGISTER_CLOCK("mxc-mmc.0", NULL, sdhc1_clk)
 	_REGISTER_CLOCK("mxc-mmc.1", NULL, sdhc2_clk)
 	_REGISTER_CLOCK("mxc-mmc.2", NULL, sdhc3_clk)
diff --git a/arch/arm/mach-imx/devices-imx25.h b/arch/arm/mach-imx/devices-imx25.h
index efa0761..fe09a17 100644
--- a/arch/arm/mach-imx/devices-imx25.h
+++ b/arch/arm/mach-imx/devices-imx25.h
@@ -87,4 +87,4 @@ extern const struct imx_spi_imx_data imx25_cspi_data[];
 
 extern struct imx_mxc_pwm_data imx25_mxc_pwm_data[];
 #define imx25_add_mxc_pwm(id)	\
-	imx_add_mxc_pwm(&imx25_mxc_pwm_data[id])
+	imx_add_mxc_pwm("imx25-pwm", &imx25_mxc_pwm_data[id])
diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index afecd78ce..1a95cf7 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1437,8 +1437,8 @@ static struct clk_lookup mx51_lookups[] = {
 	_REGISTER_CLOCK(NULL, "gpt", gpt_clk)
 	/* i.mx51 has the i.mx27 type fec */
 	_REGISTER_CLOCK("imx27-fec.0", NULL, fec_clk)
-	_REGISTER_CLOCK("mxc_pwm.0", "pwm", pwm1_clk)
-	_REGISTER_CLOCK("mxc_pwm.1", "pwm", pwm2_clk)
+	_REGISTER_CLOCK("imx51-pwm.0", "pwm", pwm1_clk)
+	_REGISTER_CLOCK("imx51-pwm.1", "pwm", pwm2_clk)
 	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c1_clk)
 	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c2_clk)
 	_REGISTER_CLOCK("imx-i2c.2", NULL, hsi2c_clk)
diff --git a/arch/arm/mach-mx5/devices-imx51.h b/arch/arm/mach-mx5/devices-imx51.h
index 89fe77f..1760810 100644
--- a/arch/arm/mach-mx5/devices-imx51.h
+++ b/arch/arm/mach-mx5/devices-imx51.h
@@ -47,7 +47,7 @@ extern const struct imx_imx2_wdt_data imx51_imx2_wdt_data[];
 
 extern const struct imx_mxc_pwm_data imx51_mxc_pwm_data[];
 #define imx51_add_mxc_pwm(id)	\
-	imx_add_mxc_pwm(&imx51_mxc_pwm_data[id])
+	imx_add_mxc_pwm("imx51-pwm", &imx51_mxc_pwm_data[id])
 
 extern const struct imx_imx_keypad_data imx51_imx_keypad_data;
 #define imx51_add_imx_keypad(pdata)	\
diff --git a/arch/arm/plat-mxc/devices/platform-mxc_pwm.c b/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
index b0c4ae2..e51bbd2 100644
--- a/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
+++ b/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
@@ -49,7 +49,7 @@ const struct imx_mxc_pwm_data imx51_mxc_pwm_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_SOC_IMX51 */
 
-struct platform_device *__init imx_add_mxc_pwm(
+struct platform_device *__init imx_add_mxc_pwm(const char *name,
 		const struct imx_mxc_pwm_data *data)
 {
 	struct resource res[] = {
@@ -64,6 +64,6 @@ struct platform_device *__init imx_add_mxc_pwm(
 		},
 	};
 
-	return imx_add_platform_device("mxc_pwm", data->id,
+	return imx_add_platform_device(name, data->id,
 			res, ARRAY_SIZE(res), NULL, 0);
 }
diff --git a/arch/arm/plat-mxc/pwm.c b/arch/arm/plat-mxc/pwm.c
index 42d74ea..96c9f91 100644
--- a/arch/arm/plat-mxc/pwm.c
+++ b/arch/arm/plat-mxc/pwm.c
@@ -36,7 +36,10 @@
 #define MX3_PWMCR_CLKSRC_IPG      (1 << 16)
 #define MX3_PWMCR_EN              (1 << 0)
 
-
+enum {
+	PWM_TYPE_MX1,
+	PWM_TYPE_MX3,
+};
 
 struct pwm_device {
 	struct list_head	node;
@@ -50,6 +53,7 @@ struct pwm_device {
 
 	unsigned int	use_count;
 	unsigned int	pwm_id;
+	int		type;
 };
 
 int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
@@ -57,7 +61,7 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 	if (pwm == NULL || period_ns == 0 || duty_ns > period_ns)
 		return -EINVAL;
 
-	if (!(cpu_is_mx1() || cpu_is_mx21())) {
+	if (pwm->type == PWM_TYPE_MX3) {
 		unsigned long long c;
 		unsigned long period_cycles, duty_cycles, prescale;
 		u32 cr;
@@ -85,7 +89,9 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 			cr |= MX3_PWMCR_CLKSRC_IPG_HIGH;
 
 		writel(cr, pwm->mmio_base + MX3_PWMCR);
-	} else if (cpu_is_mx1() || cpu_is_mx21()) {
+	}
+
+	if (pwm->type == PWM_TYPE_MX1) {
 		/* The PWM subsystem allows for exact frequencies. However,
 		 * I cannot connect a scope on my device to the PWM line and
 		 * thus cannot provide the program the PWM controller
@@ -268,10 +274,17 @@ static int __devexit mxc_pwm_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct platform_device_id mxc_pwm_ids[] = {
+	{ "imx25-pwm", PWM_TYPE_MX3 },
+	{ "imx51-pwm", PWM_TYPE_MX3 },
+	{ },
+};
+
 static struct platform_driver mxc_pwm_driver = {
 	.driver		= {
 		.name	= "mxc_pwm",
 	},
+	.id_table	= mxc_pwm_ids,
 	.probe		= mxc_pwm_probe,
 	.remove		= __devexit_p(mxc_pwm_remove),
 };
-- 
1.7.4.1
