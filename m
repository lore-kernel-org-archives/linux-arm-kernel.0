From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 19 Jul 2012 00:57:49 +0800
Subject: [PATCH] PM / OPP: Initialize OPP table from device tree
Message-ID: <1342630669-27546-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With a lot of devices booting from device tree nowadays, it requires
that OPP table can be initialized from device tree.  The patch adds
a helper function of_init_opp_table together with a binding doc for
that purpose.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 Documentation/devicetree/bindings/power/opp.txt |   29 ++++++++++
 drivers/base/power/opp.c                        |   66 +++++++++++++++++++++++
 include/linux/opp.h                             |    4 ++
 3 files changed, 99 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/opp.txt

diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
new file mode 100644
index 0000000..1dd0db2
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/opp.txt
@@ -0,0 +1,29 @@
+* Generic OPP Interface
+
+SoCs have a standard set of tuples consisting of frequency and
+voltage pairs that the device will support per voltage domain. These
+are called Operating Performance Points or OPPs.
+
+Properties:
+- operating-points: An array of 3-tuples items, and each item consists
+  of frequency, voltage and enabling like <freq vol en>.
+	freq: clock frequency in kHz
+	vol: voltage in microvolt
+	en: initially enabled (1) or not (0)
+
+Examples:
+
+cpu at 0 {
+	compatible = "arm,cortex-a9";
+	reg = <0>;
+	next-level-cache = <&L2>;
+	operating-points = <
+		/* kHz    uV    en */
+		1200000 1275000 0
+		996000  1225000 1
+		792000  1100000 1
+		672000  1100000 0
+		396000  950000  1
+		198000  850000  1
+	>;
+};
diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index ac993ea..2d750f9 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -22,6 +22,7 @@
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/opp.h>
+#include <linux/of.h>
 
 /*
  * Internal data structure organization with the OPP layer library is as
@@ -674,3 +675,68 @@ struct srcu_notifier_head *opp_get_notifier(struct device *dev)
 
 	return &dev_opp->head;
 }
+
+#ifdef CONFIG_OF
+/**
+ * of_init_opp_table() - Initialize opp table from device tree
+ * @dev:	device pointer used to lookup device OPPs.
+ *
+ * Register the initial OPP table with the OPP library for given device.
+ */
+int of_init_opp_table(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	const char *propname = "operating-points";
+	const struct property *pp;
+	u32 *opp;
+	int ret, i, nr;
+
+	pp = of_find_property(np, propname, NULL);
+	if (!pp) {
+		dev_err(dev, "%s: Unable to find property", __func__);
+		return -ENODEV;
+	}
+
+	opp = kzalloc(pp->length, GFP_KERNEL);
+	if (!opp) {
+		dev_err(dev, "%s: Unable to allocate array\n", __func__);
+		return -ENOMEM;
+	}
+
+	nr = pp->length / sizeof(u32);
+	ret = of_property_read_u32_array(np, propname, opp, nr);
+	if (ret) {
+		dev_err(dev, "%s: Unable to read OPPs\n", __func__);
+		goto out;
+	}
+
+	nr /= 3;
+	for (i = 0; i < nr; i++) {
+		/*
+		 * Each OPP is a set of tuples consisting of frequency,
+		 * voltage and availability like <freq-kHz vol-uV enable>.
+		 */
+		u32 *val = opp + i * 3;
+
+		val[0] *= 1000;
+		ret = opp_add(dev, val[0], val[1]);
+		if (ret) {
+			dev_warn(dev, "%s: Failed to add OPP %d: %d\n",
+				 __func__, val[0], ret);
+			continue;
+		}
+
+		if (!val[2]) {
+			ret = opp_disable(dev, val[0]);
+			if (ret)
+				dev_warn(dev, "%s: Failed to disable OPP %d: %d\n",
+					 __func__, val[0], ret);
+		}
+	}
+
+	ret = 0;
+out:
+	kfree(opp);
+	return ret;
+}
+#endif
diff --git a/include/linux/opp.h b/include/linux/opp.h
index 2a4e5fa..fd165ad 100644
--- a/include/linux/opp.h
+++ b/include/linux/opp.h
@@ -48,6 +48,10 @@ int opp_disable(struct device *dev, unsigned long freq);
 
 struct srcu_notifier_head *opp_get_notifier(struct device *dev);
 
+#ifdef CONFIG_OF
+int of_init_opp_table(struct device *dev);
+#endif
+
 #else
 static inline unsigned long opp_get_voltage(struct opp *opp)
 {
-- 
1.7.5.4
