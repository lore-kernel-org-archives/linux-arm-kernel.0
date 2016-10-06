From: eric.auger@redhat.com (Eric Auger)
Date: Thu,  6 Oct 2016 08:45:23 +0000
Subject: [PATCH v13 07/15] irqchip/gicv3-its: Register the MSI doorbell
In-Reply-To: <1475743531-4780-1-git-send-email-eric.auger@redhat.com>
References: <1475743531-4780-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1475743531-4780-8-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch registers the ITS global doorbell. Registered information
are needed to set up the KVM passthrough use case.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v12 -> v13:
- use new doorbell registration prototype

v11 -> v12:
- use new irq_get_msi_doorbell_info name
- simplify error handling

v10 -> v11:
- adapt to new doorbell registration API and implement msi_doorbell_info
---
 drivers/irqchip/irq-gic-v3-its.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 98ff669..3fc715e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -30,6 +30,7 @@
 #include <linux/of_platform.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
+#include <linux/msi-doorbell.h>
 
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic-v3.h>
@@ -86,6 +87,7 @@ struct its_node {
 	u32			ite_size;
 	u32			device_ids;
 	int			numa_node;
+	struct msi_doorbell_info	*doorbell_info;
 };
 
 #define ITS_ITT_ALIGN		SZ_256
@@ -1717,6 +1719,7 @@ static int __init its_probe(struct device_node *node,
 
 	if (of_property_read_bool(node, "msi-controller")) {
 		struct msi_domain_info *info;
+		phys_addr_t translater;
 
 		info = kzalloc(sizeof(*info), GFP_KERNEL);
 		if (!info) {
@@ -1724,10 +1727,21 @@ static int __init its_probe(struct device_node *node,
 			goto out_free_tables;
 		}
 
+		translater = its->phys_base + GITS_TRANSLATER;
+		err = msi_doorbell_register_global(translater, sizeof(u32),
+						   true, &its->doorbell_info);
+
+		if (err)  {
+			kfree(info);
+			goto out_free_tables;
+		}
+
+
 		inner_domain = irq_domain_add_tree(node, &its_domain_ops, its);
 		if (!inner_domain) {
 			err = -ENOMEM;
 			kfree(info);
+			msi_doorbell_unregister_global(its->doorbell_info);
 			goto out_free_tables;
 		}
 
-- 
1.9.1
