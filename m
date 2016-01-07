From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu,  7 Jan 2016 16:46:13 +0100
Subject: [PATCH v12 2/4] PM / Domains: add setter for dev.pm_domain
In-Reply-To: <1452181575-9206-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1452181575-9206-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1452181575-9206-3-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds a function that sets the pointer to dev_pm_domain in struct device
and that warns if the device has already finished probing. The reason
why we want to enforce that is because in the general case that can
cause problems and also that we can simplify code quite a bit if we can
always assume that.

This patch also changes all current code that directly sets the
dev.pm_domain pointer.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v12:
- Include linux/pm_domain.h in vga_switcheroo.c for dev_pm_domain_set()

Changes in v11:
- Move calls to dev_pm_domain_set() out from &dev->power.lock as that
  isn't needed for dev->pm_domain.

Changes in v9:
- Add docs noting the need for the device lock to be held before calling
  dev_pm_domain_set()

Changes in v8:
- Add dev_pm_domain_set() and update code to use it

 arch/arm/mach-omap2/omap_device.c |  7 ++++---
 drivers/acpi/acpi_lpss.c          |  5 ++++-
 drivers/acpi/device_pm.c          |  5 +++--
 drivers/base/power/clock_ops.c    |  5 +++--
 drivers/base/power/common.c       | 21 +++++++++++++++++++++
 drivers/base/power/domain.c       |  6 ++++--
 drivers/gpu/vga/vga_switcheroo.c  | 11 ++++++-----
 drivers/misc/mei/pci-me.c         |  5 +++--
 drivers/misc/mei/pci-txe.c        |  5 +++--
 include/linux/pm_domain.h         |  3 +++
 10 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 3750ed14f8c5..0437537751bc 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -32,6 +32,7 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/notifier.h>
@@ -168,7 +169,7 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
 			r->name = dev_name(&pdev->dev);
 	}
 
-	pdev->dev.pm_domain = &omap_device_pm_domain;
+	dev_pm_domain_set(&pdev->dev, &omap_device_pm_domain);
 
 	if (device_active) {
 		omap_device_enable(pdev);
@@ -180,7 +181,7 @@ odbfd_exit1:
 odbfd_exit:
 	/* if data/we are at fault.. load up a fail handler */
 	if (ret)
-		pdev->dev.pm_domain = &omap_device_fail_pm_domain;
+		dev_pm_domain_set(&pdev->dev, &omap_device_fail_pm_domain);
 
 	return ret;
 }
@@ -701,7 +702,7 @@ int omap_device_register(struct platform_device *pdev)
 {
 	pr_debug("omap_device: %s: registering\n", pdev->name);
 
-	pdev->dev.pm_domain = &omap_device_pm_domain;
+	dev_pm_domain_set(&pdev->dev, &omap_device_pm_domain);
 	return platform_device_add(pdev);
 }
 
diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 047281a6ae11..c570b1d9f094 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -18,6 +18,7 @@
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/clk-lpss.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/delay.h>
 
