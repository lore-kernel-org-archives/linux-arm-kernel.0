From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 4 May 2012 20:12:18 +0800
Subject: [PATCH v2 4/5] ARM: mxs: do not add dma device by default
In-Reply-To: <1336133539-13465-1-git-send-email-b29396@freescale.com>
References: <1336133539-13465-1-git-send-email-b29396@freescale.com>
Message-ID: <1336133539-13465-4-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

This will cause conflict when dt is enabled.
So let each platform add dma devices respectively.

Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Huang Shijie <b32955@freescale.com>
Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
ChangeLog v2->v3:
 * introduce mx23/mx28_soc_init()
ChangeLog v1->v2:
 * Add the missed mx28_add_dma() for mx28evk.c.
---
 arch/arm/mach-mxs/devices/platform-dma.c |   23 +----------------------
 arch/arm/mach-mxs/include/mach/common.h  |    4 ++++
 arch/arm/mach-mxs/mach-apx4devkit.c      |    2 ++
 arch/arm/mach-mxs/mach-m28evk.c          |    2 ++
 arch/arm/mach-mxs/mach-mx23evk.c         |    2 ++
 arch/arm/mach-mxs/mach-mx28evk.c         |    2 ++
 arch/arm/mach-mxs/mach-stmp378x_devb.c   |    2 ++
 arch/arm/mach-mxs/mach-tx28.c            |    2 ++
 arch/arm/mach-mxs/mm.c                   |   12 ++++++++++++
 9 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-mxs/devices/platform-dma.c b/arch/arm/mach-mxs/devices/platform-dma.c
index aff4813..4682450 100644
--- a/arch/arm/mach-mxs/devices/platform-dma.c
+++ b/arch/arm/mach-mxs/devices/platform-dma.c
@@ -14,7 +14,7 @@
 #include <mach/mx28.h>
 #include <mach/devices-common.h>
 
-static struct platform_device *__init mxs_add_dma(const char *devid,
+struct platform_device *__init mxs_add_dma(const char *devid,
 						resource_size_t base)
 {
 	struct resource res[] = {
@@ -29,24 +29,3 @@ static struct platform_device *__init mxs_add_dma(const char *devid,
 				res, ARRAY_SIZE(res), NULL, 0,
 				DMA_BIT_MASK(32));
 }
-
-static int __init mxs_add_mxs_dma(void)
-{
-	char *mx23_apbh = "imx23-dma-apbh";
-	char *mx23_apbx = "imx23-dma-apbx";
-	char *mx28_apbh = "imx28-dma-apbh";
-	char *mx28_apbx = "imx28-dma-apbx";
-
-	if (cpu_is_mx23()) {
-		mxs_add_dma(mx23_apbh, MX23_APBH_DMA_BASE_ADDR);
-		mxs_add_dma(mx23_apbx, MX23_APBX_DMA_BASE_ADDR);
-	}
-
-	if (cpu_is_mx28()) {
-		mxs_add_dma(mx28_apbh, MX28_APBH_DMA_BASE_ADDR);
-		mxs_add_dma(mx28_apbx, MX28_APBX_DMA_BASE_ADDR);
-	}
-
-	return 0;
-}
-arch_initcall(mxs_add_mxs_dma);
diff --git a/arch/arm/mach-mxs/include/mach/common.h b/arch/arm/mach-mxs/include/mach/common.h
index c50c3ea..b212553 100644
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
@@ -33,4 +35,6 @@ extern void icoll_init_irq(void);
 
 extern int mxs_clkctrl_timeout(unsigned int reg_offset, unsigned int mask);
 
+extern struct platform_device *mxs_add_dma(const char *devid,
+						resource_size_t base);
 #endif /* __MACH_MXS_COMMON_H__ */
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
index 50af5ce..6a1acad 100644
--- a/arch/arm/mach-mxs/mm.c
+++ b/arch/arm/mach-mxs/mm.c
@@ -61,3 +61,15 @@ void __init mx28_init_irq(void)
 {
 	icoll_init_irq();
 }
+
+void __init mx23_soc_init(void)
+{
+	mxs_add_dma("imx23-dma-apbh", MX23_APBH_DMA_BASE_ADDR);
+	mxs_add_dma("imx23-dma-apbx", MX23_APBX_DMA_BASE_ADDR);
+}
+
+void __init mx28_soc_init(void)
+{
+	mxs_add_dma("imx28-dma-apbh", MX23_APBH_DMA_BASE_ADDR);
+	mxs_add_dma("imx28-dma-apbx", MX23_APBX_DMA_BASE_ADDR);
+}
-- 
1.7.0.4
