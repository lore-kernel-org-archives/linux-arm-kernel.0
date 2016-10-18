From: zourongrong@gmail.com (Rongrong Zou)
Date: Tue, 18 Oct 2016 12:01:16 +0800
Subject: [PATCH v4 1/9] drm/hisilicon/hibmc: Add hisilicon hibmc drm master
 driver
In-Reply-To: <1476763284-100508-1-git-send-email-zourongrong@gmail.com>
References: <1476763284-100508-1-git-send-email-zourongrong@gmail.com>
Message-ID: <1476763284-100508-2-git-send-email-zourongrong@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DRM master driver for Hisilicon Hibmc SoC which used for
Out-of-band management. Blow is the general hardware connection,
both the Hibmc and the host CPU are on the same mother board.

+----------+       +----------+
|          | PCIe  |  Hibmc   |
|host CPU( |<----->| display  |
|arm64,x86)|       |subsystem |
+----------+       +----------+

Signed-off-by: Rongrong Zou <zourongrong@gmail.com>
---
 drivers/gpu/drm/hisilicon/Kconfig                 |   1 +
 drivers/gpu/drm/hisilicon/Makefile                |   1 +
 drivers/gpu/drm/hisilicon/hibmc/Kconfig           |   7 +
 drivers/gpu/drm/hisilicon/hibmc/Makefile          |   5 +
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 270 ++++++++++++++++++++++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  35 +++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_power.c |  85 +++++++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_power.h |  28 +++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_regs.h  | 212 +++++++++++++++++
 9 files changed, 644 insertions(+)
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/Kconfig
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/Makefile
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_power.c
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_power.h
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_regs.h

diff --git a/drivers/gpu/drm/hisilicon/Kconfig b/drivers/gpu/drm/hisilicon/Kconfig
index 558c61b..2fd2724 100644
--- a/drivers/gpu/drm/hisilicon/Kconfig
+++ b/drivers/gpu/drm/hisilicon/Kconfig
@@ -2,4 +2,5 @@
 # hisilicon drm device configuration.
 # Please keep this list sorted alphabetically
 
+source "drivers/gpu/drm/hisilicon/hibmc/Kconfig"
 source "drivers/gpu/drm/hisilicon/kirin/Kconfig"
diff --git a/drivers/gpu/drm/hisilicon/Makefile b/drivers/gpu/drm/hisilicon/Makefile
index e3f6d49..c8155bf 100644
--- a/drivers/gpu/drm/hisilicon/Makefile
+++ b/drivers/gpu/drm/hisilicon/Makefile
@@ -2,4 +2,5 @@
 # Makefile for hisilicon drm drivers.
 # Please keep this list sorted alphabetically
 
+obj-$(CONFIG_DRM_HISI_HIBMC) += hibmc/
 obj-$(CONFIG_DRM_HISI_KIRIN) += kirin/
