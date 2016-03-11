From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Fri, 11 Mar 2016 14:29:28 +0530
Subject: [PATCH v1 1/4] mfd: syscon: Introduce syscon_regmap_read_from_offset
In-Reply-To: <cover.1457684688.git.maitysanchayan@gmail.com>
References: <cover.1457684688.git.maitysanchayan@gmail.com>
Message-ID: <bf50505be7aedd3bc30bd4959c9a7c0273654944.1457684688.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently syscon does not provide an abstraction to access a
register from syscon reference like below

ocotp-cfg1 = <&ocotp 0x20>

syscon_regmap_read_from_offset provides a generic abstraction to
access a register from syscon reference as above. It allows to
specify the node and node name of phandle reference, reading the
offset from the node entry and providing the value from the offset
in the register map.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 drivers/mfd/syscon.c       | 30 ++++++++++++++++++++++++++++++
 include/linux/mfd/syscon.h | 10 ++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index b7aabee..349c38e 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -129,6 +129,36 @@ struct regmap *syscon_node_to_regmap(struct device_node *np)
 }
 EXPORT_SYMBOL_GPL(syscon_node_to_regmap);
 
+int syscon_regmap_read_from_offset(struct device_node *np,
+				const char *s, unsigned int *val)
+{
+	struct of_phandle_args pargs;
+	struct regmap *regmap;
+	int offset;
+	int ret;
+
+	if (!np)
+		return -ENODEV;
+
+	ret = of_parse_phandle_with_fixed_args(np, s, 1, 0, &pargs);
+	if (ret)
+		return ret;
+
+	regmap = syscon_node_to_regmap(pargs.np);
+	if (IS_ERR(regmap)) {
+		of_node_put(pargs.np);
+		return PTR_ERR(regmap);
+	}
+
+	offset = pargs.args[0];
+	of_node_put(pargs.np);
+
+	ret = regmap_read(regmap, offset, val);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(syscon_regmap_read_from_offset);
+
 struct regmap *syscon_regmap_lookup_by_compatible(const char *s)
 {
 	struct device_node *syscon_np;
diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
index 75e543b..3c02ed9 100644
--- a/include/linux/mfd/syscon.h
+++ b/include/linux/mfd/syscon.h
@@ -26,6 +26,9 @@ extern struct regmap *syscon_regmap_lookup_by_pdevname(const char *s);
 extern struct regmap *syscon_regmap_lookup_by_phandle(
 					struct device_node *np,
 					const char *property);
+extern int syscon_regmap_read_from_offset(struct device_node *np,
+					  const char *s,
+					  unsigned int *val);
 #else
 static inline struct regmap *syscon_node_to_regmap(struct device_node *np)
 {
@@ -48,6 +51,13 @@ static inline struct regmap *syscon_regmap_lookup_by_phandle(
 {
 	return ERR_PTR(-ENOSYS);
 }
+
+static inline int syscon_regmap_read_from_offset(struct device_node *np,
+						 const char *s,
+						 unsigned int *val)
+{
+	return ERR_PTR(-ENOSYS);
+}
 #endif
 
 #endif /* __LINUX_MFD_SYSCON_H__ */
-- 
2.7.2
