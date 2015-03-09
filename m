From: hdegoede@redhat.com (Hans de Goede)
Date: Mon,  9 Mar 2015 21:40:15 +0100
Subject: [PATCH 02/15] phy-sun4i-usb: Add a helper function to update the iscr
 register
In-Reply-To: <1425933628-9672-1-git-send-email-hdegoede@redhat.com>
References: <1425933628-9672-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1425933628-9672-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add sun4i_usb_phy_update_iscr() helper function to allow the otg driver to
update the sun4i usb phy0 Interface Status and Control Register.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/phy/phy-sun4i-usb.c       | 13 +++++++++++++
 include/linux/phy/phy-sun4i-usb.h | 26 ++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)
 create mode 100644 include/linux/phy/phy-sun4i-usb.h

diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index a2b08f3c..4742d5a 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -79,6 +79,19 @@ struct sun4i_usb_phy_data {
 #define to_sun4i_usb_phy_data(phy) \
 	container_of((phy), struct sun4i_usb_phy_data, phys[(phy)->index])
 
+void sun4i_usb_phy_update_iscr(struct phy *_phy, u32 clr, u32 set)
+{
+	struct sun4i_usb_phy *phy = phy_get_drvdata(_phy);
+	struct sun4i_usb_phy_data *data = to_sun4i_usb_phy_data(phy);
+	u32 iscr;
+
+	iscr = readl(data->base + REG_ISCR);
+	iscr &= ~clr;
+	iscr |= set;
+	writel(iscr, data->base + REG_ISCR);
+}
+EXPORT_SYMBOL(sun4i_usb_phy_update_iscr);
+
 static void sun4i_usb_phy_write(struct sun4i_usb_phy *phy, u32 addr, u32 data,
 				int len)
 {
diff --git a/include/linux/phy/phy-sun4i-usb.h b/include/linux/phy/phy-sun4i-usb.h
new file mode 100644
index 0000000..f69e784
--- /dev/null
+++ b/include/linux/phy/phy-sun4i-usb.h
@@ -0,0 +1,26 @@
+/*
+ * Allwinner sun4i USB phy header
+ *
+ * Copyright (C) 2015 Hans de Goede <hdegoede@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __PHY_SUN4I_USB_H
+#define __PHY_SUN4I_USB_H
+
+#include <linux/phy/phy.h>
+
+/**
+ * sun4i_usb_phy_update_iscr() - Update sun4i usb phy0 Interface Status and
+ * Control bits
+ * @phy: Reference to sun4i usb phy0
+ * @clr: bits to clear in the ISCR register
+ * @set: bits to set in the ISCR register
+ */
+void sun4i_usb_phy_update_iscr(struct phy *phy, u32 clr, u32 set);
+
+#endif
-- 
2.3.1
