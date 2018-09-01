From: mirq-linux@rere.qmqm.pl (=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?=)
Date: Sat, 01 Sep 2018 16:08:47 +0200
Subject: [PATCH v3 07/13] drm/cirrus: use simpler
 remove_conflicting_pci_framebuffers()
In-Reply-To: <cover.1535810304.git.mirq-linux@rere.qmqm.pl>
References: <cover.1535810304.git.mirq-linux@rere.qmqm.pl>
Message-ID: <a9a4691b6eea789664edd6b85a85b7990953a222.1535810304.git.mirq-linux@rere.qmqm.pl>
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