@@ -875,13 +876,14 @@ static int acpi_lpss_platform_notify(struct notifier_block *nb,
 
 	switch (action) {
 	case BUS_NOTIFY_BIND_DRIVER:
-		pdev->dev.pm_domain = &acpi_lpss_pm_domain;
+		dev_pm_domain_set(&pdev->dev, &acpi_lpss_pm_domain);
 		break;
 	case BUS_NOTIFY_DRIVER_NOT_BOUND:
 	case BUS_NOTIFY_UNBOUND_DRIVER:
 		pdev->dev.pm_domain = NULL;
 		break;
 	case BUS_NOTIFY_ADD_DEVICE:
+		dev_pm_domain_set(&pdev->dev, &acpi_lpss_pm_domain);
 		if (pdata->dev_desc->flags & LPSS_LTR)
 			return sysfs_create_group(&pdev->dev.kobj,
 						  &lpss_attr_group);
@@ -889,6 +891,7 @@ static int acpi_lpss_platform_notify(struct notifier_block *nb,
 	case BUS_NOTIFY_DEL_DEVICE:
 		if (pdata->dev_desc->flags & LPSS_LTR)
 			sysfs_remove_group(&pdev->dev.kobj, &lpss_attr_group);
+		dev_pm_domain_set(&pdev->dev, NULL);
 		break;
 	default:
 		break;
diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 08a02cdc737c..cd2c3d6d40e0 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -22,6 +22,7 @@
 #include <linux/export.h>
 #include <linux/mutex.h>
 #include <linux/pm_qos.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 
 #include "internal.h"
@@ -1059,7 +1060,7 @@ static void acpi_dev_pm_detach(struct device *dev, bool power_off)
 	struct acpi_device *adev = ACPI_COMPANION(dev);
 
 	if (adev && dev->pm_domain == &acpi_general_pm_domain) {
-		dev->pm_domain = NULL;
+		dev_pm_domain_set(dev, NULL);
 		acpi_remove_pm_notifier(adev);
 		if (power_off) {
 			/*
@@ -1111,7 +1112,7 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
 		return -EBUSY;
 
 	acpi_add_pm_notifier(adev, dev, acpi_pm_notify_work_func);
-	dev->pm_domain = &acpi_general_pm_domain;
+	dev_pm_domain_set(dev, &acpi_general_pm_domain);
 	if (power_on) {
 		acpi_dev_pm_full_power(adev);
 		acpi_device_wakeup(adev, ACPI_STATE_S0, false);
diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 60ee5591ee8f..b36d01e0589d 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -15,6 +15,7 @@
 #include <linux/clkdev.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 
 #ifdef CONFIG_PM_CLK
@@ -348,7 +349,7 @@ static int pm_clk_notify(struct notifier_block *nb,
 		if (error)
 			break;
 
-		dev->pm_domain = clknb->pm_domain;
+		dev_pm_domain_set(dev, clknb->pm_domain);
 		if (clknb->con_ids[0]) {
 			for (con_id = clknb->con_ids; *con_id; con_id++)
 				pm_clk_add(dev, *con_id);
@@ -361,7 +362,7 @@ static int pm_clk_notify(struct notifier_block *nb,
 		if (dev->pm_domain != clknb->pm_domain)
 			break;
 
-		dev->pm_domain = NULL;
+		dev_pm_domain_set(dev, NULL);
 		pm_clk_destroy(dev);
 		break;
 	}
diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index f48e33385b3e..02812bcabcac 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -128,3 +128,24 @@ void dev_pm_domain_detach(struct device *dev, bool power_off)
 		dev->pm_domain->detach(dev, power_off);
 }
 EXPORT_SYMBOL_GPL(dev_pm_domain_detach);
+
+/**
+ * dev_pm_domain_set - Set PM domain of a device.
+ * @dev: Device whose PM domain is to be set.
+ * @pd: PM domain to be set, or NULL.
+ *
+ * Sets the PM domain the device belongs to. The PM domain of a device needs
+ * to be set before its probe finishes (it's bound to a driver).
+ *
+ * This function must be called with the device lock held.
+ */
+void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd)
+{
+	if (dev->pm_domain == pd)
+		return;
+
+	WARN(device_is_bound(dev),
+	     "PM domains can only be changed for unbound devices\n");
+	dev->pm_domain = pd;
+}
+EXPORT_SYMBOL_GPL(dev_pm_domain_set);
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index b80379012840..e8b526faec1f 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1188,10 +1188,11 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
 	}
 
 	dev->power.subsys_data->domain_data = &gpd_data->base;
-	dev->pm_domain = &genpd->domain;
 
 	spin_unlock_irq(&dev->power.lock);
 
+	dev_pm_domain_set(dev, &genpd->domain);
+
 	return gpd_data;
 
  err_free:
@@ -1205,9 +1206,10 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
 static void genpd_free_dev_data(struct device *dev,
 				struct generic_pm_domain_data *gpd_data)
 {
+	dev_pm_domain_set(dev, NULL);
+
 	spin_lock_irq(&dev->power.lock);
 
-	dev->pm_domain = NULL;
 	dev->power.subsys_data->domain_data = NULL;
 
 	spin_unlock_irq(&dev->power.lock);
diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
index d64d9058bce5..665ab9fd0e01 100644
--- a/drivers/gpu/vga/vga_switcheroo.c
+++ b/drivers/gpu/vga/vga_switcheroo.c
@@ -36,6 +36,7 @@
 #include <linux/fs.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
@@ -918,17 +919,17 @@ int vga_switcheroo_init_domain_pm_ops(struct device *dev,
 		domain->ops.runtime_suspend = vga_switcheroo_runtime_suspend;
 		domain->ops.runtime_resume = vga_switcheroo_runtime_resume;
 
-		dev->pm_domain = domain;
+		dev_pm_domain_set(dev, domain);
 		return 0;
 	}
-	dev->pm_domain = NULL;
+	dev_pm_domain_set(dev, NULL);
 	return -EINVAL;
 }
 EXPORT_SYMBOL(vga_switcheroo_init_domain_pm_ops);
 
 void vga_switcheroo_fini_domain_pm_ops(struct device *dev)
 {
-	dev->pm_domain = NULL;
+	dev_pm_domain_set(dev, NULL);
 }
 EXPORT_SYMBOL(vga_switcheroo_fini_domain_pm_ops);
 
@@ -989,10 +990,10 @@ vga_switcheroo_init_domain_pm_optimus_hdmi_audio(struct device *dev,
 		domain->ops.runtime_resume =
 			vga_switcheroo_runtime_resume_hdmi_audio;
 
-		dev->pm_domain = domain;
+		dev_pm_domain_set(dev, domain);
 		return 0;
 	}
-	dev->pm_domain = NULL;
+	dev_pm_domain_set(dev, NULL);
 	return -EINVAL;
 }
 EXPORT_SYMBOL(vga_switcheroo_init_domain_pm_optimus_hdmi_audio);
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 27678d8154e0..75fc9c688df8 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -31,6 +31,7 @@
 #include <linux/jiffies.h>
 #include <linux/interrupt.h>
 
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 
 #include <linux/mei.h>
@@ -436,7 +437,7 @@ static inline void mei_me_set_pm_domain(struct mei_device *dev)
 		dev->pg_domain.ops.runtime_resume = mei_me_pm_runtime_resume;
 		dev->pg_domain.ops.runtime_idle = mei_me_pm_runtime_idle;
 
-		pdev->dev.pm_domain = &dev->pg_domain;
+		dev_pm_domain_set(&pdev->dev, &dev->pg_domain);
 	}
 }
 
