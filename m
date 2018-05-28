From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 28 May 2018 17:21:11 -0400
Subject: [PATCH V3 2/2] scsi: hpsa: drop shutdown callback
In-Reply-To: <1527542471-10316-1-git-send-email-okaya@codeaurora.org>
References: <1527542471-10316-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1527542471-10316-2-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'Commit cc27b735ad3a ("PCI/portdrv: Turn off PCIe services during
shutdown")' has been added to kernel to shutdown pending PCIe port
service interrupts during reboot so that a newly started kexec kernel
wouldn't observe pending interrupts.

pcie_port_device_remove() is disabling the root port and switches by
calling pci_disable_device() after all PCIe service drivers are shutdown.

This has been found to cause crashes on HP DL360 Gen9 machines during
reboot due to hpsa driver not clearing the bus master bit during the
shutdown procedure by calling pci_disable_device().

Drop the shutdown API and do an orderly clean up by using the remove.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=199779
Fixes: cc27b735ad3a ("PCI/portdrv: Turn off PCIe services during shutdown")
Cc: stable at vger.kernel.org
Reported-by: Ryan Finnie <ryan@finnie.org>
---
 drivers/scsi/hpsa.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 3a9eca1..3dbef28 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -8970,7 +8970,6 @@ static struct pci_driver hpsa_pci_driver = {
 	.probe = hpsa_init_one,
 	.remove = hpsa_remove_one,
 	.id_table = hpsa_pci_device_id,	/* id_table */
-	.shutdown = hpsa_shutdown,
 	.suspend = hpsa_suspend,
 	.resume = hpsa_resume,
 };
-- 
2.7.4
