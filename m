From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Wed, 20 Sep 2017 13:38:19 +0530
Subject: [PATCH 1/4] irqchip/gic-v3-its: Handle return value of kasprintf
In-Reply-To: <1505894901-9403-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1505894901-9403-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1505894901-9403-2-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kasprintf() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index 14a8c0a..f703069 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -158,6 +158,9 @@ static int __init its_pci_of_msi_init(void)
 	its_entry = (struct acpi_madt_generic_translator *)header;
 	node_name = kasprintf(GFP_KERNEL, "ITS at 0x%lx",
 			      (long)its_entry->base_address);
+	if (!node_name)
+		return -ENOMEM;
+
 	dom_handle = iort_find_domain_token(its_entry->translation_id);
 	if (!dom_handle) {
 		pr_err("%s: Unable to locate ITS domain handle\n", node_name);
-- 
1.9.1
