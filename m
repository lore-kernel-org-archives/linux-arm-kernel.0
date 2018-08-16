From: jolly.shah@xilinx.com (Jolly Shah)
Date: Thu, 16 Aug 2018 12:21:44 -0700
Subject: [PATCH v2 3/3] drivers: soc: xilinx: Add ZynqMP power domain driver
In-Reply-To: <1534447304-12919-1-git-send-email-jollys@xilinx.com>
References: <1534447304-12919-1-git-send-email-jollys@xilinx.com>
Message-ID: <1534447304-12919-4-git-send-email-jollys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jolly Shah <jolly.shah@xilinx.com>

The zynqmp-genpd driver communicates the usage requirements
for logical power domains / devices to the platform FW.
FW is responsible for choosing appropriate power states,
taking Linux' usage information into account.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/soc/xilinx/Kconfig             |   9 +
 drivers/soc/xilinx/Makefile            |   2 +
 drivers/soc/xilinx/zynqmp_pm_domains.c | 352 +++++++++++++++++++++++++++++++++
 3 files changed, 363 insertions(+)
 create mode 100644 drivers/soc/xilinx/zynqmp_pm_domains.c

diff --git a/drivers/soc/xilinx/Kconfig b/drivers/soc/xilinx/Kconfig
index 687c8f3..964b205 100644
--- a/drivers/soc/xilinx/Kconfig
+++ b/drivers/soc/xilinx/Kconfig
@@ -17,4 +17,13 @@ config XILINX_VCU
 	  To compile this driver as a module, choose M here: the
 	  module will be called xlnx_vcu.
 
+config ZYNQMP_PM_DOMAINS
+	bool "Enable Zynq MPSoC generic PM domains"
+	default y
+	depends on PM && ARCH_ZYNQMP
+	select PM_GENERIC_DOMAINS
+	help
+	  Say yes to enable device power management through PM domains
+	  If in doubt, say N.
+
 endmenu
