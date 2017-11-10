From: jlu@pengutronix.de (Jan Luebbe)
Date: Fri, 10 Nov 2017 10:03:07 +0100
Subject: [PATCH v3 6/7] EDAC: Add missing debugfs_create_x32 wrapper
In-Reply-To: <20171110090308.21562-1-jlu@pengutronix.de>
References: <20171110090308.21562-1-jlu@pengutronix.de>
Message-ID: <20171110090308.21562-7-jlu@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We already have wrappers for x8 and x16, so add the missing x32 one.

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
index dec88dcea036..546b16e29221 100644
--- a/drivers/edac/edac_module.h
+++ b/drivers/edac/edac_module.h
@@ -82,6 +82,8 @@ struct dentry *
 edac_debugfs_create_x8(const char *name, umode_t mode, struct dentry *parent, u8 *value);
 struct dentry *
 edac_debugfs_create_x16(const char *name, umode_t mode, struct dentry *parent, u16 *value);
+struct dentry *
+edac_debugfs_create_x32(const char *name, umode_t mode, struct dentry *parent, u32 *value);
 #else
 static inline int edac_debugfs_init(void)					{ return -ENODEV; }
 static inline void edac_debugfs_exit(void)					{ }
@@ -98,6 +100,9 @@ edac_debugfs_create_x8(const char *name, umode_t mode,
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
