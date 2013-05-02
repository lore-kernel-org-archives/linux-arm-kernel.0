From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  2 May 2013 17:16:09 +0200
Subject: [PATCH, RFC 05/22] drm: always provide debugfs function prototypes
In-Reply-To: <1367507786-505303-1-git-send-email-arnd@arndb.de>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
Message-ID: <1367507786-505303-6-git-send-email-arnd@arndb.de>
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

Cc: Ben Gamari <bgamari@gmail.com>
Cc: Dave Airlie <airlied@redhat.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/drm/drmP.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/drm/drmP.h b/include/drm/drmP.h
index 6119659..f780d62 100644
--- a/include/drm/drmP.h
+++ b/include/drm/drmP.h
@@ -1550,7 +1550,7 @@ extern int drm_proc_init(struct drm_minor *minor, struct proc_dir_entry *root);
 extern int drm_proc_cleanup(struct drm_minor *minor, struct proc_dir_entry *root);
 
 				/* Debugfs support */
-#if defined(CONFIG_DEBUG_FS)
+
 extern int drm_debugfs_init(struct drm_minor *minor, int minor_id,
 			    struct dentry *root);
 extern int drm_debugfs_create_files(struct drm_info_list *files, int count,
@@ -1558,7 +1558,6 @@ extern int drm_debugfs_create_files(struct drm_info_list *files, int count,
 extern int drm_debugfs_remove_files(struct drm_info_list *files, int count,
                                     struct drm_minor *minor);
 extern int drm_debugfs_cleanup(struct drm_minor *minor);
-#endif
 
 				/* Info file support */
 extern int drm_name_info(struct seq_file *m, void *data);
-- 
1.8.1.2
