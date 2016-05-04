From: eric.auger@linaro.org (Eric Auger)
Date: Wed,  4 May 2016 15:18:11 +0000
Subject: [PATCH v9 5/8] genirq/irq: introduce msi_doorbell_info
In-Reply-To: <1462375094-2390-1-git-send-email-eric.auger@linaro.org>
References: <1462375094-2390-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1462375094-2390-6-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The purpose is to be able to retrieve the MSI doorbells of an irqchip.
This is now needed since on some platforms those doorbells must be
iommu mapped (in case the MSIs transit through an IOMMU that do not
bypass those transactions).

The assumption is there is a maximum of one doorbell region per cpu.
Sometimes a single doorbell is supported, hence the union.

A doorbell region is characterized by its physical address base, size and
IOMMU protection flag. Those 2 last characteristics are shared among all
doorbells.

irq_chip msi_doorbell_info callback enables to retrieve the doorbells of
the irqchip.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---
v8 -> v9:
- use a union and doorbell_is_percpu boolean

v7 -> v8:
- size and prot now are shared among all doorbells
- doorbells now directly points to a percpu phys_addr_t

v7: creation
---
 include/linux/irq.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index c4de623..4b4e479 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -312,6 +312,17 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
 	return d->hwirq;
 }
 
+/* Describe all the MSI doorbell regions for an irqchip */
+struct irq_chip_msi_doorbell_info {
+	union {
+		phys_addr_t __percpu *percpu_doorbells;
+		phys_addr_t global_doorbell;
+	};
+	bool doorbell_is_percpu;
+	size_t size;	/* size of a each doorbell */
+	int prot;	/* iommu protection flag */
+};
+
 /**
  * struct irq_chip - hardware interrupt chip descriptor
  *
@@ -349,6 +360,7 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
  * @irq_get_irqchip_state:	return the internal state of an interrupt
  * @irq_set_irqchip_state:	set the internal state of a interrupt
  * @irq_set_vcpu_affinity:	optional to target a vCPU in a virtual machine
+ * @msi_doorbell_info:	return the MSI doorbell info
  * @ipi_send_single:	send a single IPI to destination cpus
  * @ipi_send_mask:	send an IPI to destination cpus in cpumask
  * @flags:		chip specific flags
@@ -394,7 +406,8 @@ struct irq_chip {
 	int		(*irq_set_irqchip_state)(struct irq_data *data, enum irqchip_irq_state which, bool state);
 
 	int		(*irq_set_vcpu_affinity)(struct irq_data *data, void *vcpu_info);
-
+	struct irq_chip_msi_doorbell_info *(*msi_doorbell_info)(
+							struct irq_data *data);
 	void		(*ipi_send_single)(struct irq_data *data, unsigned int cpu);
 	void		(*ipi_send_mask)(struct irq_data *data, const struct cpumask *dest);
 
-- 
1.9.1
