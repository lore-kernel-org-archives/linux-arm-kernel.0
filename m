From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  9 Aug 2012 16:53:49 +0100
Subject: [PATCH 2/8] irqdomain: Take interrupt-parent property into account if
 specified
In-Reply-To: <1344527635-6163-1-git-send-email-lee.jones@linaro.org>
References: <1344527635-6163-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1344527635-6163-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

irq_find_host() currently ignores the 'interrupt-parent' property
even if it's specified in the Device Tree. Meaning that a node can
match to a domain in its hierarchy even if it doesn't belong to it.
By searching for the parent first using of_irq_find_parent() we
insist that the 'interrupt-parent' property is taken into account
ensuring a greater chance of returning the correct domain.

CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 kernel/irq/irqdomain.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 49a7772..db63b9b 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/topology.h>
 #include <linux/seq_file.h>
@@ -323,8 +324,14 @@ EXPORT_SYMBOL_GPL(irq_domain_add_tree);
 struct irq_domain *irq_find_host(struct device_node *node)
 {
 	struct irq_domain *h, *found = NULL;
+	struct device_node *parent_node;
 	int rc;
 
+	/* Take heed if an 'interrupt-parent' was specified. */
+	parent_node = of_irq_find_parent(node);
+	if (parent_node)
+		node = parent_node;
+
 	/* We might want to match the legacy controller last since
 	 * it might potentially be set to match all interrupts in
 	 * the absence of a device node. This isn't a problem so far
-- 
1.7.9.5
