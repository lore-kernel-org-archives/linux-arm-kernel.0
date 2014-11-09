From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Sun,  9 Nov 2014 23:10:28 +0800
Subject: [RFC Part4 v1 06/17] genirq: Introduce callback
 irq_chip.irq_write_msi_msg
In-Reply-To: <1415545839-28263-1-git-send-email-jiang.liu@linux.intel.com>
References: <1415545839-28263-1-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <1415545839-28263-7-git-send-email-jiang.liu@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce callback irq_chip.irq_write_msi_msg, so we could share common
code among MSI alike interrupt controllers, such as HPET and DMAR.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 include/linux/irq.h |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 041edd6dc409..99aea9925b21 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -326,6 +326,7 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
  * @irq_release_resources:	optional to release resources acquired with
  *				irq_request_resources
  * @irq_compose_msi_msg:	optional to compose message content for MSI
+ * @irq_write_msi_msg:	optional to write message content for MSI
  * @flags:		chip specific flags
  */
 struct irq_chip {
@@ -363,6 +364,7 @@ struct irq_chip {
 	void		(*irq_release_resources)(struct irq_data *data);
 
 	void		(*irq_compose_msi_msg)(struct irq_data *data, struct msi_msg *msg);
+	void		(*irq_write_msi_msg)(struct irq_data *data, struct msi_msg *msg);
 
 	unsigned long	flags;
 };
@@ -457,6 +459,12 @@ extern void irq_chip_ack_parent(struct irq_data *data);
 extern int irq_chip_retrigger_hierarchy(struct irq_data *data);
 #endif
 
+static inline void irq_chip_write_msi_msg(struct irq_data *data,
+					  struct msi_msg *msg)
+{
+	data->chip->irq_write_msi_msg(data, msg);
+}
+
 /* Handling of unhandled and spurious interrupts: */
 extern void note_interrupt(unsigned int irq, struct irq_desc *desc,
 			   irqreturn_t action_ret);
-- 
1.7.10.4
