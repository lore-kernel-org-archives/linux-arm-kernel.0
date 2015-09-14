From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 14 Sep 2015 17:44:02 +0100
Subject: [PATCH v3 3/8] genirq: irqdomain: Allow a domain to be identified
 with non-DT data
In-Reply-To: <1442249047-21182-1-git-send-email-marc.zyngier@arm.com>
References: <1442249047-21182-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1442249047-21182-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that irqdomains are not directly tied to device nodes, let's
make sure that they can be identified by other types of data.

For this, we implement the method suggested in a previous patch,
where device_token is a small integer representing data stored
in an IDR.

We end-up with a bunch of functions to allocate/free a token,
retrieve the data associated to it, or even lookup a token
by data. Not all of it might prove to be necessary, but we can
probably drop some of them if they don't get enough traction.

With this, it is possible to uniquely indentify a irqdomain,
even without a device node.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/irqdomain.h |   5 ++
 kernel/irq/irqdomain.c    | 134 ++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 136 insertions(+), 3 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index ac7041b..ecd0b25 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -159,6 +159,11 @@ enum {
 	IRQ_DOMAIN_FLAG_NONCORE		= (1 << 16),
 };
 
+extern void *irq_domain_alloc_domain_token(void *data);
+extern void irq_domain_free_domain_token(void *domain_token);
+extern void *irq_domain_token_to_data(void *domain_token);
+extern void *irq_domain_find_domain_token(void *data);
+
 #ifdef CONFIG_IRQ_DOMAIN
 extern struct device_node *irq_domain_token_to_of_node(void *domain_token);
 
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index a00e0ce..619552a 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -2,6 +2,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/hardirq.h>
+#include <linux/idr.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdesc.h>
@@ -23,20 +24,147 @@ static DEFINE_MUTEX(irq_domain_mutex);
 
 static DEFINE_MUTEX(revmap_trees_mutex);
 static struct irq_domain *irq_default_domain;
+static DEFINE_IDR(irq_domain_idr);
 
 static int irq_domain_alloc_descs(int virq, unsigned int nr_irqs,
 				  irq_hw_number_t hwirq, int node);
 static void irq_domain_check_hierarchy(struct irq_domain *domain);
 
+/*
+ * We need to differenciate between a valid pointer (to a device_node)
+ * and a "small integer". For this, we encode a "type" in the bottom
+ * two bits:
+ *
+ * - device_node, being a pointer, has encoding 00 (and is left alone)
+ * - small integer is shifted by two bits to the left, and has encoding 01
+ *
+ * Encodings 10 and 11 are reserved.
+ */
+static bool irq_domain_check_of_node(void *domain_token)
+{
+	return (virt_addr_valid(domain_token) &&
+		IS_ALIGNED((unsigned long)domain_token,
+			   sizeof(unsigned long)));
+}
+
+static void *irq_domain_encode_id(int id)
+{
+	return (void *)(long)((id << 2) | 1);
+}
+
+static int irq_domain_decode_id(void *domain_token)
+{
+	int val = (long)domain_token;
+
+	WARN_ON((val & 3) != 1);
+	return val >> 2;
+}
+
+/**
+ * irq_domain_alloc_domain_token - Allocate a new domain_token
+ * @data: caller-specific data
+ *
+ * Allocate a "small integer" that can be used to identify an irqdomain.
+ * Returns this integer as a void *, or NULL on failure.
+ */
+void *irq_domain_alloc_domain_token(void *data)
+{
+	int id;
+
+	if (!data)
+		data = &irq_domain_idr;
+
+	/*
+	 * Reuse the global irqdomain mutex, as this should be called
+	 * in the same context. 2^24 - 1 domains should be enough for
+	 * everybody.
+	 */
+	mutex_lock(&irq_domain_mutex);
+	id = idr_alloc(&irq_domain_idr, data, 1, 0xffffff, GFP_KERNEL);
+	mutex_unlock(&irq_domain_mutex);
+
+	if (id < 0)
+		return NULL;
+
+	return irq_domain_encode_id(id);
+}
+
+/**
+ * irq_domain_free_domain_token - Free an existing domain_token
+ * @domain_token: A previously allocated domain token
+ *
+ * Free the "small integer" that was used to identify an irqdomain.
+ * @domain_token is not allowed to be NULL or a valid kernel address.
+ */
+void irq_domain_free_domain_token(void *domain_token)
+{
+	WARN_ON(!domain_token);
+	WARN_ON(irq_domain_check_of_node(domain_token));
+
+	mutex_lock(&irq_domain_mutex);
+	idr_remove(&irq_domain_idr, irq_domain_decode_id(domain_token));
+	mutex_unlock(&irq_domain_mutex);
+}
+
+/**
+ * irq_domain_token_to_data - Retrieve data associated with a domain_token
+ * @domain_token: An allocated domain token
+ *
+ * Returns the data previously associated with an irqdomain.
+ */
+void *irq_domain_token_to_data(void *domain_token)
+{
+	void *data;
+
+	WARN_ON(!domain_token);
+	WARN_ON(irq_domain_check_of_node(domain_token));
+
+	rcu_read_lock();
+	data = idr_find(&irq_domain_idr, irq_domain_decode_id(domain_token));
+	rcu_read_unlock();
+
+	if (data == &irq_domain_idr)
+		data = NULL;
+
+	return data;
+}
+
+static int __irq_domain_matches_id(int id, void *p, void *data)
+{
+	return (p == data) ? id : 0;
+}
+
+/**
+ * irq_domain_token_find_domain_token - Find a previously allocated domain_token
+ * @data: A unique pointer previously used to allocate a domain_token
+ *
+ * Returns the domain_token previously allocated with @data. Because
+ * this is an expensive operation, it should only be used when there
+ * is no practical way to retrieve the domain token itself. @data must
+ * have only been used to allocate a single domain_token.
+ */
+void *irq_domain_find_domain_token(void *data)
+{
+	int id;
+
+	mutex_lock(&irq_domain_mutex);
+	id = idr_for_each(&irq_domain_idr, __irq_domain_matches_id, data);
+	mutex_unlock(&irq_domain_mutex);
+
+	if (WARN_ON(id <= 0))
+		return NULL;
+
+	return irq_domain_encode_id(id);
+}
+
 struct device_node *irq_domain_token_to_of_node(void *domain_token)
 {
 	/*
 	 * Assume that anything represented by a valid kernel address
 	 * is a device_node. Anything else must be a "small integer",
-	 * and indirected by some other structure (an IDR, for
-	 * example) if a pointer is required.
+	 * and indirected via the irqdomain IDR layer.
 	 */
-	if (virt_addr_valid(domain_token))
+	if (irq_domain_check_of_node(domain_token))
 		return domain_token;
 
 	return NULL;
-- 
2.1.4
