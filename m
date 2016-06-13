From: liudongdong3@huawei.com (Dongdong Liu)
Date: Mon, 13 Jun 2016 21:02:03 +0800
Subject: [RFC PATCH V2 2/2] ARM64/PCI: Start using quirks handling for ACPI
 based PCI host controller
In-Reply-To: <1465822923-33599-1-git-send-email-liudongdong3@huawei.com>
References: <1465822923-33599-1-git-send-email-liudongdong3@huawei.com>
Message-ID: <1465822923-33599-3-git-send-email-liudongdong3@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomasz Nowicki <tn@semihalf.com>

pci_generic_ecam_ops is used by default. Since there are platforms
which have non-compliant ECAM space we need to overwrite these
accessors prior to PCI buses enumeration. In order to do that
we call pci_mcfg_get_ops to retrieve pci_ecam_ops structure so that
we can use proper PCI config space accessors and bus_shift.

pci_generic_ecam_ops is still used for platforms free from quirks.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 arch/arm64/kernel/pci.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 94cd43c..a891bda 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -139,6 +139,7 @@ pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
 	struct pci_config_window *cfg;
 	struct resource cfgres;
 	unsigned int bsz;
+	struct pci_ecam_ops *ops;
 
 	/* Use address from _CBA if present, otherwise lookup MCFG */
 	if (!root->mcfg_addr)
@@ -150,12 +151,12 @@ pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
 		return NULL;
 	}
 
-	bsz = 1 << pci_generic_ecam_ops.bus_shift;
+	ops = pci_mcfg_get_ops(root);
+	bsz = 1 << ops->bus_shift;
 	cfgres.start = root->mcfg_addr + bus_res->start * bsz;
 	cfgres.end = cfgres.start + resource_size(bus_res) * bsz - 1;
 	cfgres.flags = IORESOURCE_MEM;
-	cfg = pci_ecam_create(&root->device->dev, &cfgres, bus_res,
-			      &pci_generic_ecam_ops);
+	cfg = pci_ecam_create(&root->device->dev, &cfgres, bus_res, ops);
 	if (IS_ERR(cfg)) {
 		dev_err(&root->device->dev, "%04x:%pR error %ld mapping ECAM\n",
 			seg, bus_res, PTR_ERR(cfg));
-- 
1.9.1
