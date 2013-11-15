From: tony@atomide.com (Tony Lindgren)
Date: Thu, 14 Nov 2013 16:09:50 -0800
Subject: [PATCH 03/11] ARM: OMAP2+: Add support for board specific auxdata
 quirks
In-Reply-To: <1384474198-20756-1-git-send-email-tony@atomide.com>
References: <1384474198-20756-1-git-send-email-tony@atomide.com>
Message-ID: <1384474198-20756-4-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks like some boards need to fill in the auxdata before
we call of_platform_populate(). Let's add support for
auxdata quirks like we already have for pdata quirks for
legacy drivers.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/pdata-quirks.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 10c7145..cb2863d 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -125,7 +125,18 @@ void omap_pcs_legacy_init(int irq, void (*rearm)(void))
 	pcs_pdata.rearm = rearm;
 }
 
+/*
+ * Few boards still need auxdata populated before we populate
+ * the dev entries in of_platform_populate().
+ */
+static struct pdata_init auxdata_quirks[] __initdata = {
+	{ /* sentinel */ },
+};
+
 struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
+#ifdef CONFIG_MACH_NOKIA_N8X0
+	OF_DEV_AUXDATA("ti,omap2420-mmc", 0x4809c000, "mmci-omap.0", NULL),
+#endif
 #ifdef CONFIG_ARCH_OMAP3
 	OF_DEV_AUXDATA("ti,omap3-padconf", 0x48002030, "48002030.pinmux", &pcs_pdata),
 	OF_DEV_AUXDATA("ti,omap3-padconf", 0x48002a00, "48002a00.pinmux", &pcs_pdata),
@@ -137,6 +148,10 @@ struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 	{ /* sentinel */ },
 };
 
+/*
+ * Few boards still need to initialize some legacy devices with
+ * platform data until the drivers support device tree.
+ */
 static struct pdata_init pdata_quirks[] __initdata = {
 #ifdef CONFIG_ARCH_OMAP3
 	{ "nokia,omap3-n9", hsmmc2_internal_input_clk, },
@@ -155,14 +170,8 @@ static struct pdata_init pdata_quirks[] __initdata = {
 	{ /* sentinel */ },
 };
 
-void __init pdata_quirks_init(struct of_device_id *omap_dt_match_table)
+static void pdata_quirks_check(struct pdata_init *quirks)
 {
-	struct pdata_init *quirks = pdata_quirks;
-
-	omap_sdrc_init(NULL, NULL);
-	of_platform_populate(NULL, omap_dt_match_table,
-			     omap_auxdata_lookup, NULL);
-
 	while (quirks->compatible) {
 		if (of_machine_is_compatible(quirks->compatible)) {
 			if (quirks->fn)
@@ -172,3 +181,12 @@ void __init pdata_quirks_init(struct of_device_id *omap_dt_match_table)
 		quirks++;
 	}
 }
+
+void __init pdata_quirks_init(struct of_device_id *omap_dt_match_table)
+{
+	omap_sdrc_init(NULL, NULL);
+	pdata_quirks_check(auxdata_quirks);
+	of_platform_populate(NULL, omap_dt_match_table,
+			     omap_auxdata_lookup, NULL);
+	pdata_quirks_check(pdata_quirks);
+}
-- 
1.8.1.1
