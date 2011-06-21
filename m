From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 Jun 2011 11:40:51 +0100
Subject: [PATCH] dt: early platform devices support
Message-ID: <mailman.32.1308664016.24103.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for populating early platform devices from the device
tree, by walking the tree and adding nodes whose 'compatible'
property matches the 'class' string passed as a parameter.

This allows devices to be probed long before the whole device
infrastructure is available.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/of/platform.c       |   31 +++++++++++++++++++++++++++++++
 include/linux/of_platform.h |    2 ++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 9b785be..1ba304e 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -326,4 +326,35 @@ int of_platform_populate(struct device_node *root,
 =09of_node_put(root);
 =09return rc;
 }
+
+/**
+ * of_early_platform_populate() - Populate early platform devices from DT
+ * @class: string to compare to the 'compatible' attributes
+ *
+ * This function walks the device tree and register devices whose
+ * 'compatible' property matches the 'class' parameter.
+ *
+ * Returns 0 on success, < 0 on failure.
+ */
+int of_early_platform_populate(const char *class)
+{
+=09struct platform_device *pdev;
+=09struct device_node *np =3D NULL;
+=09int id =3D 0, rc =3D 0;
+
+=09while ((np =3D of_find_compatible_node(np, NULL, class))) {
+=09=09pdev =3D kzalloc(sizeof(*pdev), GFP_KERNEL);
+=09=09if (!pdev) {
+=09=09=09of_node_put(np);
+=09=09=09rc =3D -ENOMEM;
+=09=09=09break;
+=09=09}
+=09=09pdev->name =3D np->name;
+=09=09pdev->id =3D id++;
+=09=09pdev->dev.of_node =3D of_node_get(np);
+=09=09early_platform_add_devices(&pdev, 1);
+=09}
+
+=09return rc;
+}
 #endif /* !CONFIG_SPARC */
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 43c723d..fee17f7 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -58,6 +58,8 @@ extern int of_platform_bus_probe(struct device_node *root=
,
 extern int of_platform_populate(struct device_node *root,
 =09=09=09=09const struct of_device_id *matches,
 =09=09=09=09struct device *parent);
+
+extern int of_early_platform_populate(const char *class);
 #endif /* !CONFIG_SPARC */
=20
 #endif /* CONFIG_OF_DEVICE */
--=20
1.7.0.4

--------------090307080308090105090300--
