From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 18 Nov 2013 16:54:37 +0100
Subject: [RESEND PATCH v3 3/4] usb: musb: dsps, debugfs files
In-Reply-To: <1384790078-15366-1-git-send-email-mpa@pengutronix.de>
References: <1384790078-15366-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1384790078-15366-4-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

debugfs files to show the contents of important dsps registers.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/usb/musb/musb_dsps.c | 55 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 7b36d32..06debf8 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -46,6 +46,8 @@
 #include <linux/of_irq.h>
 #include <linux/usb/of.h>
 
+#include <linux/debugfs.h>
+
 #include "musb_core.h"
 
 static const struct of_device_id musb_dsps_of_match[];
@@ -119,6 +121,27 @@ struct dsps_glue {
 	const struct dsps_musb_wrapper *wrp; /* wrapper register offsets */
 	struct timer_list timer;	/* otg_workaround timer */
 	unsigned long last_timer;    /* last timer data for each instance */
+
+	struct debugfs_regset32 regset;
+	struct dentry *dbgfs_root;
+};
+
+static const struct debugfs_reg32 dsps_musb_regs[] = {
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
 };
 
 static void dsps_musb_try_idle(struct musb *musb, unsigned long timeout)
@@ -350,6 +373,30 @@ out:
 	return ret;
 }
 
+static int dsps_musb_dbg_init(struct musb *musb, struct dsps_glue *glue)
+{
+	struct dentry *root;
+	struct dentry *file;
+	char buf[128];
+
+	sprintf(buf, "%s.dsps", dev_name(musb->controller));
+	root = debugfs_create_dir(buf, NULL);
+	if (!root)
+		return -ENOMEM;
+	glue->dbgfs_root = root;
+
+	glue->regset.regs = dsps_musb_regs;
+	glue->regset.nregs = ARRAY_SIZE(dsps_musb_regs);
+	glue->regset.base = musb->ctrl_base;
+
+	file = debugfs_create_regset32("regdump", S_IRUGO, root, &glue->regset);
+	if (!file) {
+		debugfs_remove_recursive(root);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
 static int dsps_musb_init(struct musb *musb)
 {
 	struct device *dev = musb->controller;
@@ -359,6 +406,7 @@ static int dsps_musb_init(struct musb *musb)
 	void __iomem *reg_base;
 	struct resource *r;
 	u32 rev, val;
+	int ret;
 
 	r = platform_get_resource_byname(parent, IORESOURCE_MEM, "control");
 	if (!r)
@@ -392,6 +440,10 @@ static int dsps_musb_init(struct musb *musb)
 	val &= ~(1 << wrp->otg_disable);
 	dsps_writel(musb->ctrl_base, wrp->phy_utmi, val);
 
+	ret = dsps_musb_dbg_init(musb, glue);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -586,6 +638,9 @@ static int dsps_remove(struct platform_device *pdev)
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	kfree(glue);
+
+	debugfs_remove_recursive(glue->dbgfs_root);
+
 	return 0;
 }
 
-- 
1.8.4.2
