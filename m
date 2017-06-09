From: jlu@pengutronix.de (Jan Luebbe)
Date: Fri,  9 Jun 2017 10:31:19 +0200
Subject: [RFC PATCH 3/7] EDAC: Add missing debugfs_create_x32 wrapper
In-Reply-To: <20170609083123.6539-1-jlu@pengutronix.de>
References: <20170609083123.6539-1-jlu@pengutronix.de>
Message-ID: <20170609083123.6539-4-jlu@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We already have wrappers for x8 and x16.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
---
 drivers/edac/debugfs.c     | 11 +++++++++++
 drivers/edac/edac_module.h |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/edac/debugfs.c b/drivers/edac/debugfs.c
index 92dbb7e2320c..268ede7a60b2 100644
--- a/drivers/edac/debugfs.c
+++ b/drivers/edac/debugfs.c
@@ -161,3 +161,14 @@ struct dentry *edac_debugfs_create_x16(const char *name, umode_t mode,
 	return debugfs_create_x16(name, mode, parent, value);
 }
 EXPORT_SYMBOL_GPL(edac_debugfs_create_x16);
+
+/* Wrapper for debugfs_create_x32() */
+struct dentry *edac_debugfs_create_x32(const char *name, umode_t mode,
+				       struct dentry *parent, u32 *value)
+{
+	if (!parent)
+		parent = edac_debugfs;
+
+	return debugfs_create_x32(name, mode, parent, value);
+}
+EXPORT_SYMBOL_GPL(edac_debugfs_create_x32);
diff --git a/drivers/edac/edac_module.h b/drivers/edac/edac_module.h
index 014871e169cc..3d87cb15ab45 100644
--- a/drivers/edac/edac_module.h
+++ b/drivers/edac/edac_module.h
@@ -81,6 +81,8 @@ struct dentry *
 edac_debugfs_create_x8(const char *name, umode_t mode, struct dentry *parent, u8 *value);
 struct dentry *
 edac_debugfs_create_x16(const char *name, umode_t mode, struct dentry *parent, u16 *value);
+struct dentry *
+edac_debugfs_create_x32(const char *name, umode_t mode, struct dentry *parent, u32 *value);
 #else
 static inline int edac_debugfs_init(void)					{ return -ENODEV; }
 static inline void edac_debugfs_exit(void)					{ }
@@ -97,6 +99,9 @@ edac_debugfs_create_x8(const char *name, umode_t mode,
 static inline struct dentry *
 edac_debugfs_create_x16(const char *name, umode_t mode,
 		       struct dentry *parent, u16 *value)			{ return NULL; }
+static inline struct dentry *
+edac_debugfs_create_x32(const char *name, umode_t mode,
+		       struct dentry *parent, u32 *value)			{ return NULL; }
 #endif
 
 /*
-- 
2.11.0
