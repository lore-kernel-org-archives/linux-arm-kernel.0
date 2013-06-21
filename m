From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 22 Jun 2013 00:38:16 +0200
Subject: [PATCH] drm: always provide debugfs function prototypes
Message-ID: <201306220038.17115.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is generally considered bad style to enclose function prototypes
in header files in #ifdef. This case illustrates why that is:
The tegra host1x driver calls into the debugfs functions if
CONFIG_DEBUG_FS is enabled, but that code is otherwise already
discarded by the compiler, so leaving the prototype in place
actually makes everything work.

drivers/gpu/host1x/drm/dc.c: In function 'tegra_dc_debugfs_init':
drivers/gpu/host1x/drm/dc.c:1004:2: error: implicit declaration of function 'drm_debugfs_create_files' [-Werror=implicit-function-declaration]
drivers/gpu/host1x/drm/dc.c: In function 'tegra_dc_debugfs_exit': drivers/gpu/host1x/drm/dc.c:1026:2: error: implicit declaration of function 'drm_debugfs_remove_files' [-Werror=implicit-function-declaration]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Ben Gamari <bgamari@gmail.com>
Cc: Dave Airlie <airlied@redhat.com>

diff --git a/include/drm/drmP.h b/include/drm/drmP.h
index 63d17ee..8bc105e 100644
--- a/include/drm/drmP.h
+++ b/include/drm/drmP.h
@@ -1551,7 +1551,7 @@ extern int drm_proc_init(struct drm_minor *minor, struct proc_dir_entry *root);
 extern int drm_proc_cleanup(struct drm_minor *minor, struct proc_dir_entry *root);
 
 				/* Debugfs support */
-#if defined(CONFIG_DEBUG_FS)
+
 extern int drm_debugfs_init(struct drm_minor *minor, int minor_id,
 			    struct dentry *root);
 extern int drm_debugfs_create_files(struct drm_info_list *files, int count,
@@ -1559,7 +1559,6 @@ extern int drm_debugfs_create_files(struct drm_info_list *files, int count,
 extern int drm_debugfs_remove_files(struct drm_info_list *files, int count,
                                     struct drm_minor *minor);
 extern int drm_debugfs_cleanup(struct drm_minor *minor);
-#endif
 
 				/* Info file support */
 extern int drm_name_info(struct seq_file *m, void *data);
