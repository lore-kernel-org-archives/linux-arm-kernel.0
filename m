From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 7 Jun 2011 15:47:59 +0530
Subject: [PATCH V3 1/3] drivers/pwm st_pwm: Add support for ST's Pulse Width
	Modulator
In-Reply-To: <cover.1306831238.git.viresh.kumar@st.com>
References: <cover.1306831238.git.viresh.kumar@st.com>
Message-ID: <af3d50b271b17e404d236e19196adfd4618e2501.1306831238.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for ST Microelectronics Pulse Width Modulator. This is
currently used by ST's SPEAr platform and tested on the same.

This patch also adds drivers/pwm directory as suggested by Arnd Bergmann in
following discussion:

http://comments.gmane.org/gmane.linux.ports.arm.kernel/118651

pwm framework is not separated in this patch as a separate file, as it has
already been submitted by multiple people. This driver will adopt the new pwm
framework requirements as soon as framework is pushed.

Reviewed-by: Stanley Miao <stanley.miao@windriver.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 MAINTAINERS          |    5 +
 drivers/Kconfig      |    1 +
 drivers/Makefile     |    1 +
 drivers/pwm/Kconfig  |   22 +++
 drivers/pwm/Makefile |    5 +
 drivers/pwm/st_pwm.c |  496 ++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 530 insertions(+), 0 deletions(-)
 create mode 100644 drivers/pwm/Kconfig
 create mode 100644 drivers/pwm/Makefile
 create mode 100644 drivers/pwm/st_pwm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 48b0a4f..4e8ffa4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6031,6 +6031,11 @@ M:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
 S:	Maintained
 F:	arch/alpha/kernel/srm_env.c
 
+ST Microelectronics Pulse Width Modulator Support
+M:	Viresh Kumar <viresh.kumar@st.com>
+S:	Maintained
+F:	drivers/pwm/st_pwm.c
+
 STABLE BRANCH
 M:	Greg Kroah-Hartman <greg@kroah.com>
 L:	stable at kernel.org
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 3bb154d..4d3bb12 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -126,4 +126,5 @@ source "drivers/hwspinlock/Kconfig"
 
 source "drivers/clocksource/Kconfig"
 
+source "drivers/pwm/Kconfig"
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index 09f3232..c321763 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -6,6 +6,7 @@
 #
 
 obj-y				+= gpio/
