From: weitway@gmail.com (weitway at gmail.com)
Date: Wed, 13 Apr 2011 23:53:35 +0800
Subject: [PATCH 6/7] ARM i.MX53: add pwm devices support
In-Reply-To: <1302710016-3569-1-git-send-email-weitway@gmail.com>
References: <1302710016-3569-1-git-send-email-weitway@gmail.com>
Message-ID: <1302710016-3569-6-git-send-email-weitway@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jason Chen <b02280@freescale.com>

Signed-off-by: Jason Chen <b02280@freescale.com>
---
 arch/arm/mach-mx5/clock-mx51-mx53.c          |    6 ++++--
 arch/arm/mach-mx5/devices-imx53.h            |    4 ++++
 arch/arm/plat-mxc/devices/platform-mxc_pwm.c |   13 +++++++++----
 arch/arm/plat-mxc/pwm.c                      |    3 ++-
 4 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 213ec33..2d22031 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1410,8 +1410,8 @@ static struct clk_lookup mx51_lookups[] = {
 	_REGISTER_CLOCK("imx-uart.2", NULL, uart3_clk)
 	_REGISTER_CLOCK(NULL, "gpt", gpt_clk)
 	_REGISTER_CLOCK("fec.0", NULL, fec_clk)
-	_REGISTER_CLOCK("mxc_pwm.0", "pwm", pwm1_clk)
-	_REGISTER_CLOCK("mxc_pwm.1", "pwm", pwm2_clk)
+	_REGISTER_CLOCK("mxc_pwm.0", NULL, pwm1_clk)
+	_REGISTER_CLOCK("mxc_pwm.1", NULL, pwm2_clk)
 	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c1_clk)
 	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c2_clk)
 	_REGISTER_CLOCK("imx-i2c.2", NULL, hsi2c_clk)
@@ -1468,6 +1468,8 @@ static struct clk_lookup mx53_lookups[] = {
 	_REGISTER_CLOCK("imx53-cspi.0", NULL, cspi_clk)
 	_REGISTER_CLOCK("imx2-wdt.0", NULL, dummy_clk)
 	_REGISTER_CLOCK("imx2-wdt.1", NULL, dummy_clk)
+	_REGISTER_CLOCK("mxc_pwm.0", NULL, pwm1_clk)
+	_REGISTER_CLOCK("mxc_pwm.1", NULL, pwm2_clk)
 	_REGISTER_CLOCK("imx-ipuv3", NULL, ipu_clk)
 	_REGISTER_CLOCK("imx-ipuv3", "di0", ipu_di0_clk)
 	_REGISTER_CLOCK("imx-ipuv3", "di1", ipu_di1_clk)
diff --git a/arch/arm/mach-mx5/devices-imx53.h b/arch/arm/mach-mx5/devices-imx53.h
index 8049039..fd591ff 100644
--- a/arch/arm/mach-mx5/devices-imx53.h
+++ b/arch/arm/mach-mx5/devices-imx53.h
@@ -34,6 +34,10 @@ extern const struct imx_imx2_wdt_data imx53_imx2_wdt_data[] __initconst;
 #define imx53_add_imx2_wdt(id, pdata)	\
 	imx_add_imx2_wdt(&imx53_imx2_wdt_data[id])
 
+extern const struct imx_mxc_pwm_data imx53_mxc_pwm_data[] __initconst;
+#define imx53_add_mxc_pwm(id)	\
+	imx_add_mxc_pwm(&imx53_mxc_pwm_data[id])
+
 extern const struct imx_ipuv3_data imx53_ipuv3_data __initconst;
 #define imx53_add_ipuv3(pdata)	\
 	imx_add_ipuv3(&imx53_ipuv3_data, pdata)
diff --git a/arch/arm/plat-mxc/devices/platform-mxc_pwm.c b/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
index b0c4ae2..e610c5b 100644
--- a/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
+++ b/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
@@ -42,13 +42,18 @@ const struct imx_mxc_pwm_data imx27_mxc_pwm_data __initconst =
 
 #ifdef CONFIG_SOC_IMX51
 const struct imx_mxc_pwm_data imx51_mxc_pwm_data[] __initconst = {
-#define imx51_mxc_pwm_data_entry(_id, _hwid)				\
-	imx_mxc_pwm_data_entry(MX51, _id, _hwid, SZ_16K)
-	imx51_mxc_pwm_data_entry(0, 1),
-	imx51_mxc_pwm_data_entry(1, 2),
+	imx_mxc_pwm_data_entry(MX51, 0, 1, SZ_16K),
+	imx_mxc_pwm_data_entry(MX51, 1, 2, SZ_16K),
 };
 #endif /* ifdef CONFIG_SOC_IMX51 */
 
+#ifdef CONFIG_SOC_IMX53
+const struct imx_mxc_pwm_data imx53_mxc_pwm_data[] __initconst = {
+	imx_mxc_pwm_data_entry(MX53, 0, 1, SZ_16K),
+	imx_mxc_pwm_data_entry(MX53, 1, 2, SZ_16K),
+};
+#endif /* ifdef CONFIG_SOC_IMX53 */
+
 struct platform_device *__init imx_add_mxc_pwm(
 		const struct imx_mxc_pwm_data *data)
 {
diff --git a/arch/arm/plat-mxc/pwm.c b/arch/arm/plat-mxc/pwm.c
index 7a61ef8..5230413 100644
--- a/arch/arm/plat-mxc/pwm.c
+++ b/arch/arm/plat-mxc/pwm.c
@@ -57,7 +57,8 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 	if (pwm == NULL || period_ns == 0 || duty_ns > period_ns)
 		return -EINVAL;
 
-	if (cpu_is_mx27() || cpu_is_mx3() || cpu_is_mx25() || cpu_is_mx51()) {
+	if (cpu_is_mx27() || cpu_is_mx3() || cpu_is_mx25() || cpu_is_mx51()
+		|| cpu_is_mx53()) {
 		unsigned long long c;
 		unsigned long period_cycles, duty_cycles, prescale;
 		u32 cr;
-- 
1.7.1
