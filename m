From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Tue, 6 Nov 2018 14:11:01 +0530
Subject: [RFC PATCH v3 09/13] genirq/msi: Add support for .msi_unprepare
 callback
In-Reply-To: <20181106084105.32483-1-lokeshvutla@ti.com>
References: <20181106084105.32483-1-lokeshvutla@ti.com>
Message-ID: <20181106084105.32483-10-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an optional callback .msi_unprepare to struct msi_domain_ops.
This is used to clear any effect that is done by .msi_prepare callback.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Changes since v2:
- New patch

 include/linux/msi.h |  3 +++
 kernel/irq/msi.c    | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 021f789226b5..1e37aa569a3c 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -237,6 +237,8 @@ struct msi_domain_ops {
 	int		(*msi_prepare)(struct irq_domain *domain,
 				       struct device *dev, int nvec,
 				       msi_alloc_info_t *arg);
+	void		(*msi_unprepare)(struct irq_domain *domain, int nvec,
+					 void *data);
 	void		(*msi_finish)(msi_alloc_info_t *arg, int retval);
 	void		(*set_desc)(msi_alloc_info_t *arg,
 				    struct msi_desc *desc);
@@ -317,6 +319,7 @@ void platform_msi_domain_free_irqs(struct device *dev);
 /* When an MSI domain is used as an intermediate domain */
 int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
 			    int nvec, msi_alloc_info_t *args);
+void msi_domain_unprepare_irqs(struct irq_domain *domain, int nvec, void *data);
 int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
 			     int virq, int nvec, msi_alloc_info_t *args);
 struct irq_domain *
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index e37238317fab..87ce5a5d0c6d 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -312,6 +312,16 @@ int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
 	return ret;
 }
 
+void msi_domain_unprepare_irqs(struct irq_domain *domain, int nvec,
+			       void *data)
+{
+	struct msi_domain_info *info = domain->host_data;
+	struct msi_domain_ops *ops = info->ops;
+
+	if (ops->msi_unprepare)
+		ops->msi_unprepare(domain, nvec, data);
+}
+
 int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
 			     int virq, int nvec, msi_alloc_info_t *arg)
 {
-- 
2.19.1
