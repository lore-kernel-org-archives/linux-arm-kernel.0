From: robherring2@gmail.com (Rob Herring)
Date: Thu, 29 May 2014 17:40:21 -0500
Subject: [PATCH v2 11/11] clk: versatile: add versatile OSC support
In-Reply-To: <1401403221-27523-1-git-send-email-robherring2@gmail.com>
References: <1401403221-27523-1-git-send-email-robherring2@gmail.com>
Message-ID: <1401403221-27523-12-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Versatile platforms share the same OSC programming model as Integrator
platforms. Add the necessary parameters and init functions for Versatile.

Renaming the file to clk-versatile.c as versatile is used as the family
name for ARM, Ltd. boards.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Mike Turquette <mturquette@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
- Rename clk-integrator.c to clk-versatile.c

 drivers/clk/versatile/Makefile                     |  3 +-
 .../{clk-integrator.c => clk-versatile.c}          | 35 ++++++++++++++++++++--
 2 files changed, 34 insertions(+), 4 deletions(-)
 rename drivers/clk/versatile/{clk-integrator.c => clk-versatile.c} (66%)

diff --git a/drivers/clk/versatile/Makefile b/drivers/clk/versatile/Makefile
index c16ca78..9ee2b37 100644
--- a/drivers/clk/versatile/Makefile
+++ b/drivers/clk/versatile/Makefile
@@ -1,6 +1,5 @@
 # Makefile for Versatile-specific clocks
-obj-$(CONFIG_ICST)		+= clk-icst.o
-obj-$(CONFIG_ARCH_INTEGRATOR)	+= clk-integrator.o
+obj-$(CONFIG_ICST)		+= clk-icst.o clk-versatile.o
 obj-$(CONFIG_INTEGRATOR_IMPD1)	+= clk-impd1.o
 obj-$(CONFIG_ARCH_REALVIEW)	+= clk-realview.o
 obj-$(CONFIG_ARCH_VEXPRESS)	+= clk-vexpress.o clk-sp810.o
diff --git a/drivers/clk/versatile/clk-integrator.c b/drivers/clk/versatile/clk-versatile.c
similarity index 66%
rename from drivers/clk/versatile/clk-integrator.c
rename to drivers/clk/versatile/clk-versatile.c
index 734c4b8..fe52a79 100644
--- a/drivers/clk/versatile/clk-integrator.c
+++ b/drivers/clk/versatile/clk-versatile.c
@@ -17,6 +17,9 @@
 
 #define INTEGRATOR_HDR_LOCK_OFFSET	0x14
 
+#define VERSATILE_SYS_OSCCLCD_OFFSET	0x1c
+#define VERSATILE_SYS_LOCK_OFFSET	0x20
+
 /* Base offset for the core module */
 static void __iomem *cm_base;
 
@@ -37,11 +40,27 @@ static const struct clk_icst_desc __initdata cm_auxosc_desc = {
 	.lock_offset = INTEGRATOR_HDR_LOCK_OFFSET,
 };
 
-static void __init of_integrator_cm_osc_setup(struct device_node *np)
+static const struct icst_params versatile_auxosc_params = {
+	.vco_max	= ICST307_VCO_MAX,
+	.vco_min	= ICST307_VCO_MIN,
+	.vd_min		= 4 + 8,
+	.vd_max		= 511 + 8,
+	.rd_min		= 1 + 2,
+	.rd_max		= 127 + 2,
+	.s2div		= icst307_s2div,
+	.idx2s		= icst307_idx2s,
+};
+
+static const struct clk_icst_desc versatile_auxosc_desc __initconst = {
+	.params = &versatile_auxosc_params,
+	.vco_offset = VERSATILE_SYS_OSCCLCD_OFFSET,
+	.lock_offset = VERSATILE_SYS_LOCK_OFFSET,
+};
+static void __init cm_osc_setup(struct device_node *np,
+				const struct clk_icst_desc *desc)
 {
 	struct clk *clk = ERR_PTR(-EINVAL);
 	const char *clk_name = np->name;
-	const struct clk_icst_desc *desc = &cm_auxosc_desc;
 	const char *parent_name;
 
 	if (!cm_base) {
@@ -65,5 +84,17 @@ static void __init of_integrator_cm_osc_setup(struct device_node *np)
 	if (!IS_ERR(clk))
 		of_clk_add_provider(np, of_clk_src_simple_get, clk);
 }
+
+static void __init of_integrator_cm_osc_setup(struct device_node *np)
+{
+	cm_osc_setup(np, &cm_auxosc_desc);
+}
 CLK_OF_DECLARE(integrator_cm_auxosc_clk,
 	"arm,integrator-cm-auxosc", of_integrator_cm_osc_setup);
+
+static void __init of_versatile_cm_osc_setup(struct device_node *np)
+{
+	cm_osc_setup(np, &versatile_auxosc_desc);
+}
+CLK_OF_DECLARE(versatile_cm_auxosc_clk,
+	       "arm,versatile-cm-auxosc", of_versatile_cm_osc_setup);
-- 
1.9.1
