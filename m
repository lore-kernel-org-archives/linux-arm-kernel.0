From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 25 May 2018 10:04:23 -0400
Subject: [PATCH] PCI: Try to clean up resources via remove if shutdown doesn't
 exist
Message-ID: <1527257063-15843-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is up to a driver to implement shutdown() callback. If shutdown()
callback is not implemented, PCI device can have pending interrupt and
even do DMA transactions while the system is going down.

If kexec is in use, this can damage the newly booting kexec kernel
or even prevent it from booting altogether. Fallback to calling the
remove() callback if shutdown() isn't implemented for a given driver.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci-driver.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 6ace470..4ac72e3 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -475,8 +475,17 @@ static void pci_device_shutdown(struct device *dev)
 
 	pm_runtime_resume(dev);
 
+	/*
+	 * Try shutdown callback if it exists, otherwise fallback to remove
+	 * callback. PCI drivers can do DMA and have pending interrupts.
+	 * Leaving the DMA and interrupts pending could damage the newly
+	 * booting kexec kernel as well as prevent it from booting altogether
+	 * if the pending interrupt is level.
+	 */
 	if (drv && drv->shutdown)
 		drv->shutdown(pci_dev);
+	else if (drv && drv->remove)
+		drv->remove(pci_dev);
 
 	/*
 	 * If this is a kexec reboot, turn off Bus Master bit on the
-- 
2.7.4
