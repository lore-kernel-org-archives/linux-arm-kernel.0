From: bp@alien8.de (Borislav Petkov)
Date: Tue, 22 Sep 2015 18:37:01 +0200
Subject: [PATCH 1/5] EDAC: Carve out debugfs functionality
In-Reply-To: <20150922163405.GC3437@pd.tnic>
References: <20150922163405.GC3437@pd.tnic>
Message-ID: <1442939825-13455-1-git-send-email-bp@alien8.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Borislav Petkov <bp@suse.de>

... into a separate compilation unit and drop a couple of
CONFIG_EDAC_DEBUG ifdefferies. Rename edac_create_debug_nodes() to
edac_create_debugfs_nodes(), while at it.

No functionality change.

Cc: <linux-edac@vger.kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/edac/Makefile        |   2 +
 drivers/edac/debugfs.c       | 103 ++++++++++++++++++++++++++++++++++++++++
 drivers/edac/edac_core.h     |   2 +
 drivers/edac/edac_mc_sysfs.c | 110 +------------------------------------------
 drivers/edac/edac_module.h   |   2 +
 include/linux/edac.h         |   2 -
 6 files changed, 110 insertions(+), 111 deletions(-)
 create mode 100644 drivers/edac/debugfs.c

diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index ae3c5f3ce405..dbf53e08bdd1 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -12,6 +12,8 @@ obj-$(CONFIG_EDAC_MM_EDAC)		+= edac_core.o
 edac_core-y	:= edac_mc.o edac_device.o edac_mc_sysfs.o
 edac_core-y	+= edac_module.o edac_device_sysfs.o
 
+edac_core-$(CONFIG_EDAC_DEBUG)		+= debugfs.o
+
 ifdef CONFIG_PCI
 edac_core-y	+= edac_pci.o edac_pci_sysfs.o
 endif
