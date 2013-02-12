From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 12 Feb 2013 14:34:40 -0700
Subject: Building DRM for i.MX fails with linux-next 20130212
In-Reply-To: <CAOMZO5AnbiQts5tHH3XS9HeALcRDdbL2Q9=dcv4Fs3wNnLMy9g@mail.gmail.com>
References: <CAOMZO5CzFbSKe1dKjCgmFtzbPCjMsHu1mGzphae3jmhByCPBqw@mail.gmail.com>
 <CAOMZO5AnbiQts5tHH3XS9HeALcRDdbL2Q9=dcv4Fs3wNnLMy9g@mail.gmail.com>
Message-ID: <20130212213440.GA27624@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 12, 2013 at 07:20:30PM -0200, Fabio Estevam wrote:
> Dave/Bjorn,
> 
> On Tue, Feb 12, 2013 at 3:50 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > Hi,
> >
> > Building imx_v6_v7_defconfig on linux-next 20130212 gives me the
> > following build error:
> >
> >   CC      drivers/gpu/drm/drm_pci.o
> > drivers/gpu/drm/drm_pci.c: In function ?drm_pcie_get_speed_cap_mask?:
> > drivers/gpu/drm/drm_pci.c:485:2: error: implicit declaration of
> > function ?pcie_capability_read_dword?
> > [-Werror=implicit-function-declaration]
> 
> ,and it is caused by commit:
> 
> commit dd66cc2e1f4765d0e6f39eb1e7d8d64d3f1cc522
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Fri Jan 4 19:10:42 2013 +0000
> 
>     drm/pci: Use PCI Express Capability accessors

I sent Dave the patch below last Friday.  It's essentially the same
as yours, Fabio.

commit ed0708e69f71fab656afc1c891f3c54c9b105664
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri Feb 8 15:18:35 2013 -0700

    drm/pci: define drm_pcie_get_speed_cap_mask() only when CONFIG_PCI=y
    
    Move drm_pcie_get_speed_cap_mask() under #ifdef CONFIG_PCI because it
    it used only for PCI devices (evergreen, r600, r770), and it uses
    PCI interfaces that only exist when CONFIG_PCI=y.
    
    Previously, we tried to compile drm_pcie_get_speed_cap_mask() even when
    CONFIG_PCI=n, which fails.
    
    Tested-by: Fengguang Wu <fengguang.wu@intel.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/gpu/drm/drm_pci.c b/drivers/gpu/drm/drm_pci.c
index 754bc96..2b818c7 100644
--- a/drivers/gpu/drm/drm_pci.c
+++ b/drivers/gpu/drm/drm_pci.c
@@ -439,33 +439,6 @@ int drm_pci_init(struct drm_driver *driver, struct pci_driver *pdriver)
 	return 0;
 }
 
-#else
-
-int drm_pci_init(struct drm_driver *driver, struct pci_driver *pdriver)
-{
-	return -1;
-}
-
-#endif
-
-EXPORT_SYMBOL(drm_pci_init);
-
-/*@}*/
-void drm_pci_exit(struct drm_driver *driver, struct pci_driver *pdriver)
-{
-	struct drm_device *dev, *tmp;
-	DRM_DEBUG("\n");
-
-	if (driver->driver_features & DRIVER_MODESET) {
-		pci_unregister_driver(pdriver);
-	} else {
-		list_for_each_entry_safe(dev, tmp, &driver->device_list, driver_item)
-			drm_put_dev(dev);
-	}
-	DRM_INFO("Module unloaded\n");
-}
-EXPORT_SYMBOL(drm_pci_exit);
-
 int drm_pcie_get_speed_cap_mask(struct drm_device *dev, u32 *mask)
 {
 	struct pci_dev *root;
@@ -514,3 +487,30 @@ int drm_pcie_get_speed_cap_mask(struct drm_device *dev, u32 *mask)
 	return 0;
 }
 EXPORT_SYMBOL(drm_pcie_get_speed_cap_mask);
+
+#else
+
+int drm_pci_init(struct drm_driver *driver, struct pci_driver *pdriver)
+{
+	return -1;
+}
+
+#endif
+
+EXPORT_SYMBOL(drm_pci_init);
+
+/*@}*/
+void drm_pci_exit(struct drm_driver *driver, struct pci_driver *pdriver)
+{
+	struct drm_device *dev, *tmp;
+	DRM_DEBUG("\n");
+
+	if (driver->driver_features & DRIVER_MODESET) {
+		pci_unregister_driver(pdriver);
+	} else {
+		list_for_each_entry_safe(dev, tmp, &driver->device_list, driver_item)
+			drm_put_dev(dev);
+	}
+	DRM_INFO("Module unloaded\n");
+}
+EXPORT_SYMBOL(drm_pci_exit);
