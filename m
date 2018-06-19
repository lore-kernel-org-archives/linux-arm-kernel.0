From: javierm@redhat.com (Javier Martinez Canillas)
Date: Tue, 19 Jun 2018 20:20:51 +0200
Subject: [RFC PATCH] driver core: add a debugfs entry to show deferred devices
Message-ID: <20180619182051.26478-1-javierm@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For debugging purposes it may be useful to know what are the devices whose
probe function was deferred. Add a debugfs entry showing that information.

  $ cat /sys/kernel/debug/deferred_devices
  48070000.i2c:twl at 48:bci
  musb-hdrc.0.auto
  omapdrm.0

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

---

 drivers/base/dd.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 1435d7281c6..98a3ab4a852 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -224,6 +224,43 @@ void device_unblock_probing(void)
 	driver_deferred_probe_trigger();
 }
 
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+#include <linux/debugfs.h>
+
+static struct dentry *deferred_devices;
+
+/*
+ * deferred_devs_show() - Show the devices in the deferred probe pending list.
+ */
+static int deferred_devs_show(struct seq_file *s, void *data)
+{
+	struct device_private *curr;
+	int ret = 0;
+
+	mutex_lock(&deferred_probe_mutex);
+
+	list_for_each_entry(curr, &deferred_probe_pending_list, deferred_probe)
+		seq_printf(s, "%s\n", dev_name(curr->device));
+
+	mutex_unlock(&deferred_probe_mutex);
+
+	return ret;
+}
+
+static int deferred_devs_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, deferred_devs_show, inode->i_private);
+}
+
+static const struct file_operations deferred_devs_fops = {
+	.owner = THIS_MODULE,
+	.open = deferred_devs_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+#endif /* IS_ENABLED(CONFIG_DEBUG_FS) */
+
 /**
  * deferred_probe_initcall() - Enable probing of deferred devices
  *
@@ -233,6 +270,14 @@ void device_unblock_probing(void)
  */
 static int deferred_probe_initcall(void)
 {
+	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
+		deferred_devices = debugfs_create_file("deferred_devices",
+						       0444, NULL, NULL,
+						       &deferred_devs_fops);
+		if (!deferred_devices)
+			return -ENOMEM;
+	}
+
 	driver_deferred_probe_enable = true;
 	driver_deferred_probe_trigger();
 	/* Sort as many dependencies as possible before exiting initcalls */
-- 
2.17.1
