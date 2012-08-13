From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Aug 2012 21:05:33 +0800
Subject: [PATCH 13/17] ARM: imx53: decouple device tree boot from board files
In-Reply-To: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
References: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1344863137-6112-14-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now, imx53 device tree kernel calls pinctrl to set up pins.  The
functions used to hook up non-DT pin setup is not needed for DT boot
any more.  Remove them from DT image.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/imx53-dt.c            |   20 --------------------
 arch/arm/plat-mxc/include/mach/common.h |    4 ----
 2 files changed, 0 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-imx/imx53-dt.c b/arch/arm/mach-imx/imx53-dt.c
index 7f47391..f577b5d 100644
--- a/arch/arm/mach-imx/imx53-dt.c
+++ b/arch/arm/mach-imx/imx53-dt.c
@@ -50,14 +50,6 @@ static const struct of_dev_auxdata imx53_auxdata_lookup[] __initconst = {
 	{ /* sentinel */ }
 };
 
-static const struct of_device_id imx53_iomuxc_of_match[] __initconst = {
-	{ .compatible = "fsl,imx53-iomuxc-ard", .data = imx53_ard_common_init, },
-	{ .compatible = "fsl,imx53-iomuxc-evk", .data = imx53_evk_common_init, },
-	{ .compatible = "fsl,imx53-iomuxc-qsb", .data = imx53_qsb_common_init, },
-	{ .compatible = "fsl,imx53-iomuxc-smd", .data = imx53_smd_common_init, },
-	{ /* sentinel */ }
-};
-
 static void __init imx53_qsb_init(void)
 {
 	struct clk *clk;
@@ -73,18 +65,6 @@ static void __init imx53_qsb_init(void)
 
 static void __init imx53_dt_init(void)
 {
-	struct device_node *node;
-	const struct of_device_id *of_id;
-	void (*func)(void);
-
-	node = of_find_matching_node(NULL, imx53_iomuxc_of_match);
-	if (node) {
-		of_id = of_match_node(imx53_iomuxc_of_match, node);
-		func = of_id->data;
-		func();
-		of_node_put(node);
-	}
-
 	if (of_machine_is_compatible("fsl,imx53-qsb"))
 		imx53_qsb_init();
 
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 7128e97..96fa702 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -138,10 +138,6 @@ extern void imx_gpc_init(void);
 extern void imx_gpc_pre_suspend(void);
 extern void imx_gpc_post_resume(void);
 extern void imx51_babbage_common_init(void);
-extern void imx53_ard_common_init(void);
-extern void imx53_evk_common_init(void);
-extern void imx53_qsb_common_init(void);
-extern void imx53_smd_common_init(void);
 extern int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode);
 extern void imx6q_clock_map_io(void);
 
-- 
1.7.5.4
