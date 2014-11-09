From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Sun,  9 Nov 2014 23:10:26 +0800
Subject: [RFC Part4 v1 04/17] PCI/MSI: Replace msi_update_msg() with
 irq_chip_compose_msi_msg()
In-Reply-To: <1415545839-28263-1-git-send-email-jiang.liu@linux.intel.com>
References: <1415545839-28263-1-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <1415545839-28263-5-git-send-email-jiang.liu@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Function irq_chip_compose_msi_msg() can achieve the same goal as
msi_update_msg(), so kill msi_update_msg().

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/kernel/apic/msi.c |   25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 12919b3c6cf4..727e4254f124 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -53,31 +53,16 @@ static void msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
 		MSI_DATA_VECTOR(cfg->vector);
 }
 
-static void msi_update_msg(struct msi_msg *msg, struct irq_data *irq_data)
-{
-	struct irq_cfg *cfg = irqd_cfg(irq_data);
-
-	msg->data &= ~MSI_DATA_VECTOR_MASK;
-	msg->data |= MSI_DATA_VECTOR(cfg->vector);
-	msg->address_lo &= ~MSI_ADDR_DEST_ID_MASK;
-	msg->address_lo |= MSI_ADDR_DEST_ID(cfg->dest_apicid);
-	if (x2apic_enabled())
-		msg->address_hi = MSI_ADDR_BASE_HI |
-				  MSI_ADDR_EXT_DEST_ID(cfg->dest_apicid);
-}
-
 static int msi_set_affinity(struct irq_data *data, const struct cpumask *mask,
 			    bool force)
 {
 	struct irq_data *parent = data->parent_data;
+	struct msi_msg msg;
 	int ret;
 
 	ret = parent->chip->irq_set_affinity(parent, mask, force);
 	if (ret >= 0 && ret != IRQ_SET_MASK_OK_DONE) {
-		struct msi_msg msg;
-
-		__get_cached_msi_msg(data->msi_desc, &msg);
-		msi_update_msg(&msg, data);
+		irq_chip_compose_msi_msg(data, &msg);
 		__write_msi_msg(data->msi_desc, &msg);
 	}
 
@@ -179,8 +164,7 @@ dmar_msi_set_affinity(struct irq_data *data, const struct cpumask *mask,
 
 	ret = parent->chip->irq_set_affinity(parent, mask, force);
 	if (ret >= 0) {
-		dmar_msi_read(data->irq, &msg);
-		msi_update_msg(&msg, data);
+		irq_chip_compose_msi_msg(data, &msg);
 		dmar_msi_write(data->irq, &msg);
 	}
 
@@ -310,8 +294,7 @@ static int hpet_msi_set_affinity(struct irq_data *data,
 
 	ret = parent->chip->irq_set_affinity(parent, mask, force);
 	if (ret >= 0 && ret != IRQ_SET_MASK_OK_DONE) {
-		hpet_msi_read(data->handler_data, &msg);
-		msi_update_msg(&msg, data);
+		irq_chip_compose_msi_msg(data, &msg);
 		hpet_msi_write(data->handler_data, &msg);
 	}
 
-- 
1.7.10.4
