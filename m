From: bp@alien8.de (Borislav Petkov)
Date: Tue, 22 Sep 2015 18:37:02 +0200
Subject: [PATCH 2/5] EDAC: Add debugfs wrappers
In-Reply-To: <1442939825-13455-1-git-send-email-bp@alien8.de>
References: <20150922163405.GC3437@pd.tnic>
 <1442939825-13455-1-git-send-email-bp@alien8.de>
Message-ID: <1442939825-13455-2-git-send-email-bp@alien8.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Borislav Petkov <bp@suse.de>

Later patches will convert EDAC users to those.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/edac/debugfs.c     | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/edac/edac_module.h | 34 +++++++++++++++++++++-----
 2 files changed, 88 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/debugfs.c b/drivers/edac/debugfs.c
index bcd558d5cb48..4864703115cc 100644
--- a/drivers/edac/debugfs.c
+++ b/drivers/edac/debugfs.c
@@ -101,3 +101,63 @@ nomem:
 	debugfs_remove(mci->debugfs);
 	return -ENOMEM;
 }
+
+/* Create a toplevel dir under EDAC's debugfs hierarchy */
+struct dentry *edac_debugfs_create_dir(const char *dirname)
+{
+	if (!edac_debugfs)
+		return NULL;
+
+	return debugfs_create_dir(dirname, edac_debugfs);
+}
+EXPORT_SYMBOL_GPL(edac_debugfs_create_dir);
+
+/* Create a toplevel dir under EDAC's debugfs hierarchy with parent @parent */
+struct dentry *
+edac_debugfs_create_dir_at(const char *dirname, struct dentry *parent)
+{
+	return debugfs_create_dir(dirname, parent);
+}
+EXPORT_SYMBOL_GPL(edac_debugfs_create_dir_at);
+
+/*
+ * Create a file under EDAC's hierarchy or a sub-hierarchy:
+ *
+ * @name: file name
+ * @mode: file permissions
+ * @parent: parent dentry. If NULL, it becomes the toplevel EDAC dir
+ * @data: private data of caller
+ * @fops: file operations of this file
+ */
+struct dentry *
+edac_debugfs_create_file(const char *name, umode_t mode, struct dentry *parent,
+			 void *data, const struct file_operations *fops)
+{
+	if (!parent)
+		parent = edac_debugfs;
+
+	return debugfs_create_file(name, mode, parent, data, fops);
+}
+EXPORT_SYMBOL_GPL(edac_debugfs_create_file);
+
+/* Wrapper for debugfs_create_x8() */
+struct dentry *edac_debugfs_create_x8(const char *name, umode_t mode,
+				       struct dentry *parent, u8 *value)
+{
+	if (!parent)
+		parent = edac_debugfs;
+
+	return debugfs_create_x8(name, mode, parent, value);
+}
+EXPORT_SYMBOL_GPL(edac_debugfs_create_x8);
+
+/* Wrapper for debugfs_create_x16() */
+struct dentry *edac_debugfs_create_x16(const char *name, umode_t mode,
+				       struct dentry *parent, u16 *value)
+{
+	if (!parent)
+		parent = edac_debugfs;
+
+	return debugfs_create_x16(name, mode, parent, value);
+}
+EXPORT_SYMBOL_GPL(edac_debugfs_create_x16);
diff --git a/drivers/edac/edac_module.h b/drivers/edac/edac_module.h
index 79a6c6e20819..b95a48fc723d 100644
--- a/drivers/edac/edac_module.h
+++ b/drivers/edac/edac_module.h
@@ -60,17 +60,39 @@ extern void *edac_align_ptr(void **p, unsigned size, int n_elems);
 /*
  * EDAC debugfs functions
  */
+
+#define edac_debugfs_remove_recursive debugfs_remove_recursive
+#define edac_debugfs_remove debugfs_remove
 #ifdef CONFIG_EDAC_DEBUG
 int edac_debugfs_init(void);
 void edac_debugfs_exit(void);
 int edac_create_debugfs_nodes(struct mem_ctl_info *mci);
+struct dentry *edac_debugfs_create_dir(const char *dirname);
+struct dentry *
+edac_debugfs_create_dir_at(const char *dirname, struct dentry *parent);
+struct dentry *
+edac_debugfs_create_file(const char *name, umode_t mode, struct dentry *parent,
+			 void *data, const struct file_operations *fops);
+struct dentry *
+edac_debugfs_create_x8(const char *name, umode_t mode, struct dentry *parent, u8 *value);
+struct dentry *
+edac_debugfs_create_x16(const char *name, umode_t mode, struct dentry *parent, u16 *value);
 #else
-static inline int edac_debugfs_init(void)
-{
-	return -ENODEV;
-}
-static inline void edac_debugfs_exit(void) {}
-static inline int edac_create_debugfs_nodes(struct mem_ctl_info *mci) { return 0; }
+static inline int edac_debugfs_init(void)					{ return -ENODEV; }
+static inline void edac_debugfs_exit(void)					{ }
+static inline int edac_create_debugfs_nodes(struct mem_ctl_info *mci)		{ return 0; }
+static inline struct dentry *edac_debugfs_create_dir(const char *dirname)	{ return NULL; }
+static inline struct dentry *
+edac_debugfs_create_dir_at(const char *dirname, struct dentry *parent)		{ return NULL; }
+static inline struct dentry *
+edac_debugfs_create_file(const char *name, umode_t mode, struct dentry *parent,
+			 void *data, const struct file_operations *fops)	{ return NULL; }
+static inline struct dentry *
+edac_debugfs_create_x8(const char *name, umode_t mode,
+		       struct dentry *parent, u8 *value)			{ return NULL; }
+static inline struct dentry *
+edac_debugfs_create_x16(const char *name, umode_t mode,
+		       struct dentry *parent, u16 *value)			{ return NULL; }
 #endif
 
 /*
-- 
2.3.5
