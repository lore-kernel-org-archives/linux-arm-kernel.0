From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:23:18 +0200
Subject: [PATCH 03/21] soc: renesas: identify RZ/A2
In-Reply-To: <cover.1538128711.git.horms+renesas@verge.net.au>
References: <cover.1538128711.git.horms+renesas@verge.net.au>
Message-ID: <175f435f44b724e389f23c154d94fda45870c1f6.1538128711.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Brandt <chris.brandt@renesas.com>

Add support for identifying the RZ/A2M (R7S9210) SoC.
Also add support for reading the BSID register which is a different format
than the PRR.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/renesas-soc.c | 55 +++++++++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 56916183739b..ce19b2732433 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -46,8 +46,12 @@ static const struct renesas_family fam_rmobile __initconst __maybe_unused = {
 	.reg	= 0xe600101c,		/* CCCR (Common Chip Code Register) */
 };
 
-static const struct renesas_family fam_rza __initconst __maybe_unused = {
-	.name	= "RZ/A",
+static const struct renesas_family fam_rza1 __initconst __maybe_unused = {
+	.name	= "RZ/A1",
+};
+
+static const struct renesas_family fam_rza2 __initconst __maybe_unused = {
+	.name	= "RZ/A2",
 };
 
 static const struct renesas_family fam_rzg1 __initconst __maybe_unused = {
@@ -72,7 +76,12 @@ struct renesas_soc {
 };
 
 static const struct renesas_soc soc_rz_a1h __initconst __maybe_unused = {
-	.family	= &fam_rza,
+	.family	= &fam_rza1,
+};
+
+static const struct renesas_soc soc_rz_a2m __initconst __maybe_unused = {
+	.family	= &fam_rza2,
+	.id	= 0x3b,
 };
 
 static const struct renesas_soc soc_rmobile_ape6 __initconst __maybe_unused = {
@@ -194,6 +203,9 @@ static const struct of_device_id renesas_socs[] __initconst = {
 #ifdef CONFIG_ARCH_R7S72100
 	{ .compatible = "renesas,r7s72100",	.data = &soc_rz_a1h },
 #endif
+#ifdef CONFIG_ARCH_R7S9210
+	{ .compatible = "renesas,r7s9210",	.data = &soc_rz_a2m },
+#endif
 #ifdef CONFIG_ARCH_R8A73A4
 	{ .compatible = "renesas,r8a73a4",	.data = &soc_rmobile_ape6 },
 #endif
@@ -275,7 +287,7 @@ static int __init renesas_soc_init(void)
 	void __iomem *chipid = NULL;
 	struct soc_device *soc_dev;
 	struct device_node *np;
-	unsigned int product;
+	unsigned int product, eshi = 0, eslo;
 
 	match = of_match_node(renesas_socs, of_root);
 	if (!match)
@@ -284,6 +296,31 @@ static int __init renesas_soc_init(void)
 	soc = match->data;
 	family = soc->family;
 
+	np = of_find_compatible_node(NULL, NULL, "renesas,bsid");
+	if (np) {
+		chipid = of_iomap(np, 0);
+		of_node_put(np);
+
+		if (chipid) {
+			product = readl(chipid);
+			iounmap(chipid);
+
+			if (soc->id && ((product >> 16) & 0xff) != soc->id) {
+				pr_warn("SoC mismatch (product = 0x%x)\n",
+					product);
+				return -ENODEV;
+			}
+		}
+
+		/*
+		 * TODO: Upper 4 bits of BSID are for chip version, but the
+		 * format is not known at this time so we don't know how to
+		 * specify eshi and eslo
+		 */
+
+		goto done;
+	}
+
 	/* Try PRR first, then hardcoded fallback */
 	np = of_find_compatible_node(NULL, NULL, "renesas,prr");
 	if (np) {
@@ -302,8 +339,11 @@ static int __init renesas_soc_init(void)
 			pr_warn("SoC mismatch (product = 0x%x)\n", product);
 			return -ENODEV;
 		}
+		eshi = ((product >> 4) & 0x0f) + 1;
+		eslo = product & 0xf;
 	}
 
+done:
 	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
 	if (!soc_dev_attr)
 		return -ENOMEM;
@@ -315,10 +355,9 @@ static int __init renesas_soc_init(void)
 	soc_dev_attr->family = kstrdup_const(family->name, GFP_KERNEL);
 	soc_dev_attr->soc_id = kstrdup_const(strchr(match->compatible, ',') + 1,
 					     GFP_KERNEL);
-	if (chipid)
-		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "ES%u.%u",
-						   ((product >> 4) & 0x0f) + 1,
-						   product & 0xf);
+	if (eshi)
+		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "ES%u.%u", eshi,
+						   eslo);
 
 	pr_info("Detected Renesas %s %s %s\n", soc_dev_attr->family,
 		soc_dev_attr->soc_id, soc_dev_attr->revision ?: "");
-- 
2.11.0
