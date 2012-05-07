From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  7 May 2012 09:16:06 +0800
Subject: [PATCH RESEND 1/9] ARM: mxs: enable pinctrl dummy states
In-Reply-To: <1336353374-28939-1-git-send-email-shawn.guo@linaro.org>
References: <1336353374-28939-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1336353374-28939-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mxs pinctrl driver will only support DT probe.  That said, the mxs
device drivers can only get pinctrl state from pinctrl subsystem when
the drivers get probed from device tree.

Before converting the whole mxs platform support over to device tree,
we need to enable pinctrl dummy states for those non-DT board files
to ensure the pinctrl API adopted by mxs device drivers will work for
both DT and non-DT probe.

Instead of calling pinctrl_provide_dummies() directly in every board
file, the patch introduces soc specific calls mx23_soc_init() and
mx28_soc_init() for boards' .init_machine hook to invoke, so that
any soc specific setup for non-DT boot only can be added there.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/include/mach/common.h |    2 ++
 arch/arm/mach-mxs/mach-apx4devkit.c     |    2 ++
 arch/arm/mach-mxs/mach-m28evk.c         |    2 ++
 arch/arm/mach-mxs/mach-mx23evk.c        |    2 ++
 arch/arm/mach-mxs/mach-mx28evk.c        |    2 ++
 arch/arm/mach-mxs/mach-stmp378x_devb.c  |    2 ++
 arch/arm/mach-mxs/mach-tx28.c           |    2 ++
 arch/arm/mach-mxs/mm.c                  |   11 +++++++++++
 8 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/include/mach/common.h b/arch/arm/mach-mxs/include/mach/common.h
index c50c3ea..8d88399 100644
--- a/arch/arm/mach-mxs/include/mach/common.h
+++ b/arch/arm/mach-mxs/include/mach/common.h
@@ -19,11 +19,13 @@ extern void mxs_timer_init(struct clk *, int);
 extern void mxs_restart(char, const char *);
 extern int mxs_saif_clkmux_select(unsigned int clkmux);
 
+extern void mx23_soc_init(void);
 extern int mx23_register_gpios(void);
 extern int mx23_clocks_init(void);
 extern void mx23_map_io(void);
 extern void mx23_init_irq(void);
 
+extern void mx28_soc_init(void);
 extern int mx28_register_gpios(void);
 extern int mx28_clocks_init(void);
 extern void mx28_map_io(void);
diff --git a/arch/arm/mach-mxs/mach-apx4devkit.c b/arch/arm/mach-mxs/mach-apx4devkit.c
index 48a7fab..5e90b9d 100644
--- a/arch/arm/mach-mxs/mach-apx4devkit.c
+++ b/arch/arm/mach-mxs/mach-apx4devkit.c
@@ -207,6 +207,8 @@ static int apx4devkit_phy_fixup(struct phy_device *phy)
 
 static void __init apx4devkit_init(void)
 {
+	mx28_soc_init();
+
 	mxs_iomux_setup_multiple_pads(apx4devkit_pads,
 			ARRAY_SIZE(apx4devkit_pads));
 
diff --git a/arch/arm/mach-mxs/mach-m28evk.c b/arch/arm/mach-mxs/mach-m28evk.c
index 06d7996..4c00c87 100644
--- a/arch/arm/mach-mxs/mach-m28evk.c
+++ b/arch/arm/mach-mxs/mach-m28evk.c
@@ -319,6 +319,8 @@ static struct mxs_mmc_platform_data m28evk_mmc_pdata[] __initdata = {
 
 static void __init m28evk_init(void)
 {
+	mx28_soc_init();
+
 	mxs_iomux_setup_multiple_pads(m28evk_pads, ARRAY_SIZE(m28evk_pads));
 
 	mx28_add_duart();
diff --git a/arch/arm/mach-mxs/mach-mx23evk.c b/arch/arm/mach-mxs/mach-mx23evk.c
index 5ea1c57..e7272a4 100644
--- a/arch/arm/mach-mxs/mach-mx23evk.c
+++ b/arch/arm/mach-mxs/mach-mx23evk.c
@@ -141,6 +141,8 @@ static void __init mx23evk_init(void)
 {
 	int ret;
 
+	mx23_soc_init();
+
 	mxs_iomux_setup_multiple_pads(mx23evk_pads, ARRAY_SIZE(mx23evk_pads));
 
 	mx23_add_duart();
diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index e386c14..da4610e 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -413,6 +413,8 @@ static void __init mx28evk_init(void)
 {
 	int ret;
 
+	mx28_soc_init();
+
 	mxs_iomux_setup_multiple_pads(mx28evk_pads, ARRAY_SIZE(mx28evk_pads));
 
 	mx28_add_duart();
diff --git a/arch/arm/mach-mxs/mach-stmp378x_devb.c b/arch/arm/mach-mxs/mach-stmp378x_devb.c
index a626c07..6548965 100644
--- a/arch/arm/mach-mxs/mach-stmp378x_devb.c
+++ b/arch/arm/mach-mxs/mach-stmp378x_devb.c
@@ -85,6 +85,8 @@ static void __init stmp378x_dvb_init(void)
 {
 	int ret;
 
+	mx23_soc_init();
+
 	mxs_iomux_setup_multiple_pads(stmp378x_dvb_pads,
 			ARRAY_SIZE(stmp378x_dvb_pads));
 
diff --git a/arch/arm/mach-mxs/mach-tx28.c b/arch/arm/mach-mxs/mach-tx28.c
index 2c0862e..8837029 100644
--- a/arch/arm/mach-mxs/mach-tx28.c
+++ b/arch/arm/mach-mxs/mach-tx28.c
@@ -146,6 +146,8 @@ static struct mxs_mmc_platform_data tx28_mmc0_pdata __initdata = {
 
 static void __init tx28_stk5v3_init(void)
 {
+	mx28_soc_init();
+
 	mxs_iomux_setup_multiple_pads(tx28_stk5v3_pads,
 			ARRAY_SIZE(tx28_stk5v3_pads));
 
diff --git a/arch/arm/mach-mxs/mm.c b/arch/arm/mach-mxs/mm.c
index 50af5ce..67a384e 100644
--- a/arch/arm/mach-mxs/mm.c
+++ b/arch/arm/mach-mxs/mm.c
@@ -13,6 +13,7 @@
 
 #include <linux/mm.h>
 #include <linux/init.h>
+#include <linux/pinctrl/machine.h>
 
 #include <asm/mach/map.h>
 
@@ -61,3 +62,13 @@ void __init mx28_init_irq(void)
 {
 	icoll_init_irq();
 }
+
+void __init mx23_soc_init(void)
+{
+	pinctrl_provide_dummies();
+}
+
+void __init mx28_soc_init(void)
+{
+	pinctrl_provide_dummies();
+}
-- 
1.7.5.4
