From: guido@vanguardiasur.com.ar (=?UTF-8?q?Guido=20Mart=C3=ADnez?=)
Date: Tue, 17 Jun 2014 11:17:09 -0300
Subject: [PATCH/RESEND 7/9] drm/tilcdc: fix double kfree
In-Reply-To: <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
Message-ID: <1403014631-18072-8-git-send-email-guido@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

display_timings_release calls kfree on the display_timings object passed
to it. Calling kfree after it is wrong. SLUB debug showed the following
warning:

    =============================================================================
    BUG kmalloc-64 (Tainted: G        W    ): Object already free
    -----------------------------------------------------------------------------

    Disabling lock debugging due to kernel taint
    INFO: Allocated in of_get_display_timings+0x2c/0x214 age=601 cpu=0
    pid=884
     __slab_alloc.constprop.79+0x2e0/0x33c
     kmem_cache_alloc+0xac/0xdc
     of_get_display_timings+0x2c/0x214
     panel_probe+0x7c/0x314 [tilcdc]
     platform_drv_probe+0x18/0x48
     [..snip..]
    INFO: Freed in panel_destroy+0x18/0x3c [tilcdc] age=0 cpu=0 pid=907
     __slab_free+0x34/0x330
     panel_destroy+0x18/0x3c [tilcdc]
     tilcdc_unload+0xd0/0x118 [tilcdc]
     drm_dev_unregister+0x24/0x98
     [..snip..]

Signed-off-by: Guido Mart?nez <guido@vanguardiasur.com.ar>
Cc: <stable@vger.kernel.org> #v3.9+
---
 drivers/gpu/drm/tilcdc/tilcdc_panel.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_panel.c b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
index 1943b2f..b085dcc 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_panel.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
@@ -286,10 +286,8 @@ static void panel_destroy(struct tilcdc_module *mod)
 {
 	struct panel_module *panel_mod = to_panel_module(mod);
 
-	if (panel_mod->timings) {
+	if (panel_mod->timings)
 		display_timings_release(panel_mod->timings);
-		kfree(panel_mod->timings);
-	}
 
 	tilcdc_module_cleanup(mod);
 	kfree(panel_mod->info);
-- 
2.0.0
