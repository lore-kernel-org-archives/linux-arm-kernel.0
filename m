From: tn@semihalf.com (Tomasz Nowicki)
Date: Wed, 16 Dec 2015 16:16:28 +0100
Subject: [PATCH V2 18/23] x86, acpi,
 pci: Use equivalent function introduced in previous patch.
In-Reply-To: <1450278993-12664-1-git-send-email-tn@semihalf.com>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
Message-ID: <1450278993-12664-19-git-send-email-tn@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 arch/x86/pci/acpi.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 5f78595..33233a7 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -201,29 +201,11 @@ static int setup_mcfg_map(struct acpi_pci_root_info *ci)
 
 	return 0;
 }
-
-static void teardown_mcfg_map(struct acpi_pci_root_info *ci)
-{
-	struct acpi_pci_root *root = ci->root;
-	struct pci_mmcfg_region *cfg;
-
-	cfg = pci_mmconfig_lookup(root->segment, root->secondary.start);
-	if (!cfg)
-		return;
-
-	if (cfg->hot_added)
-		pci_mmconfig_delete(root->segment, root->secondary.start,
-				    root->secondary.end);
-}
 #else
 static int setup_mcfg_map(struct acpi_pci_root_info *ci)
 {
 	return 0;
 }
-
-static void teardown_mcfg_map(struct acpi_pci_root_info *ci)
-{
-}
 #endif
 
 static int pci_acpi_root_get_node(struct acpi_pci_root *root)
@@ -251,7 +233,7 @@ static int pci_acpi_root_init_info(struct acpi_pci_root_info *ci)
 
 static void pci_acpi_root_release_info(struct acpi_pci_root_info *ci)
 {
-	teardown_mcfg_map(ci);
+	pci_mmcfg_teardown_map(ci);
 	kfree(container_of(ci, struct pci_root_info, common));
 }
 
-- 
1.9.1
