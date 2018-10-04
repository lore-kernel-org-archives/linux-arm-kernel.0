From: jolly.shah@xilinx.com (Jolly Shah)
Date: Thu, 4 Oct 2018 14:23:41 -0700
Subject: [PATCH v3 4/4] drivers: soc: xilinx: Add ZynqMP power domain driver
In-Reply-To: <1538688221-9823-1-git-send-email-jollys@xilinx.com>
References: <1538688221-9823-1-git-send-email-jollys@xilinx.com>
Message-ID: <1538688221-9823-5-git-send-email-jollys@xilinx.com>
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
 drivers/firmware/xilinx/Kconfig        |   1 +
 drivers/firmware/xilinx/zynqmp.c       |  15 ++
 drivers/soc/xilinx/Kconfig             |   9 +
 drivers/soc/xilinx/Makefile            |   2 +
 drivers/soc/xilinx/zynqmp_pm_domains.c | 403 +++++++++++++++++++++++++++++++++
 5 files changed, 430 insertions(+)
 create mode 100644 drivers/soc/xilinx/zynqmp_pm_domains.c

diff --git a/drivers/firmware/xilinx/Kconfig b/drivers/firmware/xilinx/Kconfig
index 8f44b9c..bd33bbf 100644
--- a/drivers/firmware/xilinx/Kconfig
+++ b/drivers/firmware/xilinx/Kconfig
@@ -6,6 +6,7 @@ menu "Zynq MPSoC Firmware Drivers"
 
 config ZYNQMP_FIRMWARE
 	bool "Enable Xilinx Zynq MPSoC firmware interface"
+	select MFD_CORE
 	help
 	  Firmware interface driver is used by different
 	  drivers to communicate with the firmware for
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index faf6a52..6b365df 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -14,6 +14,7 @@
 #include <linux/compiler.h>
 #include <linux/device.h>
 #include <linux/init.h>
+#include <linux/mfd/core.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
@@ -23,6 +24,12 @@
 #include <linux/firmware/xlnx-zynqmp.h>
 #include "zynqmp-debug.h"
 
