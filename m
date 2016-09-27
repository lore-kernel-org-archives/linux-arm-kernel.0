From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 27 Sep 2016 20:05:39 +0200
Subject: [PULL 31/50] arm: KVM: Inject a Virtual Abort if it was pending
In-Reply-To: <20160927180558.14699-1-christoffer.dall@linaro.org>
References: <20160927180558.14699-1-christoffer.dall@linaro.org>
Message-ID: <20160927180558.14699-32-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

If we have caught an Abort whilst exiting, we've tagged the
exit code with the pending information. In that case, let's
re-inject the error into the guest, after having adjusted
the PC if required.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/handle_exit.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/kvm/handle_exit.c b/arch/arm/kvm/handle_exit.c
index 863fdf4..4eacb5c 100644
--- a/arch/arm/kvm/handle_exit.c
+++ b/arch/arm/kvm/handle_exit.c
@@ -144,6 +144,25 @@ int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 {
 	exit_handle_fn exit_handler;
 
+	if (ARM_ABORT_PENDING(exception_index)) {
+		u8 hsr_ec = kvm_vcpu_trap_get_class(vcpu);
+
+		/*
+		 * HVC/SMC already have an adjusted PC, which we need
+		 * to correct in order to return to after having
+		 * injected the abort.
+		 */
+		if (hsr_ec == HSR_EC_HVC || hsr_ec == HSR_EC_SMC) {
+			u32 adj =  kvm_vcpu_trap_il_is32bit(vcpu) ? 4 : 2;
+			*vcpu_pc(vcpu) -= adj;
+		}
+
+		kvm_inject_vabt(vcpu);
+		return 1;
+	}
+
+	exception_index = ARM_EXCEPTION_CODE(exception_index);
+
 	switch (exception_index) {
 	case ARM_EXCEPTION_IRQ:
 		return 1;
-- 
2.9.0
