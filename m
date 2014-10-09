From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 09 Oct 2014 10:40:07 +0200
Subject: [PATCH] vfio/pci: make MSI handling optional
Message-ID: <6188781.C8VgeYvZpD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent bug fix to the MSIx handling in vfio added references
to functions that may not be defined if MSI is disabled in the kernel,
resulting in this link error:

drivers/built-in.o: In function `vfio_msi_set_vector_signal':
:(.text+0x450808): undefined reference to `get_cached_msi_msg'
:(.text+0x45080c): undefined reference to `write_msi_msg'

>From what I can tell, all the MSI specific ioctl handling can
be made optional in this case, which also reduces the code size
for the vfo driver. This patches does so using a build-time
IS_ENABLED() check, which leaves all the build coverage testing
present but avoids the link error.

A side-effect of this is that the driver now returns -ENOTTY instead
of -EINVAL if user space calls VFIO_PCI_MSI_IRQ_INDEX on a kernel
without MSI support, which seems to be the best behavior, but
the approach could easily be changed if we want to preserve the
existing behavior for compatibility reasons.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: b8f02af096b1 ("vfio/pci: Restore MSIx message prior to enabling")
---
Found using randconfig build testing on ARM.

diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 553212f037c3..1117f96b8556 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -827,6 +827,9 @@ int vfio_pci_set_irqs_ioctl(struct vfio_pci_device *vdev, uint32_t flags,
 		break;
 	case VFIO_PCI_MSI_IRQ_INDEX:
 	case VFIO_PCI_MSIX_IRQ_INDEX:
+		if (!IS_ENABLED(CONFIG_PCI_MSI))
+			break;
+
 		switch (flags & VFIO_IRQ_SET_ACTION_TYPE_MASK) {
 		case VFIO_IRQ_SET_ACTION_MASK:
 		case VFIO_IRQ_SET_ACTION_UNMASK:
