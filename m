From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 26 Oct 2016 18:41:48 +0100
Subject: [PATCH v2 8/8] KVM: arm/arm64: Enable selective trapping of TLB
 instructions
In-Reply-To: <20161026174148.17172-1-punit.agrawal@arm.com>
References: <20161026174148.17172-1-punit.agrawal@arm.com>
Message-ID: <20161026174148.17172-9-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The TTLB bit of Hypervisor Control Register controls the trapping of
guest TLB maintenance instructions. Taking the trap requires a switch to
the hypervisor and is an expensive operation.

Enable selective trapping of guest TLB instructions when the associated
perf trace event is enabled for a specific virtual machine.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/perf_trace.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/virt/kvm/arm/perf_trace.c b/virt/kvm/arm/perf_trace.c
index 1cafbc9..649ca55 100644
--- a/virt/kvm/arm/perf_trace.c
+++ b/virt/kvm/arm/perf_trace.c
@@ -17,6 +17,8 @@
 #include <linux/kvm_host.h>
 #include <linux/trace_events.h>
 
+#include <asm/kvm_emulate.h>
+
 typedef int (*perf_trace_callback_fn)(struct kvm *kvm, bool enable);
 
 struct kvm_trace_hook {
@@ -24,7 +26,37 @@ struct kvm_trace_hook {
 	perf_trace_callback_fn setup_fn;
 };
 
+static int tlb_invalidate_trap(struct kvm *kvm, bool enable)
+{
+	int i;
+	struct kvm_vcpu *vcpu;
+
+	/*
+	 * Halt the VM to ensure atomic update across all vcpus (this
+	 * avoids racy behaviour against other modifications of
+	 * HCR_EL2 such as kvm_toggle_cache/kvm_set_way_flush).
+	 */
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
+
+	return 0;
+}
+
 static struct kvm_trace_hook trace_hook[] = {
+	{
+		.key = "kvm_tlb_invalidate",
+		.setup_fn = tlb_invalidate_trap,
+	},
 	{ },
 };
 
-- 
2.9.3
