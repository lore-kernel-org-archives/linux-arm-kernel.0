From: tn@semihalf.com (Tomasz Nowicki)
Date: Thu,  4 Feb 2016 18:28:54 +0100
Subject: [PATCH V4 16/23] x86, acpi,
 pci: Use equivalent function from mcfg.c driver.
In-Reply-To: <1454606941-9523-1-git-send-email-tn@semihalf.com>
References: <1454606941-9523-1-git-send-email-tn@semihalf.com>
Message-ID: <1454606941-9523-17-git-send-email-tn@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since mcfg.c driver provides the same function lets use it and remove
code duplication.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Tested-by: Duc Dang <dhdang@apm.com>
Tested-by: Dongdong Liu <liudongdong3@huawei.com>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
Tested-by: Sinan Kaya <okaya@codeaurora.org>
---
 arch/x86/pci/acpi.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index d5086d1..b4e72b5 100644
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
