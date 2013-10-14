From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 14 Oct 2013 15:29:02 +0200
Subject: [PATCH 3/3] usb: musb: dsps, debugfs files
In-Reply-To: <1381757342-13324-1-git-send-email-mpa@pengutronix.de>
References: <1381757342-13324-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1381757342-13324-4-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

debugfs files to show the contents of important dsps registers.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/usb/musb/musb_dsps.c | 89 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 189e52c..b24b697 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -46,6 +46,8 @@
 #include <linux/of_irq.h>
 #include <linux/usb/of.h>
 
+#include <linux/debugfs.h>
+
 #include "musb_core.h"
 
 static const struct of_device_id musb_dsps_of_match[];
@@ -121,6 +123,61 @@ struct dsps_glue {
 	unsigned long last_timer;    /* last timer data for each instance */
 };
 
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+
+struct musb_register_map {
+	char			*name;
+	unsigned		offset;
+};
+
+static const struct musb_register_map musb_regmap[] = {
+	{ "revision",		0x00 },
+	{ "control",		0x14 },
+	{ "status",		0x18 },
+	{ "eoi",		0x24 },
+	{ "intr0_stat",		0x30 },
+	{ "intr1_stat",		0x34 },
+	{ "intr0_set",		0x38 },
+	{ "intr1_set",		0x3c },
+	{ "txmode",		0x70 },
+	{ "rxmode",		0x74 },
+	{ "autoreq",		0xd0 },
+	{ "srpfixtime",		0xd4 },
+	{ "tdown",		0xd8 },
+	{ "phy_utmi",		0xe0 },
+	{ "mode",		0xe8 },
+	{  }	/* Terminating Entry */
+};
+
+static int musb_regdump_show(struct seq_file *s, void *unused)
+{
+	struct musb		*musb = s->private;
+	unsigned		i;
+
+	seq_puts(s, "MUSB (M)HDRC dsps Register Dump\n");
+
+	for (i = 0; i < ARRAY_SIZE(musb_regmap); i++) {
+		u32 val = musb_readl(musb->ctrl_base, musb_regmap[i].offset);
+		seq_printf(s, "%-12s: %08x\n", musb_regmap[i].name, val);
+	}
+
+	return 0;
+}
+
+static int musb_regdump_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, musb_regdump_show, inode->i_private);
+}
+
+static const struct file_operations musb_regdump_fops = {
+	.open			= musb_regdump_open,
+	.read			= seq_read,
+	.llseek			= seq_lseek,
+	.release		= single_release,
+};
+
+#endif /* IS_ENABLED(CONFIG_DEBUG_FS) */
+
 /**
  * dsps_musb_enable - enable interrupts
  */
@@ -348,6 +405,31 @@ out:
 	return ret;
 }
 
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+static int dsps_musb_dbg_init(struct musb *musb)
+{
+	struct dentry *root;
+	struct dentry *file;
+	char buf[128];
+
+	sprintf(buf, "%s.dsps", dev_name(musb->controller));
+	root = debugfs_create_dir(buf, NULL);
+	if (!root)
+		return -ENOMEM;
+
+	file = debugfs_create_file("regdump", S_IRUGO, root, musb,
+			&musb_regdump_fops);
+	if (!file)
+		return -ENOMEM;
+	return 0;
+}
+#else
+static int dsps_musb_dbg_init(struct musb *musb)
+{
+	return 0;
+}
+#endif
+
 static int dsps_musb_init(struct musb *musb)
 {
 	struct device *dev = musb->controller;
@@ -357,6 +439,7 @@ static int dsps_musb_init(struct musb *musb)
 	void __iomem *reg_base;
 	struct resource *r;
 	u32 rev, val;
+	int ret;
 
 	r = platform_get_resource_byname(parent, IORESOURCE_MEM, "control");
 	if (!r)
@@ -390,6 +473,12 @@ static int dsps_musb_init(struct musb *musb)
 	val &= ~(1 << wrp->otg_disable);
 	dsps_writel(musb->ctrl_base, wrp->phy_utmi, val);
 
+	ret = dsps_musb_dbg_init(musb);
+	if (ret)
+		return ret;
+
+	dev_info(dev, "%s:%d %s: OK\n", __FILE__, __LINE__, __func__);
+
 	return 0;
 }
 
-- 
1.8.4.rc3
