From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 19 Oct 2016 10:28:26 +0800
Subject: [PATCH v7, 7/8] usb: mtu3: dual-role mode support
In-Reply-To: <1476844107-31087-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1476844107-31087-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1476844107-31087-8-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

support dual-role mode; there are two ways to switch between
host and device modes, one is by idpin, another is by debugfs
which depends on user input.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/Kconfig       |   15 +-
 drivers/usb/mtu3/Makefile      |   11 +-
 drivers/usb/mtu3/mtu3.h        |   34 +++-
 drivers/usb/mtu3/mtu3_core.c   |   14 +-
 drivers/usb/mtu3/mtu3_dr.c     |  379 ++++++++++++++++++++++++++++++++++++++++
 drivers/usb/mtu3/mtu3_dr.h     |   27 ++-
 drivers/usb/mtu3/mtu3_gadget.c |    6 +-
 drivers/usb/mtu3/mtu3_host.c   |    6 +
 drivers/usb/mtu3/mtu3_plat.c   |   86 ++++++++-
 9 files changed, 557 insertions(+), 21 deletions(-)
 create mode 100644 drivers/usb/mtu3/mtu3_dr.c

diff --git a/drivers/usb/mtu3/Kconfig b/drivers/usb/mtu3/Kconfig
index 59e3f6f..25cd619 100644
--- a/drivers/usb/mtu3/Kconfig
+++ b/drivers/usb/mtu3/Kconfig
@@ -2,7 +2,7 @@
 
 config USB_MTU3
 	tristate "MediaTek USB3 Dual Role controller"
-	depends on (USB || USB_GADGET) && HAS_DMA
+	depends on EXTCON && (USB || USB_GADGET) && HAS_DMA
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	select USB_XHCI_MTK if USB_SUPPORT && USB_XHCI_HCD
 	help
@@ -19,6 +19,7 @@ config USB_MTU3
 if USB_MTU3
 choice
 	bool "MTU3 Mode Selection"
+	default USB_MTU3_DUAL_ROLE if (USB && USB_GADGET)
 	default USB_MTU3_HOST if (USB && !USB_GADGET)
 	default USB_MTU3_GADGET if (!USB && USB_GADGET)
 
@@ -36,6 +37,18 @@ config USB_MTU3_GADGET
 	  Select this when you want to use MTU3 in gadget mode only,
 	  thereby the host feature will be regressed.
 
+config USB_MTU3_DUAL_ROLE
+	bool "Dual Role mode"
+	depends on ((USB=y || USB=USB_MTU3) && (USB_GADGET=y || USB_GADGET=USB_MTU3))
+	help
+	  This is the default mode of working of MTU3 controller where
+	  both host and gadget features are enabled.
+
 endchoice
 
+config USB_MTU3_DEBUG
+	bool "Enable Debugging Messages"
+	help
+	  Say Y here to enable debugging messages in the MTU3 Driver.
+
 endif
diff --git a/drivers/usb/mtu3/Makefile b/drivers/usb/mtu3/Makefile
index 41e45e9..60e0fff 100644
--- a/drivers/usb/mtu3/Makefile
+++ b/drivers/usb/mtu3/Makefile
@@ -1,11 +1,18 @@
+
+ccflags-$(CONFIG_USB_MTU3_DEBUG)	+= -DDEBUG
+
 obj-$(CONFIG_USB_MTU3)	+= mtu3.o
 
 mtu3-y	:= mtu3_plat.o
 
-ifneq ($(filter y,$(CONFIG_USB_MTU3_HOST)),)
+ifneq ($(filter y,$(CONFIG_USB_MTU3_HOST) $(CONFIG_USB_MTU3_DUAL_ROLE)),)
 	mtu3-y	+= mtu3_host.o
 endif
 
-ifneq ($(filter y,$(CONFIG_USB_MTU3_GADGET)),)
+ifneq ($(filter y,$(CONFIG_USB_MTU3_GADGET) $(CONFIG_USB_MTU3_DUAL_ROLE)),)
 	mtu3-y	+= mtu3_core.o mtu3_gadget_ep0.o mtu3_gadget.o mtu3_qmu.o
 endif
