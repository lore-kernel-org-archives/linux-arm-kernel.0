From: guido@vanguardiasur.com.ar (=?UTF-8?q?Guido=20Mart=C3=ADnez?=)
Date: Tue, 17 Jun 2014 11:17:04 -0300
Subject: [PATCH/RESEND 2/9] drm/tilcdc: panel: fix dangling sysfs connector
 node
In-Reply-To: <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
Message-ID: <1403014631-18072-3-git-send-email-guido@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a drm_sysfs_connector_remove call when we destroy the panel to make
sure the connector node in sysfs gets deleted.

This is required for proper unload and re-load of this driver as a
module. Without this, we would get a warning at re-load time like so:

   ------------[ cut here ]------------
   WARNING: CPU: 0 PID: 824 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x54/0x74()
   sysfs: cannot create duplicate filename '/class/drm/card0-LVDS-1'
   Modules linked in: [...]
   CPU: 0 PID: 824 Comm: modprobe Not tainted 3.15.0-rc4-00027-g6484f96-dirty #81
   [<c0013bb8>] (unwind_backtrace) from [<c0011824>] (show_stack+0x10/0x14)
   [<c0011824>] (show_stack) from [<c0034e8c>] (warn_slowpath_common+0x68/0x88)
   [<c0034e8c>] (warn_slowpath_common) from [<c0034edc>] (warn_slowpath_fmt+0x30/0x40)
   [<c0034edc>] (warn_slowpath_fmt) from [<c01243f4>] (sysfs_warn_dup+0x54/0x74)
   [<c01243f4>] (sysfs_warn_dup) from [<c0124708>] (sysfs_do_create_link_sd.isra.2+0xb0/0xb8)
   [<c0124708>] (sysfs_do_create_link_sd.isra.2) from [<c02ae37c>] (device_add+0x338/0x520)
   [<c02ae37c>] (device_add) from [<c02ae6e8>] (device_create_groups_vargs+0xa0/0xc4)
   [<c02ae6e8>] (device_create_groups_vargs) from [<c02ae758>] (device_create+0x24/0x2c)
   [<c02ae758>] (device_create) from [<c029b4ec>] (drm_sysfs_connector_add+0x64/0x204)
   [<c029b4ec>] (drm_sysfs_connector_add) from [<bf0b1fec>] (panel_modeset_init+0xb8/0x134 [tilcdc])
   [<bf0b1fec>] (panel_modeset_init [tilcdc]) from [<bf0b2bf0>] (tilcdc_load+0x214/0x4c0 [tilcdc])
   [<bf0b2bf0>] (tilcdc_load [tilcdc]) from [<c029955c>] (drm_dev_register+0xa4/0x104)
      [ .. snip .. ]
   ---[ end trace b2d09cd9578b0497 ]---
   [drm:drm_sysfs_connector_add] *ERROR* failed to register connector device: -17

Signed-off-by: Guido Mart?nez <guido@vanguardiasur.com.ar>
Cc: <stable@vger.kernel.org> #v3.9+
---
 drivers/gpu/drm/tilcdc/tilcdc_panel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_panel.c b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
index 86c6732..1943b2f 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_panel.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
@@ -151,6 +151,7 @@ struct panel_connector {
 static void panel_connector_destroy(struct drm_connector *connector)
 {
 	struct panel_connector *panel_connector = to_panel_connector(connector);
+	drm_sysfs_connector_remove(connector);
 	drm_connector_cleanup(connector);
 	kfree(panel_connector);
 }
-- 
2.0.0
