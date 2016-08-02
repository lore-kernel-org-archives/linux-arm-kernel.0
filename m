From: eric.auger@redhat.com (Eric Auger)
Date: Tue,  2 Aug 2016 17:23:29 +0000
Subject: [PATCH v12 03/11] genirq: Introduce irq_get_msi_doorbell_info
In-Reply-To: <1470158617-7022-1-git-send-email-eric.auger@redhat.com>
References: <1470158617-7022-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1470158617-7022-4-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Auger <eric.auger@linaro.org>

The purpose is to be able to retrieve the MSI doorbells of an irqchip.
This is now needed since on some platforms those doorbells must be
iommu mapped (in case the MSIs transit through an IOMMU that do not
bypass those transactions).

The assumption is there is a maximum of one doorbell region per cpu. The
doorbell can be global or per cpu.

A doorbell region is characterized by its physical address base, size,
IOMMU protection flag and whether it implements IRQ remapping (aka.
IRQ translation). Those characteristics are shared among all doorbells.

irq_get_msi_doorbell_info callback enables to retrieve the doorbells of
the irqchip.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---
v11 -> v12:
- remove tail comments and do proper kernel doc ones
- align struct members
- rename msi_doorbell_info into irq_get_msi_doorbell_info
- remove line break

v10 -> v11:
- disappeared in V10 and restored now. struct irq_chip_msi_doorbell_info
  is identifical to the one in V10 (union, irq_remapping field).

v7 -> v8:
- size and prot now are shared among all doorbells
- doorbells now directly points to a percpu phys_addr_t

v7: creation
---
 include/linux/irq.h | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 4d758a7..27a6cd0 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -313,6 +313,26 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
 }
 
 /**
+ * struct msi_doorbell_info - MSI doorbell region descriptor
+ * @percpu_doorbells: per cpu doorbell base address
+ * @global_doorbell: base address of the doorbell
+ * @doorbell_is_percpu: is the doorbell per cpu or global?
+ * @irq_remapping: is irq_remapping implemented?
+ * @size: size of the doorbell
+ * @prot: iommu protection flag
+ */
+struct msi_doorbell_info {
+	union {
+		phys_addr_t __percpu	*percpu_doorbells;
+		phys_addr_t		global_doorbell;
+	};
+	bool	doorbell_is_percpu;
+	bool	irq_remapping;
+	size_t	size;
+	int	prot;
+};
+
+/**
  * struct irq_chip - hardware interrupt chip descriptor
  *
  * @name:		name for /proc/interrupts
@@ -349,6 +369,7 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
  * @irq_get_irqchip_state:	return the internal state of an interrupt
  * @irq_set_irqchip_state:	set the internal state of a interrupt
  * @irq_set_vcpu_affinity:	optional to target a vCPU in a virtual machine
+ * @irq_get_msi_doorbell_info:	return the MSI doorbell info
  * @ipi_send_single:	send a single IPI to destination cpus
  * @ipi_send_mask:	send an IPI to destination cpus in cpumask
  * @flags:		chip specific flags
@@ -394,7 +415,7 @@ struct irq_chip {
 	int		(*irq_set_irqchip_state)(struct irq_data *data, enum irqchip_irq_state which, bool state);
 
 	int		(*irq_set_vcpu_affinity)(struct irq_data *data, void *vcpu_info);
-
+	struct msi_doorbell_info *(*irq_get_msi_doorbell_info)(struct irq_data *data);
 	void		(*ipi_send_single)(struct irq_data *data, unsigned int cpu);
 	void		(*ipi_send_mask)(struct irq_data *data, const struct cpumask *dest);
 
-- 
1.9.1