diff --git a/drivers/soc/xilinx/Makefile b/drivers/soc/xilinx/Makefile
index dee8fd5..f468d1b 100644
--- a/drivers/soc/xilinx/Makefile
+++ b/drivers/soc/xilinx/Makefile
@@ -1,2 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_XILINX_VCU)	+= xlnx_vcu.o
+
+obj-$(CONFIG_ZYNQMP_PM_DOMAINS) += zynqmp_pm_domains.o
diff --git a/drivers/soc/xilinx/zynqmp_pm_domains.c b/drivers/soc/xilinx/zynqmp_pm_domains.c
new file mode 100644
index 0000000..aab462c
--- /dev/null
+++ b/drivers/soc/xilinx/zynqmp_pm_domains.c
@@ -0,0 +1,352 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ZynqMP Generic PM domain support
+ *
+ *  Copyright (C) 2015-2018 Xilinx, Inc.
+ *
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajan.vaja@xilinx.com>
+ */
+
+#include <linux/err.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/slab.h>
+
+#include <linux/firmware/xlnx-zynqmp.h>
+
+/* Flag stating if PM nodes mapped to the PM domain has been requested */
+#define ZYNQMP_PM_DOMAIN_REQUESTED	BIT(0)
+
+/**
+ * struct zynqmp_pm_domain - Wrapper around struct generic_pm_domain
+ * @gpd:		Generic power domain
+ * @dev_list:		List of devices belong to power domain
+ * @node_ids:		PM node IDs corresponding to device(s) inside PM domain
+ * @node_id_num:	Number of PM node IDs
+ * @flags:		ZynqMP PM domain flags
+ */
+struct zynqmp_pm_domain {
+	struct generic_pm_domain gpd;
+	struct list_head dev_list;
+	u32 *node_ids;
+	int node_id_num;
+	u8 flags;
+};
+
+/*
+ * struct zynqmp_domain_device - Device node present in power domain
+ * @dev:	Device
+ * &list:	List member for the devices in domain list
+ */
+struct zynqmp_domain_device {
+	struct device *dev;
+	struct list_head list;
+};
+
+/**
+ * zynqmp_gpd_is_active_wakeup_path() - Check if device is in wakeup source
+ *					path
+ * @dev:	Device to check for wakeup source path
+ * @not_used:	Data member (not required)
+ *
+ * This function is checks device's child hierarchy and checks if any device is
+ * set as wakeup source.
+ *
+ * Return: 1 if device is in wakeup source path else 0
+ */
+static int zynqmp_gpd_is_active_wakeup_path(struct device *dev, void *not_used)
+{
+	int may_wakeup;
+
+	may_wakeup = device_may_wakeup(dev);
+	if (may_wakeup)
+		return may_wakeup;
+
+	return device_for_each_child(dev, NULL,
+			zynqmp_gpd_is_active_wakeup_path);
+}
+
+/**
+ * zynqmp_gpd_power_on() - Power on PM domain
+ * @domain:	Generic PM domain
+ *
+ * This function is called before devices inside a PM domain are resumed, to
+ * power on PM domain.
+ *
+ * Return: 0 on success, error code otherwise
+ */
+static int zynqmp_gpd_power_on(struct generic_pm_domain *domain)
+{
+	int i, ret;
+	struct zynqmp_pm_domain *pd;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->set_requirement)
+		return -ENXIO;
+
+	pd = container_of(domain, struct zynqmp_pm_domain, gpd);
+	for (i = 0; i < pd->node_id_num; i++) {
+		ret = eemi_ops->set_requirement(pd->node_ids[i],
+						ZYNQMP_PM_CAPABILITY_ACCESS,
+						ZYNQMP_PM_MAX_QOS,
+						ZYNQMP_PM_REQUEST_ACK_BLOCKING);
+		if (ret) {
+			pr_err("%s() %s set requirement for node %d failed: %d\n",
+			       __func__, domain->name, pd->node_ids[i], ret);
+			return ret;
+		}
+	}
+
+	pr_debug("%s() Powered on %s domain\n", __func__, domain->name);
+
+	return 0;
+}
+
+/**
+ * zynqmp_gpd_power_off() - Power off PM domain
+ * @domain:	Generic PM domain
+ *
+ * This function is called after devices inside a PM domain are suspended, to
+ * power off PM domain.
+ *
+ * Return: 0 on success, error code otherwise
+ */
+static int zynqmp_gpd_power_off(struct generic_pm_domain *domain)
+{
+	int i, ret;
+	struct zynqmp_pm_domain *pd;
+	struct zynqmp_domain_device *zdev, *tmp;
+	u32 capabilities = 0;
+	bool may_wakeup;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->set_requirement)
+		return -ENXIO;
+
+	pd = container_of(domain, struct zynqmp_pm_domain, gpd);
+
+	/* If domain is already released there is nothing to be done */
+	if (!(pd->flags & ZYNQMP_PM_DOMAIN_REQUESTED))
+		return 0;
+
+	list_for_each_entry_safe(zdev, tmp, &pd->dev_list, list) {
+		/* If device is in wakeup path, set capability to WAKEUP */
+		may_wakeup = zynqmp_gpd_is_active_wakeup_path(zdev->dev, NULL);
+		if (may_wakeup) {
+			dev_dbg(zdev->dev, "device is in wakeup path in %s\n",
+				domain->name);
+			capabilities = ZYNQMP_PM_CAPABILITY_WAKEUP;
+			break;
+		}
+	}
+
+	for (i = pd->node_id_num - 1; i >= 0; i--) {
+		ret = eemi_ops->set_requirement(pd->node_ids[i],
+						   capabilities, 0,
+						   ZYNQMP_PM_REQUEST_ACK_NO);
+		/**
+		 * If powering down of any node inside this domain fails,
+		 * report and return the error
+		 */
+		if (ret) {
+			pr_err("%s() %s set requirement for node %d failed: %d\n",
+			       __func__, domain->name, pd->node_ids[i], ret);
+			return ret;
+		}
+	}
+
+	pr_debug("%s() Powered off %s domain\n", __func__, domain->name);
+
+	return 0;
+}
+
+/**
+ * zynqmp_gpd_attach_dev() - Attach device to the PM domain
+ * @domain:	Generic PM domain
+ * @dev:	Device to attach
+ *
+ * Return: 0 on success, error code otherwise
+ */
+static int zynqmp_gpd_attach_dev(struct generic_pm_domain *domain,
+				 struct device *dev)
+{
+	int i, ret;
+	struct zynqmp_pm_domain *pd;
+	struct zynqmp_domain_device *zdev;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->request_node)
+		return -ENXIO;
+
+	pd = container_of(domain, struct zynqmp_pm_domain, gpd);
+
+	zdev = devm_kzalloc(dev, sizeof(*zdev), GFP_KERNEL);
+	if (!zdev)
+		return -ENOMEM;
+
+	zdev->dev = dev;
+	list_add(&zdev->list, &pd->dev_list);
+
+	/* If this is not the first device to attach there is nothing to do */
+	if (domain->device_count)
+		return 0;
+
+	for (i = 0; i < pd->node_id_num; i++) {
+		ret = eemi_ops->request_node(pd->node_ids[i], 0, 0,
+						ZYNQMP_PM_REQUEST_ACK_BLOCKING);
+		/* If requesting a node fails print and return the error */
+		if (ret) {
+			pr_err("%s() %s request failed for node %d: %d\n",
+			       __func__, domain->name, pd->node_ids[i], ret);
+			list_del(&zdev->list);
+			zdev->dev = NULL;
+			devm_kfree(dev, zdev);
+			return ret;
+		}
+	}
+
+	pd->flags |= ZYNQMP_PM_DOMAIN_REQUESTED;
+
+	pr_debug("%s() %s attached to %s domain\n", __func__,
+		 dev_name(dev), domain->name);
+
+	return 0;
+}
+
+/**
+ * zynqmp_gpd_detach_dev() - Detach device from the PM domain
+ * @domain:	Generic PM domain
+ * @dev:	Device to detach
+ */
+static void zynqmp_gpd_detach_dev(struct generic_pm_domain *domain,
+				  struct device *dev)
+{
+	int i, ret;
+	struct zynqmp_pm_domain *pd;
+	struct zynqmp_domain_device *zdev, *tmp;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->release_node)
+		return;
+
+	pd = container_of(domain, struct zynqmp_pm_domain, gpd);
+
+	list_for_each_entry_safe(zdev, tmp, &pd->dev_list, list)
+		if (zdev->dev == dev) {
+			list_del(&zdev->list);
+			zdev->dev = NULL;
+			devm_kfree(dev, zdev);
+		}
+
+	/* If this is not the last device to detach there is nothing to do */
+	if (domain->device_count)
+		return;
+
+	for (i = 0; i < pd->node_id_num; i++) {
+		ret = eemi_ops->release_node(pd->node_ids[i]);
+		/* If releasing a node fails print the error and return */
+		if (ret) {
+			pr_err("%s() %s release failed for node %d: %d\n",
+			       __func__, domain->name, pd->node_ids[i], ret);
+			return;
+		}
+	}
+
+	pd->flags &= ~ZYNQMP_PM_DOMAIN_REQUESTED;
+
+	pr_debug("%s() %s detached from %s domain\n", __func__,
+		 dev_name(dev), domain->name);
+}
+
+/**
+ * zynqmp_gpd_probe() - Initialize ZynqMP specific PM domains
+ * @pdev:	Platform device pointer
+ *
+ * Description:	This function populates struct zynqmp_pm_domain for each PM
+ * domain and initalizes generic PM domain. If the "pd-id" DT property
+ * of a certain domain is missing or invalid, that domain will be skipped.
+ *
+ * Return: 0 on success, error code otherwise
+ */
+static int zynqmp_gpd_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct device_node *child_err, *child, *np = pdev->dev.of_node;
+
+	for_each_child_of_node(np, child) {
+		struct zynqmp_pm_domain *pd;
+
+		pd = devm_kzalloc(&pdev->dev, sizeof(*pd), GFP_KERNEL);
+		if (!pd) {
+			ret = -ENOMEM;
+			goto err_cleanup;
+		}
+
+		ret = of_property_count_u32_elems(child, "pd-id");
+		if (ret <= 0)
+			goto err_cleanup;
+
+		pd->node_id_num = ret;
+		pd->node_ids = devm_kcalloc(&pdev->dev, ret,
+					    sizeof(*pd->node_ids), GFP_KERNEL);
+		if (!pd->node_ids) {
+			ret = -ENOMEM;
+			goto err_cleanup;
+		}
+
+		ret = of_property_read_u32_array(child, "pd-id", pd->node_ids,
+						 pd->node_id_num);
+		if (ret)
+			goto err_cleanup;
+
+		pd->gpd.name = kstrdup(child->name, GFP_KERNEL);
+		pd->gpd.power_off = zynqmp_gpd_power_off;
+		pd->gpd.power_on = zynqmp_gpd_power_on;
+		pd->gpd.attach_dev = zynqmp_gpd_attach_dev;
+		pd->gpd.detach_dev = zynqmp_gpd_detach_dev;
+
+		/* Mark all PM domains as initially powered off */
+		pm_genpd_init(&pd->gpd, NULL, true);
+
+		ret = of_genpd_add_provider_simple(child, &pd->gpd);
+		if (ret)
+			goto err_cleanup;
+
+		INIT_LIST_HEAD(&pd->dev_list);
+
+		pr_debug("%s() %s PM domain registered\n",
+			 __func__, child->name);
+	}
+
+	return 0;
+
+err_cleanup:
+	child_err = child;
+	for_each_child_of_node(np, child) {
+		if (child == child_err)
+			break;
+		of_genpd_del_provider(child);
+	}
+
+	return ret;
+}
+
+static const struct of_device_id zynqmp_power_domain_of_match[] = {
+	{.compatible = "xlnx,zynqmp-power-controller"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, zynqmp_power_domain_of_match);
+
+static struct platform_driver zynqmp_power_domain_driver = {
+	.driver	= {
+		.name = "zynqmp_power_controller",
+		.of_match_table = zynqmp_power_domain_of_match,
+	},
+	.probe = zynqmp_gpd_probe,
+};
+module_platform_driver(zynqmp_power_domain_driver);
-- 
2.7.4
