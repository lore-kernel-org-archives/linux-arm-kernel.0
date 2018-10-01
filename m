From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Mon,  1 Oct 2018 16:13:45 +0200
Subject: [PATCH v6 01/14] genirq/msi: Allow creation of a tree-based irqdomain
 for platform-msi
In-Reply-To: <20181001141358.31508-1-miquel.raynal@bootlin.com>
References: <20181001141358.31508-1-miquel.raynal@bootlin.com>
Message-ID: <20181001141358.31508-2-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

platform_msi_create_device_domain() always creates a revmap-based
irqdomain, which has the drawback of requiring the number of MSIs
that can be allocated ahead of time. This is not always possible,
and we sometimes need to use a tree-based irqdomain instead.

Add a new platform_msi_create_device_tree_domain() helper to
that effect.

Reported-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/base/platform-msi.c | 14 ++++++++------
 include/linux/msi.h         | 17 ++++++++++++-----
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 60d6cc618f1c..f39a920496fb 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -321,11 +321,12 @@ void *platform_msi_get_host_data(struct irq_domain *domain)
  * Returns an irqdomain for @nvec interrupts
  */
 struct irq_domain *
-platform_msi_create_device_domain(struct device *dev,
-				  unsigned int nvec,
-				  irq_write_msi_msg_t write_msi_msg,
-				  const struct irq_domain_ops *ops,
-				  void *host_data)
+__platform_msi_create_device_domain(struct device *dev,
+				    unsigned int nvec,
+				    bool is_tree,
+				    irq_write_msi_msg_t write_msi_msg,
+				    const struct irq_domain_ops *ops,
+				    void *host_data)
 {
 	struct platform_msi_priv_data *data;
 	struct irq_domain *domain;
@@ -336,7 +337,8 @@ platform_msi_create_device_domain(struct device *dev,
 		return NULL;
 
 	data->host_data = host_data;
-	domain = irq_domain_create_hierarchy(dev->msi_domain, 0, nvec,
+	domain = irq_domain_create_hierarchy(dev->msi_domain, 0,
+					     is_tree ? 0 : nvec,
 					     dev->fwnode, ops, data);
 	if (!domain)
 		goto free_priv;
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 5839d8062dfc..0e9c50052ff3 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -317,11 +317,18 @@ int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
 int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
 			     int virq, int nvec, msi_alloc_info_t *args);
 struct irq_domain *
-platform_msi_create_device_domain(struct device *dev,
-				  unsigned int nvec,
-				  irq_write_msi_msg_t write_msi_msg,
-				  const struct irq_domain_ops *ops,
-				  void *host_data);
+__platform_msi_create_device_domain(struct device *dev,
+				    unsigned int nvec,
+				    bool is_tree,
+				    irq_write_msi_msg_t write_msi_msg,
+				    const struct irq_domain_ops *ops,
+				    void *host_data);
+
+#define platform_msi_create_device_domain(dev, nvec, write, ops, data)	\
+	__platform_msi_create_device_domain(dev, nvec, false, write, ops, data)
+#define platform_msi_create_device_tree_domain(dev, nvec, write, ops, data) \
+	__platform_msi_create_device_domain(dev, nvec, true, write, ops, data)
+
 int platform_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 			      unsigned int nr_irqs);
 void platform_msi_domain_free(struct irq_domain *domain, unsigned int virq,
-- 
2.17.1
