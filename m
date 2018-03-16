From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:53:26 +0100
Subject: [PATCH 04/14] soc: renesas: rcar-rst: Enable watchdog as reset
 trigger for Gen2
In-Reply-To: <cover.1521211738.git.horms+renesas@verge.net.au>
References: <cover.1521211738.git.horms+renesas@verge.net.au>
Message-ID: <69e0d1b8db8f8cc319f966ec3eb2fffce28c4f28.1521211738.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

This patch allows for platform specific quirks as some of the SoC need
further customization for the watchdog to work properly, like for R-Car
Gen2 and for RZ/G.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/rcar-rst.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/renesas/rcar-rst.c b/drivers/soc/renesas/rcar-rst.c
index e2340eb9ea9c..34136664ece4 100644
--- a/drivers/soc/renesas/rcar-rst.c
+++ b/drivers/soc/renesas/rcar-rst.c
@@ -13,8 +13,18 @@
 #include <linux/of_address.h>
 #include <linux/soc/renesas/rcar-rst.h>
 
+#define WDTRSTCR_RESET		0xA55A0002
+#define WDTRSTCR		0x0054
+
+static int rcar_rst_enable_wdt_reset(void __iomem *base)
+{
+	iowrite32(WDTRSTCR_RESET, base + WDTRSTCR);
+	return 0;
+}
+
 struct rst_config {
-	unsigned int modemr;	/* Mode Monitoring Register Offset */
+	unsigned int modemr;		/* Mode Monitoring Register Offset */
+	int (*configure)(void *base);	/* Platform specific configuration */
 };
 
 static const struct rst_config rcar_rst_gen1 __initconst = {
@@ -23,6 +33,11 @@ static const struct rst_config rcar_rst_gen1 __initconst = {
 
 static const struct rst_config rcar_rst_gen2 __initconst = {
 	.modemr = 0x60,
+	.configure = rcar_rst_enable_wdt_reset,
+};
+
+static const struct rst_config rcar_rst_gen3 __initconst = {
+	.modemr = 0x60,
 };
 
 static const struct of_device_id rcar_rst_matches[] __initconst = {
@@ -38,12 +53,12 @@ static const struct of_device_id rcar_rst_matches[] __initconst = {
 	{ .compatible = "renesas,r8a7792-rst", .data = &rcar_rst_gen2 },
 	{ .compatible = "renesas,r8a7793-rst", .data = &rcar_rst_gen2 },
 	{ .compatible = "renesas,r8a7794-rst", .data = &rcar_rst_gen2 },
-	/* R-Car Gen3 is handled like R-Car Gen2 */
-	{ .compatible = "renesas,r8a7795-rst", .data = &rcar_rst_gen2 },
-	{ .compatible = "renesas,r8a7796-rst", .data = &rcar_rst_gen2 },
-	{ .compatible = "renesas,r8a77970-rst", .data = &rcar_rst_gen2 },
-	{ .compatible = "renesas,r8a77980-rst", .data = &rcar_rst_gen2 },
-	{ .compatible = "renesas,r8a77995-rst", .data = &rcar_rst_gen2 },
+	/* R-Car Gen3 */
+	{ .compatible = "renesas,r8a7795-rst", .data = &rcar_rst_gen3 },
+	{ .compatible = "renesas,r8a7796-rst", .data = &rcar_rst_gen3 },
+	{ .compatible = "renesas,r8a77970-rst", .data = &rcar_rst_gen3 },
+	{ .compatible = "renesas,r8a77980-rst", .data = &rcar_rst_gen3 },
+	{ .compatible = "renesas,r8a77995-rst", .data = &rcar_rst_gen3 },
 	{ /* sentinel */ }
 };
 
@@ -72,6 +87,14 @@ static int __init rcar_rst_init(void)
 	rcar_rst_base = base;
 	cfg = match->data;
 	saved_mode = ioread32(base + cfg->modemr);
+	if (cfg->configure) {
+		error = cfg->configure(base);
+		if (error) {
+			pr_warn("%pOF: Cannot run SoC specific configuration\n",
+				np);
+			goto out_put;
+		}
+	}
 
 	pr_debug("%pOF: MODE = 0x%08x\n", np, saved_mode);
 
-- 
2.11.0
