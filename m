From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 26 Oct 2016 16:57:53 +0200
Subject: [RFC PATCH 2/5] of: overlay-mgr: add the CHIP format
In-Reply-To: <20161026145756.21689-1-antoine.tenart@free-electrons.com>
References: <20161026145756.21689-1-antoine.tenart@free-electrons.com>
Message-ID: <20161026145756.21689-3-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support parsing the header used by capes compatible with Nextthing's
C.H.I.P.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/of/overlay-manager/Kconfig       | 13 ++++++
 drivers/of/overlay-manager/Makefile      |  1 +
 drivers/of/overlay-manager/format-chip.c | 72 ++++++++++++++++++++++++++++++++
 include/linux/overlay-manager.h          | 13 ++++++
 4 files changed, 99 insertions(+)
 create mode 100644 drivers/of/overlay-manager/format-chip.c

diff --git a/drivers/of/overlay-manager/Kconfig b/drivers/of/overlay-manager/Kconfig
index eeb76054dcb8..1a36613c0c53 100644
--- a/drivers/of/overlay-manager/Kconfig
+++ b/drivers/of/overlay-manager/Kconfig
@@ -4,3 +4,16 @@ config OF_OVERLAY_MGR
 	help
 	  Enable the overlay manager to handle automatic overlay loading when
 	  devices are detected.
+
+if OF_OVERLAY_MGR
+
+menu "Dips header formats"
+
+config OF_OVERLAY_MGR_FORMAT_CHIP
+	bool "Nextthing's C.H.I.P. dip header format"
+	help
+	  Enable Nextthing's C.H.I.P. dip header format support.
+
+endmenu
+
+endif
diff --git a/drivers/of/overlay-manager/Makefile b/drivers/of/overlay-manager/Makefile
index 86d2b53950e7..637cc7ba20c2 100644
--- a/drivers/of/overlay-manager/Makefile
+++ b/drivers/of/overlay-manager/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_OF_OVERLAY_MGR)			+= overlay-manager.o
+obj-$(CONFIG_OF_OVERLAY_MGR_FORMAT_CHIP)	+= format-chip.o
diff --git a/drivers/of/overlay-manager/format-chip.c b/drivers/of/overlay-manager/format-chip.c
new file mode 100644
index 000000000000..3a3d315dcb5c
--- /dev/null
+++ b/drivers/of/overlay-manager/format-chip.c
@@ -0,0 +1,72 @@
+/*
+ * Copyright (C) 2016 - Antoine Tenart <antoine.tenart@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/device.h>
+#include <linux/overlay-manager.h>
+#include <linux/slab.h>
+
+#define CAPE_CHIP_MAGIC		0x43484950
+#define CAPE_CHIP_VERSION	1
+#define CAPE_CHIP_CANDIDATES	2
+
+static int cape_chip_parse(struct device *dev, void *data, char ***candidates,
+			   unsigned *n)
+{
+	struct chip_header *header = (struct chip_header *)data;
+	char **tmp;
+	int err;
+
+	if (dip_convert(header->magic) != CAPE_CHIP_MAGIC)
+		return -EINVAL;
+
+	if (dip_convert(header->version) > CAPE_CHIP_VERSION)
+		return -EINVAL;
+
+	tmp = devm_kzalloc(dev, CAPE_CHIP_CANDIDATES * sizeof(char *), GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	tmp[0] = devm_kasprintf(dev, GFP_KERNEL, "%x-%x-%x",
+				dip_convert(header->vendor_id),
+				dip_convert(header->product_id),
+				dip_convert(header->product_version));
+	if (!tmp[0]) {
+		err = -ENOMEM;
+		goto err_free_list;
+	}
+
+	tmp[1] = devm_kasprintf(dev, GFP_KERNEL, "%x-%x",
+				dip_convert(header->vendor_id),
+				dip_convert(header->product_id));
+	if (!tmp[1]) {
+		err = -ENOMEM;
+		goto err_free_0;
+	}
+
+	*candidates = tmp;
+	*n = CAPE_CHIP_CANDIDATES;
+
+	return 0;
+
+err_free_0:
+	devm_kfree(dev, tmp[0]);
+err_free_list:
+	devm_kfree(dev, tmp);
+	return err;
+}
+
+static struct overlay_mgr_format format_chip = {
+	.name	= "Nextthing C.H.I.P. dip header format",
+	.parse	= &cape_chip_parse,
+};
+
+static int __init cape_chip_init(void)
+{
+	return overlay_mgr_register_format(&format_chip);
+}
+device_initcall(cape_chip_init);
diff --git a/include/linux/overlay-manager.h b/include/linux/overlay-manager.h
index 8adcc4f5ddf6..d76c3c9fd863 100644
--- a/include/linux/overlay-manager.h
+++ b/include/linux/overlay-manager.h
@@ -35,4 +35,17 @@ int overlay_mgr_apply(struct device *dev, char **candidates, unsigned n);
                 -1                                              \
         )
 
+/* Nextthing's C.H.I.P. dip header */
+struct chip_header {
+        u32     magic;                  /* rsvd */
+        u8      version;                /* spec version */
+        u32     vendor_id;
+        u16     product_id;
+        u8      product_version;
+        char    vendor_name[32];
+        char    product_name[32];
+        u8      rsvd[36];               /* rsvd for futre spec versions */
+        u8      data[16];               /* user data, per-cape specific */
+} __packed;
+
 #endif /* __OVERLAY_MGR_H__ */
-- 
2.10.1
