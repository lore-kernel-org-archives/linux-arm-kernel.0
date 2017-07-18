From: jintack.lim@linaro.org (Jintack Lim)
Date: Tue, 18 Jul 2017 11:58:35 -0500
Subject: [RFC PATCH v2 09/38] KVM: arm64: Add the shadow context for virtual
 EL2 execution
In-Reply-To: <1500397144-16232-1-git-send-email-jintack.lim@linaro.org>
References: <1500397144-16232-1-git-send-email-jintack.lim@linaro.org>
Message-ID: <1500397144-16232-10-git-send-email-jintack.lim@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the nested virtualization support, a hypervisor running inside a VM
(i.e. a guest hypervisor) is now deprivilaged and runs in EL1 instead of
EL2. So, the host hypervisor manages the shadow context for the virtual
EL2 execution.

Signed-off-by: Jintack Lim <jintack.lim@linaro.org>
---
 arch/arm64/include/asm/kvm_host.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 57dccde..46880c3 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -229,6 +229,19 @@ struct kvm_cpu_context {
 	};
 
 	u64 el2_special_regs[NR_EL2_SPECIAL_REGS];
+
+	u64 shadow_sys_regs[NR_SYS_REGS];  /* only used for virtual EL2 */
+
+	/*
+	 * hw_* will be written to the hardware when entering to a VM.
+	 * They have either the virtual EL2 or EL1/EL0 context depending
+	 * on the vcpu mode.
+	 */
+	u64 *hw_sys_regs;
+	u64 hw_sp_el1;
+	u64 hw_pstate;
+	u64 hw_elr_el1;
+	u64 hw_spsr_el1;
 };
 
 typedef struct kvm_cpu_context kvm_cpu_context_t;
-- 
1.9.1
