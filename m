From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 16 Sep 2010 07:58:16 -0700
Subject: [PATCH] OPP: remove OMAP specifics to make more generic
Message-ID: <mailman.241.1284649732.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Internal OPP management is based on 'struct device *', so
we don't need to have omap_hwmod specific knowledge in this layer.

Change opp_add() to take a 'struct device *' instead of using
the OMAP hwmod in the opp_def to lookup the struct device.

Move OMAP-specific hwmod lookups into the OMAP specific layer
which adds OPPs to the database.

Quickly tested on OMAP3 to see that all OPPs are still registered
correctly with CPUfreq

---
 arch/arm/mach-omap2/opp3xxx_data.c    |   18 +++++++++++++++++-
 arch/arm/plat-omap/include/plat/opp.h |    2 +-
 arch/arm/plat-omap/opp.c              |   24 ++----------------------
 3 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-omap2/opp3x=
xx_data.c
index e337aeb..f3f9ae4 100644
--- a/arch/arm/mach-omap2/opp3xxx_data.c
+++ b/arch/arm/mach-omap2/opp3xxx_data.c
@@ -23,6 +23,7 @@
=20
 #include <plat/opp.h>
 #include <plat/cpu.h>
+#include <plat/omap_device.h>
=20
 static struct omap_opp_def __initdata omap34xx_opp_def_list[] =3D {
 	/* MPU OPP1 */
@@ -114,7 +115,22 @@ int __init omap3_pm_init_opp_table(void)
=20
 	opp_def =3D omap3_opp_def_list;
 	for (i =3D 0; i < omap3_opp_def_size; i++) {
-		r =3D opp_add(opp_def++);
+		struct omap_hwmod *oh;
+		struct device *dev;
+
+		if (!opp_def->hwmod_name) {
+			pr_err("%s: missing name of omap_hwmod, ignoring.\n", __func__);
+			return -EINVAL;
+		}
+		oh =3D omap_hwmod_lookup(opp_def->hwmod_name);
+		if (!oh || !oh->od) {
+			pr_warn("%s: no hwmod or odev for %s, cannot add OPPs.\n",
+				__func__, opp_def->hwmod_name);
+			return -EINVAL;
+		}
+		dev =3D &oh->od->pdev.dev;
+
+		r =3D opp_add(dev, opp_def++);
 		if (r)
 			pr_err("unable to add OPP %ld Hz for %s\n",
 			       opp_def->freq, opp_def->hwmod_name);
diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/inc=
lude/plat/opp.h
index 9af8c83..82cfdd6 100644
--- a/arch/arm/plat-omap/include/plat/opp.h
+++ b/arch/arm/plat-omap/include/plat/opp.h
@@ -75,7 +75,7 @@ struct omap_opp *opp_find_freq_floor(struct device *dev, =
unsigned long *freq);
=20
 struct omap_opp *opp_find_freq_ceil(struct device *dev, unsigned long *fre=
q);
=20
-int opp_add(const struct omap_opp_def *opp_def);
+int opp_add(struct device *dev, const struct omap_opp_def *opp_def);
=20
 int opp_enable(struct omap_opp *opp);
=20
diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
index b26326b..f5295ca 100644
--- a/arch/arm/plat-omap/opp.c
+++ b/arch/arm/plat-omap/opp.c
@@ -21,7 +21,6 @@
 #include <linux/list.h>
=20
 #include <plat/opp.h>
-#include <plat/omap_device.h>
=20
 /**
  * struct omap_opp - OMAP OPP description structure
@@ -58,7 +57,6 @@ struct omap_opp {
 struct device_opp {
 	struct list_head node;
=20
-	struct omap_hwmod *oh;
 	struct device *dev;
=20
 	struct list_head opp_list;
@@ -291,29 +289,12 @@ static void omap_opp_populate(struct omap_opp *opp,
  *
  * This function adds an opp definition to the opp list and returns status.
  */
-int opp_add(const struct omap_opp_def *opp_def)
+int opp_add(struct device *dev, const struct omap_opp_def *opp_def)
 {
-	struct omap_hwmod *oh;
-	struct device *dev =3D NULL;
 	struct device_opp *tmp_dev_opp, *dev_opp =3D NULL;
 	struct omap_opp *opp, *new_opp;
-	struct platform_device *pdev;
 	struct list_head *head;
=20
-	/* find the correct hwmod, and device */
-	if (!opp_def->hwmod_name) {
-		pr_err("%s: missing name of omap_hwmod, ignoring.\n", __func__);
-		return -EINVAL;
-	}
-	oh =3D omap_hwmod_lookup(opp_def->hwmod_name);
-	if (!oh || !oh->od) {
-		pr_warn("%s: no hwmod or odev for %s, cannot add OPPs.\n",
-			__func__, opp_def->hwmod_name);
-		return -EINVAL;
-	}
-	pdev =3D &oh->od->pdev;
-	dev =3D &oh->od->pdev.dev;
-
 	/* Check for existing list for 'dev' */
 	list_for_each_entry(tmp_dev_opp, &dev_opp_list, node) {
 		if (dev =3D=3D tmp_dev_opp->dev) {
@@ -331,8 +312,7 @@ int opp_add(const struct omap_opp_def *opp_def)
 			return -ENOMEM;
 		}
=20
-		dev_opp->oh =3D oh;
-		dev_opp->dev =3D &oh->od->pdev.dev;
+		dev_opp->dev =3D dev;
 		INIT_LIST_HEAD(&dev_opp->opp_list);
=20
 		list_add(&dev_opp->node, &dev_opp_list);
--=20
1.7.2.1
