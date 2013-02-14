From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Feb 2013 23:26:55 +0100
Subject: [PATCH 6/9] drm/pci: move drm_pcie_get_speed_cap_mask inside #ifdef
 CONFIG_PCI
In-Reply-To: <1360880818-4071454-1-git-send-email-arnd@arndb.de>
References: <1360880818-4071454-1-git-send-email-arnd@arndb.de>
Message-ID: <1360880818-4071454-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit dd66cc2e1  "drm/pci: Use PCI Express Capability accessors"
introduced the use of the pcie_capability_read_dword function
in the drm_pci code, which is only defined when PCI is enabled.
While most of the file is already hidden away behind an #ifdef
CONFIG_PCI, this function is not, and that now causes a link
error in the ARM imx_v6_v7_defconfig configuration.

Moving the function into the #ifdef section makes this work
again on IMX, which does not have PCI support, and should
have no impact on platforms that do.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/drm_pci.c | 75 +++++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/drm_pci.c b/drivers/gpu/drm/drm_pci.c
index 86102a0..9c408e0 100644
--- a/drivers/gpu/drm/drm_pci.c
+++ b/drivers/gpu/drm/drm_pci.c
@@ -388,6 +388,43 @@ err_g1:
 }
 EXPORT_SYMBOL(drm_get_pci_dev);
 
+int drm_pcie_get_speed_cap_mask(struct drm_device *dev, u32 *mask)
+{
+	struct pci_dev *root;
+	u32 lnkcap, lnkcap2;
+
+	*mask = 0;
+	if (!dev->pdev)
+		return -EINVAL;
+
+	root = dev->pdev->bus->self;
+
+	/* we've been informed via and serverworks don't make the cut */
+	if (root->vendor == PCI_VENDOR_ID_VIA ||
+	    root->vendor == PCI_VENDOR_ID_SERVERWORKS)
+		return -EINVAL;
+
+	pcie_capability_read_dword(root, PCI_EXP_LNKCAP, &lnkcap);
+	pcie_capability_read_dword(root, PCI_EXP_LNKCAP2, &lnkcap2);
+
+	if (lnkcap2) {	/* PCIe r3.0-compliant */
+		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_2_5GB)
+			*mask |= DRM_PCIE_SPEED_25;
+		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_5_0GB)
+			*mask |= DRM_PCIE_SPEED_50;
+		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_8_0GB)
+			*mask |= DRM_PCIE_SPEED_80;
+	} else {	/* pre-r3.0 */
+		if (lnkcap & PCI_EXP_LNKCAP_SLS_2_5GB)
+			*mask |= DRM_PCIE_SPEED_25;
+		if (lnkcap & PCI_EXP_LNKCAP_SLS_5_0GB)
+			*mask |= (DRM_PCIE_SPEED_25 | DRM_PCIE_SPEED_50);
+	}
+
+	DRM_INFO("probing gen 2 caps for device %x:%x = %x/%x\n", root->vendor, root->device, lnkcap, lnkcap2);
+	return 0;
+}
+EXPORT_SYMBOL(drm_pcie_get_speed_cap_mask);
 /**
  * PCI device initialization. Called direct from modules at load time.
  *
@@ -465,41 +502,3 @@ void drm_pci_exit(struct drm_driver *driver, struct pci_driver *pdriver)
 	DRM_INFO("Module unloaded\n");
 }
 EXPORT_SYMBOL(drm_pci_exit);
-
-int drm_pcie_get_speed_cap_mask(struct drm_device *dev, u32 *mask)
-{
-	struct pci_dev *root;
-	u32 lnkcap, lnkcap2;
-
-	*mask = 0;
-	if (!dev->pdev)
-		return -EINVAL;
-
-	root = dev->pdev->bus->self;
-
-	/* we've been informed via and serverworks don't make the cut */
-	if (root->vendor == PCI_VENDOR_ID_VIA ||
-	    root->vendor == PCI_VENDOR_ID_SERVERWORKS)
-		return -EINVAL;
-
-	pcie_capability_read_dword(root, PCI_EXP_LNKCAP, &lnkcap);
-	pcie_capability_read_dword(root, PCI_EXP_LNKCAP2, &lnkcap2);
-
-	if (lnkcap2) {	/* PCIe r3.0-compliant */
-		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_2_5GB)
-			*mask |= DRM_PCIE_SPEED_25;
-		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_5_0GB)
-			*mask |= DRM_PCIE_SPEED_50;
-		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_8_0GB)
-			*mask |= DRM_PCIE_SPEED_80;
-	} else {	/* pre-r3.0 */
-		if (lnkcap & PCI_EXP_LNKCAP_SLS_2_5GB)
-			*mask |= DRM_PCIE_SPEED_25;
-		if (lnkcap & PCI_EXP_LNKCAP_SLS_5_0GB)
-			*mask |= (DRM_PCIE_SPEED_25 | DRM_PCIE_SPEED_50);
-	}
-
-	DRM_INFO("probing gen 2 caps for device %x:%x = %x/%x\n", root->vendor, root->device, lnkcap, lnkcap2);
-	return 0;
-}
-EXPORT_SYMBOL(drm_pcie_get_speed_cap_mask);
-- 
1.8.1.2