diff --git a/drivers/gpu/drm/hisilicon/hibmc/Kconfig b/drivers/gpu/drm/hisilicon/hibmc/Kconfig
new file mode 100644
index 0000000..a9af90d
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hibmc/Kconfig
@@ -0,0 +1,7 @@
+config DRM_HISI_HIBMC
+	tristate "DRM Support for Hisilicon Hibmc"
+	depends on DRM && PCI
+
+	help
+	  Choose this option if you have a Hisilicon Hibmc soc chipset.
+	  If M is selected the module will be called hibmc-drm.
diff --git a/drivers/gpu/drm/hisilicon/hibmc/Makefile b/drivers/gpu/drm/hisilicon/hibmc/Makefile
new file mode 100644
index 0000000..97cf4a0
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hibmc/Makefile
@@ -0,0 +1,5 @@
+ccflags-y := -Iinclude/drm
+hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_power.o
+
+obj-$(CONFIG_DRM_HISI_HIBMC)	+=hibmc-drm.o
+#obj-y	+= hibmc-drm.o
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
new file mode 100644
index 0000000..733c0dd
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -0,0 +1,270 @@
+/* Hisilicon Hibmc SoC drm driver
+ *
+ * Based on the bochs drm driver.
+ *
+ * Copyright (c) 2016 Huawei Limited.
+ *
+ * Author:
+ *	Rongrong Zou <zourongrong@huawei.com>
+ *	Rongrong Zou <zourongrong@gmail.com>
+ *	Jianhua Li <lijianhua@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/console.h>
+
+#include "hibmc_drm_drv.h"
+#include "hibmc_drm_regs.h"
+#include "hibmc_drm_power.h"
+
+static const struct file_operations hibmc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= drm_open,
+	.release	= drm_release,
+	.unlocked_ioctl	= drm_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= drm_compat_ioctl,
+#endif
+	.poll		= drm_poll,
+	.read		= drm_read,
+	.llseek		= no_llseek,
+};
+
+static int hibmc_enable_vblank(struct drm_device *dev, unsigned int pipe)
+{
+	return 0;
+}
+
+static void hibmc_disable_vblank(struct drm_device *dev, unsigned int pipe)
+{
+}
+
+static struct drm_driver hibmc_driver = {
+	.fops			= &hibmc_fops,
+	.name			= "hibmc",
+	.date			= "20160828",
+	.desc			= "hibmc drm driver",
+	.major			= 1,
+	.minor			= 0,
+	.get_vblank_counter	= drm_vblank_no_hw_counter,
+	.enable_vblank		= hibmc_enable_vblank,
+	.disable_vblank		= hibmc_disable_vblank,
+};
+
+static int hibmc_pm_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int hibmc_pm_resume(struct device *dev)
+{
+	return 0;
+}
+
+static const struct dev_pm_ops hibmc_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(hibmc_pm_suspend,
+				hibmc_pm_resume)
+};
+
+static int hibmc_hw_config(struct hibmc_drm_device *hidev)
+{
+	unsigned int reg;
+
+	/* On hardware reset, power mode 0 is default. */
+	hibmc_set_power_mode(hidev, HIBMC_PW_MODE_CTL_MODE_MODE0);
+
+	/* Enable display power gate & LOCALMEM power gate*/
+	reg = readl(hidev->mmio + HIBMC_CURRENT_GATE);
+	reg &= ~HIBMC_CURR_GATE_DISPLAY_MASK;
+	reg &= ~HIBMC_CURR_GATE_LOCALMEM_MASK;
+	reg |= HIBMC_CURR_GATE_DISPLAY(ON);
+	reg |= HIBMC_CURR_GATE_LOCALMEM(ON);
+
+	hibmc_set_current_gate(hidev, reg);
+
+	/* Reset the memory controller. If the memory controller
+	 * is not reset in chip,the system might hang when sw accesses
+	 * the memory.The memory should be resetted after
+	 * changing the MXCLK.
+	 */
+	reg = readl(hidev->mmio + HIBMC_MISC_CTRL);
+	reg &= ~HIBMC_MSCCTL_LOCALMEM_RESET_MASK;
+	reg |= HIBMC_MSCCTL_LOCALMEM_RESET(RESET);
+	writel(reg, hidev->mmio + HIBMC_MISC_CTRL);
+
+	reg &= ~HIBMC_MSCCTL_LOCALMEM_RESET_MASK;
+	reg |= HIBMC_MSCCTL_LOCALMEM_RESET(NORMAL);
+
+	writel(reg, hidev->mmio + HIBMC_MISC_CTRL);
+
+	/* We can add more initialization as needed. */
+
+	return 0;
+}
+
+static int hibmc_hw_map(struct hibmc_drm_device *hidev)
+{
+	struct drm_device *dev = hidev->dev;
+	struct pci_dev *pdev = dev->pdev;
+	resource_size_t addr, size, ioaddr, iosize;
+
+	ioaddr = pci_resource_start(pdev, 1);
+	iosize = MB(2);
+
+	hidev->mmio = ioremap_nocache(ioaddr, iosize);
+
+	if (!hidev->mmio) {
+		DRM_ERROR("Cannot map mmio region\n");
+		return -ENOMEM;
+	}
+
+	addr = pci_resource_start(pdev, 0);
+	size = MB(32);
+
+	hidev->fb_map = ioremap(addr, size);
+	if (!hidev->fb_map) {
+		DRM_ERROR("Cannot map framebuffer\n");
+		return -ENOMEM;
+	}
+	hidev->fb_base = addr;
+	hidev->fb_size = size;
+
+	return 0;
+}
+
+static void hibmc_hw_fini(struct hibmc_drm_device *hidev)
+{
+	if (hidev->mmio)
+		iounmap(hidev->mmio);
+	if (hidev->fb_map)
+		iounmap(hidev->fb_map);
+}
+
+static int hibmc_hw_init(struct hibmc_drm_device *hidev)
+{
+	int ret;
+
+	ret = hibmc_hw_map(hidev);
+	if (ret)
+		return ret;
+
+	hibmc_hw_config(hidev);
+
+	return 0;
+}
+
+static int hibmc_unload(struct drm_device *dev)
+{
+	struct hibmc_drm_device *hidev = dev->dev_private;
+
+	hibmc_hw_fini(hidev);
+	dev->dev_private = NULL;
+	return 0;
+}
+
+static int hibmc_load(struct drm_device *dev, unsigned long flags)
+{
+	struct hibmc_drm_device *hidev;
+	int ret;
+
+	hidev = devm_kzalloc(dev->dev, sizeof(*hidev), GFP_KERNEL);
+	if (!hidev)
+		return -ENOMEM;
+	dev->dev_private = hidev;
+	hidev->dev = dev;
+
+	ret = hibmc_hw_init(hidev);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	hibmc_unload(dev);
+	DRM_ERROR("failed to initialize drm driver.\n");
+	return ret;
+}
+
+static int hibmc_pci_probe(struct pci_dev *pdev,
+			   const struct pci_device_id *ent)
+{
+	struct drm_device *dev;
+	int ret;
+
+	dev = drm_dev_alloc(&hibmc_driver, &pdev->dev);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->pdev = pdev;
+	pci_set_drvdata(pdev, dev);
+
+	ret = pci_enable_device(pdev);
+	if (ret)
+		goto err_free;
+
+	ret = hibmc_load(dev, 0);
+	if (ret)
+		goto err_disable;
+
+	ret = drm_dev_register(dev, 0);
+	if (ret)
+		goto err_unload;
+
+	return 0;
+
+err_unload:
+	hibmc_unload(dev);
+err_disable:
+	pci_disable_device(pdev);
+err_free:
+	drm_dev_unref(dev);
+
+	return ret;
+}
+
+static void hibmc_pci_remove(struct pci_dev *pdev)
+{
+	struct drm_device *dev = pci_get_drvdata(pdev);
+
+	drm_dev_unregister(dev);
+	hibmc_unload(dev);
+	drm_dev_unref(dev);
+}
+
+static struct pci_device_id hibmc_pci_table[] = {
+	{0x19e5, 0x1711, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{0,}
+};
+
+static struct pci_driver hibmc_pci_driver = {
+	.name =		"hibmc-drm",
+	.id_table =	hibmc_pci_table,
+	.probe =	hibmc_pci_probe,
+	.remove =	hibmc_pci_remove,
+	.driver.pm =    &hibmc_pm_ops,
+};
+
+static int __init hibmc_init(void)
+{
+	return pci_register_driver(&hibmc_pci_driver);
+}
+
+static void __exit hibmc_exit(void)
+{
+	return pci_unregister_driver(&hibmc_pci_driver);
+}
+
+module_init(hibmc_init);
+module_exit(hibmc_exit);
+
+MODULE_DEVICE_TABLE(pci, hibmc_pci_table);
+MODULE_AUTHOR("RongrongZou <zourongrong@huawei.com>");
+MODULE_DESCRIPTION("DRM Driver for Hisilicon Hibmc");
+MODULE_LICENSE("GPL v2");
+
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
new file mode 100644
index 0000000..0037341
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -0,0 +1,35 @@
+/* Hisilicon Hibmc SoC drm driver
+ *
+ * Based on the bochs drm driver.
+ *
+ * Copyright (c) 2016 Huawei Limited.
+ *
+ * Author:
+ *	Rongrong Zou <zourongrong@huawei.com>
+ *	Rongrong Zou <zourongrong@gmail.com>
+ *	Jianhua Li <lijianhua@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#ifndef HIBMC_DRM_DRV_H
+#define HIBMC_DRM_DRV_H
+
+#include <drm/drmP.h>
+
+struct hibmc_drm_device {
+	/* hw */
+	void __iomem   *mmio;
+	void __iomem   *fb_map;
+	unsigned long  fb_base;
+	unsigned long  fb_size;
+
+	/* drm */
+	struct drm_device  *dev;
+};
+
+#endif
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_power.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_power.c
new file mode 100644
index 0000000..1036542
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_power.c
@@ -0,0 +1,85 @@
+/* Hisilicon Hibmc SoC drm driver
+ *
+ * Based on the bochs drm driver.
+ *
+ * Copyright (c) 2016 Huawei Limited.
+ *
+ * Author:
+ *	Rongrong Zou <zourongrong@huawei.com>
+ *	Rongrong Zou <zourongrong@gmail.com>
+ *	Jianhua Li <lijianhua@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#include "hibmc_drm_drv.h"
+#include "hibmc_drm_regs.h"
+
+/*
+ * It can operate in one of three modes: 0, 1 or Sleep.
+ */
+void hibmc_set_power_mode(struct hibmc_drm_device *hidev,
+			  unsigned int power_mode)
+{
+	unsigned int control_value = 0;
+	void __iomem   *mmio = hidev->mmio;
+
+	if (power_mode > HIBMC_PW_MODE_CTL_MODE_SLEEP)
+		return;
+
+	control_value = readl(mmio + HIBMC_POWER_MODE_CTRL);
+	control_value &= ~HIBMC_PW_MODE_CTL_MODE_MASK;
+
+	control_value |= HIBMC_PW_MODE_CTL_MODE(power_mode) &
+			 HIBMC_PW_MODE_CTL_MODE_MASK;
+
+    /* Set up other fields in Power Control Register */
+	if (power_mode == HIBMC_PW_MODE_CTL_MODE_SLEEP) {
+		control_value &= ~HIBMC_PW_MODE_CTL_OSC_INPUT_MASK;
+		control_value |= HIBMC_PW_MODE_CTL_OSC_INPUT(0) &
+				 HIBMC_PW_MODE_CTL_OSC_INPUT_MASK;
+	} else {
+		control_value &= ~HIBMC_PW_MODE_CTL_OSC_INPUT_MASK;
+		control_value |= HIBMC_PW_MODE_CTL_OSC_INPUT(1) &
+				 HIBMC_PW_MODE_CTL_OSC_INPUT_MASK;
+	}
+	/* Program new power mode. */
+	writel(control_value, mmio + HIBMC_POWER_MODE_CTRL);
+}
+
+static unsigned int hibmc_get_power_mode(struct hibmc_drm_device *hidev)
+{
+	void __iomem   *mmio = hidev->mmio;
+
+	return (readl(mmio + HIBMC_POWER_MODE_CTRL) &
+		HIBMC_PW_MODE_CTL_MODE_MASK) >> HIBMC_PW_MODE_CTL_MODE_SHIFT;
+}
+
+void hibmc_set_current_gate(struct hibmc_drm_device *hidev, unsigned int gate)
+{
+	unsigned int gate_reg;
+	unsigned int mode;
+	void __iomem   *mmio = hidev->mmio;
+
+	/* Get current power mode. */
+	mode = hibmc_get_power_mode(hidev);
+
+	switch (mode) {
+	case HIBMC_PW_MODE_CTL_MODE_MODE0:
+		gate_reg = HIBMC_MODE0_GATE;
+		break;
+
+	case HIBMC_PW_MODE_CTL_MODE_MODE1:
+		gate_reg = HIBMC_MODE1_GATE;
+		break;
+
+	default:
+		gate_reg = HIBMC_MODE0_GATE;
+		break;
+	}
+	writel(gate, mmio + gate_reg);
+}
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_power.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_power.h
new file mode 100644
index 0000000..e20e1aa
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_power.h
@@ -0,0 +1,28 @@
+/* Hisilicon Hibmc SoC drm driver
+ *
+ * Based on the bochs drm driver.
+ *
+ * Copyright (c) 2016 Huawei Limited.
+ *
+ * Author:
+ *	Rongrong Zou <zourongrong@huawei.com>
+ *	Rongrong Zou <zourongrong@gmail.com>
+ *	Jianhua Li <lijianhua@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#ifndef HIBMC_DRM_POWER_H
+#define HIBMC_DRM_POWER_H
+
+#include "hibmc_drm_drv.h"
+
+void hibmc_set_power_mode(struct hibmc_drm_device *hidev,
+			  unsigned int power_mode);
+void hibmc_set_current_gate(struct hibmc_drm_device *hidev,
+			    unsigned int gate);
+#endif
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_regs.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_regs.h
new file mode 100644
index 0000000..9c804ca
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_regs.h
@@ -0,0 +1,212 @@
+/* Hisilicon Hibmc SoC drm driver
+ *
+ * Based on the bochs drm driver.
+ *
+ * Copyright (c) 2016 Huawei Limited.
+ *
+ * Author:
+ *	Rongrong Zou <zourongrong@huawei.com>
+ *	Rongrong Zou <zourongrong@gmail.com>
+ *	Jianhua Li <lijianhua@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#ifndef HIBMC_DRM_HW_H
+#define HIBMC_DRM_HW_H
+
+#define OFF 0
+#define ON  1
+#define DISABLE               0
+#define ENABLE                1
+
+/* register definition */
+#define HIBMC_MISC_CTRL				0x4
+
+#define HIBMC_MSCCTL_LOCALMEM_RESET(x)		((x) << 6)
+#define HIBMC_MSCCTL_LOCALMEM_RESET_MASK	0x40
+
+#define RESET                0
+#define NORMAL               1
+
+#define HIBMC_CURRENT_GATE			0x000040
+#define HIBMC_CURR_GATE_DISPLAY(x)		((x) << 2)
+#define HIBMC_CURR_GATE_DISPLAY_MASK		0x4
+
+#define HIBMC_CURR_GATE_LOCALMEM(x)		((x) << 1)
+#define HIBMC_CURR_GATE_LOCALMEM_MASK		0x2
+
+#define HIBMC_MODE0_GATE			0x000044
+#define HIBMC_MODE1_GATE			0x000048
+#define HIBMC_POWER_MODE_CTRL			0x00004C
+
+#define HIBMC_PW_MODE_CTL_OSC_INPUT(x)		((x) << 3)
+#define HIBMC_PW_MODE_CTL_OSC_INPUT_MASK	0x8
+
+#define HIBMC_PW_MODE_CTL_MODE(x)		((x) << 0)
+#define HIBMC_PW_MODE_CTL_MODE_MASK		0x03
+#define HIBMC_PW_MODE_CTL_MODE_SHIFT		0
+
+#define HIBMC_PW_MODE_CTL_MODE_MODE0		0
+#define HIBMC_PW_MODE_CTL_MODE_MODE1		1
+#define HIBMC_PW_MODE_CTL_MODE_SLEEP		2
+
+#define HIBMC_PANEL_PLL_CTRL			0x00005C
+#define HIBMC_CRT_PLL_CTRL			0x000060
+
+#define HIBMC_PLL_CTRL_BYPASS(x)		((x) << 18)
+#define HIBMC_PLL_CTRL_BYPASS_MASK		0x40000
+
+#define HIBMC_PLL_CTRL_POWER(x)			((x) << 17)
+#define HIBMC_PLL_CTRL_POWER_MASK		0x20000
+
+#define HIBMC_PLL_CTRL_INPUT(x)			((x) << 16)
+#define HIBMC_PLL_CTRL_INPUT_MASK		0x10000
+
+#define OSC					0
+#define TESTCLK					1
+
+#define HIBMC_PLL_CTRL_POD(x)			((x) << 14)
+#define HIBMC_PLL_CTRL_POD_MASK			0xC000
+
+#define HIBMC_PLL_CTRL_OD(x)			((x) << 12)
+#define HIBMC_PLL_CTRL_OD_MASK			0x3000
+
+#define HIBMC_PLL_CTRL_N(x)			((x) << 8)
+#define HIBMC_PLL_CTRL_N_MASK			0xF00
+
+#define HIBMC_PLL_CTRL_M(x)			((x) << 0)
+#define HIBMC_PLL_CTRL_M_MASK			0xFF
+
+#define HIBMC_CRT_DISP_CTL			0x80200
+
+#define HIBMC_CRT_DISP_CTL_CRTSELECT(x)		((x) << 25)
+#define HIBMC_CRT_DISP_CTL_CRTSELECT_MASK	0x2000000
+
+#define CRTSELECT_VGA                0
+#define CRTSELECT_CRT                1
+
+#define HIBMC_CRT_DISP_CTL_CLOCK_PHASE(x)	((x) << 14)
+#define HIBMC_CRT_DISP_CTL_CLOCK_PHASE_MASK	0x4000
+
+#define PHASE_ACTIVE_HIGH      0
+#define PHASE_ACTIVE_LOW       1
+
+#define HIBMC_CRT_DISP_CTL_VSYNC_PHASE(x)	((x) << 13)
+#define HIBMC_CRT_DISP_CTL_VSYNC_PHASE_MASK	0x2000
+
+#define HIBMC_CRT_DISP_CTL_HSYNC_PHASE(x)	((x) << 12)
+#define HIBMC_CRT_DISP_CTL_HSYNC_PHASE_MASK	0x1000
+
+#define HIBMC_CRT_DISP_CTL_TIMING(x)		((x) << 8)
+#define HIBMC_CRT_DISP_CTL_TIMING_MASK		0x100
+
+#define HIBMC_CRT_DISP_CTL_PLANE(x)		((x) << 2)
+#define HIBMC_CRT_DISP_CTL_PLANE_MASK		4
+
+#define HIBMC_CRT_DISP_CTL_FORMAT(x)		((x) << 0)
+#define HIBMC_CRT_DISP_CTL_FORMAT_MASK		0x03
+
+#define HIBMC_CRT_FB_ADDRESS			0x080204
+
+#define HIBMC_CRT_FB_WIDTH			0x080208
+#define HIBMC_CRT_FB_WIDTH_WIDTH(x)		((x) << 16)
+#define HIBMC_CRT_FB_WIDTH_WIDTH_MASK		0x3FFF0000
+#define HIBMC_CRT_FB_WIDTH_OFFS(x)		((x) << 0)
+#define HIBMC_CRT_FB_WIDTH_OFFS_MASK		0x3FFF
+
+#define HIBMC_CRT_HORZ_TOTAL			0x08020C
+#define HIBMC_CRT_HORZ_TOTAL_TOTAL(x)		((x) << 16)
+#define HIBMC_CRT_HORZ_TOTAL_TOTAL_MASK		0xFFF0000
+
+#define HIBMC_CRT_HORZ_TOTAL_DISPLAY_END(x)	((x) << 0)
+#define HIBMC_CRT_HORZ_TOTAL_DISPLAY_END_MASK	0xFFF
+
+#define HIBMC_CRT_HORZ_SYNC			0x080210
+#define HIBMC_CRT_HORZ_SYNC_WIDTH(x)		((x) << 16)
+#define HIBMC_CRT_HORZ_SYNC_WIDTH_MASK		0xFF0000
+
+#define HIBMC_CRT_HORZ_SYNC_START(x)		((x) << 0)
+#define HIBMC_CRT_HORZ_SYNC_START_MASK		0xFFF
+
+#define HIBMC_CRT_VERT_TOTAL			0x080214
+#define HIBMC_CRT_VERT_TOTAL_TOTAL(x)		((x) << 16)
+#define HIBMC_CRT_VERT_TOTAL_TOTAL_MASK		0x7FFF0000
+
+#define HIBMC_CRT_VERT_TOTAL_DISPLAY_END(x)	((x) << 0)
+#define HIBMC_CRT_VERT_TOTAL_DISPLAY_END_MASK	0x7FF
+
+#define HIBMC_CRT_VERT_SYNC			0x080218
+#define HIBMC_CRT_VERT_SYNC_HEIGHT(x)		((x) << 16)
+#define HIBMC_CRT_VERT_SYNC_HEIGHT_MASK		0x3F0000
+
+#define HIBMC_CRT_VERT_SYNC_START(x)		((x) << 0)
+#define HIBMC_CRT_VERT_SYNC_START_MASK		0x7FF
+
+/* Auto Centering */
+#define HIBMC_CRT_AUTO_CENTERING_TL		0x080280
+#define HIBMC_CRT_AUTO_CENTERING_TL_TOP(x)	((x) << 16)
+#define HIBMC_CRT_AUTO_CENTERING_TL_TOP_MSK	0x7FF0000
+
+#define HIBMC_CRT_AUTO_CENTERING_TL_LEFT(x)	((x) << 0)
+#define HIBMC_CRT_AUTO_CENTERING_TL_LEFT_MSK	0x7FF
+
+#define HIBMC_CRT_AUTO_CENTERING_BR		0x080284
+#define HIBMC_CRT_AUTO_CENTERING_BR_BOTTOM(x)	((x) << 16)
+#define HIBMC_CRT_AUTO_CENTERING_BR_BOTTOM_MASK	0x7FF0000
+
+#define HIBMC_CRT_AUTO_CENTERING_BR_RIGHT(x)	((x) << 0)
+#define HIBMC_CRT_AUTO_CENTERING_BR_RIGHT_MASK	0x7FF
+
+/* register to control panel output */
+#define DISPLAY_CONTROL_HISILE			0x80288
+
+#define HIBMC_RAW_INTERRUPT			0x80290
+#define HIBMC_RAW_INTERRUPT_VBLANK(x)		((x) << 2)
+#define HIBMC_RAW_INTERRUPT_VBLANK_MASK		0x4
+
+#define HIBMC_RAW_INTERRUPT_EN			0x80298
+#define HIBMC_RAW_INTERRUPT_EN_VBLANK(x)	((x) << 2)
+#define HIBMC_RAW_INTERRUPT_EN_VBLANK_MASK	0x4
+
+/* register and values for PLL control */
+#define CRT_PLL1_HS				0x802a8
+#define CRT_PLL1_HS_25MHZ			0x23d40f02
+#define CRT_PLL1_HS_40MHZ			0x23940801
+#define CRT_PLL1_HS_65MHZ			0x23940d01
+#define CRT_PLL1_HS_78MHZ			0x23540F82
+#define CRT_PLL1_HS_74MHZ			0x23941dc2
+#define CRT_PLL1_HS_80MHZ			0x23941001
+#define CRT_PLL1_HS_80MHZ_1152			0x23540fc2
+#define CRT_PLL1_HS_108MHZ			0x23b41b01
+#define CRT_PLL1_HS_162MHZ			0x23480681
+#define CRT_PLL1_HS_148MHZ			0x23541dc2
+#define CRT_PLL1_HS_193MHZ			0x234807c1
+
+#define CRT_PLL2_HS				0x802ac
+#define CRT_PLL2_HS_25MHZ			0x206B851E
+#define CRT_PLL2_HS_40MHZ			0x30000000
+#define CRT_PLL2_HS_65MHZ			0x40000000
+#define CRT_PLL2_HS_78MHZ			0x50E147AE
+#define CRT_PLL2_HS_74MHZ			0x602B6AE7
+#define CRT_PLL2_HS_80MHZ			0x70000000
+#define CRT_PLL2_HS_108MHZ			0x80000000
+#define CRT_PLL2_HS_162MHZ			0xA0000000
+#define CRT_PLL2_HS_148MHZ			0xB0CCCCCD
+#define CRT_PLL2_HS_193MHZ			0xC0872B02
+
+/* Global macros */
+#define RGB(r, g, b) \
+( \
+	(unsigned long)(((r) << 16) | ((g) << 8) | (b)) \
+)
+
+#define PADDING(align, data) (((data) + (align) - 1) & (~((align) - 1)))
+
+#define MB(x) ((x) << 20)
+
+#endif
-- 
1.9.1
