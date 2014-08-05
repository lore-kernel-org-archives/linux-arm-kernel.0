From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 05 Aug 2014 12:47:33 +0200
Subject: [PATCH 05/29] drivers: convert suppress_bind_attrs parameter into
 flags
In-Reply-To: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1407235677-26324-6-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch extends struct device_driver with a flags member and converts
existing suppress_bind_attrs bool field to a flag. This way new flags
can be easily added in the future without changing the structure itself.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-integrator/impd1.c | 2 +-
 drivers/base/bus.c               | 4 ++--
 drivers/base/platform.c          | 2 +-
 drivers/pci/host/pci-mvebu.c     | 2 +-
 drivers/pci/host/pci-rcar-gen2.c | 2 +-
 drivers/pci/host/pci-tegra.c     | 2 +-
 drivers/pci/host/pcie-rcar.c     | 2 +-
 drivers/soc/tegra/pmc.c          | 2 +-
 include/linux/device.h           | 6 ++++--
 9 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index 3ce8807..a7e7330 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -406,7 +406,7 @@ static struct lm_driver impd1_driver = {
 		 * As we're dropping the probe() function, suppress driver
 		 * binding from sysfs.
 		 */
-		.suppress_bind_attrs = true,
+		.flags = DRIVER_SUPPRESS_BIND_ATTRS,
 	},
 	.probe		= impd1_probe,
 	.remove		= impd1_remove,
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 83e910a..f223f26 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -707,7 +707,7 @@ int bus_add_driver(struct device_driver *drv)
 			__func__, drv->name);
 	}
 
-	if (!drv->suppress_bind_attrs) {
+	if (!(drv->flags & DRIVER_SUPPRESS_BIND_ATTRS)) {
 		error = add_bind_files(drv);
 		if (error) {
 			/* Ditto */
@@ -740,7 +740,7 @@ void bus_remove_driver(struct device_driver *drv)
 	if (!drv->bus)
 		return;
 
-	if (!drv->suppress_bind_attrs)
+	if (!(drv->flags & DRIVER_SUPPRESS_BIND_ATTRS))
 		remove_bind_files(drv);
 	driver_remove_groups(drv, drv->bus->drv_groups);
 	driver_remove_file(drv, &driver_attr_uevent);
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 68a8b77..c696058 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -608,7 +608,7 @@ int __init_or_module platform_driver_probe(struct platform_driver *drv,
 	drv->prevent_deferred_probe = true;
 
 	/* make sure driver won't have bind/unbind attributes */
-	drv->driver.suppress_bind_attrs = true;
+	drv->driver.flags = DRIVER_SUPPRESS_BIND_ATTRS;
 
 	/* temporary section violation during probe() */
 	drv->probe = probe;
diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index a8c6f1a..6815c50 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -1086,7 +1086,7 @@ static struct platform_driver mvebu_pcie_driver = {
 		.name = "mvebu-pcie",
 		.of_match_table = mvebu_pcie_of_match_table,
 		/* driver unloading/unbinding currently not supported */
-		.suppress_bind_attrs = true,
+		.flags = DRIVER_SUPPRESS_BIND_ATTRS,
 	},
 	.probe = mvebu_pcie_probe,
 };
diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index 3ef854f..6f1b890 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -413,7 +413,7 @@ static struct platform_driver rcar_pci_driver = {
 	.driver = {
 		.name = "pci-rcar-gen2",
 		.owner = THIS_MODULE,
-		.suppress_bind_attrs = true,
+		.flags = DRIVER_SUPPRESS_BIND_ATTRS,
 		.of_match_table = rcar_pci_of_match,
 	},
 	.probe = rcar_pci_probe,
diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 0fb0fdb..2e1698d 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -1927,7 +1927,7 @@ static struct platform_driver tegra_pcie_driver = {
 		.name = "tegra-pcie",
 		.owner = THIS_MODULE,
 		.of_match_table = tegra_pcie_of_match,
-		.suppress_bind_attrs = true,
+		.flags = DRIVER_SUPPRESS_BIND_ATTRS,
 	},
 	.probe = tegra_pcie_probe,
 };
diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 4884ee5..9a1936e 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -981,7 +981,7 @@ static struct platform_driver rcar_pcie_driver = {
 		.name = DRV_NAME,
 		.owner = THIS_MODULE,
 		.of_match_table = rcar_pcie_of_match,
-		.suppress_bind_attrs = true,
+		.flags = DRIVER_SUPPRESS_BIND_ATTRS,
 	},
 	.probe = rcar_pcie_probe,
 };
diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index a2c0ceb..77c3eb3 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -892,7 +892,7 @@ static const struct of_device_id tegra_pmc_match[] = {
 static struct platform_driver tegra_pmc_driver = {
 	.driver = {
 		.name = "tegra-pmc",
-		.suppress_bind_attrs = true,
+		.flags = DRIVER_SUPPRESS_BIND_ATTRS,
 		.of_match_table = tegra_pmc_match,
 		.pm = &tegra_pmc_pm_ops,
 	},
diff --git a/include/linux/device.h b/include/linux/device.h
index 92daded..5f4ff02 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -201,7 +201,7 @@ extern struct klist *bus_get_device_klist(struct bus_type *bus);
  * @bus:	The bus which the device of this driver belongs to.
  * @owner:	The module owner.
  * @mod_name:	Used for built-in modules.
- * @suppress_bind_attrs: Disables bind/unbind via sysfs.
+ * @flags:	Flags defining driver behaviour, see below.
  * @of_match_table: The open firmware table.
  * @acpi_match_table: The ACPI match table.
  * @probe:	Called to query the existence of a specific device,
@@ -234,7 +234,7 @@ struct device_driver {
 	struct module		*owner;
 	const char		*mod_name;	/* used for built-in modules */
 
-	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
+	unsigned long		flags;
 
 	const struct of_device_id	*of_match_table;
 	const struct acpi_device_id	*acpi_match_table;
@@ -251,6 +251,8 @@ struct device_driver {
 	struct driver_private *p;
 };
 
+/* disables bind/unbind via sysfs */
+#define DRIVER_SUPPRESS_BIND_ATTRS	(1 << 0)
 
 extern int __must_check driver_register(struct device_driver *drv);
 extern void driver_unregister(struct device_driver *drv);
-- 
1.9.2
