From: po.liu@nxp.com (Po Liu)
Date: Mon, 29 Aug 2016 15:28:01 +0800
Subject: [PATCH v1] iov: add return failure condition for pci_setup_device
Message-ID: <1472455681-18827-1-git-send-email-po.liu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If pci_setup_device() return failure, return failure directly in the
pci_iov_add_virtfn().

Signed-off-by: Po Liu <po.liu@nxp.com>
---
 drivers/pci/iov.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 2194b44..e30f05c 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -136,7 +136,10 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id, int reset)
 	virtfn->devfn = pci_iov_virtfn_devfn(dev, id);
 	virtfn->vendor = dev->vendor;
 	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_DID, &virtfn->device);
-	pci_setup_device(virtfn);
+	rc = pci_setup_device(virtfn);
+	if (rc)
+		goto failed0;
+
 	virtfn->dev.parent = dev->dev.parent;
 	virtfn->physfn = pci_dev_get(dev);
 	virtfn->is_virtfn = 1;
-- 
2.1.0.27.g96db324
