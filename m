From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 6 Dec 2011 18:43:12 +0800
Subject: [RFC PATCH 1/3] USB: Add Generic USB PHY Layer code
In-Reply-To: <1323168194-24191-1-git-send-email-peter.chen@freescale.com>
References: <1323168194-24191-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1323168194-24191-2-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This code is based on Heikki Krogerus's RFC that
Separate USB transceivers from the OTG utility
(http://www.spinics.net/lists/linux-usb/msg50149.html)

The main changes are:
- Change usb_get_transceiver's parameter from phy's name to related
controller device's name
- Fix some errors, and let it work OK at freescale i.MX51 bbg board.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/otg/Kconfig  |    2 +
 drivers/usb/otg/Makefile |    1 +
 drivers/usb/otg/phy.c    |  368 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/usb/phy.h  |  250 +++++++++++++++++++++++++++++++
 4 files changed, 621 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
index c66481a..a313dbd 100644
--- a/drivers/usb/otg/Kconfig
+++ b/drivers/usb/otg/Kconfig
@@ -130,4 +130,6 @@ config FSL_USB2_OTG
 	help
 	  Enable this to support Freescale USB OTG transceiver.
 
+config USB_PHY
+	bool
 endif # USB || OTG
diff --git a/drivers/usb/otg/Makefile b/drivers/usb/otg/Makefile
index 566655c..6545d6d 100644
--- a/drivers/usb/otg/Makefile
+++ b/drivers/usb/otg/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_TWL6030_USB)	+= twl6030-usb.o
 obj-$(CONFIG_USB_LANGWELL_OTG)	+= langwell_otg.o
 obj-$(CONFIG_NOP_USB_XCEIV)	+= nop-usb-xceiv.o
 obj-$(CONFIG_USB_ULPI)		+= ulpi.o
+obj-$(CONFIG_USB_PHY)		+= phy.o
 obj-$(CONFIG_USB_ULPI_VIEWPORT)	+= ulpi_viewport.o
 obj-$(CONFIG_USB_MSM_OTG)	+= msm_otg.o
 obj-$(CONFIG_AB8500_USB)	+= ab8500-usb.o
