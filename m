From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 26 Oct 2016 16:57:56 +0200
Subject: [RFC PATCH 5/5] of: overlay-mgr: add a detector for headers stored on
 a ds2431 eeprom over w1
In-Reply-To: <20161026145756.21689-1-antoine.tenart@free-electrons.com>
References: <20161026145756.21689-1-antoine.tenart@free-electrons.com>
Message-ID: <20161026145756.21689-6-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/of/overlay-manager/Kconfig | 10 ++++++++++
 drivers/w1/slaves/w1_ds2431.c      | 39 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/of/overlay-manager/Kconfig b/drivers/of/overlay-manager/Kconfig
index 1a36613c0c53..ad0a5b8e9e5e 100644
--- a/drivers/of/overlay-manager/Kconfig
+++ b/drivers/of/overlay-manager/Kconfig
@@ -16,4 +16,14 @@ config OF_OVERLAY_MGR_FORMAT_CHIP
 
 endmenu
 
+menu "Overlay Manager detectors"
+
+config OF_OVERLAY_MGR_DETECTOR_DS2431
+	bool "Dip header on a DS2431 EEPROM"
+	depends on W1_SLAVE_DS2431
+	help
+	  Enable dip header DS2431 EEPROM support.
+
+endmenu
+
 endif
diff --git a/drivers/w1/slaves/w1_ds2431.c b/drivers/w1/slaves/w1_ds2431.c
index 80572cb63ba8..760325f9a2bd 100644
--- a/drivers/w1/slaves/w1_ds2431.c
+++ b/drivers/w1/slaves/w1_ds2431.c
@@ -15,6 +15,9 @@
 #include <linux/device.h>
 #include <linux/types.h>
 #include <linux/delay.h>
+#include <linux/slab.h>
+
+#include <linux/overlay-manager.h>
 
 #include "../w1.h"
 #include "../w1_int.h"
@@ -280,7 +283,43 @@ static const struct attribute_group *w1_f2d_groups[] = {
 	NULL,
 };
 
+#if IS_ENABLED(CONFIG_OF_OVERLAY_MGR_DETECTOR_DS2431)
+static int chip_dip_callback(struct w1_slave *sl)
+{
+	char **candidates = NULL;
+	int i, n, err = 0;
+	u8 *data;
+
+	data = kzalloc(OVERLAY_MGR_DIP_MAX_SZ, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	/* sizeof(struct chip_header) is a mulitple of 8 */
+	for (i = 0; i < OVERLAY_MGR_DIP_MAX_SZ; i += 8) {
+		if (w1_f2d_readblock(sl, i, 8, &data[i])) {
+			err = -EIO;
+			goto end;
+		}
+	}
+
+	overlay_mgr_parse(&sl->dev, data, &candidates, &n);
+	if (!n) {
+		err = -EINVAL;
+		goto end;
+	}
+
+	err = overlay_mgr_apply(&sl->dev, candidates, n);
+
+end:
+	kfree(data);
+	return err;
+}
+#endif
+
 static struct w1_family_ops w1_f2d_fops = {
+#if IS_ENABLED(CONFIG_OF_OVERLAY_MGR_DETECTOR_DS2431)
+	.callback	= chip_dip_callback,
+#endif
 	.groups		= w1_f2d_groups,
 };
 
-- 
2.10.1
