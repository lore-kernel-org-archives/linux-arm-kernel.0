From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 23 Nov 2018 12:22:15 +0100
Subject: [PATCH 1/3] usb: core: comply to PHY framework
In-Reply-To: <20181123112217.4878-1-miquel.raynal@bootlin.com>
References: <20181123112217.4878-1-miquel.raynal@bootlin.com>
Message-ID: <20181123112217.4878-2-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current implementation of the USB core does not take into account the
new PHY framework. Correct the situation by adding a call to
phy_set_mode() before phy_power_on().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/usb/core/hcd.c |  5 +++++
 drivers/usb/core/phy.c | 28 ++++++++++++++++++++++++++++
 drivers/usb/core/phy.h |  2 ++
 3 files changed, 35 insertions(+)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 487025d31d44..bfb90b17c7a6 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2738,6 +2738,11 @@ int usb_add_hcd(struct usb_hcd *hcd,
 		if (retval)
 			return retval;
 
+		retval = usb_phy_roothub_set_mode(hcd->phy_roothub,
+						  PHY_MODE_USB_HOST_SS);
+		if (retval)
+			goto err_usb_phy_roothub_power_on;
+
 		retval = usb_phy_roothub_power_on(hcd->phy_roothub);
 		if (retval)
 			goto err_usb_phy_roothub_power_on;
diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
index 38b2c776c4b4..7580493b867a 100644
--- a/drivers/usb/core/phy.c
+++ b/drivers/usb/core/phy.c
@@ -123,6 +123,34 @@ int usb_phy_roothub_exit(struct usb_phy_roothub *phy_roothub)
 }
 EXPORT_SYMBOL_GPL(usb_phy_roothub_exit);
 
+int usb_phy_roothub_set_mode(struct usb_phy_roothub *phy_roothub,
+			     enum phy_mode mode)
+{
+	struct usb_phy_roothub *roothub_entry;
+	struct list_head *head;
+	int err;
+
+	if (!phy_roothub)
+		return 0;
+
+	head = &phy_roothub->list;
+
+	list_for_each_entry(roothub_entry, head, list) {
+		err = phy_set_mode(roothub_entry->phy, mode);
+		if (err)
+			goto err_out;
+	}
+
+	return 0;
+
+err_out:
+	list_for_each_entry_continue_reverse(roothub_entry, head, list)
+		phy_power_off(roothub_entry->phy);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(usb_phy_roothub_set_mode);
+
 int usb_phy_roothub_power_on(struct usb_phy_roothub *phy_roothub)
 {
 	struct usb_phy_roothub *roothub_entry;
diff --git a/drivers/usb/core/phy.h b/drivers/usb/core/phy.h
index 88a3c037e9df..dad564e2d2d4 100644
--- a/drivers/usb/core/phy.h
+++ b/drivers/usb/core/phy.h
@@ -16,6 +16,8 @@ struct usb_phy_roothub *usb_phy_roothub_alloc(struct device *dev);
 int usb_phy_roothub_init(struct usb_phy_roothub *phy_roothub);
 int usb_phy_roothub_exit(struct usb_phy_roothub *phy_roothub);
 
+int usb_phy_roothub_set_mode(struct usb_phy_roothub *phy_roothub,
+			     enum phy_mode mode);
 int usb_phy_roothub_power_on(struct usb_phy_roothub *phy_roothub);
 void usb_phy_roothub_power_off(struct usb_phy_roothub *phy_roothub);
 
-- 
2.19.1
