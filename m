From: mirq-linux@rere.qmqm.pl (=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?=)
Date: Thu, 30 Aug 2018 23:00:07 +0200
Subject: [PATCH v2 06/12] drm/cirrus: use simpler
 remove_conflicting_pci_framebuffers()
In-Reply-To: <cover.1535656077.git.mirq-linux@rere.qmqm.pl>
References: <cover.1535656077.git.mirq-linux@rere.qmqm.pl>
Message-ID: <8a330a00dad89889550ff9fb7d7309d58d64181c.1535656077.git.mirq-linux@rere.qmqm.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/cirrus/cirrus_drv.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/cirrus/cirrus_drv.c b/drivers/gpu/drm/cirrus/cirrus_drv.c
index 69c4e352dd78..85ed8657c862 100644
--- a/drivers/gpu/drm/cirrus/cirrus_drv.c
+++ b/drivers/gpu/drm/cirrus/cirrus_drv.c
@@ -42,33 +42,12 @@ static const struct pci_device_id pciidlist[] = {
 };
 
 
-static int cirrus_kick_out_firmware_fb(struct pci_dev *pdev)
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
-	drm_fb_helper_remove_conflicting_framebuffers(ap, "cirrusdrmfb", primary);
-	kfree(ap);
-
-	return 0;
-}
-
 static int cirrus_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *ent)
 {
 	int ret;
 
-	ret = cirrus_kick_out_firmware_fb(pdev);
+	ret = drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, 0, "cirrusdrmfb");
 	if (ret)
 		return ret;
 
-- 
2.18.0
