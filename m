From: tony@atomide.com (Tony Lindgren)
Date: Tue, 19 Nov 2013 18:56:20 -0800
Subject: [PATCH] ARM: OMAP2+: Fix populating the hwmod data from device tree
Message-ID: <20131120025620.GF10317@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have some device tree properties where the ti,hwmod has multiple
values:

am33xx.dtsi:	ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
am4372.dtsi:	ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
dra7.dtsi:	ti,hwmods = "l3_main_1", "l3_main_2";
omap3.dtsi:	ti,hwmods = "mcbsp2", "mcbsp2_sidetone";
omap3.dtsi:	ti,hwmods = "mcbsp3", "mcbsp3_sidetone";
omap4.dtsi:	ti,hwmods = "l3_main_1", "l3_main_2", "l3_main_3";
omap5.dtsi:	ti,hwmods = "l3_main_1", "l3_main_2", "l3_main_3";

So we need to handle the whole string array instead of just the
first string to find the related hwmod entry.

Cc: "Beno?t Cousson" <bcousson@baylibre.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2228,11 +2228,23 @@ static struct device_node *of_dev_hwmod_lookup(struct device_node *np,
 						struct omap_hwmod *oh)
 {
 	struct device_node *np0 = NULL, *np1 = NULL;
-	const char *p;
 
 	for_each_child_of_node(np, np0) {
-		if (of_find_property(np0, "ti,hwmods", NULL)) {
-			p = of_get_property(np0, "ti,hwmods", NULL);
+		int count, i;
+
+		count = of_property_count_strings(np0, "ti,hwmods");
+		if (count < 1)
+			continue;
+
+		for (i = 0; i < count; i++) {
+			const char *p;
+			int res;
+
+			res = of_property_read_string_index(np0, "ti,hwmods",
+							    i, &p);
+			if (res)
+				continue;
+
 			if (!strcmp(p, oh->name))
 				return np0;
 			np1 = of_dev_hwmod_lookup(np0, oh);
