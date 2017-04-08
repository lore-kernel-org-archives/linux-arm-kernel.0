From: okaya@codeaurora.org (Sinan Kaya)
Date: Sat,  8 Apr 2017 00:55:48 -0400
Subject: [PATCH V8 2/5] PCI/ASPM: split pci_aspm_init() into two
In-Reply-To: <1491627351-1111-1-git-send-email-okaya@codeaurora.org>
References: <1491627351-1111-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1491627351-1111-3-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Split pci_aspm_init() body into pci_aspm_init_upstream()
and pci_aspm_init_downstream() for bridge and endpoint
specific code behavior.

Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=194895
Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pcie/aspm.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index dc36717..a80d64b 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -826,6 +826,16 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
 	return link;
 }
 
+static int pci_aspm_init_downstream(struct pci_dev *pdev)
+{
+	return 0;
+}
+
+static int pci_aspm_init_upstream(struct pci_dev *pdev)
+{
+	return 0;
+}
+
 /*
  * pci_aspm_init: Initiate PCI express link state.
  * It is called from device_add for every single pci device.
@@ -833,7 +843,10 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
  */
 int pci_aspm_init(struct pci_dev *pdev)
 {
-	return 0;
+	if (!pdev->has_secondary_link)
+		return pci_aspm_init_downstream(pdev);
+
+	return pci_aspm_init_upstream(pdev);
 }
 
 /*
-- 
1.9.1
