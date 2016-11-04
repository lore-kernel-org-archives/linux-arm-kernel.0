From: andre.przywara@arm.com (Andre Przywara)
Date: Fri,  4 Nov 2016 17:32:00 +0000
Subject: [PATCH v8 13/16] arm: setup SPI IRQ routing tables
In-Reply-To: <20161104173203.21168-1-andre.przywara@arm.com>
References: <20161104173203.21168-1-andre.przywara@arm.com>
Message-ID: <20161104173203.21168-14-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we soon start using GSI routing on ARM platforms too, we have
to setup the initial SPI routing table. Before the first call to
KVM_SET_GSI_ROUTING, the kernel holds this table internally, but this
is overwritten with the ioctl, so we have to explicitly set it up
here.
The routing is actually not used for IRQs triggered by KVM_IRQ_LINE,
but it needs to be here anyway. We use a simple 1:1 mapping.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arm/gic.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arm/gic.c b/arm/gic.c
index 44f9365..c422e36 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -27,6 +27,8 @@
 #define KVM_VGIC_V3_ITS_SIZE (2 * SZ_64K)
 #endif
 
+#define IRQCHIP_GIC 0
+
 static int gic_fd = -1;
 static u64 gic_redists_base;
 static u64 gic_redists_size;
@@ -49,6 +51,34 @@ int irqchip_parser(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int irq__routing_init(struct kvm *kvm)
+{
+	int r;
+	int irqlines = ALIGN(irq__get_nr_allocated_lines(), 32);
+
+	/*
+	 * This describes the default routing that the kernel uses without
+	 * any routing explicitly set up via KVM_SET_GSI_ROUTING. So we
+	 * don't need to commit these setting right now. The first actual
+	 * user (MSI routing) will engage these mappings then.
+	 */
+	for (next_gsi = 0; next_gsi < irqlines; next_gsi++) {
+		r = irq__allocate_routing_entry();
+		if (r)
+			return r;
+
+		irq_routing->entries[irq_routing->nr++] =
+			(struct kvm_irq_routing_entry) {
+				.gsi = next_gsi,
+				.type = KVM_IRQ_ROUTING_IRQCHIP,
+				.u.irqchip.irqchip = IRQCHIP_GIC,
+				.u.irqchip.pin = next_gsi,
+		};
+	}
+
+	return 0;
+}
+
 static int gic__create_its_frame(struct kvm *kvm, u64 its_frame_addr)
 {
 	struct kvm_create_device its_device = {
@@ -255,6 +285,8 @@ static int gic__init_gic(struct kvm *kvm)
 			return ret;
 	}
 
+	irq__routing_init(kvm);
+
 	if (!ioctl(gic_fd, KVM_HAS_DEVICE_ATTR, &vgic_init_attr)) {
 		ret = ioctl(gic_fd, KVM_SET_DEVICE_ATTR, &vgic_init_attr);
 		if (ret)
-- 
2.9.0
