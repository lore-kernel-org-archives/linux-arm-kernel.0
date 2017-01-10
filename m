From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 10 Jan 2017 11:38:54 +0000
Subject: [PATCH v3 7/9] kvm: host_pmu: Add support for tracking guest TLB
 operations
In-Reply-To: <20170110113856.7183-1-punit.agrawal@arm.com>
References: <20170110113856.7183-1-punit.agrawal@arm.com>
Message-ID: <20170110113856.7183-8-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the callbacks required by host PMU to support monitoring guest TLB
operations.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/host_pmu.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/virt/kvm/arm/host_pmu.c b/virt/kvm/arm/host_pmu.c
index fc610ccc169a..22c3aef17ec4 100644
--- a/virt/kvm/arm/host_pmu.c
+++ b/virt/kvm/arm/host_pmu.c
@@ -13,6 +13,7 @@
 #include <asm/kvm_emulate.h>
 
 enum host_pmu_events {
+	tlb_invalidate,
 	KVM_HOST_MAX_EVENTS,
 };
 
@@ -40,10 +41,59 @@ struct event_data {
 	struct list_head event_list;
 };
 
+static u64 get_tlb_invalidate_count(struct kvm *kvm)
+{
+	struct kvm_vcpu *vcpu;
+	u64 val = 0;
+	int i;
+
+	kvm_for_each_vcpu(i, vcpu, kvm)
+		val += vcpu->stat.tlb_invalidate;
+
+	return val;
+}
+
+static void configure_tlb_invalidate(struct kvm *kvm, bool enable)
+{
+	struct kvm_vcpu *vcpu;
+	int i;
+
+	kvm_arm_halt_guest(kvm);
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		unsigned long hcr = vcpu_get_hcr(vcpu);
+
+		if (enable)
+			hcr |= HCR_TTLB;
+		else
+			hcr &= ~HCR_TTLB;
+
+		vcpu_set_hcr(vcpu, hcr);
+	}
+	kvm_arm_resume_guest(kvm);
+}
+
 static struct kvm_event_cb event_callbacks[] = {
+	{
+		.event			= tlb_invalidate,
+		.get_event_count	= get_tlb_invalidate_count,
+		.configure_event	= configure_tlb_invalidate,
+	}
 };
 
+static ssize_t events_sysfs_show(struct device *dev,
+				 struct device_attribute *attr, char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+
+	return sprintf(page, "event=0x%03llx,vm=?\n", pmu_attr->id);
+}
+PMU_EVENT_ATTR(tlb_invalidate, event_attr_tlb_invalidate, tlb_invalidate,
+	       events_sysfs_show);
+
 static struct attribute *event_attrs[] = {
+	&event_attr_tlb_invalidate.attr.attr,
 	NULL,
 };
 
-- 
2.11.0
