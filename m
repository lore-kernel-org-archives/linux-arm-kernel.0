From: tn@semihalf.com (Tomasz Nowicki)
Date: Tue, 27 Oct 2015 17:38:40 +0100
Subject: [PATCH V1 09/11] x86,
 pci: Use previously added ECAM hot_added flag to remove ECAM regions.
In-Reply-To: <1445963922-22711-1-git-send-email-tn@semihalf.com>
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
Message-ID: <1445963922-22711-10-git-send-email-tn@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have hot_added flag we can get rid of arch specific mcfg_added.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 arch/x86/pci/acpi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 28c9cd6..b4ef761 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -13,7 +13,6 @@ struct pci_root_info {
 	struct acpi_pci_root_info common;
 	struct pci_sysdata sd;
 #ifdef	CONFIG_PCI_MMCONFIG
-	bool mcfg_added;
 	u8 start_bus;
 	u8 end_bus;
 #endif
@@ -188,7 +187,6 @@ static int setup_mcfg_map(struct acpi_pci_root_info *ci)
 	info = container_of(ci, struct pci_root_info, common);
 	info->start_bus = (u8)root->secondary.start;
 	info->end_bus = (u8)root->secondary.end;
-	info->mcfg_added = false;
 	seg = info->sd.domain;
 
 	/* return success if MMCFG is not in use */
@@ -204,7 +202,6 @@ static int setup_mcfg_map(struct acpi_pci_root_info *ci)
 		/* enable MMCFG if it hasn't been enabled yet */
 		if (raw_pci_ext_ops == NULL)
 			raw_pci_ext_ops = &pci_mmcfg;
-		info->mcfg_added = true;
 	} else if (result != -EEXIST)
 		return check_segment(seg, dev,
 			 "fail to add MMCONFIG information,");
@@ -214,14 +211,17 @@ static int setup_mcfg_map(struct acpi_pci_root_info *ci)
 
 static void teardown_mcfg_map(struct acpi_pci_root_info *ci)
 {
+	struct pci_mmcfg_region *cfg;
 	struct pci_root_info *info;
 
 	info = container_of(ci, struct pci_root_info, common);
-	if (info->mcfg_added) {
-		pci_mmconfig_delete(info->sd.domain,
-				    info->start_bus, info->end_bus);
-		info->mcfg_added = false;
-	}
+	cfg = pci_mmconfig_lookup(info->sd.domain, info->start_bus);
+	if (!cfg)
+		return;
+
+	if (cfg->hot_added)
+		pci_mmconfig_delete(info->sd.domain, info->start_bus,
+				    info->end_bus);
 }
 #else
 static int setup_mcfg_map(struct acpi_pci_root_info *ci)
-- 
1.9.1