+
+ifneq ($(CONFIG_USB_MTU3_DUAL_ROLE),)
+	mtu3-y	+= mtu3_dr.o
+endif
diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index a7c0ce8..ba9df71 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -21,6 +21,7 @@
 
 #include <linux/device.h>
 #include <linux/dmapool.h>
+#include <linux/extcon.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
 #include <linux/phy/phy.h>
@@ -172,15 +173,44 @@ struct mtu3_gpd_ring {
 	struct qmu_gpd *enqueue;
 	struct qmu_gpd *dequeue;
 };
+
+/**
+* @vbus: vbus 5V used by host mode
+* @edev: external connector used to detect vbus and iddig changes
+* @vbus_nb: notifier for vbus detection
+* @vbus_nb: notifier for iddig(idpin) detection
+* @extcon_reg_dwork: delay work for extcon notifier register, waiting for
+*		xHCI driver initialization, it's necessary for system bootup
+*		as device.
+* @is_u3_drd: whether port0 supports usb3.0 dual-role device or not
+* @id_*: used to maually switch between host and device modes by idpin
+* @manual_drd_enabled: it's true when supports dual-role device by debugfs
+*		to switch host/device modes depending on user input.
+*/
+struct otg_switch_mtk {
+	struct regulator *vbus;
+	struct extcon_dev *edev;
+	struct notifier_block vbus_nb;
+	struct notifier_block id_nb;
+	struct delayed_work extcon_reg_dwork;
+	bool is_u3_drd;
+	/* dual-role switch by debugfs */
+	struct pinctrl *id_pinctrl;
+	struct pinctrl_state *id_float;
+	struct pinctrl_state *id_ground;
+	bool manual_drd_enabled;
+};
+
 /**
  * @mac_base: register base address of device MAC, exclude xHCI's
- * @ippc_base: register base address of ip port controller interface (IPPC)
+ * @ippc_base: register base address of IP Power and Clock interface (IPPC)
  * @vusb33: usb3.3V shared by device/host IP
  * @sys_clk: system clock of mtu3, shared by device/host IP
  * @dr_mode: works in which mode:
  *		host only, device only or dual-role mode
  * @u2_ports: number of usb2.0 host ports
  * @u3_ports: number of usb3.0 host ports
+ * @dbgfs_root: only used when supports manual dual-role switch via debugfs
  * @wakeup_en: it's true when supports remote wakeup in host mode
  * @wk_deb_p0: port0's wakeup debounce clock
  * @wk_deb_p1: it's optional, and depends on port1 is supported or not
@@ -196,10 +226,12 @@ struct ssusb_mtk {
 	struct regulator *vusb33;
 	struct clk *sys_clk;
 	/* otg */
+	struct otg_switch_mtk otg_switch;
 	enum usb_dr_mode dr_mode;
 	bool is_host;
 	int u2_ports;
 	int u3_ports;
+	struct dentry *dbgfs_root;
 	/* usb wakeup for host mode */
 	bool wakeup_en;
 	struct clk *wk_deb_p0;
diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index 2eef972..520e55a 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -150,7 +150,6 @@ static void mtu3_intr_disable(struct mtu3 *mtu)
 
 	/* Disable level 1 interrupts */
 	mtu3_writel(mbase, U3D_LV1IECR, ~0x0);
-
 	/* Disable endpoint interrupts */
 	mtu3_writel(mbase, U3D_EPIECR, ~0x0);
 }
@@ -161,13 +160,10 @@ static void mtu3_intr_status_clear(struct mtu3 *mtu)
 
 	/* Clear EP0 and Tx/Rx EPn interrupts status */
 	mtu3_writel(mbase, U3D_EPISR, ~0x0);
-
 	/* Clear U2 USB common interrupts status */
 	mtu3_writel(mbase, U3D_COMMON_USB_INTR, ~0x0);
-
 	/* Clear U3 LTSSM interrupts status */
 	mtu3_writel(mbase, U3D_LTSSM_INTR, ~0x0);
-
 	/* Clear speed change interrupt status */
 	mtu3_writel(mbase, U3D_DEV_LINK_INTR, ~0x0);
 }
@@ -268,7 +264,6 @@ void mtu3_start(struct mtu3 *mtu)
 
 	/* Initialize the default interrupts */
 	mtu3_intr_enable(mtu);
