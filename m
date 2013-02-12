From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 12 Feb 2013 19:20:30 -0200
Subject: Building DRM for i.MX fails with linux-next 20130212
In-Reply-To: <CAOMZO5CzFbSKe1dKjCgmFtzbPCjMsHu1mGzphae3jmhByCPBqw@mail.gmail.com>
References: <CAOMZO5CzFbSKe1dKjCgmFtzbPCjMsHu1mGzphae3jmhByCPBqw@mail.gmail.com>
Message-ID: <CAOMZO5AnbiQts5tHH3XS9HeALcRDdbL2Q9=dcv4Fs3wNnLMy9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave/Bjorn,

On Tue, Feb 12, 2013 at 3:50 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi,
>
> Building imx_v6_v7_defconfig on linux-next 20130212 gives me the
> following build error:
>
>   CC      drivers/gpu/drm/drm_pci.o
> drivers/gpu/drm/drm_pci.c: In function ?drm_pcie_get_speed_cap_mask?:
> drivers/gpu/drm/drm_pci.c:485:2: error: implicit declaration of
> function ?pcie_capability_read_dword?
> [-Werror=implicit-function-declaration]

,and it is caused by commit:

commit dd66cc2e1f4765d0e6f39eb1e7d8d64d3f1cc522
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri Jan 4 19:10:42 2013 +0000

    drm/pci: Use PCI Express Capability accessors

    Use PCI Express Capability access functions to simplify this code a bit.
    For non-PCIe devices or pre-PCIe 3.0 devices that don't implement the Link
    Capabilities 2 register, pcie_capability_read_dword() reads a zero.

    Since we're only testing whether the bits we care about are set, there's no
    need to mask out the other bits we *don't* care about.

    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Signed-off-by: Dave Airlie <airlied@redhat.com>

The patch below fixes the build on imx_v6_v7_defconfig (which has
CONFIG_PCI unselected):

diff --git a/drivers/gpu/drm/drm_pci.c b/drivers/gpu/drm/drm_pci.c
index 86102a0..93ec85d 100644
--- a/drivers/gpu/drm/drm_pci.c
+++ b/drivers/gpu/drm/drm_pci.c
@@ -466,6 +466,7 @@ void drm_pci_exit(struct drm_driver *driver,
struct pci_driver *pdriver)
 }
 EXPORT_SYMBOL(drm_pci_exit);

+#ifdef CONFIG_PCI
 int drm_pcie_get_speed_cap_mask(struct drm_device *dev, u32 *mask)
 {
        struct pci_dev *root;
@@ -503,3 +504,4 @@ int drm_pcie_get_speed_cap_mask(struct drm_device
*dev, u32 *mask)
        return 0;
 }
 EXPORT_SYMBOL(drm_pcie_get_speed_cap_mask);
+#endif

If this looks good I can submit it formally.