diff --git a/drivers/edac/debugfs.c b/drivers/edac/debugfs.c
new file mode 100644
index 000000000000..bcd558d5cb48
--- /dev/null
+++ b/drivers/edac/debugfs.c
@@ -0,0 +1,103 @@
+#include "edac_module.h"
+
+static struct dentry *edac_debugfs;
+
+static ssize_t edac_fake_inject_write(struct file *file,
+				      const char __user *data,
+				      size_t count, loff_t *ppos)
+{
+	struct device *dev = file->private_data;
+	struct mem_ctl_info *mci = to_mci(dev);
+	static enum hw_event_mc_err_type type;
+	u16 errcount = mci->fake_inject_count;
+
+	if (!errcount)
+		errcount = 1;
+
+	type = mci->fake_inject_ue ? HW_EVENT_ERR_UNCORRECTED
+				   : HW_EVENT_ERR_CORRECTED;
+
+	printk(KERN_DEBUG
+	       "Generating %d %s fake error%s to %d.%d.%d to test core handling. NOTE: this won't test the driver-specific decoding logic.\n",
+		errcount,
+		(type == HW_EVENT_ERR_UNCORRECTED) ? "UE" : "CE",
+		errcount > 1 ? "s" : "",
+		mci->fake_inject_layer[0],
+		mci->fake_inject_layer[1],
+		mci->fake_inject_layer[2]
+	       );
+	edac_mc_handle_error(type, mci, errcount, 0, 0, 0,
+			     mci->fake_inject_layer[0],
+			     mci->fake_inject_layer[1],
+			     mci->fake_inject_layer[2],
+			     "FAKE ERROR", "for EDAC testing only");
+
+	return count;
+}
+
+static const struct file_operations debug_fake_inject_fops = {
+	.open = simple_open,
+	.write = edac_fake_inject_write,
+	.llseek = generic_file_llseek,
+};
+
+int __init edac_debugfs_init(void)
+{
+	edac_debugfs = debugfs_create_dir("edac", NULL);
+	if (IS_ERR(edac_debugfs)) {
+		edac_debugfs = NULL;
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+void edac_debugfs_exit(void)
+{
+	debugfs_remove(edac_debugfs);
+}
+
+int edac_create_debugfs_nodes(struct mem_ctl_info *mci)
+{
+	struct dentry *d, *parent;
+	char name[80];
+	int i;
+
+	if (!edac_debugfs)
+		return -ENODEV;
+
+	d = debugfs_create_dir(mci->dev.kobj.name, edac_debugfs);
+	if (!d)
+		return -ENOMEM;
+	parent = d;
+
+	for (i = 0; i < mci->n_layers; i++) {
+		sprintf(name, "fake_inject_%s",
+			     edac_layer_name[mci->layers[i].type]);
+		d = debugfs_create_u8(name, S_IRUGO | S_IWUSR, parent,
+				      &mci->fake_inject_layer[i]);
+		if (!d)
+			goto nomem;
+	}
+
+	d = debugfs_create_bool("fake_inject_ue", S_IRUGO | S_IWUSR, parent,
+				&mci->fake_inject_ue);
+	if (!d)
+		goto nomem;
+
+	d = debugfs_create_u16("fake_inject_count", S_IRUGO | S_IWUSR, parent,
+				&mci->fake_inject_count);
+	if (!d)
+		goto nomem;
+
+	d = debugfs_create_file("fake_inject", S_IWUSR, parent,
+				&mci->dev,
+				&debug_fake_inject_fops);
+	if (!d)
+		goto nomem;
+
+	mci->debugfs = parent;
+	return 0;
+nomem:
+	debugfs_remove(mci->debugfs);
+	return -ENOMEM;
+}
diff --git a/drivers/edac/edac_core.h b/drivers/edac/edac_core.h
index ad42587c3f4d..4861542163d7 100644
--- a/drivers/edac/edac_core.h
+++ b/drivers/edac/edac_core.h
@@ -94,6 +94,8 @@ do {									\
 
 #define edac_dev_name(dev) (dev)->dev_name
 
+#define to_mci(k) container_of(k, struct mem_ctl_info, dev)
+
 /*
  * The following are the structures to provide for a generic
  * or abstract 'edac_device'. This set of structures and the
diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 33df7d93c857..071f7fca5ff5 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -785,47 +785,6 @@ static ssize_t mci_max_location_show(struct device *dev,
 	return p - data;
 }
 
-#ifdef CONFIG_EDAC_DEBUG
-static ssize_t edac_fake_inject_write(struct file *file,
-				      const char __user *data,
-				      size_t count, loff_t *ppos)
-{
-	struct device *dev = file->private_data;
-	struct mem_ctl_info *mci = to_mci(dev);
-	static enum hw_event_mc_err_type type;
-	u16 errcount = mci->fake_inject_count;
-
-	if (!errcount)
-		errcount = 1;
-
-	type = mci->fake_inject_ue ? HW_EVENT_ERR_UNCORRECTED
-				   : HW_EVENT_ERR_CORRECTED;
-
-	printk(KERN_DEBUG
-	       "Generating %d %s fake error%s to %d.%d.%d to test core handling. NOTE: this won't test the driver-specific decoding logic.\n",
-		errcount,
-		(type == HW_EVENT_ERR_UNCORRECTED) ? "UE" : "CE",
-		errcount > 1 ? "s" : "",
-		mci->fake_inject_layer[0],
-		mci->fake_inject_layer[1],
-		mci->fake_inject_layer[2]
-	       );
-	edac_mc_handle_error(type, mci, errcount, 0, 0, 0,
-			     mci->fake_inject_layer[0],
-			     mci->fake_inject_layer[1],
-			     mci->fake_inject_layer[2],
-			     "FAKE ERROR", "for EDAC testing only");
-
-	return count;
-}
-
-static const struct file_operations debug_fake_inject_fops = {
-	.open = simple_open,
-	.write = edac_fake_inject_write,
-	.llseek = generic_file_llseek,
-};
-#endif
-
 /* default Control file */
 static DEVICE_ATTR(reset_counters, S_IWUSR, NULL, mci_reset_counters_store);
 
@@ -896,71 +855,6 @@ static struct device_type mci_attr_type = {
 	.release	= mci_attr_release,
 };
 
-#ifdef CONFIG_EDAC_DEBUG
-static struct dentry *edac_debugfs;
-
-int __init edac_debugfs_init(void)
-{
-	edac_debugfs = debugfs_create_dir("edac", NULL);
-	if (IS_ERR(edac_debugfs)) {
-		edac_debugfs = NULL;
-		return -ENOMEM;
-	}
-	return 0;
-}
-
-void edac_debugfs_exit(void)
-{
-	debugfs_remove(edac_debugfs);
-}
-
-static int edac_create_debug_nodes(struct mem_ctl_info *mci)
-{
-	struct dentry *d, *parent;
-	char name[80];
-	int i;
-
-	if (!edac_debugfs)
-		return -ENODEV;
-
-	d = debugfs_create_dir(mci->dev.kobj.name, edac_debugfs);
-	if (!d)
-		return -ENOMEM;
-	parent = d;
-
-	for (i = 0; i < mci->n_layers; i++) {
-		sprintf(name, "fake_inject_%s",
-			     edac_layer_name[mci->layers[i].type]);
-		d = debugfs_create_u8(name, S_IRUGO | S_IWUSR, parent,
-				      &mci->fake_inject_layer[i]);
-		if (!d)
-			goto nomem;
-	}
-
-	d = debugfs_create_bool("fake_inject_ue", S_IRUGO | S_IWUSR, parent,
-				&mci->fake_inject_ue);
-	if (!d)
-		goto nomem;
-
-	d = debugfs_create_u16("fake_inject_count", S_IRUGO | S_IWUSR, parent,
-				&mci->fake_inject_count);
-	if (!d)
-		goto nomem;
-
-	d = debugfs_create_file("fake_inject", S_IWUSR, parent,
-				&mci->dev,
-				&debug_fake_inject_fops);
-	if (!d)
-		goto nomem;
-
-	mci->debugfs = parent;
-	return 0;
-nomem:
-	debugfs_remove(mci->debugfs);
-	return -ENOMEM;
-}
-#endif
-
 /*
  * Create a new Memory Controller kobject instance,
  *	mc<id> under the 'mc' directory
@@ -1039,9 +933,7 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
 		goto fail_unregister_dimm;
 #endif
 
-#ifdef CONFIG_EDAC_DEBUG
-	edac_create_debug_nodes(mci);
-#endif
+	edac_create_debugfs_nodes(mci);
 	return 0;
 
 fail_unregister_dimm:
diff --git a/drivers/edac/edac_module.h b/drivers/edac/edac_module.h
index 26ecc52e073d..79a6c6e20819 100644
--- a/drivers/edac/edac_module.h
+++ b/drivers/edac/edac_module.h
@@ -63,12 +63,14 @@ extern void *edac_align_ptr(void **p, unsigned size, int n_elems);
 #ifdef CONFIG_EDAC_DEBUG
 int edac_debugfs_init(void);
 void edac_debugfs_exit(void);
+int edac_create_debugfs_nodes(struct mem_ctl_info *mci);
 #else
 static inline int edac_debugfs_init(void)
 {
 	return -ENODEV;
 }
 static inline void edac_debugfs_exit(void) {}
+static inline int edac_create_debugfs_nodes(struct mem_ctl_info *mci) { return 0; }
 #endif
 
 /*
diff --git a/include/linux/edac.h b/include/linux/edac.h
index da3b72e95db3..b3d87e5822f8 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -769,12 +769,10 @@ struct mem_ctl_info {
 	/* the internal state of this controller instance */
 	int op_state;
 
-#ifdef CONFIG_EDAC_DEBUG
 	struct dentry *debugfs;
 	u8 fake_inject_layer[EDAC_MAX_LAYERS];
 	u32 fake_inject_ue;
 	u16 fake_inject_count;
-#endif
 };
 
 /*
-- 
2.3.5
