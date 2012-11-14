From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Wed, 14 Nov 2012 17:19:06 +0100
Subject: [PATCH 5/9] usb: add phy connection by phy-mode
In-Reply-To: <1352909950-32555-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1352909950-32555-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1352909950-32555-6-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes it possible to set the connection of the usbphy to the
soc. It is derived from the oftree bindings for the ethernetphy and adds
similar helperfunctions.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/of/Kconfig        |    4 ++++
 drivers/of/Makefile       |    1 +
 drivers/of/of_usbphy.c    |   49 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_usbphy.h |   15 ++++++++++++++
 include/linux/usb/phy.h   |    8 ++++++++
 5 files changed, 77 insertions(+)
 create mode 100644 drivers/of/of_usbphy.c
 create mode 100644 include/linux/of_usbphy.h

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index dfba3e6..28f99fb 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -67,6 +67,10 @@ config OF_MDIO
 	help
 	  OpenFirmware MDIO bus (Ethernet PHY) accessors
 
+config OF_USBPHY
+	depends on USB
+	def_bool y
+
 config OF_PCI
 	def_tristate PCI
 	depends on PCI
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index e027f44..fdcaf51 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_OF_IRQ)    += irq.o
 obj-$(CONFIG_OF_DEVICE) += device.o platform.o
 obj-$(CONFIG_OF_I2C)	+= of_i2c.o
 obj-$(CONFIG_OF_NET)	+= of_net.o
+obj-$(CONFIG_OF_USBPHY)	+= of_usbphy.o
 obj-$(CONFIG_OF_SELFTEST) += selftest.o
 obj-$(CONFIG_OF_MDIO)	+= of_mdio.o
 obj-$(CONFIG_OF_PCI)	+= of_pci.o
diff --git a/drivers/of/of_usbphy.c b/drivers/of/of_usbphy.c
new file mode 100644
index 0000000..2e71f7b
--- /dev/null
+++ b/drivers/of/of_usbphy.c
@@ -0,0 +1,49 @@
+/*
+ * OF helpers for network devices.
+ *
+ * This file is released under the GPLv2
+ *
+ * Initially copied out of drivers/of/of_net.c
+ */
+#include <linux/etherdevice.h>
+#include <linux/kernel.h>
+#include <linux/of_usbphy.h>
+#include <linux/usb/phy.h>
+#include <linux/export.h>
+
+/**
+ * It maps 'enum usb_phy_interface' found in include/linux/usb/phy.h
+ * into the device tree binding of 'phy-mode', so that USB
+ * device driver can get phy interface from device tree.
+ */
+static const char *usbphy_modes[] = {
+	[USBPHY_INTERFACE_MODE_NA]	= "",
+	[USBPHY_INTERFACE_MODE_UTMI]	= "utmi",
+	[USBPHY_INTERFACE_MODE_UTMIW]	= "utmiw",
+	[USBPHY_INTERFACE_MODE_ULPI]	= "ulpi",
+	[USBPHY_INTERFACE_MODE_SERIAL]	= "fsls",
+};
+
+/**
+ * of_get_phy_mode - Get phy mode for given device_node
+ * @np:	Pointer to the given device_node
+ *
+ * The function gets phy interface string from property 'phy-mode',
+ * and return its index in phy_modes table, or errno in error case.
+ */
+const int of_get_usbphy_mode(struct device_node *np)
+{
+	const char *pm;
+	int err, i;
+
+	err = of_property_read_string(np, "phy-mode", &pm);
+	if (err < 0)
+		return err;
+
+	for (i = 0; i < ARRAY_SIZE(usbphy_modes); i++)
+		if (!strcasecmp(pm, usbphy_modes[i]))
+			return i;
+
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(of_get_usbphy_mode);
diff --git a/include/linux/of_usbphy.h b/include/linux/of_usbphy.h
new file mode 100644
index 0000000..9a4132d
--- /dev/null
+++ b/include/linux/of_usbphy.h
@@ -0,0 +1,15 @@
+/*
+ * OF helpers for usb devices.
+ *
+ * This file is released under the GPLv2
+ */
+
+#ifndef __LINUX_OF_USBPHY_H
+#define __LINUX_OF_USBPHY_H
+
+#ifdef CONFIG_OF_USBPHY
+#include <linux/of.h>
+extern const int of_get_usbphy_mode(struct device_node *np);
+#endif
+
+#endif /* __LINUX_OF_USBPHY_H */
diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
index a29ae1e..150eb69 100644
--- a/include/linux/usb/phy.h
+++ b/include/linux/usb/phy.h
@@ -12,6 +12,14 @@
 #include <linux/notifier.h>
 #include <linux/usb.h>
 
+enum usb_phy_interface {
+	USBPHY_INTERFACE_MODE_NA,
+	USBPHY_INTERFACE_MODE_UTMI,
+	USBPHY_INTERFACE_MODE_UTMIW,
+	USBPHY_INTERFACE_MODE_ULPI,
+	USBPHY_INTERFACE_MODE_SERIAL,
+};
+
 enum usb_phy_events {
 	USB_EVENT_NONE,         /* no events or cable disconnected */
 	USB_EVENT_VBUS,         /* vbus valid event */
-- 
1.7.10.4
