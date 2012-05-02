From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed,  2 May 2012 19:33:30 +0800
Subject: [PATCH 05/15] ARM: imx: use machine specific hook for late init
In-Reply-To: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
References: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1335958420-5193-6-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Sascha Hauer <kernel@pengutronix.de>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/cpu-imx5.c            |    6 +---
 arch/arm/mach-imx/imx51-dt.c            |    1 +
 arch/arm/mach-imx/mach-cpuimx51.c       |    1 +
 arch/arm/mach-imx/mach-cpuimx51sd.c     |    1 +
 arch/arm/mach-imx/mach-mx51_3ds.c       |    1 +
 arch/arm/mach-imx/mach-mx51_babbage.c   |    1 +
 arch/arm/mach-imx/mach-mx51_efikamx.c   |   42 +++++++++++++++++--------------
 arch/arm/mach-imx/mach-mx51_efikasb.c   |   28 +++++++++++---------
 arch/arm/mach-imx/mach-pcm037.c         |    6 ++++
 arch/arm/mach-imx/mach-pcm037_eet.c     |    5 +--
 arch/arm/mach-imx/mm-imx5.c             |    5 +++
 arch/arm/mach-imx/pcm037.h              |    6 ++++
 arch/arm/plat-mxc/include/mach/common.h |    7 +++++
 13 files changed, 71 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-imx/cpu-imx5.c b/arch/arm/mach-imx/cpu-imx5.c
index aa15c51..8eb15a2 100644
--- a/arch/arm/mach-imx/cpu-imx5.c
+++ b/arch/arm/mach-imx/cpu-imx5.c
@@ -62,11 +62,8 @@ EXPORT_SYMBOL(mx51_revision);
  * Dependent on link order - so the assumption is that vfp_init is called
  * before us.
  */
