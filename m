From: jglauber@cavium.com (Jan Glauber)
Date: Thu, 17 Aug 2017 10:14:23 +0200
Subject: [PATCH v2 3/3] vfio/pci: Don't probe devices that can't be reset
In-Reply-To: <1502957663-5527-1-git-send-email-jglauber@cavium.com>
References: <1502957663-5527-1-git-send-email-jglauber@cavium.com>
Message-ID: <1502957663-5527-4-git-send-email-jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a PCI device supports neither function-level reset, nor slot
or bus reset then refuse to probe it. A line is printed to inform
the user.

Without this change starting qemu with a vfio-pci device can lead to
a kernel panic on some Cavium cn8xxx systems, depending on the used
device.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/vfio/pci/vfio_pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 063c1ce..029ba13 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -1196,6 +1196,12 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (pdev->hdr_type != PCI_HEADER_TYPE_NORMAL)
 		return -EINVAL;
 
+	ret = pci_probe_reset_bus(pdev->bus);
+	if (ret) {
+		dev_warn(&pdev->dev, "Refusing to probe because reset is not possible.\n");
+		return ret;
+	}
+
 	group = vfio_iommu_group_get(&pdev->dev);
 	if (!group)
 		return -EINVAL;
-- 
2.9.0.rc0.21.g7777322