+static const struct mfd_cell firmware_devs[] = {
+	{
+		.name = "zynqmp_power_controller",
+	},
+};
+
 /**
  * zynqmp_pm_ret_code() - Convert PMU-FW error codes to Linux error codes
  * @ret_status:		PMUFW return code
@@ -596,11 +603,19 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
 
 	zynqmp_pm_api_debugfs_init();
 
+	ret = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, firmware_devs,
+			      ARRAY_SIZE(firmware_devs), NULL, 0, NULL);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add MFD devices %d\n", ret);
+		return ret;
+	}
+
 	return of_platform_populate(dev->of_node, NULL, NULL, dev);
 }
 
 static int zynqmp_firmware_remove(struct platform_device *pdev)
 {
+	mfd_remove_devices(&pdev->dev);
 	zynqmp_pm_api_debugfs_exit();
 
 	return 0;
diff --git a/drivers/soc/xilinx/Kconfig b/drivers/soc/xilinx/Kconfig
index 687c8f3..81a345e 100644
--- a/drivers/soc/xilinx/Kconfig
+++ b/drivers/soc/xilinx/Kconfig
@@ -17,4 +17,13 @@ config XILINX_VCU
 	  To compile this driver as a module, choose M here: the
 	  module will be called xlnx_vcu.
 
+config ZYNQMP_PM_DOMAINS
+	bool "Enable Zynq MPSoC generic PM domains"
+	default y
+	depends on PM && ARCH_ZYNQMP && ZYNQMP_FIRMWARE
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
index 0000000..999fe67
--- /dev/null
+++ b/drivers/soc/xilinx/zynqmp_pm_domains.c
@@ -0,0 +1,403 @@
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
+	const u32 *node_ids;
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
+/*
+ * struct zynqmp_pd_info - PM domain info
+ * @id:		Number of PM node IDs
+ * @ids:	PM node IDs corresponding to device(s) inside PM domain
+ * @name:	PM node name
+ */
+struct zynqmp_pd_info {
+	u32 num_id;
+	const u32 *ids;
+	const char *name;
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
+	int ret, i;
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
+	int ret, i;
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
+						capabilities, 0,
+						ZYNQMP_PM_REQUEST_ACK_NO);
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
+	int ret, i;
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
+					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
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
+	int ret, i;
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
+static const u32 usb0_ids[] = {NODE_USB_0};
+static const u32 usb1_ids[] = {NODE_USB_1};
+static const u32 sata_ids[] = {NODE_SATA};
+static const u32 spi0_ids[] = {NODE_SPI_0};
+static const u32 spi1_ids[] = {NODE_SPI_1};
+static const u32 uart0_ids[] = {NODE_UART_0};
+static const u32 uart1_ids[] = {NODE_UART_1};
+static const u32 eth0_ids[] = {NODE_ETH_0};
+static const u32 eth1_ids[] = {NODE_ETH_1};
+static const u32 eth2_ids[] = {NODE_ETH_2};
+static const u32 eth3_ids[] = {NODE_ETH_3};
+static const u32 i2c0_ids[] = {NODE_I2C_0};
+static const u32 i2c1_ids[] = {NODE_I2C_1};
+static const u32 dp_ids[] = {NODE_DP};
+static const u32 gdma_ids[] = {NODE_GDMA};
+static const u32 adma_ids[] = {NODE_ADMA};
+static const u32 ttc0_ids[] = {NODE_TTC_0};
+static const u32 ttc1_ids[] = {NODE_TTC_1};
+static const u32 ttc2_ids[] = {NODE_TTC_2};
+static const u32 ttc3_ids[] = {NODE_TTC_3};
+static const u32 sd0_ids[] = {NODE_SD_0};
+static const u32 sd1_ids[] = {NODE_SD_1};
+static const u32 nand_ids[] = {NODE_NAND};
+static const u32 qspi_ids[] = {NODE_QSPI};
+static const u32 gpio_ids[] = {NODE_GPIO};
+static const u32 can0_ids[] = {NODE_CAN_0};
+static const u32 can1_ids[] = {NODE_CAN_1};
+static const u32 pcie_ids[] = {NODE_PCIE};
+static const u32 gpu_ids[] = {NODE_GPU, NODE_GPU_PP_0, NODE_GPU_PP_1};
+
+#define ZYNQMP_PM_DOMAIN(nm)	{ \
+		.name = "pd-" #nm, \
+		.num_id = ARRAY_SIZE(nm ## _ids), \
+		.ids = nm ## _ids, \
+	}
+
+static const struct zynqmp_pd_info pm_ids[] = {
+	ZYNQMP_PM_DOMAIN(usb0),
+	ZYNQMP_PM_DOMAIN(usb1),
+	ZYNQMP_PM_DOMAIN(sata),
+	ZYNQMP_PM_DOMAIN(spi0),
+	ZYNQMP_PM_DOMAIN(spi1),
+	ZYNQMP_PM_DOMAIN(uart0),
+	ZYNQMP_PM_DOMAIN(uart1),
+	ZYNQMP_PM_DOMAIN(eth0),
+	ZYNQMP_PM_DOMAIN(eth1),
+	ZYNQMP_PM_DOMAIN(eth2),
+	ZYNQMP_PM_DOMAIN(eth3),
+	ZYNQMP_PM_DOMAIN(i2c0),
+	ZYNQMP_PM_DOMAIN(i2c1),
+	ZYNQMP_PM_DOMAIN(dp),
+	ZYNQMP_PM_DOMAIN(gdma),
+	ZYNQMP_PM_DOMAIN(adma),
+	ZYNQMP_PM_DOMAIN(ttc0),
+	ZYNQMP_PM_DOMAIN(ttc1),
+	ZYNQMP_PM_DOMAIN(ttc2),
+	ZYNQMP_PM_DOMAIN(ttc3),
+	ZYNQMP_PM_DOMAIN(sd0),
+	ZYNQMP_PM_DOMAIN(sd1),
+	ZYNQMP_PM_DOMAIN(nand),
+	ZYNQMP_PM_DOMAIN(qspi),
+	ZYNQMP_PM_DOMAIN(gpio),
+	ZYNQMP_PM_DOMAIN(can0),
+	ZYNQMP_PM_DOMAIN(can1),
+	ZYNQMP_PM_DOMAIN(pcie),
+	ZYNQMP_PM_DOMAIN(gpu),
+};
+
+static int zynqmp_gpd_probe(struct platform_device *pdev)
+{
+	int i;
+	struct genpd_onecell_data *zynqmp_pd_data;
+	struct generic_pm_domain **domains;
+	struct zynqmp_pm_domain *pd;
+	struct device *dev = &pdev->dev;
+
+	pd = devm_kcalloc(dev, ARRAY_SIZE(pm_ids), sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return -ENOMEM;
+
+	zynqmp_pd_data = devm_kzalloc(dev, sizeof(*zynqmp_pd_data), GFP_KERNEL);
+	if (!zynqmp_pd_data)
+		return -ENOMEM;
+
+	domains = devm_kcalloc(dev, ARRAY_SIZE(pm_ids), sizeof(*domains),
+			       GFP_KERNEL);
+	if (!domains)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(pm_ids); i++, pd++) {
+		pd->node_id_num = pm_ids[i].num_id;
+		pd->node_ids = pm_ids[i].ids;
+		pd->gpd.name = pm_ids[i].name;
+		pd->gpd.power_off = zynqmp_gpd_power_off;
+		pd->gpd.power_on = zynqmp_gpd_power_on;
+		pd->gpd.attach_dev = zynqmp_gpd_attach_dev;
+		pd->gpd.detach_dev = zynqmp_gpd_detach_dev;
+
+		domains[i] = &pd->gpd;
+
+		/* Mark all PM domains as initially powered off */
+		pm_genpd_init(&pd->gpd, NULL, true);
+		INIT_LIST_HEAD(&pd->dev_list);
+	}
+
+	zynqmp_pd_data->domains = domains;
+	zynqmp_pd_data->num_domains = ARRAY_SIZE(pm_ids);
+	of_genpd_add_provider_onecell(dev->parent->of_node, zynqmp_pd_data);
+
+	return 0;
+}
+
+static int zynqmp_gpd_remove(struct platform_device *pdev)
+{
+	of_genpd_del_provider(pdev->dev.parent->of_node);
+
+	return 0;
+}
+
+static struct platform_driver zynqmp_power_domain_driver = {
+	.driver	= {
+		.name = "zynqmp_power_controller",
+	},
+	.probe = zynqmp_gpd_probe,
+	.remove = zynqmp_gpd_remove,
+};
+module_platform_driver(zynqmp_power_domain_driver);
+
+MODULE_ALIAS("platform:zynqmp_power_controller");
-- 
2.7.4
