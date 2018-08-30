From: mirq-linux@rere.qmqm.pl (=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?=)
Date: Thu, 30 Aug 2018 23:00:08 +0200
Subject: [PATCH v2 08/12] drm/radeon: use simpler
 remove_conflicting_pci_framebuffers()
In-Reply-To: <cover.1535656077.git.mirq-linux@rere.qmqm.pl>
References: <cover.1535656077.git.mirq-linux@rere.qmqm.pl>
Message-ID: <3b6a06b61458471bdecb40fa0af052a75d5a8222.1535656077.git.mirq-linux@rere.qmqm.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index b28288a781ef..36c98a0ec991 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -311,27 +311,6 @@ static struct drm_driver kms_driver;
 
 bool radeon_device_is_virtual(void);
 
-static int radeon_kick_out_firmware_fb(struct pci_dev *pdev)
-{
-	struct apertures_struct *ap;
-	bool primary = false;
-
-	ap = alloc_apertures(1);
-	if (!ap)
-		return -ENOMEM;
-
-	ap->ranges[0].base = pci_resource_start(pdev, 0);
-	ap->ranges[0].size = pci_resource_len(pdev, 0);
-
-#ifdef CONFIG_X86
-	primary = pdev->resource[PCI_ROM_RESOURCE].flags & IORESOURCE_ROM_SHADOW;
-#endif
-	drm_fb_helper_remove_conflicting_framebuffers(ap, "radeondrmfb", primary);
-	kfree(ap);
-
-	return 0;
-}
-
 static int radeon_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *ent)
 {
@@ -341,7 +320,7 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 		return -EPROBE_DEFER;
 
 	/* Get rid of things like offb */
-	ret = radeon_kick_out_firmware_fb(pdev);
+	ret = drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, 0, "radeondrmfb");
 	if (ret)
 		return ret;
 
-- 
2.18.0
