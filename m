From: stefan@agner.ch (Stefan Agner)
Date: Wed, 22 Oct 2014 18:27:55 +0200
Subject: [PATCH v2 2/4] ARM: imx: clk-vf610: get input clocks from assigned
 clocks
In-Reply-To: <1413995277-2844-1-git-send-email-stefan@agner.ch>
References: <1413995277-2844-1-git-send-email-stefan@agner.ch>
Message-ID: <1413995277-2844-3-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the clock assignment device tree changes, the clocks get
initialized properly but the search for those clocks fails with
errors:

[    0.000000] i.MX clk 4: register failed with -17
[    0.000000] i.MX clk 5: register failed with -17

This is because the module can't find those clocks anymore, and
tries to initialize fixed clocks with the same name.

Get the clock modules input clocks from the assigned clocks by
default by using of_clk_get_by_name(). If this function returns
not a valid clock, fall back to the old behaviour and search the
input clock from the device tree's /clocks/$name node.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/mach-imx/clk-vf610.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/clk-vf610.c b/arch/arm/mach-imx/clk-vf610.c
index a178184..1963a44 100644
--- a/arch/arm/mach-imx/clk-vf610.c
+++ b/arch/arm/mach-imx/clk-vf610.c
@@ -105,6 +105,17 @@ static unsigned int const clks_init_on[] __initconst = {
 	VF610_CLK_DDR_SEL,
 };
 
+static struct clk * __init vf610_get_fixed_clock(
+				struct device_node *ccm_node, const char *name)
+{
+	struct clk *clk = of_clk_get_by_name(ccm_node, name);
+
+	/* Backward compatibility if device tree is missing clks assignments */
+	if (IS_ERR(clk))
+		clk = imx_obtain_fixed_clock(name, 0);
+	return clk;
+};
+
 static void __init vf610_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
@@ -115,11 +126,10 @@ static void __init vf610_clocks_init(struct device_node *ccm_node)
 	clk[VF610_CLK_SIRC_32K] = imx_clk_fixed("sirc_32k", 32000);
 	clk[VF610_CLK_FIRC] = imx_clk_fixed("firc", 24000000);
 
-	clk[VF610_CLK_SXOSC] = imx_obtain_fixed_clock("sxosc", 0);
-	clk[VF610_CLK_FXOSC] = imx_obtain_fixed_clock("fxosc", 0);
-	clk[VF610_CLK_AUDIO_EXT] = imx_obtain_fixed_clock("audio_ext", 0);
-	clk[VF610_CLK_ENET_EXT] = imx_obtain_fixed_clock("enet_ext", 0);
-
+	clk[VF610_CLK_SXOSC] = vf610_get_fixed_clock(ccm_node, "sxosc");
+	clk[VF610_CLK_FXOSC] = vf610_get_fixed_clock(ccm_node, "fxosc");
+	clk[VF610_CLK_AUDIO_EXT] = vf610_get_fixed_clock(ccm_node, "audio_ext");
+	clk[VF610_CLK_ENET_EXT] = vf610_get_fixed_clock(ccm_node, "enet_ext");
 	clk[VF610_CLK_FXOSC_HALF] = imx_clk_fixed_factor("fxosc_half", "fxosc", 1, 2);
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,vf610-anatop");
-- 
2.1.2
