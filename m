From: benjamin.widawsky@intel.com (Ben Widawsky)
Date: Tue, 21 Jan 2014 12:33:18 -0800
Subject: [PATCH 2/6] drm/armada: Use new drm debugfs file helper
In-Reply-To: <1390336402-2049-1-git-send-email-benjamin.widawsky@intel.com>
References: <1389708847-25038-1-git-send-email-benjamin.widawsky@intel.com>
 <1390336402-2049-1-git-send-email-benjamin.widawsky@intel.com>
Message-ID: <1390336402-2049-2-git-send-email-benjamin.widawsky@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The debugfs helper duplicates the functionality used by Armada, so let's
just use that.

WARNING: Not even compile tested. I can compile test this if required,
but I figured there'd be other kind people who already have the cross
toolchain setup.

Signed-off-by: Ben Widawsky <ben@bwidawsk.net>
---
 drivers/gpu/drm/armada/armada_debugfs.c | 40 ++++-----------------------------
 1 file changed, 4 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_debugfs.c b/drivers/gpu/drm/armada/armada_debugfs.c
index 471e456..64e4361 100644
--- a/drivers/gpu/drm/armada/armada_debugfs.c
+++ b/drivers/gpu/drm/armada/armada_debugfs.c
@@ -107,38 +107,6 @@ static struct drm_info_list armada_debugfs_list[] = {
 };
 #define ARMADA_DEBUGFS_ENTRIES ARRAY_SIZE(armada_debugfs_list)
 
-static int drm_add_fake_info_node(struct drm_minor *minor, struct dentry *ent,
-	const void *key)
-{
-	struct drm_info_node *node;
-
-	node = kmalloc(sizeof(struct drm_info_node), GFP_KERNEL);
-	if (node == NULL) {
-		debugfs_remove(ent);
-		return -ENOMEM;
-	}
-
-	node->minor = minor;
-	node->dent = ent;
-	node->info_ent = (void *) key;
-
-	mutex_lock(&minor->debugfs_lock);
-	list_add(&node->list, &minor->debugfs_list);
-	mutex_unlock(&minor->debugfs_lock);
-
-	return 0;
-}
-
-static int armada_debugfs_create(struct dentry *root, struct drm_minor *minor,
-	const char *name, umode_t mode, const struct file_operations *fops)
-{
-	struct dentry *de;
-
-	de = debugfs_create_file(name, mode, root, minor->dev, fops);
-
-	return drm_add_fake_info_node(minor, de, fops);
-}
-
 int armada_drm_debugfs_init(struct drm_minor *minor)
 {
 	int ret;
@@ -149,13 +117,13 @@ int armada_drm_debugfs_init(struct drm_minor *minor)
 	if (ret)
 		return ret;
 
-	ret = armada_debugfs_create(minor->debugfs_root, minor,
-				   "reg", S_IFREG | S_IRUSR, &fops_reg_r);
+	ret = drm_debugfs_create_file(minor->debugfs_root, minor, "reg",
+				      S_IFREG | S_IRUSR, &fops_reg_r);
 	if (ret)
 		goto err_1;
 
-	ret = armada_debugfs_create(minor->debugfs_root, minor,
-				"reg_wr", S_IFREG | S_IWUSR, &fops_reg_w);
+	ret = drm_debugfs_create_file(minor->debugfs_root, minor,
+				      "reg_wr", S_IFREG | S_IWUSR, &fops_reg_w);
 	if (ret)
 		goto err_2;
 	return ret;
-- 
1.8.5.3
