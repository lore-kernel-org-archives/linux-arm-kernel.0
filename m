From: abailon@baylibre.com (Alexandre Bailon)
Date: Wed, 16 Nov 2016 11:52:24 +0100
Subject: [PATCH v5 2/3] usb: musb: core: added helper function for parsing DT
In-Reply-To: <1479293545-7516-1-git-send-email-abailon@baylibre.com>
References: <1479293545-7516-1-git-send-email-abailon@baylibre.com>
Message-ID: <1479293545-7516-3-git-send-email-abailon@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Petr Kulhavy <petr@barix.com>

This adds the function musb_get_mode() to get the DT property "dr_mode"

Signed-off-by: Petr Kulhavy <petr@barix.com>
Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Tested-by: David Lechner <david@lechnology.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/usb/musb/musb_core.c | 19 +++++++++++++++++++
 drivers/usb/musb/musb_core.h |  6 ++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index e01116e..9b44566 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -100,6 +100,7 @@
 #include <linux/io.h>
 #include <linux/dma-mapping.h>
 #include <linux/usb.h>
+#include <linux/usb/of.h>
 
 #include "musb_core.h"
 #include "musb_trace.h"
@@ -130,6 +131,24 @@ static inline struct musb *dev_to_musb(struct device *dev)
 	return dev_get_drvdata(dev);
 }
 
+enum musb_mode musb_get_mode(struct device *dev)
+{
+	enum usb_dr_mode mode;
+
+	mode = usb_get_dr_mode(dev);
+	switch (mode) {
+	case USB_DR_MODE_HOST:
+		return MUSB_HOST;
+	case USB_DR_MODE_PERIPHERAL:
+		return MUSB_PERIPHERAL;
+	case USB_DR_MODE_OTG:
+	case USB_DR_MODE_UNKNOWN:
+	default:
+		return MUSB_OTG;
+	}
+}
+EXPORT_SYMBOL_GPL(musb_get_mode);
+
 /*-------------------------------------------------------------------------*/
 
 #ifndef CONFIG_BLACKFIN
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 2cb88a49..76f00f6 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -617,4 +617,10 @@ static inline void musb_platform_post_root_reset_end(struct musb *musb)
 		musb->ops->post_root_reset_end(musb);
 }
 
+/*
+ * gets the "dr_mode" property from DT and converts it into musb_mode
+ * if the property is not found or not recognized returns MUSB_OTG
+ */
+extern enum musb_mode musb_get_mode(struct device *dev);
+
 #endif	/* __MUSB_CORE_H__ */
-- 
2.7.3
