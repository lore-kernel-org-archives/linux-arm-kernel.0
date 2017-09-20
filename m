From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Wed, 20 Sep 2017 13:38:20 +0530
Subject: [PATCH 2/4] irqchip/gic-v3-its-platform-msi: Handle return value of
 kasprintf
In-Reply-To: <1505894901-9403-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1505894901-9403-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1505894901-9403-3-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kasprintf() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/irqchip/irq-gic-v3-its-platform-msi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
index 833a90f..a731f82 100644
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -126,6 +126,9 @@ static int __init its_pmsi_init_one(struct fwnode_handle *fwnode,
 	its_entry = (struct acpi_madt_generic_translator *)header;
 	node_name = kasprintf(GFP_KERNEL, "ITS at 0x%lx",
 			      (long)its_entry->base_address);
+	if (!node_name)
+		return -ENOMEM;
+
 	domain_handle = iort_find_domain_token(its_entry->translation_id);
 	if (!domain_handle) {
 		pr_err("%s: Unable to locate ITS domain handle\n", node_name);
-- 
1.9.1
