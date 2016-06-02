From: tn@semihalf.com (Tomasz Nowicki)
Date: Thu,  2 Jun 2016 10:41:02 +0200
Subject: [RFC PATCH 2/3] arm64,
 pci: Start using quirks handling for ACPI based PCI host controller.
In-Reply-To: <1464856864-18049-1-git-send-email-tn@semihalf.com>
References: <1464856864-18049-1-git-send-email-tn@semihalf.com>
Message-ID: <1464856864-18049-3-git-send-email-tn@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
index 39f2a40..3a83c28 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -140,6 +140,7 @@ static int pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root,
 	struct resource cfgres;
 	unsigned int bsz;
 	int err;
+	struct pci_ecam_ops *ops;
 
 	err = pci_mcfg_lookup(root);
 	if (err) {
@@ -147,12 +148,12 @@ static int pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root,
 		return err;
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
 		pr_err("%04x:%pR error %ld mapping CAM\n", seg, bus_res,
 		       PTR_ERR(cfg));
-- 
1.9.1
