From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 31 Aug 2010 14:12:09 +0200
Subject: [PATCH 07/12] DMAENGINE: add debugfs file for PL08X
In-Reply-To: <1283256734-3408-7-git-send-email-linus.walleij@stericsson.com>
References: <1283256734-3408-1-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-2-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-3-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-4-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-5-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-6-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-7-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1283256734-3408-8-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a debugfs file for the PL08X showing the current allocation
of physical to virtual channels.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/dma/amba-pl08x.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 65892d5..a99ad19 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -68,6 +68,8 @@
 #include <linux/amba/bus.h>
 #include <linux/dmaengine.h>
 #include <linux/amba/pl08x.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
 
 #include <asm/hardware/pl080.h>
 #include <asm/dma.h>
@@ -1806,6 +1808,60 @@ static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
 	return i;
 }
 
+#ifdef CONFIG_DEBUG_FS
+static int pl08x_debugfs_show(struct seq_file *s, void *data)
+{
+	struct pl08x_driver_data *pl08x = s->private;
+	struct pl08x_phy_chan *ch;
+	unsigned long flags;
+	int i;
+
+	seq_printf(s, "PL08x physical channels:\n");
+	seq_printf(s, "CHANNEL:\tUSER:\n");
+	seq_printf(s, "--------\t-----\n");
+	for (i = 0; i < pl08x->vd->channels; i++) {
+		struct pl08x_dma_chan *virt_chan;
+
+		ch = &pl08x->phy_chans[i];
+
+		spin_lock_irqsave(&ch->lock, flags);
+		virt_chan = ch->serving;
+
+		seq_printf(s, "%d\t\t%s\n",
+			   ch->id, virt_chan ? virt_chan->name : "(none)");
+
+		spin_unlock_irqrestore(&ch->lock, flags);
+	}
+	return 0;
+}
+
+static int pl08x_debugfs_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, pl08x_debugfs_show, inode->i_private);
+}
+
+static const struct file_operations pl08x_debugfs_operations = {
+	.open		= pl08x_debugfs_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static void init_pl08x_debugfs(struct pl08x_driver_data *pl08x)
+{
+	/* Expose a simple debugfs interface to view all clocks */
+	(void) debugfs_create_file(dev_name(&pl08x->adev->dev), S_IFREG | S_IRUGO,
+				   NULL, pl08x,
+				   &pl08x_debugfs_operations);
+	return 0;
+}
+
+#else
+static inline void init_pl08x_debugfs(struct pl08x_driver_data *pl08x)
+{
+}
+#endif
+
 static int pl08x_probe(struct amba_device *adev, struct amba_id *id)
 {
 	struct pl08x_driver_data *pl08x;
@@ -1937,6 +1993,7 @@ static int pl08x_probe(struct amba_device *adev, struct amba_id *id)
 	}
 
 	amba_set_drvdata(adev, pl08x);
+	init_pl08x_debugfs(pl08x);
 	dev_info(&pl08x->adev->dev, "ARM(R) %s DMA block initialized @%08x\n",
 		vd->name, adev->res.start);
 	return 0;
-- 
1.6.3.3
