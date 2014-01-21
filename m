From: benjamin.widawsky@intel.com (Ben Widawsky)
Date: Tue, 21 Jan 2014 12:33:17 -0800
Subject: [PATCH 1/6] drm: Create a debugfs file creation helper
In-Reply-To: <1389708847-25038-1-git-send-email-benjamin.widawsky@intel.com>
References: <1389708847-25038-1-git-send-email-benjamin.widawsky@intel.com>
Message-ID: <1390336402-2049-1-git-send-email-benjamin.widawsky@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DRM layer already provides a helper function to create a set of files
following a specific idiom primarily characterized by the access flags
of the file, and the file operations. This is great for writing concise
code to handle these very common cases.

This new helper function is provided to drivers that wish to change
either the access flags, or the fops for the file - in particular the
latter. This usage has become cropping up over many of the drivers.
Providing the helper is therefore here for the usual reasons.

Upcoming patches will update the callers. Currently the key is the same
as fops. This is what most callers want, the exception is when you want
to use 1 fops for multiple file nodes. I have found one case for this
(in i915), and don't feel it's a good idea to have the interface reflect
this one, currently fringe usage. In the future if more callers want to
have a separate fops and key, the interface should be extended.

v2: The original patch simply changes the way in which we wedge special
files into the normal drm node list. Daniel requested a fuller helper
function, which this patch addresses. His original claim that v1 was
buggy is unfounded.

Requested-by: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Ben Widawsky <ben@bwidawsk.net>
---
 drivers/gpu/drm/drm_debugfs.c | 49 +++++++++++++++++++++++++++++++++++++++++++
 include/drm/drmP.h            | 14 +++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index b4b51d4..ea470b7 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -237,5 +237,54 @@ int drm_debugfs_cleanup(struct drm_minor *minor)
 	return 0;
 }
 
+/**
+ * Helper function for DRM drivers to create a debugfs file.
+ *
+ * \param root parent directory entry for the new file
+ * \param minor minor device minor number
+ * \param name the new file's name
+ * \param fops file operations for the new file
+ * \param mode permissions for access
+ * \return zero on success, negative errno otherwise
+ *
+ * Instantiate a debugfs file with aforementioned data. The file will be added
+ * to the drm debugfs file list in the standard way, thus making cleanup
+ * possible through the normal drm_debugfs_remove_files() call.
+ *
+ * The primary motivation for this interface over the existing one is this
+ * interface provides explicit mode, and fops flags at the cost of some extra
+ * bookkeeping to be done by the driver.
+ */
+int drm_debugfs_create_file(struct dentry *root,
+			    struct drm_minor *minor,
+			    const char *name,
+			    const struct file_operations *fops,
+			    umode_t mode)
+{
+	struct drm_info_node *node;
+	struct dentry *ent;
+
+	ent = debugfs_create_file(name, mode, root, minor->dev, fops);
+	if (!ent)
+		return PTR_ERR(ent);
+
+	node = kmalloc(sizeof(*node), GFP_KERNEL);
+	if (node == NULL) {
+		debugfs_remove(ent);
+		return -ENOMEM;
+	}
+
+	node->minor = minor;
+	node->dent = ent;
+	node->info_ent = (void *)fops;
+
+	mutex_lock(&minor->debugfs_lock);
+	list_add(&node->list, &minor->debugfs_list);
+	mutex_unlock(&minor->debugfs_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_debugfs_create_file);
+
 #endif /* CONFIG_DEBUG_FS */
 
diff --git a/include/drm/drmP.h b/include/drm/drmP.h
index 63eab2b..b8e2baf 100644
--- a/include/drm/drmP.h
+++ b/include/drm/drmP.h
@@ -1458,6 +1458,11 @@ extern struct drm_local_map *drm_getsarea(struct drm_device *dev);
 #if defined(CONFIG_DEBUG_FS)
 extern int drm_debugfs_init(struct drm_minor *minor, int minor_id,
 			    struct dentry *root);
+extern int drm_debugfs_create_file(struct dentry *root,
+				   struct drm_minor *minor,
+				   const char *name,
+				   const struct file_operations *fops,
+				   umode_t mode);
 extern int drm_debugfs_create_files(const struct drm_info_list *files,
 				    int count, struct dentry *root,
 				    struct drm_minor *minor);
@@ -1478,6 +1483,15 @@ static inline int drm_debugfs_create_files(const struct drm_info_list *files,
 	return 0;
 }
 
+static inline int drm_debugfs_create_file(struct dentry *root,
+					  struct drm_minor *minor,
+					  const char *name,
+					  const struct file_operations *fops,
+					  umode_t mode)
+{
+	return 0;
+}
+
 static inline int drm_debugfs_remove_files(const struct drm_info_list *files,
 					   int count, struct drm_minor *minor)
 {
-- 
1.8.5.3
