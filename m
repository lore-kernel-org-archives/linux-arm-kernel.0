From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Fri, 4 Aug 2017 10:32:46 +0800
Subject: [PATCH v2 1/2] usb: mtu3: add a vbus debugfs interface
Message-ID: <1501813967-21868-1-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provides a new vbus debugfs interface used to turn on/off vbus
regulator, it also can be used to get/put reference count of
vbus, due to sometimes we need keep it alive when manually switch
mtu3 to device mode.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_dr.c |   58 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 50 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_dr.c b/drivers/usb/mtu3/mtu3_dr.c
index 11a0d3b..5602561 100644
--- a/drivers/usb/mtu3/mtu3_dr.c
+++ b/drivers/usb/mtu3/mtu3_dr.c
@@ -322,23 +322,65 @@ static ssize_t ssusb_mode_write(struct file *file,
 	.release = single_release,
 };
 
+static int ssusb_vbus_show(struct seq_file *sf, void *unused)
+{
+	struct ssusb_mtk *ssusb = sf->private;
+	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
+
+	seq_printf(sf, "vbus state: %s\n(echo on/off)\n",
+		regulator_is_enabled(otg_sx->vbus) ? "on" : "off");
+
+	return 0;
+}
+
+static int ssusb_vbus_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ssusb_vbus_show, inode->i_private);
+}
+
+static ssize_t ssusb_vbus_write(struct file *file,
+	const char __user *ubuf, size_t count, loff_t *ppos)
+{
+	struct seq_file *sf = file->private_data;
+	struct ssusb_mtk *ssusb = sf->private;
+	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
+	char buf[16];
+	bool enable;
+
+	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
+		return -EFAULT;
+
+	if (kstrtobool(buf, &enable)) {
+		dev_err(ssusb->dev, "wrong setting\n");
+		return -EINVAL;
+	}
+
+	ssusb_set_vbus(otg_sx, enable);
+
+	return count;
+}
+
+static const struct file_operations ssusb_vbus_fops = {
+	.open = ssusb_vbus_open,
+	.write = ssusb_vbus_write,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
 static void ssusb_debugfs_init(struct ssusb_mtk *ssusb)
 {
 	struct dentry *root;
-	struct dentry *file;
 
 	root = debugfs_create_dir(dev_name(ssusb->dev), usb_debug_root);
-	if (IS_ERR_OR_NULL(root)) {
-		if (!root)
-			dev_err(ssusb->dev, "create debugfs root failed\n");
+	if (!root) {
+		dev_err(ssusb->dev, "create debugfs root failed\n");
 		return;
 	}
 	ssusb->dbgfs_root = root;
 
-	file = debugfs_create_file("mode", S_IRUGO | S_IWUSR, root,
-			ssusb, &ssusb_mode_fops);
-	if (!file)
-		dev_dbg(ssusb->dev, "create debugfs mode failed\n");
+	debugfs_create_file("mode", 0644, root, ssusb, &ssusb_mode_fops);
+	debugfs_create_file("vbus", 0644, root, ssusb, &ssusb_vbus_fops);
 }
 
 static void ssusb_debugfs_exit(struct ssusb_mtk *ssusb)
-- 
1.7.9.5
