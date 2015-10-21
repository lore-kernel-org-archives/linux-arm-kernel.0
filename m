From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Wed, 21 Oct 2015 11:47:26 -0700
Subject: [PATCH V3 3/6] irqdomain: introduce is_fwnode_irqchip helper
In-Reply-To: <1445453249-32557-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1445453249-32557-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1445453249-32557-4-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since there will be several places checking if fwnode.type
is equal FWNODE_IRQCHIP, this patch adds a convenient function
for this purpose.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 drivers/irqchip/irq-gic.c | 2 +-
 include/linux/irqdomain.h | 5 +++++
 kernel/irq/irqdomain.c    | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 1d0e768..6685b33 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -939,7 +939,7 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 		return 0;
 	}
 
-	if (fwspec->fwnode->type == FWNODE_IRQCHIP) {
+	if (is_fwnode_irqchip(fwspec->fwnode)) {
 		if(fwspec->param_count != 2)
 			return -EINVAL;
 
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index d5e5c5b..4950a71 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -211,6 +211,11 @@ static inline struct fwnode_handle *of_node_to_fwnode(struct device_node *node)
 	return node ? &node->fwnode : NULL;
 }
 
+static inline bool is_fwnode_irqchip(struct fwnode_handle *fwnode)
+{
+	return fwnode && fwnode->type == FWNODE_IRQCHIP;
+}
+
 static inline struct irq_domain *irq_find_matching_host(struct device_node *node,
 							enum irq_domain_bus_token bus_token)
 {
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 22aa961..7f34d98 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -70,7 +70,7 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnode)
 {
 	struct irqchip_fwid *fwid;
 
-	if (WARN_ON(fwnode->type != FWNODE_IRQCHIP))
+	if (WARN_ON(!is_fwnode_irqchip(fwnode)))
 		return;
 
 	fwid = container_of(fwnode, struct irqchip_fwid, fwnode);
-- 
2.1.0
