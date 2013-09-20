From: tony@atomide.com (Tony Lindgren)
Date: Fri, 20 Sep 2013 10:38:19 -0700
Subject: [PATCH 3/4] ARM: OMAP2+: Use pdata quirk support for board-generic.c
In-Reply-To: <20130920173310.2584.24522.stgit@localhost>
References: <20130920173310.2584.24522.stgit@localhost>
Message-ID: <20130920173819.2584.99020.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's use platform data quirk support for board-generic.c.
This removes all board specific hacks out of board-generic.c.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-generic.c |   32 ---------------------------
 arch/arm/mach-omap2/pdata-quirks.c  |   41 +++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 022b0df..a66575f 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -15,13 +15,10 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/irqdomain.h>
-#include <linux/clk.h>
 
 #include <asm/mach/arch.h>
 
 #include "common.h"
-#include "common-board-devices.h"
-#include "dss-common.h"
 
 #if !(defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3))
 #define intc_of_init	NULL
@@ -36,41 +33,12 @@ static struct of_device_id omap_dt_match_table[] __initdata = {
 	{ }
 };
 
-/*
- * Create alias for USB host PHY clock.
- * Remove this when clock phandle can be provided via DT
- */
-static void __init legacy_init_ehci_clk(char *clkname)
-{
-	int ret;
-
-	ret = clk_add_alias("main_clk", NULL, clkname, NULL);
-	if (ret) {
-		pr_err("%s:Failed to add main_clk alias to %s :%d\n",
-						__func__, clkname, ret);
-	}
-}
-
 static void __init omap_generic_init(void)
 {
 	omap_sdrc_init(NULL, NULL);
 
 	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
 	pdata_quirks_init();
-
-	/*
-	 * HACK: call display setup code for selected boards to enable omapdss.
-	 * This will be removed when omapdss supports DT.
-	 */
-	if (of_machine_is_compatible("ti,omap4-panda")) {
-		omap4_panda_display_init_of();
-		legacy_init_ehci_clk("auxclk3_ck");
-
-	}
-	else if (of_machine_is_compatible("ti,omap4-sdp"))
-		omap_4430sdp_display_init_of();
-	else if (of_machine_is_compatible("ti,omap5-uevm"))
-		legacy_init_ehci_clk("auxclk1_ck");
 }
 
 #ifdef CONFIG_SOC_OMAP2420
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index e605199..648d957 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -20,7 +20,48 @@ struct pdata_init {
 	void (*fn)(void);
 };
 
+/*
+ * Create alias for USB host PHY clock.
+ * Remove this when clock phandle can be provided via DT
+ */
+static void __init __used legacy_init_ehci_clk(char *clkname)
+{
+	int ret;
+
+	ret = clk_add_alias("main_clk", NULL, clkname, NULL);
+	if (ret)
+		pr_err("%s:Failed to add main_clk alias to %s :%d\n",
+		       __func__, clkname, ret);
+}
+
+#ifdef CONFIG_ARCH_OMAP4
+static void __init omap4_sdp_legacy_init(void)
+{
+	omap_4430sdp_display_init_of();
+}
+
+static void __init omap4_panda_legacy_init(void)
+{
+	omap4_panda_display_init_of();
+	legacy_init_ehci_clk("auxclk3_ck");
+}
+#endif
+
+#ifdef CONFIG_SOC_OMAP5
+static void __init omap5_uevm_legacy_init(void)
+{
+	legacy_init_ehci_clk("auxclk1_ck");
+}
+#endif
+
 static struct pdata_init pdata_quirks[] __initdata = {
+#ifdef CONFIG_ARCH_OMAP4
+	{ "ti,omap4-sdp", omap4_sdp_legacy_init, },
+	{ "ti,omap4-panda", omap4_panda_legacy_init, },
+#endif
+#ifdef CONFIG_SOC_OMAP5
+	{ "ti,omap5-uevm", omap5_uevm_legacy_init, },
+#endif
 	{ /* sentinel */ },
 };
 
