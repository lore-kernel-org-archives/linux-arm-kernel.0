From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 22 Nov 2017 00:30:55 -0500
Subject: [PATCH 10/30] drm/nouveau: deprecate pci_get_bus_and_slot()
In-Reply-To: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1511328675-21981-11-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
extract the domain number. Other places, use the actual domain number from
the device.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/gpu/drm/nouveau/dispnv04/arb.c           | 3 ++-
 drivers/gpu/drm/nouveau/dispnv04/hw.c            | 6 ++++--
 drivers/gpu/drm/nouveau/nouveau_drm.c            | 3 ++-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c | 2 +-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/arb.c b/drivers/gpu/drm/nouveau/dispnv04/arb.c
index 90075b6..729d7d0 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/arb.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/arb.c
@@ -214,7 +214,8 @@ struct nv_sim_state {
 	    (dev->pdev->device & 0xffff) == 0x01f0 /*CHIPSET_NFORCE2*/) {
 		uint32_t type;
 
-		pci_read_config_dword(pci_get_bus_and_slot(0, 1), 0x7c, &type);
+		pci_read_config_dword(pci_get_domain_bus_and_slot(0, 0, 1),
+				      0x7c, &type);
 
 		sim_data.memory_type = (type >> 12) & 1;
 		sim_data.memory_width = 64;
diff --git a/drivers/gpu/drm/nouveau/dispnv04/hw.c b/drivers/gpu/drm/nouveau/dispnv04/hw.c
index b985990..4b35093 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/hw.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/hw.c
@@ -221,7 +221,8 @@
 	    (dev->pdev->device & 0x0ff0) == CHIPSET_NFORCE) {
 		uint32_t mpllP;
 
-		pci_read_config_dword(pci_get_bus_and_slot(0, 3), 0x6c, &mpllP);
+		pci_read_config_dword(pci_get_domain_bus_and_slot(0, 0, 3),
+				      0x6c, &mpllP);
 		mpllP = (mpllP >> 8) & 0xf;
 		if (!mpllP)
 			mpllP = 4;
@@ -232,7 +233,8 @@
 	    (dev->pdev->device & 0xff0) == CHIPSET_NFORCE2) {
 		uint32_t clock;
 
-		pci_read_config_dword(pci_get_bus_and_slot(0, 5), 0x4c, &clock);
+		pci_read_config_dword(pci_get_domain_bus_and_slot(0, 0, 5),
+				      0x4c, &clock);
 		return clock / 1000;
 	}
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 595630d..0b6c639 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -406,7 +406,8 @@ static int nouveau_drm_probe(struct pci_dev *pdev,
 	}
 
 	/* subfunction one is a hdmi audio device? */
-	drm->hdmi_device = pci_get_bus_and_slot((unsigned int)pdev->bus->number,
+	drm->hdmi_device = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
+						(unsigned int)pdev->bus->number,
 						PCI_DEVFN(PCI_SLOT(pdev->devfn), 1));
 
 	if (!drm->hdmi_device) {
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c
index 3c6a871..3d2a203 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c
@@ -29,7 +29,7 @@
 	struct pci_dev *bridge;
 	u32 mem, mib;
 
-	bridge = pci_get_bus_and_slot(0, PCI_DEVFN(0, 1));
+	bridge = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 1));
 	if (!bridge) {
 		nvkm_error(&fb->subdev, "no bridge device\n");
 		return -ENODEV;
-- 
1.9.1
