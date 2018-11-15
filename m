From: andrew.murray@arm.com (Andrew Murray)
Date: Thu, 15 Nov 2018 12:55:46 +0000
Subject: [PATCH 1/4] arm64: KVM: add accessors to track guest/host only
 counters
In-Reply-To: <1542286549-4501-1-git-send-email-andrew.murray@arm.com>
References: <1542286549-4501-1-git-send-email-andrew.murray@arm.com>
Message-ID: <1542286549-4501-2-git-send-email-andrew.murray@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to effeciently enable/disable guest/host only perf counters
at guest entry/exit we add bitfields to kvm_cpu_context for guest and
host only events as well as accessors for updating them.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/arm64/include/asm/kvm_host.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 1550192..b6f998b 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -203,6 +203,8 @@ struct kvm_cpu_context {
 	};
 
 	struct kvm_vcpu *__hyp_running_vcpu;
+	u32 events_host_only;
+	u32 events_guest_only;
 };
 
 typedef struct kvm_cpu_context kvm_cpu_context_t;
@@ -472,6 +474,24 @@ static inline int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
 {
 	return kvm_arch_vcpu_run_map_fp(vcpu);
 }
+static inline void kvm_set_clr_host_pmu_events(u32 clr, u32 set)
+{
+	kvm_cpu_context_t *ctx = this_cpu_ptr(&kvm_host_cpu_state);
+
+	ctx->events_host_only &= ~clr;
+	ctx->events_host_only |= set;
+}
+
+static inline void kvm_set_clr_guest_pmu_events(u32 clr, u32 set)
+{
+	kvm_cpu_context_t *ctx = this_cpu_ptr(&kvm_host_cpu_state);
+
+	ctx->events_guest_only &= ~clr;
+	ctx->events_guest_only |= set;
+}
+#else
+static inline void kvm_set_clr_host_pmu_events(u32 clr, u32 set) {}
+static inline void kvm_set_clr_guest_pmu_events(u32 clr, u32 set) {}
 #endif
 
 static inline void kvm_arm_vhe_guest_enter(void)
-- 
2.7.4
