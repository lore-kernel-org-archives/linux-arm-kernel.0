From: tn@semihalf.com (Tomasz Nowicki)
Date: Tue, 27 Oct 2015 17:38:39 +0100
Subject: [PATCH V1 08/11] pci, acpi,
 ecam: Add flag to indicate whether ECAM region was hot added or not.
In-Reply-To: <1445963922-22711-1-git-send-email-tn@semihalf.com>
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
Message-ID: <1445963922-22711-9-git-send-email-tn@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two ways we can get ECAM (aka MCFG) regions using ACPI,
from MCFG static table and from _CBA method. We cannot remove static
regions, however regions coming from _CBA should be removed while removing
bridge device.

In the light of above we need flag to mark hot added ECAM entries
so that user should use pci_mmconfig_inject while adding regions from
_CBA method.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/pci/ecam.c   | 2 ++
 include/linux/ecam.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
index 8a5eef7..da35b4c 100644
--- a/drivers/pci/ecam.c
+++ b/drivers/pci/ecam.c
@@ -131,6 +131,7 @@ struct pci_mmcfg_region *pci_mmconfig_alloc(int segment, int start,
 	new->segment = segment;
 	new->start_bus = start;
 	new->end_bus = end;
+	new->hot_added = false;
 
 	res = &new->res;
 	res->start = addr + PCI_MMCFG_BUS_OFFSET(start);
@@ -221,6 +222,7 @@ int pci_mmconfig_inject(struct pci_mmcfg_region *cfg)
 		err = -ENOMEM;
 		goto out;
 	} else {
+		cfg->hot_added = true;
 		list_add_sorted(cfg);
 		pr_info("MMCONFIG at %pR (base %#lx)\n",
 			&cfg->res, (unsigned long)cfg->address);
diff --git a/include/linux/ecam.h b/include/linux/ecam.h
index 813acd1..e0f322e 100644
--- a/include/linux/ecam.h
+++ b/include/linux/ecam.h
@@ -17,6 +17,7 @@ struct pci_mmcfg_region {
 	u8 start_bus;
 	u8 end_bus;
 	char name[PCI_MMCFG_RESOURCE_NAME_LEN];
+	bool hot_added;
 };
 
 struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus);
-- 
1.9.1
