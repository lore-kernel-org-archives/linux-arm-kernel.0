From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 22 May 2018 13:58:00 -0400
Subject: [PATCH] PCI/portdrv: do not disable device on remove()
Message-ID: <1527011883-21320-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'Commit cc27b735ad3a ("PCI/portdrv: Turn off PCIe services during
shutdown")' has been added to kernel to shutdown pending PCIe port
service interrupts during reboot so that a newly started kexec kernel
wouldn't observe pending interrupts.

pcie_port_device_remove() is disabling the root port and switches by
calling pci_disable_device() after all PCIe service drivers are shutdown.

pci_disable_device() has a much wider impact then port service itself and
it prevents all inbound transactions to reach to the system and impacts
the entire PCI traffic behind the bridge.

Issue is that pcie_port_device_remove() doesn't maintain any coordination
with the rest of the PCI device drivers in the system before clearing the
bus master bit.

This has been found to cause crashes on HP DL360 Gen9 machines during
reboot. Besides, kexec is already clearing the bus master bit in
pci_device_shutdown() after all PCI drivers are removed.

Just remove the extra clear here.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=199779
Fixes: cc27b735ad3a ("PCI/portdrv: Turn off PCIe services during shutdown")
Cc: stable at vger.kernel.org
Reported-by: Ryan Finnie <ryan@finnie.org>
---
 drivers/pci/pcie/portdrv_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index c9c0663..d22a95d 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -409,7 +409,6 @@ void pcie_port_device_remove(struct pci_dev *dev)
 {
 	device_for_each_child(&dev->dev, NULL, remove_iter);
 	pci_free_irq_vectors(dev);
-	pci_disable_device(dev);
 }
 
 /**
-- 
2.7.4