-
 	mtu->is_active = 1;
 
 	if (mtu->softconnect)
@@ -516,7 +511,6 @@ static int mtu3_mem_alloc(struct mtu3 *mtu)
 	mtu->out_eps = &ep_array[mtu->num_eps];
 	/* ep0 uses in_eps[0], out_eps[0] is reserved */
 	mtu->ep0 = mtu->in_eps;
-
 	mtu->ep0->mtu = mtu;
 	mtu->ep0->epnum = 0;
 
@@ -560,6 +554,7 @@ static void mtu3_set_speed(struct mtu3 *mtu)
 		/* HS/FS detected by HW */
 		mtu3_setbits(mbase, U3D_POWER_MANAGEMENT, HS_ENABLE);
 	}
+
 	dev_info(mtu->dev, "max_speed: %s\n",
 		usb_speed_string(mtu->max_speed));
 }
@@ -586,13 +581,10 @@ static void mtu3_regs_init(struct mtu3 *mtu)
 
 	/* delay about 0.1us from detecting reset to send chirp-K */
 	mtu3_clrbits(mbase, U3D_LINK_RESET_INFO, WTCHRP_MSK);
-
 	/* U2/U3 detected by HW */
 	mtu3_writel(mbase, U3D_DEVICE_CONF, 0);
-
 	/* enable QMU 16B checksum */
 	mtu3_setbits(mbase, U3D_QCR0, QMU_CS16B_EN);
-
 	/* vbus detected by HW */
 	mtu3_clrbits(mbase, U3D_MISC_CTRL, VBUS_FRC_EN | VBUS_ON);
 }
@@ -838,6 +830,10 @@ int ssusb_gadget_init(struct ssusb_mtk *ssusb)
 		goto gadget_err;
 	}
 
+	/* init as host mode, power down device IP for power saving */
+	if (mtu->ssusb->dr_mode == USB_DR_MODE_OTG)
+		mtu3_stop(mtu);
+
 	dev_dbg(dev, " %s() done...\n", __func__);
 
 	return 0;
