From: jason.chen@freescale.com (jason.chen at freescale.com)
Date: Tue, 30 Aug 2011 18:11:32 +0800
Subject: [PATCH-V2 1/2] ARM imx53: add pwm devices support
Message-ID: <1314699093-30276-1-git-send-email-jason.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jason Chen <b02280@freescale.com>

Signed-off-by: Jason Chen <b02280@freescale.com>
Signed-off-by: Jason Chen <jason.chen@linaro.org>
---
 arch/arm/mach-mx5/clock-mx51-mx53.c          |    2 ++
 arch/arm/mach-mx5/devices-imx53.h            |    4 ++++
 arch/arm/plat-mxc/devices/platform-mxc_pwm.c |    9 +++++++++
 arch/arm/plat-mxc/pwm.c                      |    3 ++-
 4 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index f7bf996..f5f116f 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1507,6 +1507,8 @@ static struct clk_lookup mx53_lookups[] = {
 	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
 	_REGISTER_CLOCK("imx-ssi.2", NULL, ssi3_clk)
 	_REGISTER_CLOCK("imx-keypad", NULL, dummy_clk)
+	_REGISTER_CLOCK("mxc_pwm.0", NULL, pwm1_clk)
+	_REGISTER_CLOCK("mxc_pwm.1", NULL, pwm2_clk)
 };
 
 static void clk_tree_init(void)
diff --git a/arch/arm/mach-mx5/devices-imx53.h b/arch/arm/mach-mx5/devices-imx53.h
index c27fe8b..258e68f 100644
--- a/arch/arm/mach-mx5/devices-imx53.h
+++ b/arch/arm/mach-mx5/devices-imx53.h
@@ -40,3 +40,7 @@ extern const struct imx_imx_ssi_data imx53_imx_ssi_data[];
 extern const struct imx_imx_keypad_data imx53_imx_keypad_data;
 #define imx53_add_imx_keypad(pdata)	\
 	imx_add_imx_keypad(&imx53_imx_keypad_data, pdata)
+
+extern const struct imx_mxc_pwm_data imx53_mxc_pwm_data[] __initconst;
+#define imx53_add_mxc_pwm(id)	\
+	imx_add_mxc_pwm(&imx53_mxc_pwm_data[id])
diff --git a/arch/arm/plat-mxc/devices/platform-mxc_pwm.c b/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
index b0c4ae2..18cfd07 100644
--- a/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
+++ b/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
@@ -49,6 +49,15 @@ const struct imx_mxc_pwm_data imx51_mxc_pwm_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_SOC_IMX51 */
 
+#ifdef CONFIG_SOC_IMX53
+const struct imx_mxc_pwm_data imx53_mxc_pwm_data[] __initconst = {
+#define imx53_mxc_pwm_data_entry(_id, _hwid)				\
+	imx_mxc_pwm_data_entry(MX53, _id, _hwid, SZ_16K)
+	imx53_mxc_pwm_data_entry(0, 1),
+	imx53_mxc_pwm_data_entry(1, 2),
+};
+#endif /* ifdef CONFIG_SOC_IMX53 */
+
 struct platform_device *__init imx_add_mxc_pwm(
 		const struct imx_mxc_pwm_data *data)
 {
diff --git a/arch/arm/plat-mxc/pwm.c b/arch/arm/plat-mxc/pwm.c
index 761c3c9..5dda436 100644
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
1.7.4.1