+obj-y				+= pwm/
 obj-$(CONFIG_PCI)		+= pci/
 obj-$(CONFIG_PARISC)		+= parisc/
 obj-$(CONFIG_RAPIDIO)		+= rapidio/
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
new file mode 100644
index 0000000..85fd25c
--- /dev/null
+++ b/drivers/pwm/Kconfig
@@ -0,0 +1,22 @@
+#
+# Pulse Width Modulator (PWM) devices
+#
+
+menuconfig PWMLIB
+	bool "PWM Support"
+	help
+	  This enables PWM support for kernel. You only need to enable this, if
+	  you also want to enable one or more of the PWM drivers below.
+
+	  If unsure, say N.
+
+if PWMLIB
+
+config ST_PWM
+	tristate "ST Microelectronics Pulse Width Modulator"
+	default n
+	help
+	  Support for ST Microelectronics Pulse Width Modulator. Currently it is
+	  present and tested on SPEAr Platform only.
+
+endif # PWMLIB
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
new file mode 100644
index 0000000..7c3b338
--- /dev/null
+++ b/drivers/pwm/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for PWM devices
+#
+
+obj-$(CONFIG_ST_PWM)		+= st_pwm.o
diff --git a/drivers/pwm/st_pwm.c b/drivers/pwm/st_pwm.c
new file mode 100644
index 0000000..97317fb
--- /dev/null
+++ b/drivers/pwm/st_pwm.c
@@ -0,0 +1,496 @@
+/*
+ * drivers/pwm/st_pwm.c
+ *
+ * ST Microelectronics Pulse Width Modulator driver
+ *
+ * Copyright (C) 2010-2011 ST Microelectronics
+ * Viresh Kumar<viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/* Tested on ST's SPEAr Platform */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+/* PWM registers and bits definitions */
+#define PWMCR			0x00
+#define PWMDCR			0x04
+#define PWMPCR			0x08
+
+#define PWM_EN_MASK		0x1
+#define MIN_PRESCALE		0x00
+#define MAX_PRESCALE		0x3FFF
+#define PRESCALE_SHIFT		2
+#define MIN_DUTY		0x0001
+#define MAX_DUTY		0xFFFF
+#define MAX_PERIOD		0xFFFF
+#define MIN_PERIOD		0x0001
+
+#define PWM_DEVICE_PER_IP	4
+#define PWM_DEVICE_OFFSET	0x10
+
+/* lock for accessing list of all pwm ips */
+static DEFINE_SPINLOCK(list_lock);
+/* list of all pwm ips available in system */
+static LIST_HEAD(pwm_list);
+
+/**
+ * struct pwm_device: struct representing pwm device/channel
+ *
+ * pwmd_id: id of pwm device
+ * pwm: pointer to parent pwm ip
+ * label: used for storing label passed in pwm_request
+ * offset: base address offset from parent pwm mmio_base
+ * busy: represents usage status of a pwm device
+ * lock: lock specific to a pwm device. User for accessing struct pwm_device
+ * fields and programming pwmd registers.
+ * node: node for adding device to parent pwm's devices list
+ *
+ * Each pwm IP contains four independent pwm device/channels. Some or all of
+ * which may be present in our configuration.
+ */
+struct pwm_device {
+	unsigned pwmd_id;
+	struct pwm *pwm;
+	const char *label;
+	unsigned offset;
+	unsigned busy;
+	spinlock_t lock;
+	struct list_head node;
+};
+
+/**
+ * struct pwm: struct representing pwm ip
+ *
+ * id: id of pwm ip
+ * mmio_base: base address of pwm
+ * clk: pointer to clk structure of pwm ip
+ * clk_enabled: clock enable status
+ * pdev: pointer to pdev structure of pwm
+ * lock: lock specific to current pwm ip. Used for accessing strut pwm fields
+ * and enabling/disabling clk.
+ * devices: list of devices/childrens of pwm ip
+ * node: node for adding pwm to global list of all pwm ips
+ */
+struct pwm {
+	unsigned id;
+	void __iomem *mmio_base;
+	struct clk *clk;
+	int clk_enabled;
+	struct platform_device *pdev;
+	spinlock_t lock;
+	struct list_head devices;
+	struct list_head node;
+};
+
+/*
+ * NOTE: If both pwm & pwmd locks are required, then they should be taken in
+ * following order: pwm->lock & then pwmd->lock and they should be released in
+ * reverse order.
+ */
+
+/*
+ * period_ns = 10^9 * (PRESCALE + 1) * PV / PWM_CLK_RATE
+ * duty_ns = 10^9 * (PRESCALE + 1) * DC / PWM_CLK_RATE
+ *
+ * PV = (PWM_CLK_RATE * period_ns)/ (10^9 * (PRESCALE + 1))
+ * DC = (PWM_CLK_RATE * duty_ns)/ (10^9 * (PRESCALE + 1))
+ */
+int pwm_config(struct pwm_device *pwmd, int duty_ns, int period_ns)
+{
+	u64 val, div, clk_rate;
+	unsigned long prescale = MIN_PRESCALE, pv, dc;
+	int ret = -EINVAL;
+
+	if (!pwmd) {
+		pr_err("config - NULL pwm device pointer\n");
+		return -EFAULT;
+	}
+
+	if (period_ns == 0 || duty_ns > period_ns)
+		goto err;
+
+	/* TODO: Need to optimize this loop */
+	/*
+	 * Find pv, dc and prescale to suit duty_ns and period_ns. This is done
+	 * according to formulas provided above this routine.
+	 */
+	while (1) {
+		div = 1000000000;
+		div *= 1 + prescale;
+		clk_rate = clk_get_rate(pwmd->pwm->clk);
+		val = clk_rate * period_ns;
+		pv = div64_u64(val, div);
+		val = clk_rate * duty_ns;
+		dc = div64_u64(val, div);
+
+		/* if duty_ns and period_ns are not acheivable then return */
+		if (!pv || !dc || pv < MIN_PERIOD || dc < MIN_DUTY)
+			goto err;
+
+		/*
+		 * if pv and dc have crossed their upper limit, then increase
+		 * prescale and recalculate pv and dc.
+		 */
+		if ((pv > MAX_PERIOD) || (dc > MAX_DUTY)) {
+			prescale++;
+			if (prescale > MAX_PRESCALE)
+				goto err;
+			continue;
+		}
+		break;
+	}
+
+	/*
+	 * NOTE: the clock to PWM has to be enabled first before writing to the
+	 * registers.
+	 */
+	spin_lock(&pwmd->pwm->lock);
+	ret = clk_enable(pwmd->pwm->clk);
+	if (ret) {
+		spin_unlock(&pwmd->pwm->lock);
+		goto err;
+	}
+
+	spin_lock(&pwmd->lock);
+	writel(prescale << PRESCALE_SHIFT, pwmd->pwm->mmio_base +
+			pwmd->offset + PWMCR);
+	writel(dc, pwmd->pwm->mmio_base + pwmd->offset + PWMDCR);
+	writel(pv, pwmd->pwm->mmio_base + pwmd->offset + PWMPCR);
+	spin_unlock(&pwmd->lock);
+	clk_disable(pwmd->pwm->clk);
+	spin_unlock(&pwmd->pwm->lock);
+
+	return 0;
+err:
+	dev_err(&pwmd->pwm->pdev->dev, "pwm config fail\n");
+	return ret;
+}
+EXPORT_SYMBOL(pwm_config);
+
+int pwm_enable(struct pwm_device *pwmd)
+{
+	int ret = 0;
+	u32 val = 0;
+
+	if (!pwmd) {
+		pr_err("enable - NULL pwm device pointer\n");
+		return -EFAULT;
+	}
+
+	spin_lock(&pwmd->pwm->lock);
+	ret = clk_enable(pwmd->pwm->clk);
+	if (!ret)
+		pwmd->pwm->clk_enabled++;
+	else {
+		spin_unlock(&pwmd->pwm->lock);
+		goto err;
+	}
+
+	spin_lock(&pwmd->lock);
+	val = readl(pwmd->pwm->mmio_base + pwmd->offset + PWMCR);
+	writel(val | PWM_EN_MASK, pwmd->pwm->mmio_base + pwmd->offset + PWMCR);
+	spin_unlock(&pwmd->lock);
+	spin_unlock(&pwmd->pwm->lock);
+	return 0;
+err:
+	dev_err(&pwmd->pwm->pdev->dev, "pwm enable fail\n");
+	return ret;
+}
+EXPORT_SYMBOL(pwm_enable);
+
+void pwm_disable(struct pwm_device *pwmd)
+{
+	if (!pwmd) {
+		pr_err("disable - NULL pwm device pointer\n");
+		return;
+	}
+
+	spin_lock(&pwmd->pwm->lock);
+	spin_lock(&pwmd->lock);
+	writel(0, pwmd->pwm->mmio_base + pwmd->offset + PWMCR);
+	if (pwmd->pwm->clk_enabled) {
+		clk_disable(pwmd->pwm->clk);
+		pwmd->pwm->clk_enabled--;
+	}
+	spin_unlock(&pwmd->lock);
+	spin_unlock(&pwmd->pwm->lock);
+}
+EXPORT_SYMBOL(pwm_disable);
+
+struct pwm_device *pwm_request(int pwmd_id, const char *label)
+{
+	int found = 0;
+	struct pwm *pwm;
+	struct pwm_device *pwmd = NULL;
+
+	spin_lock(&list_lock);
+	list_for_each_entry(pwm, &pwm_list, node) {
+		spin_lock(&pwm->lock);
+		list_for_each_entry(pwmd, &pwm->devices, node) {
+			if (pwmd->pwmd_id == pwmd_id) {
+				found = 1;
+				break;
+			}
+		}
+		spin_unlock(&pwm->lock);
+		if (found)
+			break;
+	}
+	spin_unlock(&list_lock);
+
+	if (found) {
+		spin_lock(&pwmd->lock);
+		if (pwmd->busy == 0) {
+			pwmd->busy++;
+			pwmd->label = label;
+		} else
+			pwmd = ERR_PTR(-EBUSY);
+		spin_unlock(&pwmd->lock);
+	} else
+		pwmd = ERR_PTR(-ENOENT);
+
+	if (IS_ERR(pwmd))
+		pr_err("request fail\n");
+
+	return pwmd;
+}
+EXPORT_SYMBOL(pwm_request);
+
+void pwm_free(struct pwm_device *pwmd)
+{
+	if (!pwmd) {
+		pr_err("disable - NULL pwm device pointer\n");
+		return;
+	}
+
+	spin_lock(&pwmd->lock);
+	if (pwmd->busy) {
+		pwmd->busy--;
+		pwmd->label = NULL;
+	} else {
+		spin_unlock(&pwmd->lock);
+		dev_warn(&pwmd->pwm->pdev->dev, "pwm device already freed\n");
+		return;
+	}
+
+	spin_unlock(&pwmd->lock);
+}
+EXPORT_SYMBOL(pwm_free);
+
+/* creates and add pwmd device to parent pwm's devices list */
+static int add_pwm_device(unsigned int pwmd_id, struct pwm *pwm)
+{
+	struct pwm_device *pwmd;
+
+	pwmd = kzalloc(sizeof(*pwmd), GFP_KERNEL);
+	if (!pwmd)
+		return -ENOMEM;
+
+	pwmd->pwm = pwm;
+	pwmd->busy = 0;
+	pwmd->pwmd_id = pwmd_id + pwm->id * PWM_DEVICE_PER_IP;
+	pwmd->offset = pwmd_id * PWM_DEVICE_OFFSET;
+	spin_lock_init(&pwmd->lock);
+
+	spin_lock(&pwm->lock);
+	list_add_tail(&pwmd->node, &pwm->devices);
+	spin_unlock(&pwm->lock);
+
+	return 0;
+}
+
+/* removes all pwmd devices from parent pwm's devices list */
+static void remove_pwm_devices(struct pwm *pwm)
+{
+	struct pwm_device *pwmd;
+
+	spin_lock(&pwm->lock);
+	list_for_each_entry(pwmd, &pwm->devices, node) {
+		list_del(&pwmd->node);
+		kfree(pwmd);
+	}
+	spin_unlock(&pwm->lock);
+}
+
+static int __devinit st_pwm_probe(struct platform_device *pdev)
+{
+	struct pwm *pwm = NULL;
+	struct resource *res;
+	int ret = 0, pwmd_id = 0;
+
+	pwm = kzalloc(sizeof(*pwm), GFP_KERNEL);
+	if (!pwm) {
+		ret = -ENOMEM;
+		dev_dbg(&pdev->dev, "failed to allocate memory\n");
+		goto err;
+	}
+
+	pwm->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(pwm->clk)) {
+		ret = PTR_ERR(pwm->clk);
+		dev_dbg(&pdev->dev, "Error getting clock\n");
+		goto err_free;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		ret = -ENODEV;
+		dev_dbg(&pdev->dev, "no memory resource defined\n");
+		goto err_free_clk;
+	}
+
+	if (!request_mem_region(res->start, resource_size(res), pdev->name)) {
+		ret = -EBUSY;
+		dev_dbg(&pdev->dev, "failed to request memory resource\n");
+		goto err_free_clk;
+	}
+
+	pwm->mmio_base = ioremap(res->start, resource_size(res));
+	if (!pwm->mmio_base) {
+		ret = -ENOMEM;
+		dev_dbg(&pdev->dev, "failed to ioremap\n");
+		goto err_free_mem;
+	}
+
+	/* initialize pwm structure */
+	pwm->clk_enabled = 0;
+	pwm->pdev = pdev;
+	/* if pdev->id is -1, only one pwm ip is present */
+	if (pdev->id == -1)
+		pwm->id = 0;
+	else
+		pwm->id = pdev->id;
+
+	spin_lock_init(&pwm->lock);
+	INIT_LIST_HEAD(&pwm->devices);
+	platform_set_drvdata(pdev, pwm);
+
+	/* add pwm to pwm list */
+	spin_lock(&list_lock);
+	list_add_tail(&pwm->node, &pwm_list);
+	spin_unlock(&list_lock);
+
+	/* add pwm devices */
+	for (pwmd_id = 0; pwmd_id < PWM_DEVICE_PER_IP; pwmd_id++) {
+		ret = add_pwm_device(pwmd_id, pwm);
+		if (!ret)
+			continue;
+		dev_err(&pdev->dev, "Add device fail for pwm device id: %d\n",
+				pwmd_id);
+	}
+
+	if (list_empty(&pwm->node))
+		goto err_remove_pwm;
+
+	dev_info(&pdev->dev, "Initialization successful\n");
+	return 0;
+
+err_remove_pwm:
+	spin_lock(&list_lock);
+	list_del(&pwm->node);
+	spin_unlock(&list_lock);
+
+	platform_set_drvdata(pdev, NULL);
+	iounmap(pwm->mmio_base);
+err_free_mem:
+	release_mem_region(res->start, resource_size(res));
+err_free_clk:
+	clk_put(pwm->clk);
+err_free:
+	kfree(pwm);
+err:
+	dev_err(&pdev->dev, "Initialization Fail. Error: %d\n", ret);
+
+	return ret;
+}
+
+static int __devexit st_pwm_remove(struct platform_device *pdev)
+{
+	struct pwm *pwm;
+	struct resource *res;
+	int ret = 0;
+
+	pwm = platform_get_drvdata(pdev);
+	if (pwm == NULL) {
+		ret = -ENODEV;
+		dev_dbg(&pdev->dev, "Remove: get_drvdata fail\n");
+		goto err;
+	}
+	platform_set_drvdata(pdev, NULL);
+
+	/* remove pwm devices */
+	remove_pwm_devices(pwm);
+
+	/* remove pwm from pwm_list */
+	spin_lock(&list_lock);
+	list_del(&pwm->node);
+	spin_unlock(&list_lock);
+
+	iounmap(pwm->mmio_base);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		ret = -ENODEV;
+		dev_dbg(&pdev->dev, "Remove: get_resource fail\n");
+		goto err;
+	}
+	release_mem_region(res->start, resource_size(res));
+
+	if (pwm->clk_enabled)
+		clk_disable(pwm->clk);
+	clk_put(pwm->clk);
+
+	kfree(pwm);
+	return 0;
+
+err:
+	dev_err(&pdev->dev, "Remove: Fail - %d\n", ret);
+	return ret;
+}
+
+static struct platform_driver st_pwm_driver = {
+	.driver = {
+		.name = "st_pwm",
+		.bus = &platform_bus_type,
+		.owner = THIS_MODULE,
+	},
+	.probe = st_pwm_probe,
+	.remove = __devexit_p(st_pwm_remove)
+};
+
+static int __init st_pwm_init(void)
+{
+	int ret = 0;
+
+	ret = platform_driver_register(&st_pwm_driver);
+	if (ret)
+		pr_err("failed to register st_pwm_driver\n");
+
+	return ret;
+}
+module_init(st_pwm_init);
+
+static void __exit st_pwm_exit(void)
+{
+	platform_driver_unregister(&st_pwm_driver);
+}
+module_exit(st_pwm_exit);
+
+MODULE_AUTHOR("Viresh Kumar <viresh.kumar@st.com>");
+MODULE_DESCRIPTION("ST PWM Driver");
+MODULE_LICENSE("GPL");
-- 
1.7.2.2