diff --git a/drivers/usb/mtu3/mtu3_dr.c b/drivers/usb/mtu3/mtu3_dr.c
new file mode 100644
index 0000000..1a8987e
--- /dev/null
+++ b/drivers/usb/mtu3/mtu3_dr.c
@@ -0,0 +1,379 @@
+/*
+ * mtu3_dr.c - dual role switch and host glue layer
+ *
+ * Copyright (C) 2016 MediaTek Inc.
+ *
+ * Author: Chunfeng Yun <chunfeng.yun@mediatek.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/debugfs.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/seq_file.h>
+#include <linux/uaccess.h>
+
+#include "mtu3.h"
+#include "mtu3_dr.h"
+
+#define USB2_PORT 2
+#define USB3_PORT 3
+
+enum mtu3_vbus_id_state {
+	MTU3_ID_FLOAT = 1,
+	MTU3_ID_GROUND,
+	MTU3_VBUS_OFF,
+	MTU3_VBUS_VALID,
+};
+
+static void toggle_opstate(struct ssusb_mtk *ssusb)
+{
+	if (!ssusb->otg_switch.is_u3_drd) {
+		mtu3_setbits(ssusb->mac_base, U3D_DEVICE_CONTROL, DC_SESSION);
+		mtu3_setbits(ssusb->mac_base, U3D_POWER_MANAGEMENT, SOFT_CONN);
+	}
+}
+
+/* only port0 supports dual-role mode */
+static int ssusb_port0_switch(struct ssusb_mtk *ssusb,
+	int version, bool tohost)
+{
+	void __iomem *ibase = ssusb->ippc_base;
+	u32 value;
+
+	dev_dbg(ssusb->dev, "%s (switch u%d port0 to %s)\n", __func__,
+		version, tohost ? "host" : "device");
+
+	if (version == USB2_PORT) {
+		/* 1. power off and disable u2 port0 */
+		value = mtu3_readl(ibase, SSUSB_U2_CTRL(0));
+		value |= SSUSB_U2_PORT_PDN | SSUSB_U2_PORT_DIS;
+		mtu3_writel(ibase, SSUSB_U2_CTRL(0), value);
+
+		/* 2. power on, enable u2 port0 and select its mode */
+		value = mtu3_readl(ibase, SSUSB_U2_CTRL(0));
+		value &= ~(SSUSB_U2_PORT_PDN | SSUSB_U2_PORT_DIS);
+		value = tohost ? (value | SSUSB_U2_PORT_HOST_SEL) :
+			(value & (~SSUSB_U2_PORT_HOST_SEL));
+		mtu3_writel(ibase, SSUSB_U2_CTRL(0), value);
+	} else {
+		/* 1. power off and disable u3 port0 */
+		value = mtu3_readl(ibase, SSUSB_U3_CTRL(0));
+		value |= SSUSB_U3_PORT_PDN | SSUSB_U3_PORT_DIS;
+		mtu3_writel(ibase, SSUSB_U3_CTRL(0), value);
+
+		/* 2. power on, enable u3 port0 and select its mode */
+		value = mtu3_readl(ibase, SSUSB_U3_CTRL(0));
+		value &= ~(SSUSB_U3_PORT_PDN | SSUSB_U3_PORT_DIS);
+		value = tohost ? (value | SSUSB_U3_PORT_HOST_SEL) :
+			(value & (~SSUSB_U3_PORT_HOST_SEL));
+		mtu3_writel(ibase, SSUSB_U3_CTRL(0), value);
+	}
+
+	return 0;
+}
+
+static void switch_port_to_host(struct ssusb_mtk *ssusb)
+{
+	u32 check_clk = 0;
+
+	dev_dbg(ssusb->dev, "%s\n", __func__);
+
+	ssusb_port0_switch(ssusb, USB2_PORT, true);
+
+	if (ssusb->otg_switch.is_u3_drd) {
+		ssusb_port0_switch(ssusb, USB3_PORT, true);
+		check_clk = SSUSB_U3_MAC_RST_B_STS;
+	}
+
+	ssusb_check_clocks(ssusb, check_clk);
+
+	/* after all clocks are stable */
+	toggle_opstate(ssusb);
+}
+
+static void switch_port_to_device(struct ssusb_mtk *ssusb)
+{
+	u32 check_clk = 0;
+
+	dev_dbg(ssusb->dev, "%s\n", __func__);
+
+	ssusb_port0_switch(ssusb, USB2_PORT, false);
+
+	if (ssusb->otg_switch.is_u3_drd) {
+		ssusb_port0_switch(ssusb, USB3_PORT, false);
+		check_clk = SSUSB_U3_MAC_RST_B_STS;
+	}
+
+	ssusb_check_clocks(ssusb, check_clk);
+}
+
+int ssusb_set_vbus(struct otg_switch_mtk *otg_sx, int is_on)
+{
+	struct ssusb_mtk *ssusb =
+		container_of(otg_sx, struct ssusb_mtk, otg_switch);
+	struct regulator *vbus = otg_sx->vbus;
+	int ret;
+
+	/* vbus is optional */
+	if (!vbus)
+		return 0;
+
+	dev_dbg(ssusb->dev, "%s: turn %s\n", __func__, is_on ? "on" : "off");
+
+	if (is_on) {
+		ret = regulator_enable(vbus);
+		if (ret) {
+			dev_err(ssusb->dev, "vbus regulator enable failed\n");
+			return ret;
+		}
+	} else {
+		regulator_disable(vbus);
+	}
+
+	return 0;
+}
+
+/*
+ * switch to host: -> MTU3_VBUS_OFF --> MTU3_ID_GROUND
+ * switch to device: -> MTU3_ID_FLOAT --> MTU3_VBUS_VALID
+ */
+static void ssusb_set_mailbox(struct otg_switch_mtk *otg_sx,
+	enum mtu3_vbus_id_state status)
+{
+	struct ssusb_mtk *ssusb =
+		container_of(otg_sx, struct ssusb_mtk, otg_switch);
+	struct mtu3 *mtu = ssusb->u3d;
+
+	dev_dbg(ssusb->dev, "mailbox state(%d)\n", status);
+
+	switch (status) {
+	case MTU3_ID_GROUND:
+		switch_port_to_host(ssusb);
+		ssusb_set_vbus(otg_sx, 1);
+		ssusb->is_host = true;
+		break;
+	case MTU3_ID_FLOAT:
+		ssusb->is_host = false;
+		ssusb_set_vbus(otg_sx, 0);
+		switch_port_to_device(ssusb);
+		break;
+	case MTU3_VBUS_OFF:
+		mtu3_stop(mtu);
+		pm_relax(ssusb->dev);
+		break;
+	case MTU3_VBUS_VALID:
+		/* avoid suspend when works as device */
+		pm_stay_awake(ssusb->dev);
+		mtu3_start(mtu);
+		break;
+	default:
+		dev_err(ssusb->dev, "invalid state\n");
+	}
+}
+
+static int ssusb_id_notifier(struct notifier_block *nb,
+	unsigned long event, void *ptr)
+{
+	struct otg_switch_mtk *otg_sx =
+		container_of(nb, struct otg_switch_mtk, id_nb);
+
+	if (event)
+		ssusb_set_mailbox(otg_sx, MTU3_ID_GROUND);
+	else
+		ssusb_set_mailbox(otg_sx, MTU3_ID_FLOAT);
+
+	return NOTIFY_DONE;
+}
+
+static int ssusb_vbus_notifier(struct notifier_block *nb,
+	unsigned long event, void *ptr)
+{
+	struct otg_switch_mtk *otg_sx =
+		container_of(nb, struct otg_switch_mtk, vbus_nb);
+
+	if (event)
+		ssusb_set_mailbox(otg_sx, MTU3_VBUS_VALID);
+	else
+		ssusb_set_mailbox(otg_sx, MTU3_VBUS_OFF);
+
+	return NOTIFY_DONE;
+}
+
+static int ssusb_extcon_register(struct otg_switch_mtk *otg_sx)
+{
+	struct ssusb_mtk *ssusb =
+		container_of(otg_sx, struct ssusb_mtk, otg_switch);
+	struct extcon_dev *edev = otg_sx->edev;
+	int ret;
+
+	/* extcon is optional */
+	if (!edev)
+		return 0;
+
+	otg_sx->vbus_nb.notifier_call = ssusb_vbus_notifier;
+	ret = extcon_register_notifier(edev, EXTCON_USB,
+					&otg_sx->vbus_nb);
+	if (ret < 0)
+		dev_err(ssusb->dev, "failed to register notifier for USB\n");
+
+	otg_sx->id_nb.notifier_call = ssusb_id_notifier;
+	ret = extcon_register_notifier(edev, EXTCON_USB_HOST,
+					&otg_sx->id_nb);
+	if (ret < 0)
+		dev_err(ssusb->dev, "failed to register notifier for USB-HOST\n");
+
+	dev_dbg(ssusb->dev, "EXTCON_USB: %d, EXTCON_USB_HOST: %d\n",
+		extcon_get_cable_state_(edev, EXTCON_USB),
+		extcon_get_cable_state_(edev, EXTCON_USB_HOST));
+
+	/* default as host, switch to device mode if needed */
+	if (extcon_get_cable_state_(edev, EXTCON_USB_HOST) == false)
+		ssusb_set_mailbox(otg_sx, MTU3_ID_FLOAT);
+	if (extcon_get_cable_state_(edev, EXTCON_USB) == true)
+		ssusb_set_mailbox(otg_sx, MTU3_VBUS_VALID);
+
+	return 0;
+}
+
+static void extcon_register_dwork(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct otg_switch_mtk *otg_sx =
+	    container_of(dwork, struct otg_switch_mtk, extcon_reg_dwork);
+
+	ssusb_extcon_register(otg_sx);
+}
+
+/*
+ * We provide an interface via debugfs to switch between host and device modes
+ * depending on user input.
+ * This is useful in special cases, such as uses TYPE-A receptacle but also
+ * wants to support dual-role mode.
+ * It generates cable state changes by pulling up/down IDPIN and
+ * notifies driver to switch mode by "extcon-usb-gpio".
+ * NOTE: when use MICRO receptacle, should not enable this interface.
+ */
+static void ssusb_mode_manual_switch(struct ssusb_mtk *ssusb, int to_host)
+{
+	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
+
+	if (to_host)
+		pinctrl_select_state(otg_sx->id_pinctrl, otg_sx->id_ground);
+	else
+		pinctrl_select_state(otg_sx->id_pinctrl, otg_sx->id_float);
+}
+
+
+static int ssusb_mode_show(struct seq_file *sf, void *unused)
+{
+	struct ssusb_mtk *ssusb = sf->private;
+
+	seq_printf(sf, "current mode: %s(%s drd)\n(echo device/host)\n",
+		ssusb->is_host ? "host" : "device",
+		ssusb->otg_switch.manual_drd_enabled ? "manual" : "auto");
+
+	return 0;
+}
+
+static int ssusb_mode_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ssusb_mode_show, inode->i_private);
+}
+
+static ssize_t ssusb_mode_write(struct file *file,
+	const char __user *ubuf, size_t count, loff_t *ppos)
+{
+	struct seq_file *sf = file->private_data;
+	struct ssusb_mtk *ssusb = sf->private;
+	char buf[16];
+
+	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
+		return -EFAULT;
+
+	if (!strncmp(buf, "host", 4) && !ssusb->is_host) {
+		ssusb_mode_manual_switch(ssusb, 1);
+	} else if (!strncmp(buf, "device", 6) && ssusb->is_host) {
+		ssusb_mode_manual_switch(ssusb, 0);
+	} else {
+		dev_err(ssusb->dev, "wrong or duplicated setting\n");
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static const struct file_operations ssusb_mode_fops = {
+	.open = ssusb_mode_open,
+	.write = ssusb_mode_write,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static void ssusb_debugfs_init(struct ssusb_mtk *ssusb)
+{
+	struct dentry *root;
+	struct dentry *file;
+
+	root = debugfs_create_dir(dev_name(ssusb->dev), usb_debug_root);
+	if (IS_ERR_OR_NULL(root)) {
+		if (!root)
+			dev_err(ssusb->dev, "create debugfs root failed\n");
+		return;
+	}
+	ssusb->dbgfs_root = root;
+
+	file = debugfs_create_file("mode", S_IRUGO | S_IWUSR, root,
+			ssusb, &ssusb_mode_fops);
+	if (!file)
+		dev_dbg(ssusb->dev, "create debugfs mode failed\n");
+}
+
+static void ssusb_debugfs_exit(struct ssusb_mtk *ssusb)
+{
+	debugfs_remove_recursive(ssusb->dbgfs_root);
+}
+
+int ssusb_otg_switch_init(struct ssusb_mtk *ssusb)
+{
+	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
+
+	INIT_DELAYED_WORK(&otg_sx->extcon_reg_dwork, extcon_register_dwork);
+
+	if (otg_sx->manual_drd_enabled)
+		ssusb_debugfs_init(ssusb);
+
+	/* It is enough to delay 1s for waiting for host initialization */
+	schedule_delayed_work(&otg_sx->extcon_reg_dwork, HZ);
+
+	return 0;
+}
+
+void ssusb_otg_switch_exit(struct ssusb_mtk *ssusb)
+{
+	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
+
+	cancel_delayed_work(&otg_sx->extcon_reg_dwork);
+
+	if (otg_sx->edev) {
+		extcon_unregister_notifier(otg_sx->edev,
+			EXTCON_USB, &otg_sx->vbus_nb);
+		extcon_unregister_notifier(otg_sx->edev,
+			EXTCON_USB_HOST, &otg_sx->id_nb);
+	}
+
+	if (otg_sx->manual_drd_enabled)
+		ssusb_debugfs_exit(ssusb);
+}
diff --git a/drivers/usb/mtu3/mtu3_dr.h b/drivers/usb/mtu3/mtu3_dr.h
index 07066f4..9b228b5 100644
--- a/drivers/usb/mtu3/mtu3_dr.h
+++ b/drivers/usb/mtu3/mtu3_dr.h
@@ -19,7 +19,7 @@
 #ifndef _MTU3_DR_H_
 #define _MTU3_DR_H_
 
-#if IS_ENABLED(CONFIG_USB_MTU3_HOST)
+#if IS_ENABLED(CONFIG_USB_MTU3_HOST) || IS_ENABLED(CONFIG_USB_MTU3_DUAL_ROLE)
 
 int ssusb_host_init(struct ssusb_mtk *ssusb, struct device_node *parent_dn);
 void ssusb_host_exit(struct ssusb_mtk *ssusb);
@@ -69,7 +69,7 @@ static inline void ssusb_wakeup_disable(struct ssusb_mtk *ssusb)
 #endif
 
 
-#if IS_ENABLED(CONFIG_USB_MTU3_GADGET)
+#if IS_ENABLED(CONFIG_USB_MTU3_GADGET) || IS_ENABLED(CONFIG_USB_MTU3_DUAL_ROLE)
 int ssusb_gadget_init(struct ssusb_mtk *ssusb);
 void ssusb_gadget_exit(struct ssusb_mtk *ssusb);
 #else
@@ -82,4 +82,27 @@ static inline void ssusb_gadget_exit(struct ssusb_mtk *ssusb)
 {}
 #endif
 
+
+#if IS_ENABLED(CONFIG_USB_MTU3_DUAL_ROLE)
+int ssusb_otg_switch_init(struct ssusb_mtk *ssusb);
+void ssusb_otg_switch_exit(struct ssusb_mtk *ssusb);
+int ssusb_set_vbus(struct otg_switch_mtk *otg_sx, int is_on);
+
+#else
+
+static inline int ssusb_otg_switch_init(struct ssusb_mtk *ssusb)
+{
+	return 0;
+}
+
+static inline void ssusb_otg_switch_exit(struct ssusb_mtk *ssusb)
+{}
+
+static inline int ssusb_set_vbus(struct otg_switch_mtk *otg_sx, int is_on)
+{
+	return 0;
+}
+
+#endif
+
 #endif		/* _MTU3_DR_H_ */
diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index 84f3fe1..9dd2441 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -522,7 +522,8 @@ static int mtu3_gadget_start(struct usb_gadget *gadget,
 	mtu->softconnect = 0;
 	mtu->gadget_driver = driver;
 
-	mtu3_start(mtu);
+	if (mtu->ssusb->dr_mode == USB_DR_MODE_PERIPHERAL)
+		mtu3_start(mtu);
 
 	spin_unlock_irqrestore(&mtu->lock, flags);
 
@@ -575,7 +576,8 @@ static int mtu3_gadget_stop(struct usb_gadget *g)
 	stop_activity(mtu);
 	mtu->gadget_driver = NULL;
 
-	mtu3_stop(mtu);
+	if (mtu->ssusb->dr_mode == USB_DR_MODE_PERIPHERAL)
+		mtu3_stop(mtu);
 
 	spin_unlock_irqrestore(&mtu->lock, flags);
 
diff --git a/drivers/usb/mtu3/mtu3_host.c b/drivers/usb/mtu3/mtu3_host.c
index 361d6d8..cd4d010 100644
--- a/drivers/usb/mtu3/mtu3_host.c
+++ b/drivers/usb/mtu3/mtu3_host.c
@@ -230,10 +230,16 @@ static void ssusb_host_setup(struct ssusb_mtk *ssusb)
 	 * if support OTG, gadget driver will switch port0 to device mode
 	 */
 	ssusb_host_enable(ssusb);
+
+	/* if port0 supports dual-role, works as host mode by default */
+	ssusb_set_vbus(&ssusb->otg_switch, 1);
 }
 
 static void ssusb_host_cleanup(struct ssusb_mtk *ssusb)
 {
+	if (ssusb->is_host)
+		ssusb_set_vbus(&ssusb->otg_switch, 0);
+
 	ssusb_host_disable(ssusb, false);
 }
 
diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index facb76c..7833678 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -142,13 +142,10 @@ static int ssusb_rscs_init(struct ssusb_mtk *ssusb)
 
 phy_err:
 	ssusb_phy_exit(ssusb);
-
 phy_init_err:
 	clk_disable_unprepare(ssusb->sys_clk);
-
 clk_err:
 	regulator_disable(ssusb->vusb33);
-
 vusb33_err:
 
 	return ret;
@@ -170,10 +167,39 @@ static void ssusb_ip_sw_reset(struct ssusb_mtk *ssusb)
 	mtu3_clrbits(ssusb->ippc_base, U3D_SSUSB_IP_PW_CTRL0, SSUSB_IP_SW_RST);
 }
 
+static int get_iddig_pinctrl(struct ssusb_mtk *ssusb)
+{
+	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
+
+	otg_sx->id_pinctrl = devm_pinctrl_get(ssusb->dev);
+	if (IS_ERR(otg_sx->id_pinctrl)) {
+		dev_err(ssusb->dev, "Cannot find id pinctrl!\n");
+		return PTR_ERR(otg_sx->id_pinctrl);
+	}
+
+	otg_sx->id_float =
+		pinctrl_lookup_state(otg_sx->id_pinctrl, "id_float");
+	if (IS_ERR(otg_sx->id_float)) {
+		dev_err(ssusb->dev, "Cannot find pinctrl id_float!\n");
+		return PTR_ERR(otg_sx->id_float);
+	}
+
+	otg_sx->id_ground =
+		pinctrl_lookup_state(otg_sx->id_pinctrl, "id_ground");
+	if (IS_ERR(otg_sx->id_ground)) {
+		dev_err(ssusb->dev, "Cannot find pinctrl id_ground!\n");
+		return PTR_ERR(otg_sx->id_ground);
+	}
+
+	return 0;
+}
+
 static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 {
 	struct device_node *node = pdev->dev.of_node;
+	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
 	struct device *dev = &pdev->dev;
+	struct regulator *vbus;
 	struct resource *res;
 	int i;
 	int ret;
@@ -230,6 +256,37 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 	if (ret)
 		return ret;
 
+	if (ssusb->dr_mode != USB_DR_MODE_OTG)
+		return 0;
+
+	/* if dual-role mode is supported */
+	vbus = devm_regulator_get(&pdev->dev, "vbus");
+	if (IS_ERR(vbus)) {
+		dev_err(dev, "failed to get vbus\n");
+		return PTR_ERR(vbus);
+	}
+	otg_sx->vbus = vbus;
+
+	otg_sx->is_u3_drd = of_property_read_bool(node, "mediatek,usb3-drd");
+	otg_sx->manual_drd_enabled =
+		of_property_read_bool(node, "enable-manual-drd");
+
+	if (of_property_read_bool(node, "extcon")) {
+		otg_sx->edev = extcon_get_edev_by_phandle(ssusb->dev, 0);
+		if (IS_ERR(otg_sx->edev)) {
+			dev_err(ssusb->dev, "couldn't get extcon device\n");
+			return -EPROBE_DEFER;
+		}
+		if (otg_sx->manual_drd_enabled) {
+			ret = get_iddig_pinctrl(ssusb);
+			if (ret)
+				return ret;
+		}
+	}
+
+	dev_info(dev, "dr_mode: %d, is_u3_dr: %d\n",
+		ssusb->dr_mode, otg_sx->is_u3_drd);
+
 	return 0;
 }
 
@@ -292,6 +349,21 @@ static int mtu3_probe(struct platform_device *pdev)
 			goto comm_exit;
 		}
 		break;
+	case USB_DR_MODE_OTG:
+		ret = ssusb_gadget_init(ssusb);
+		if (ret) {
+			dev_err(dev, "failed to initialize gadget\n");
+			goto comm_exit;
+		}
+
+		ret = ssusb_host_init(ssusb, node);
+		if (ret) {
+			dev_err(dev, "failed to initialize host\n");
+			goto gadget_exit;
+		}
+
+		ssusb_otg_switch_init(ssusb);
+		break;
 	default:
 		dev_err(dev, "unsupported mode: %d\n", ssusb->dr_mode);
 		ret = -EINVAL;
@@ -300,9 +372,10 @@ static int mtu3_probe(struct platform_device *pdev)
 
 	return 0;
 
+gadget_exit:
+	ssusb_gadget_exit(ssusb);
 comm_exit:
 	ssusb_rscs_exit(ssusb);
-
 comm_init_err:
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
@@ -321,6 +394,11 @@ static int mtu3_remove(struct platform_device *pdev)
 	case USB_DR_MODE_HOST:
 		ssusb_host_exit(ssusb);
 		break;
+	case USB_DR_MODE_OTG:
+		ssusb_otg_switch_exit(ssusb);
+		ssusb_gadget_exit(ssusb);
+		ssusb_host_exit(ssusb);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
1.7.9.5
