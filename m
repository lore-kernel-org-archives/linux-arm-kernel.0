From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Aug 2012 21:17:43 +0800
Subject: [PATCH 18/18] ARM: imx51: decouple device tree boot from board files
In-Reply-To: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
References: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1344863863-9094-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now, imx51 device tree kernel calls pinctrl to set up pins.  The
function used to hook up non-DT pin setup is not needed for DT boot
any more.  Remove it from DT image.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/imx51-dt.c            |   17 -----------------
 arch/arm/plat-mxc/include/mach/common.h |    1 -
 2 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-imx/imx51-dt.c b/arch/arm/mach-imx/imx51-dt.c
index f5261e6..bcf7f69 100644
--- a/arch/arm/mach-imx/imx51-dt.c
+++ b/arch/arm/mach-imx/imx51-dt.c
@@ -43,25 +43,8 @@ static const struct of_dev_auxdata imx51_auxdata_lookup[] __initconst = {
 	{ /* sentinel */ }
 };
 
-static const struct of_device_id imx51_iomuxc_of_match[] __initconst = {
-	{ .compatible = "fsl,imx51-iomuxc-babbage", .data = imx51_babbage_common_init, },
-	{ /* sentinel */ }
-};
-
 static void __init imx51_dt_init(void)
 {
-	struct device_node *node;
-	const struct of_device_id *of_id;
-	void (*func)(void);
-
-	node = of_find_matching_node(NULL, imx51_iomuxc_of_match);
-	if (node) {
-		of_id = of_match_node(imx51_iomuxc_of_match, node);
-		func = of_id->data;
-		func();
-		of_node_put(node);
-	}
-
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     imx51_auxdata_lookup, NULL);
 }
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 0932fc6..28ba09f 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -136,7 +136,6 @@ extern void imx_src_prepare_restart(void);
 extern void imx_gpc_init(void);
 extern void imx_gpc_pre_suspend(void);
 extern void imx_gpc_post_resume(void);
-extern void imx51_babbage_common_init(void);
 extern int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode);
 extern void imx6q_clock_map_io(void);
 
-- 
1.7.5.4