-static int __init mx51_neon_fixup(void)
+int __init mx51_neon_fixup(void)
 {
-	if (!cpu_is_mx51())
-		return 0;
-
 	if (mx51_revision() < IMX_CHIP_REVISION_3_0 &&
 			(elf_hwcap & HWCAP_NEON)) {
 		elf_hwcap &= ~HWCAP_NEON;
@@ -75,7 +72,6 @@ static int __init mx51_neon_fixup(void)
 	return 0;
 }
 
-late_initcall(mx51_neon_fixup);
 #endif
 
 static int get_mx53_srev(void)
diff --git a/arch/arm/mach-imx/imx51-dt.c b/arch/arm/mach-imx/imx51-dt.c
index 5cca5739..da4f4f5 100644
--- a/arch/arm/mach-imx/imx51-dt.c
+++ b/arch/arm/mach-imx/imx51-dt.c
@@ -115,6 +115,7 @@ DT_MACHINE_START(IMX51_DT, "Freescale i.MX51 (Device Tree Support)")
 	.handle_irq	= imx51_handle_irq,
 	.timer		= &imx51_timer,
 	.init_machine	= imx51_dt_init,
+	.init_late	= imx51_init_late,
 	.dt_compat	= imx51_dt_board_compat,
 	.restart	= mxc_restart,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-cpuimx51.c b/arch/arm/mach-imx/mach-cpuimx51.c
index 944025d..4bd7c76 100644
--- a/arch/arm/mach-imx/mach-cpuimx51.c
+++ b/arch/arm/mach-imx/mach-cpuimx51.c
@@ -297,5 +297,6 @@ MACHINE_START(EUKREA_CPUIMX51, "Eukrea CPUIMX51 Module")
 	.handle_irq = imx51_handle_irq,
 	.timer = &mxc_timer,
 	.init_machine = eukrea_cpuimx51_init,
+	.init_late	= imx51_init_late,
 	.restart	= mxc_restart,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-cpuimx51sd.c b/arch/arm/mach-imx/mach-cpuimx51sd.c
index 9fbe923..0b8770f 100644
--- a/arch/arm/mach-imx/mach-cpuimx51sd.c
+++ b/arch/arm/mach-imx/mach-cpuimx51sd.c
@@ -335,5 +335,6 @@ MACHINE_START(EUKREA_CPUIMX51SD, "Eukrea CPUIMX51SD")
 	.handle_irq = imx51_handle_irq,
 	.timer = &mxc_timer,
 	.init_machine = eukrea_cpuimx51sd_init,
+	.init_late	= imx51_init_late,
 	.restart	= mxc_restart,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-mx51_3ds.c b/arch/arm/mach-imx/mach-mx51_3ds.c
index 83eab41..3c5b163 100644
--- a/arch/arm/mach-imx/mach-mx51_3ds.c
+++ b/arch/arm/mach-imx/mach-mx51_3ds.c
@@ -175,5 +175,6 @@ MACHINE_START(MX51_3DS, "Freescale MX51 3-Stack Board")
 	.handle_irq = imx51_handle_irq,
 	.timer = &mx51_3ds_timer,
 	.init_machine = mx51_3ds_init,
+	.init_late	= imx51_init_late,
 	.restart	= mxc_restart,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-mx51_babbage.c b/arch/arm/mach-imx/mach-mx51_babbage.c
index e4b822e..f3b0115 100644
--- a/arch/arm/mach-imx/mach-mx51_babbage.c
+++ b/arch/arm/mach-imx/mach-mx51_babbage.c
@@ -426,5 +426,6 @@ MACHINE_START(MX51_BABBAGE, "Freescale MX51 Babbage Board")
 	.handle_irq = imx51_handle_irq,
 	.timer = &mx51_babbage_timer,
 	.init_machine = mx51_babbage_init,
+	.init_late	= imx51_init_late,
 	.restart	= mxc_restart,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-mx51_efikamx.c b/arch/arm/mach-imx/mach-mx51_efikamx.c
index 586e9f8..a9f3c7c 100644
--- a/arch/arm/mach-imx/mach-mx51_efikamx.c
+++ b/arch/arm/mach-imx/mach-mx51_efikamx.c
@@ -207,29 +207,32 @@ static void mx51_efikamx_power_off(void)
 
 static int __init mx51_efikamx_power_init(void)
 {
-	if (machine_is_mx51_efikamx()) {
-		pwgt1 = regulator_get(NULL, "pwgt1");
-		pwgt2 = regulator_get(NULL, "pwgt2");
-		if (!IS_ERR(pwgt1) && !IS_ERR(pwgt2)) {
-			regulator_enable(pwgt1);
-			regulator_enable(pwgt2);
-		}
-		gpio_request(EFIKAMX_POWEROFF, "poweroff");
-		pm_power_off = mx51_efikamx_power_off;
-
-		/* enable coincell charger. maybe need a small power driver ? */
-		coincell = regulator_get(NULL, "coincell");
-		if (!IS_ERR(coincell)) {
-			regulator_set_voltage(coincell, 3000000, 3000000);
-			regulator_enable(coincell);
-		}
-
-		regulator_has_full_constraints();
+	pwgt1 = regulator_get(NULL, "pwgt1");
+	pwgt2 = regulator_get(NULL, "pwgt2");
+	if (!IS_ERR(pwgt1) && !IS_ERR(pwgt2)) {
+		regulator_enable(pwgt1);
+		regulator_enable(pwgt2);
+	}
+	gpio_request(EFIKAMX_POWEROFF, "poweroff");
+	pm_power_off = mx51_efikamx_power_off;
+
+	/* enable coincell charger. maybe need a small power driver ? */
+	coincell = regulator_get(NULL, "coincell");
+	if (!IS_ERR(coincell)) {
+		regulator_set_voltage(coincell, 3000000, 3000000);
+		regulator_enable(coincell);
 	}
 
+	regulator_has_full_constraints();
+
 	return 0;
 }
-late_initcall(mx51_efikamx_power_init);
+
+static void __init mx51_efikamx_init_late(void)
+{
+	imx51_init_late();
+	mx51_efikamx_power_init();
+}
 
 static void __init mx51_efikamx_init(void)
 {
@@ -293,5 +296,6 @@ MACHINE_START(MX51_EFIKAMX, "Genesi EfikaMX nettop")
 	.handle_irq = imx51_handle_irq,
 	.timer = &mx51_efikamx_timer,
 	.init_machine = mx51_efikamx_init,
+	.init_late = mx51_efikamx_init_late,
 	.restart = mx51_efikamx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-mx51_efikasb.c b/arch/arm/mach-imx/mach-mx51_efikasb.c
index 24aded9..e73db38 100644
--- a/arch/arm/mach-imx/mach-mx51_efikasb.c
+++ b/arch/arm/mach-imx/mach-mx51_efikasb.c
@@ -211,22 +211,25 @@ static void mx51_efikasb_power_off(void)
 
 static int __init mx51_efikasb_power_init(void)
 {
-	if (machine_is_mx51_efikasb()) {
-		pwgt1 = regulator_get(NULL, "pwgt1");
-		pwgt2 = regulator_get(NULL, "pwgt2");
-		if (!IS_ERR(pwgt1) && !IS_ERR(pwgt2)) {
-			regulator_enable(pwgt1);
-			regulator_enable(pwgt2);
-		}
-		gpio_request(EFIKASB_POWEROFF, "poweroff");
-		pm_power_off = mx51_efikasb_power_off;
-
-		regulator_has_full_constraints();
+	pwgt1 = regulator_get(NULL, "pwgt1");
+	pwgt2 = regulator_get(NULL, "pwgt2");
+	if (!IS_ERR(pwgt1) && !IS_ERR(pwgt2)) {
+		regulator_enable(pwgt1);
+		regulator_enable(pwgt2);
 	}
+	gpio_request(EFIKASB_POWEROFF, "poweroff");
+	pm_power_off = mx51_efikasb_power_off;
+
+	regulator_has_full_constraints();
 
 	return 0;
 }
-late_initcall(mx51_efikasb_power_init);
+
+static void __init mx51_efikasb_init_late(void)
+{
+	imx51_init_late();
+	mx51_efikasb_power_init();
+}
 
 /* 01     R1.3 board
    10     R2.0 board */
@@ -287,6 +290,7 @@ MACHINE_START(MX51_EFIKASB, "Genesi Efika Smartbook")
 	.init_irq = mx51_init_irq,
 	.handle_irq = imx51_handle_irq,
 	.init_machine =  efikasb_board_init,
+	.init_late = mx51_efikasb_init_late,
 	.timer = &mx51_efikasb_timer,
 	.restart	= mxc_restart,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-pcm037.c b/arch/arm/mach-imx/mach-pcm037.c
index 5fddf94..3aba3a9 100644
--- a/arch/arm/mach-imx/mach-pcm037.c
+++ b/arch/arm/mach-imx/mach-pcm037.c
@@ -694,6 +694,11 @@ static void __init pcm037_reserve(void)
 			MX3_CAMERA_BUF_SIZE);
 }
 
+static void __init pcm037_init_late(void)
+{
+	pcm037_eet_init_devices();
+}
+
 MACHINE_START(PCM037, "Phytec Phycore pcm037")
 	/* Maintainer: Pengutronix */
 	.atag_offset = 0x100,
@@ -704,5 +709,6 @@ MACHINE_START(PCM037, "Phytec Phycore pcm037")
 	.handle_irq = imx31_handle_irq,
 	.timer = &pcm037_timer,
 	.init_machine = pcm037_init,
+	.init_late = pcm037_init_late,
 	.restart	= mxc_restart,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-pcm037_eet.c b/arch/arm/mach-imx/mach-pcm037_eet.c
index 1b7606b..11ffa81 100644
--- a/arch/arm/mach-imx/mach-pcm037_eet.c
+++ b/arch/arm/mach-imx/mach-pcm037_eet.c
@@ -160,9 +160,9 @@ static const struct gpio_keys_platform_data
 	.rep		= 0, /* No auto-repeat */
 };
 
-static int __init eet_init_devices(void)
+int __init pcm037_eet_init_devices(void)
 {
-	if (!machine_is_pcm037() || pcm037_variant() != PCM037_EET)
+	if (pcm037_variant() != PCM037_EET)
 		return 0;
 
 	mxc_iomux_setup_multiple_pins(pcm037_eet_pins,
@@ -176,4 +176,3 @@ static int __init eet_init_devices(void)
 
 	return 0;
 }
-late_initcall(eet_init_devices);
diff --git a/arch/arm/mach-imx/mm-imx5.c b/arch/arm/mach-imx/mm-imx5.c
index e10f391..d6b7e9f 100644
--- a/arch/arm/mach-imx/mm-imx5.c
+++ b/arch/arm/mach-imx/mm-imx5.c
@@ -234,3 +234,8 @@ void __init imx53_soc_init(void)
 	platform_device_register_simple("imx31-audmux", 0, imx53_audmux_res,
 					ARRAY_SIZE(imx53_audmux_res));
 }
+
+void __init imx51_init_late(void)
+{
+	mx51_neon_fixup();
+}
diff --git a/arch/arm/mach-imx/pcm037.h b/arch/arm/mach-imx/pcm037.h
index d692972..7d16769 100644
--- a/arch/arm/mach-imx/pcm037.h
+++ b/arch/arm/mach-imx/pcm037.h
@@ -8,4 +8,10 @@ enum pcm037_board_variant {
 
 extern enum pcm037_board_variant pcm037_variant(void);
 
+#ifdef CONFIG_MACH_PCM037_EET
+int pcm037_eet_init_devices(void);
+#else
+static inline int pcm037_eet_init_devices(void) { return 0; }
+#endif
+
 #endif
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 0319c4a..cf663d8 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -53,6 +53,7 @@ extern void imx35_soc_init(void);
 extern void imx50_soc_init(void);
 extern void imx51_soc_init(void);
 extern void imx53_soc_init(void);
+extern void imx51_init_late(void);
 extern void epit_timer_init(struct clk *timer_clk, void __iomem *base, int irq);
 extern void mxc_timer_init(struct clk *timer_clk, void __iomem *, int);
 extern int mx1_clocks_init(unsigned long fref);
@@ -149,4 +150,10 @@ extern void imx6q_pm_init(void);
 static inline void imx6q_pm_init(void) {}
 #endif
 
+#ifdef CONFIG_NEON
+extern int mx51_neon_fixup(void);
+#else
+static inline int mx51_neon_fixup(void) { return 0; }
+#endif
+
 #endif
-- 
1.7.5.4
