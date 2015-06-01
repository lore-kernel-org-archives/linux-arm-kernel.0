From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 1 Jun 2015 09:23:14 +0300
Subject: [PATCHv4 06/10] ARM: OMAP: display: change compat names to array
In-Reply-To: <1433139798-23450-1-git-send-email-tomi.valkeinen@ti.com>
References: <1433139798-23450-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1433139798-23450-7-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simplify the DSS detection logic by creating a list of the omapdss
compat strings, instead of checking each separately with an 'if'.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/display.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index f492ae147c6a..9868d0bc7805 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -568,25 +568,24 @@ void __init omapdss_early_init_of(void)
 
 }
 
+static const char * const omapdss_compat_names[] __initconst = {
+	"ti,omap2-dss",
+	"ti,omap3-dss",
+	"ti,omap4-dss",
+	"ti,omap5-dss",
+};
+
 struct device_node * __init omapdss_find_dss_of_node(void)
 {
 	struct device_node *node;
+	int i;
 
-	node = of_find_compatible_node(NULL, NULL, "ti,omap2-dss");
-	if (node)
-		return node;
-
-	node = of_find_compatible_node(NULL, NULL, "ti,omap3-dss");
-	if (node)
-		return node;
-
-	node = of_find_compatible_node(NULL, NULL, "ti,omap4-dss");
-	if (node)
-		return node;
-
-	node = of_find_compatible_node(NULL, NULL, "ti,omap5-dss");
-	if (node)
-		return node;
+	for (i = 0; i < ARRAY_SIZE(omapdss_compat_names); ++i) {
+		node = of_find_compatible_node(NULL, NULL,
+			omapdss_compat_names[i]);
+		if (node)
+			return node;
+	}
 
 	return NULL;
 }
-- 
2.1.4