@@ -448,7 +449,7 @@ static inline void mei_me_set_pm_domain(struct mei_device *dev)
 static inline void mei_me_unset_pm_domain(struct mei_device *dev)
 {
 	/* stop using pm callbacks if any */
-	dev->dev->pm_domain = NULL;
+	dev_pm_domain_set(dev->dev, NULL);
 }
 
 static const struct dev_pm_ops mei_me_pm_ops = {
diff --git a/drivers/misc/mei/pci-txe.c b/drivers/misc/mei/pci-txe.c
index 0882c0201907..71f8a7475717 100644
--- a/drivers/misc/mei/pci-txe.c
+++ b/drivers/misc/mei/pci-txe.c
@@ -27,6 +27,7 @@
 #include <linux/jiffies.h>
 #include <linux/interrupt.h>
 #include <linux/workqueue.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 
 #include <linux/mei.h>
@@ -388,7 +389,7 @@ static inline void mei_txe_set_pm_domain(struct mei_device *dev)
 		dev->pg_domain.ops.runtime_resume = mei_txe_pm_runtime_resume;
 		dev->pg_domain.ops.runtime_idle = mei_txe_pm_runtime_idle;
 
-		pdev->dev.pm_domain = &dev->pg_domain;
+		dev_pm_domain_set(&pdev->dev, &dev->pg_domain);
 	}
 }
 
@@ -400,7 +401,7 @@ static inline void mei_txe_set_pm_domain(struct mei_device *dev)
 static inline void mei_txe_unset_pm_domain(struct mei_device *dev)
 {
 	/* stop using pm callbacks if any */
-	dev->dev->pm_domain = NULL;
+	dev_pm_domain_set(dev->dev, NULL);
 }
 
 static const struct dev_pm_ops mei_txe_pm_ops = {
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index ba4ced38efae..db21d3995f7e 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -240,12 +240,15 @@ static inline int of_genpd_add_provider_onecell(struct device_node *np,
 #ifdef CONFIG_PM
 extern int dev_pm_domain_attach(struct device *dev, bool power_on);
 extern void dev_pm_domain_detach(struct device *dev, bool power_off);
+extern void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd);
 #else
 static inline int dev_pm_domain_attach(struct device *dev, bool power_on)
 {
 	return -ENODEV;
 }
 static inline void dev_pm_domain_detach(struct device *dev, bool power_off) {}
+static inline void dev_pm_domain_set(struct device *dev,
+				     struct dev_pm_domain *pd) {}
 #endif
 
 #endif /* _LINUX_PM_DOMAIN_H */
-- 
2.5.0
