From: alcooperx@gmail.com (Al Cooper)
Date: Tue, 27 Jun 2017 10:59:13 -0400
Subject: [PATCH v3 4/4] phy: usb: phy-brcm-usb: Add ability to force DRD mode
 to host or device
In-Reply-To: <1498575553-19311-1-git-send-email-alcooperx@gmail.com>
References: <1498575553-19311-1-git-send-email-alcooperx@gmail.com>
Message-ID: <1498575553-19311-5-git-send-email-alcooperx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Al Cooper <al.cooper@broadcom.com>

When the usb phy device mode is set to "drd", the USB port will
switch between device and host modes depending on what's plugged
into the port. Customers have asked for the ability to force
host or device mode from software. This commit adds sysfs
entries to the phy device that allow this. The sysfs for the phy
device can be found at:
/sys/bus/platform/drivers/brcmstb-usb-phy/*.usb-phy

The following sysfs entries were added:
- "dr_mode" (RO) - The current phy "dr_mode" setting.
  It will be set to one of the following values:
  - "host" - host mode
  - "peripheral " - device mode
  - "drd" - switch between device and host mode based on
    installed device
  - "typec-pd" - device/host mode is controller by the USB
    Type-C PD protocol.

If "dr_mode" is "drd"
- "drd_select" (RW) -
  It will be set to one of the following values:
  - "host" - force host mode
  - "device" - force device mode
  - "auto" - allow normal auto selection of host/device based on
    inserted USB device

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/phy/broadcom/phy-brcm-usb.c | 85 +++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index cd18616..e30fde8 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -27,6 +27,8 @@
 
 #include "phy-brcm-usb-init.h"
 
+static DEFINE_MUTEX(sysfs_lock);
+
 enum brcm_usb_phy_id {
 	BRCM_USB_PHY_2_0 = 0,
 	BRCM_USB_PHY_3_0,
@@ -45,6 +47,12 @@ struct value_to_name_map {
 	{ USB_CTLR_MODE_TYPEC_PD, "typec-pd" }
 };
 
+static struct value_to_name_map brcm_dual_mode_to_name[] = {
+	{ 0, "host" },
+	{ 1, "device" },
+	{ 2, "auto" },
+};
+
 struct brcm_usb_phy {
 	struct phy *phy;
 	unsigned int id;
@@ -156,6 +164,73 @@ static int name_to_value(struct value_to_name_map *table, int count,
 	return -EINVAL;
 }
 
+static const char *value_to_name(struct value_to_name_map *table, int count,
+				int value)
+{
+	if (value >= count)
+		return "unknown";
+	return table[value].name;
+}
+
+static ssize_t dr_mode_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct brcm_usb_phy_data *priv = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n",
+		value_to_name(&brcm_dr_mode_to_name[0],
+			ARRAY_SIZE(brcm_dr_mode_to_name),
+			priv->ini.mode));
+}
+static DEVICE_ATTR_RO(dr_mode);
+
+static ssize_t dual_select_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t len)
+{
+	struct brcm_usb_phy_data *priv = dev_get_drvdata(dev);
+	int value;
+	int res;
+
+	mutex_lock(&sysfs_lock);
+	res = name_to_value(&brcm_dual_mode_to_name[0],
+			ARRAY_SIZE(brcm_dual_mode_to_name), buf, &value);
+	if (!res) {
+		brcm_usb_init_set_dual_select(&priv->ini, value);
+		res = len;
+	}
+	mutex_unlock(&sysfs_lock);
+	return res;
+}
+
+static ssize_t dual_select_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct brcm_usb_phy_data *priv = dev_get_drvdata(dev);
+	int value;
+
+	mutex_lock(&sysfs_lock);
+	value = brcm_usb_init_get_dual_select(&priv->ini);
+	mutex_unlock(&sysfs_lock);
+	return sprintf(buf, "%s\n",
+		value_to_name(&brcm_dual_mode_to_name[0],
+			ARRAY_SIZE(brcm_dual_mode_to_name),
+			value));
+}
+static DEVICE_ATTR_RW(dual_select);
+
+static struct attribute *brcm_usb_phy_attrs[] = {
+	&dev_attr_dr_mode.attr,
+	&dev_attr_dual_select.attr,
+	NULL
+};
+
+static const struct attribute_group brcm_usb_phy_group = {
+	.attrs = brcm_usb_phy_attrs,
+};
+
 static int brcm_usb_phy_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -262,6 +337,16 @@ static int brcm_usb_phy_probe(struct platform_device *pdev)
 
 	brcm_usb_init_ipp(&priv->ini);
 
+	/*
+	 * Create sysfs entries for mode.
+	 * Remove "dual_select" attribute if not in dual mode
+	 */
+	if (priv->ini.mode != USB_CTLR_MODE_DRD)
+		brcm_usb_phy_attrs[1] = NULL;
+	err = sysfs_create_group(&dev->kobj, &brcm_usb_phy_group);
+	if (err)
+		dev_warn(&pdev->dev, "Error creating sysfs attributes\n");
+
 	/* start with everything off */
 	if (priv->has_xhci)
 		brcm_usb_uninit_xhci(&priv->ini);
-- 
1.9.0.138.g2de3478
