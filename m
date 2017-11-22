From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 22 Nov 2017 17:49:17 -0500
Subject: [PATCH V2 22/29] [media] atomisp: deprecate pci_get_bus_and_slot()
In-Reply-To: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
References: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1511390964-9979-23-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Getting ready to remove pci_get_bus_and_slot() function. Since ISP always
uses domain 0, hard-code it in the code when calling the replacement
function pci_get_domain_bus_and_slot().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/staging/media/atomisp/pci/atomisp2/atomisp_v4l2.c               | 2 +-
 drivers/staging/media/atomisp/platform/intel-mid/intel_mid_pcihelpers.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp2/atomisp_v4l2.c b/drivers/staging/media/atomisp/pci/atomisp2/atomisp_v4l2.c
index 663aa91..95b9c7a 100644
--- a/drivers/staging/media/atomisp/pci/atomisp2/atomisp_v4l2.c
+++ b/drivers/staging/media/atomisp/pci/atomisp2/atomisp_v4l2.c
@@ -1233,7 +1233,7 @@ static int atomisp_pci_probe(struct pci_dev *dev,
 	isp->pdev = dev;
 	isp->dev = &dev->dev;
 	isp->sw_contex.power_state = ATOM_ISP_POWER_UP;
-	isp->pci_root = pci_get_bus_and_slot(0, 0);
+	isp->pci_root = pci_get_domain_bus_and_slot(0, 0, 0);
 	if (!isp->pci_root) {
 		dev_err(&dev->dev, "Unable to find PCI host\n");
 		return -ENODEV;
diff --git a/drivers/staging/media/atomisp/platform/intel-mid/intel_mid_pcihelpers.c b/drivers/staging/media/atomisp/platform/intel-mid/intel_mid_pcihelpers.c
index 4631b1d..51dcef57 100644
--- a/drivers/staging/media/atomisp/platform/intel-mid/intel_mid_pcihelpers.c
+++ b/drivers/staging/media/atomisp/platform/intel-mid/intel_mid_pcihelpers.c
@@ -39,7 +39,7 @@ static inline int platform_is(u8 model)
 
 static int intel_mid_msgbus_init(void)
 {
-	pci_root = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0));
+	pci_root = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
 	if (!pci_root) {
 		pr_err("%s: Error: msgbus PCI handle NULL\n", __func__);
 		return -ENODEV;
-- 
1.9.1