diff --git a/drivers/usb/otg/phy.c b/drivers/usb/otg/phy.c
new file mode 100644
index 0000000..8a5f50c
--- /dev/null
+++ b/drivers/usb/otg/phy.c
@@ -0,0 +1,368 @@
+/*
+ * phy.c -- USB Pysical Layer utility code
+ *
+ * Copyright (C) 2011 Intel Corporation
+ *
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/list.h>
+
+#include <linux/usb/phy.h>
+
+static LIST_HEAD(xceiv_list);
+static DEFINE_MUTEX(xceiv_lock);
+
+/* For transceiver drivers */
+
+/*
+ * usb_register_transceiver - add a USB transceiver
+ * @xceiv: the transceiver to be added
+ *
+ * Add new transceiver to the list. USB transceiver drivers call this
+ * after filling struct usb_transceiver.
+ */
+void usb_register_transceiver(struct usb_transceiver *x)
+{
+	mutex_lock(&xceiv_lock);
+
+	list_add_tail(&x->list, &xceiv_list);
+
+	mutex_unlock(&xceiv_lock);
+}
+EXPORT_SYMBOL(usb_register_transceiver);
+
+/*
+ * usb_del_transceiver - remove a USB transceiver from the list
+ * @xceiv: the transceiver to be removed from the list
+ *
+ * Removes a transceiver from the list. USB transceiver drivers will
+ * call this when they are unloading. It is the responsibility of the
+ * driver the ensure there are no users left before calling this.
+ */
+void usb_unregister_transceiver(struct usb_transceiver *xceiv)
+{
+	mutex_lock(&xceiv_lock);
+
+	list_del(&xceiv->list);
+
+	mutex_unlock(&xceiv_lock);
+}
+EXPORT_SYMBOL(usb_unregister_transceiver);
+
+/* For everyone */
+
+/*
+ * usb_get_transceiver - find a USB transceiver
+ * @name: the device name which uses this transceiver
+ *
+ * Returns a transceiver driver matching the name, or NULL, and gets
+ * refcount to it. The caller is responsible for calling
+ * usb_put_transceiver() to release that count.
+ */
+struct usb_transceiver *usb_get_transceiver(const char *name)
+{
+	struct usb_transceiver *xceiv;
+
+	mutex_lock(&xceiv_lock);
+
+	list_for_each_entry(xceiv, &xceiv_list, list) {
+		if (strcmp(xceiv->recv_name, name) == 0) {
+			get_device(xceiv->dev);
+			mutex_unlock(&xceiv_lock);
+			return xceiv;
+		}
+	}
+
+	mutex_unlock(&xceiv_lock);
+
+	return NULL;
+}
+EXPORT_SYMBOL(usb_get_transceiver);
+
+/*
+ * usb_put_transceiver - release a USB transceiver
+ * @xceiv: the transceiver returned by usb_get_transceiver()
+ *
+ * Releases a refcount the caller received from usb_get_transceiver().
+ */
+void usb_put_transceiver(struct usb_transceiver *xceiv)
+{
+	mutex_lock(&xceiv_lock);
+
+	if (xceiv)
+		put_device(xceiv->dev);
+
+	mutex_unlock(&xceiv_lock);
+}
+EXPORT_SYMBOL(usb_put_transceiver);
+
+/* USB charging */
+
+static int usb_charger_get_property(struct power_supply *psy,
+				enum power_supply_property psp,
+				union power_supply_propval *val)
+{
+	struct usb_charger *charger =
+		container_of(psy, struct usb_charger, psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = charger->present;
+		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = charger->online;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		val->intval = charger->max_current;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static enum power_supply_property power_props[] = {
+	POWER_SUPPLY_PROP_PRESENT,	/* Charger detected */
+	POWER_SUPPLY_PROP_ONLINE,	/* VBUS online */
+	POWER_SUPPLY_PROP_CURRENT_MAX,	/* Maximum current in mA */
+};
+
+static void usb_charger_work(struct work_struct *data)
+{
+	int			ret;
+	struct usb_charger	*charger =
+			container_of(data, struct usb_charger, work);
+	struct usb_transceiver	*xceiv =
+			container_of(charger, struct usb_transceiver, charger);
+
+	/**
+	 * FIXME: THIS IS ONLY THE CONCEPT
+	 */
+
+	if (!charger->online)
+		return;
+
+	mutex_lock(&charger->lock);
+
+	/*
+	 * Let the charger know VBUS is online. This will usually
+	 * starts data contact detection.
+	 */
+	if (charger->connect && charger->connect(charger))
+		goto out;
+
+	/* Start the primary charger detection. */
+	if (charger->detect) {
+		ret = charger->detect(charger);
+		if (ret <= 0)
+			goto out;
+		else
+			charger->present = ret;
+	}
+
+	charger->psy.type = POWER_SUPPLY_TYPE_USB_DCP;
+
+	/* Set charger type (DCP, CDP, SDP...). */
+	if (charger->present && charger->get_type) {
+		ret = charger->get_type(charger);
+		if (ret >= 0)
+			charger->psy.type = ret;
+	}
+out:
+	switch (charger->psy.type) {
+	case POWER_SUPPLY_TYPE_USB_DCP:
+		charger->max_current = 5000; /* FIXME */
+		break;
+	case POWER_SUPPLY_TYPE_USB_CDP:
+		charger->max_current = 500;
+		/* FALLTHROUGH */
+	case POWER_SUPPLY_TYPE_USB:
+	default:
+		if (xceiv->link_connect)
+			xceiv->link_connect(xceiv->link_data);
+		break;
+	}
+
+	power_supply_changed(&charger->psy);
+
+	mutex_unlock(&charger->lock);
+}
+
+/*
+ * usb_create_charger - create a USB charger
+ * @charger: the charger to be initialized
+ * @name: name for the power supply
+ * @supplied_to: the power supplies that use this charger (batteries)
+ * @num_supplicants: number of power supplies using this charger
+ *
+ * Registers a power supply for the charger. The charger driver will
+ * call this after filling struct usb_charger. All the users are
+ * expected to be in the supplied_to parameter.
+ *
+ * There is no expectation for charger detection capability. USB as
+ * B-peripheral will always supply power. If charger detection is
+ * supported, the driver will fill the appropriate callbacks in the
+ * struct usb_charger.
+ *
+ * A transceiver will always contain the charger, was it used or not.
+ * The charger detection may be done in the transceiver hw or it may
+ * be done in a completely separate hw block. In any case, a charger
+ * is always linked with a transceiver as a transceiver will always
+ * represent the USB PHY where the power is actually coming.
+ */
+int usb_create_charger(struct usb_charger *charger,
+		const char *name,
+		char **supplied_to,
+		size_t num_supplicants)
+{
+	int			ret;
+	struct power_supply	*psy = &charger->psy;
+	struct usb_transceiver	*xceiv =
+			container_of(charger, struct usb_transceiver, charger);
+
+	if (!charger->dev)
+		return -EINVAL;
+
+	if (name)
+		psy->name = name;
+	else
+		psy->name = "usb";
+	psy->type		= POWER_SUPPLY_TYPE_USB;
+	psy->properties		= power_props;
+	psy->num_properties	= ARRAY_SIZE(power_props);
+	psy->get_property	= usb_charger_get_property;
+
+	psy->supplied_to	= supplied_to;
+	psy->num_supplicants	= num_supplicants;
+
+	ret = power_supply_register(charger->dev, psy);
+	if (ret)
+		goto fail;
+
+	mutex_init(&charger->lock);
+	INIT_WORK(&charger->work, usb_charger_work);
+
+	xceiv->has_charger = 1;
+fail:
+	return ret;
+}
+EXPORT_SYMBOL(usb_create_charger);
+
+/*
+ * usb_remove_charger - remove a USB charger
+ * @charger: the charger to be removed
+ *
+ * Unregister the chargers power supply.
+ */
+void usb_remove_charger(struct usb_charger *charger)
+{
+	struct usb_transceiver *xceiv =
+			container_of(charger, struct usb_transceiver, charger);
+
+	if (!xceiv->has_charger)
+		return;
+
+	power_supply_unregister(&charger->psy);
+	xceiv->has_charger = 0;
+}
+EXPORT_SYMBOL(usb_remove_charger);
+
+/*
+ * usb_set_power - Set the maximum power allowed to draw
+ * @xceiv: the transceiver containing the charger
+ * @mA: maximum current in milliamps
+ *
+ * Called from the controller after enumeration to inform the maximum
+ * power from the configuration, after bus suspend and resume.
+ */
+int usb_set_power(struct usb_transceiver *xceiv, unsigned mA)
+{
+	struct usb_charger *charger = &xceiv->charger;
+
+	/**
+	 * FIXME: THIS IS ONLY THE CONCEPT
+	 */
+
+	if (!xceiv->has_charger || !charger->online)
+		return 0;
+
+	if (charger->max_current == mA)
+		return 0;
+
+	/* If the charger is present, this is a CDP charger */
+	/* FIXME: Check the charger type. */
+	/* FIXME: When the bus is suspended, the current needs to be handled */
+	if (charger->present)
+		charger->max_current = 5000; /* FIXME */
+	else
+		charger->max_current = mA;
+
+	if (charger->set_power)
+		charger->set_power(charger, mA);
+
+	power_supply_changed(&charger->psy);
+
+	return 0;
+}
+EXPORT_SYMBOL(usb_set_power);
+
+/*
+ * usb_vbus_connect - inform about VBUS connection
+ * @xceiv: the transceiver containing the charger
+ *
+ * Inform the charger VBUS is connected. The USB device controller is
+ * expected to keep the dataline pullups disabled until link_connect()
+ * is called.
+ */
+int usb_vbus_connect(struct usb_transceiver *xceiv)
+{
+	struct usb_charger *charger = &xceiv->charger;
+
+	if (!xceiv->has_charger) {
+		if (xceiv->link_connect)
+			xceiv->link_connect(xceiv->link_data);
+		return 0;
+	}
+
+	charger->online = 1;
+	schedule_work(&charger->work);
+
+	return 0;
+}
+EXPORT_SYMBOL(usb_vbus_connect);
+
+/*
+ * usb_vbus_disconnect - inform about VBUS disconnection
+ * @xceiv: the transceiver containing the charger
+ *
+ * Inform the charger that VBUS is disconnected. The charging will be
+ * stopped and the charger properties cleared.
+ */
+int usb_vbus_disconnect(struct usb_transceiver *xceiv)
+{
+	struct usb_charger *charger = &xceiv->charger;
+
+	if (!xceiv->has_charger)
+		return 0;
+
+	charger->online = 0;
+	charger->present = 0;
+	charger->max_current = 0;
+	charger->psy.type = POWER_SUPPLY_TYPE_USB;
+
+	if (charger->disconnect)
+		charger->disconnect(charger);
+
+	power_supply_changed(&charger->psy);
+
+	return 0;
+}
+EXPORT_SYMBOL(usb_vbus_disconnect);
diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
new file mode 100644
index 0000000..f0f4ecf
--- /dev/null
+++ b/include/linux/usb/phy.h
@@ -0,0 +1,250 @@
+
+#ifndef __LINUX_USB_PHY_H
+#define __LINUX_USB_PHY_H
+
+#include <linux/power_supply.h>
+
+struct usb_transceiver;
+
+struct usb_xceiv_io_ops {
+	int (*read)(struct usb_transceiver *xceiv, u32 reg);
+	int (*write)(struct usb_transceiver *xceiv, u32 val, u32 reg);
+};
+
+enum usb_xceiv_interface {
+	USB_XCEIV_UNDEF,
+	USB_XCEIV_UTMI,
+	USB_XCEIV_UTMIPLUS,
+	USB_XCEIV_ULPI,
+	USB_XCEIV_SIE,
+};
+
+enum battery_charging_spec {
+	BATTERY_CHARGING_SPEC_NONE = 0,
+	BATTERY_CHARGING_SPEC_UNKNOWN,
+	BATTERY_CHARGING_SPEC_1_0,
+	BATTERY_CHARGING_SPEC_1_1,
+	BATTERY_CHARGING_SPEC_1_2,
+};
+
+struct usb_charger {
+	struct device		*dev;
+	struct power_supply	psy;
+	struct work_struct	work;
+	struct mutex		lock;
+
+	/* Compliant with Battery Charging Specification version (if any) */
+	enum battery_charging_spec	bc;
+
+	/* properties */
+	unsigned		present:1;
+	unsigned		online:1;
+	unsigned		max_current;
+
+	int	(*connect)(struct usb_charger *charger);
+	int	(*disconnect)(struct usb_charger *charger);
+	int	(*set_power)(struct usb_charger *charger, unsigned mA);
+
+	int	(*detect)(struct usb_charger *charger);
+	int	(*get_type)(struct usb_charger *charger);
+	/*void	(*detect_aca)(struct usb_charger *charger);*/
+};
+
+struct usb_transceiver {
+	struct device		*dev;
+	/* the device name of related usb controller */
+	char		*recv_name;
+
+	struct list_head	list;
+	struct usb_charger	charger;
+	unsigned		has_charger:1;
+
+	unsigned long		link_data;
+	unsigned int 		flags;
+
+	/*
+	 * For hw platforms where the transceiver needs to take care
+	 * of some of the OTG protocols.
+	 */
+	struct otg		*otg;
+
+	enum usb_xceiv_interface	interface;
+
+	struct usb_xceiv_io_ops		*io_ops;
+	void __iomem			*io_priv;
+
+	/* Initialize/shutdown the USB transceiver */
+	int	(*init)(struct usb_transceiver *xceiv);
+	int	(*shutdown)(struct usb_transceiver *xceiv);
+
+	/* set transceiver into suspend mode */
+	int	(*set_suspend)(struct usb_transceiver *xceiv,
+				int suspend);
+	/* effective for A-peripheral, ignored for B devices */
+	int	(*set_vbus)(struct usb_transceiver *xceiv,
+				bool enabled);
+
+	/* Called by the PHY utility code when it's safe to connect */
+	void	(*link_connect)(unsigned long data);
+
+	/* UTMI+ OTG control functions */
+	int	(*id_pullup)(struct usb_transceiver *xceiv, int on);
+	int	(*dp_pulldown)(struct usb_transceiver *xceiv, int on);
+	int	(*dm_pulldown)(struct usb_transceiver *xceiv, int on);
+	int	(*dischrg_vbus)(struct usb_transceiver *xceiv, int on);
+	int	(*chrg_vbus)(struct usb_transceiver *xceiv, int on);
+	int	(*drv_vbus)(struct usb_transceiver *xceiv, int on);
+};
+
+/* helpers for direct access thru low-level io interface */
+static inline int xceiv_io_read(struct usb_transceiver *xceiv, u32 reg)
+{
+	if (xceiv->io_ops && xceiv->io_ops->read)
+		return xceiv->io_ops->read(xceiv, reg);
+
+	return -EINVAL;
+}
+
+static inline int xceiv_io_write(struct usb_transceiver *xceiv, u32 val, u32 reg)
+{
+	if (xceiv->io_ops && xceiv->io_ops->write)
+		return xceiv->io_ops->write(xceiv, val, reg);
+
+	return -EINVAL;
+}
+/* Prototypes */
+extern void usb_register_transceiver(struct usb_transceiver *x);
+extern void usb_unregister_transceiver(struct usb_transceiver *xceiv);
+extern struct usb_transceiver *usb_get_transceiver(const char *name);
+extern void usb_put_transceiver(struct usb_transceiver *xceiv);
+
+extern int usb_set_power(struct usb_transceiver *xceiv, unsigned mA);
+extern int usb_vbus_connect(struct usb_transceiver *xceiv);
+extern int usb_vbus_disconnect(struct usb_transceiver *xceiv);
+
+/* Helpers for USB transceiver initialization and powering */
+
+/*
+ * ULPI transceivers will need ULPI access from the controller. When the
+ * controller is initialized, the controller driver will fill the
+ * usb_xceiv_io_ops and call this.
+ */
+static inline int
+usb_transceiver_init(struct usb_transceiver *xceiv)
+{
+	if (xceiv->init)
+		return xceiv->init(xceiv);
+	return 0;
+}
+
+/*
+ * This is a wrapper that the controller driver can use to deliver all
+ * the required variables to the transceiver.
+ */
+static inline int
+usb_start_transceiver(struct usb_transceiver *xceiv,
+		struct usb_xceiv_io_ops *io_ops,
+		void __iomem *io_priv,
+		void (*link_connect)(unsigned long),
+		unsigned long link_data)
+{
+	xceiv->io_ops = io_ops;
+	xceiv->io_priv = io_priv;
+	xceiv->link_connect = link_connect;
+	xceiv->link_data = link_data;
+
+	if (xceiv->init)
+		return xceiv->init(xceiv);
+
+	return 0;
+}
+
+/*
+ * REVISIT With ULPI transceivers, the controller should still be able to allow
+ * ULPI reads and writes before calling this.
+ */
+static inline int
+usb_transceiver_shutdown(struct usb_transceiver *xceiv)
+{
+	if (xceiv->shutdown)
+		return xceiv->shutdown(xceiv);
+	return 0;
+}
+
+static inline int
+usb_transceiver_set_suspend(struct usb_transceiver *xceiv, int suspend)
+{
+	if (xceiv->set_suspend)
+		return xceiv->set_suspend(xceiv, suspend);
+	return 0;
+}
+
+/* Helpers for OTG capable transceivers */
+
+/*
+ * xceiv_to_otg - return struct otg member
+ * @xceiv: USB transceiver
+ *
+ * Simple helper that can be used with other drivers that need to
+ * access the otg structure. One case would be separate host
+ * controller drivers. If the device controller driver holds the
+ * struct otg, the struct usb_transceiver can be used to deliver it to
+ * the host controller drivers.
+ */
+static inline struct otg
+*xceiv_to_otg(struct usb_transceiver *xceiv)
+{
+	if (xceiv && xceiv->otg)
+		return xceiv->otg;
+	return NULL;
+}
+
+static inline int
+usb_phy_id_pullup(struct usb_transceiver *xceiv, int on)
+{
+	if (xceiv->id_pullup)
+		return xceiv->id_pullup(xceiv, on);
+	return -ENOTSUPP;
+}
+
+static inline int
+usb_phy_dp_pulldown(struct usb_transceiver *xceiv, int on)
+{
+	if (xceiv->dp_pulldown)
+		return xceiv->dp_pulldown(xceiv, on);
+	return -ENOTSUPP;
+}
+
+static inline int
+usb_phy_dm_pulldown(struct usb_transceiver *xceiv, int on)
+{
+	if (xceiv->dm_pulldown)
+		return xceiv->dm_pulldown(xceiv, on);
+	return -ENOTSUPP;
+}
+
+static inline int
+usb_phy_dischrg_vbus(struct usb_transceiver *xceiv, int on)
+{
+	if (xceiv->dischrg_vbus)
+		return xceiv->dischrg_vbus(xceiv, on);
+	return -ENOTSUPP;
+}
+
+static inline int
+usb_phy_chrg_vbus(struct usb_transceiver *xceiv, int on)
+{
+	if (xceiv->chrg_vbus)
+		return xceiv->chrg_vbus(xceiv, on);
+	return -ENOTSUPP;
+}
+
+static inline int
+usb_phy_drv_vbus(struct usb_transceiver *xceiv, int on)
+{
+	if (xceiv->drv_vbus)
+		return xceiv->drv_vbus(xceiv, on);
+	return -ENOTSUPP;
+}
+
+#endif /* __LINUX_USB_PHY_H */
-- 
1.6.3.3
