From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  6 Sep 2016 14:02:06 +0100
Subject: [PATCH 08/19] arm64: KVM: Inject a Virtual SError if it was pending
In-Reply-To: <1473166937-15271-1-git-send-email-marc.zyngier@arm.com>
References: <1473166937-15271-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1473166937-15271-9-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we have caught an SError whilst exiting, we've tagged the
exit code with the pending information. In that case, let's
re-inject the error into the guest, after having adjusted
the PC if required.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/handle_exit.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 08afc69a..a204adf 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -170,6 +170,26 @@ int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 {
 	exit_handle_fn exit_handler;
 
+	if (ARM_SERROR_PENDING(exception_index)) {
+		u8 hsr_ec = ESR_ELx_EC(kvm_vcpu_get_hsr(vcpu));
+
+		/*
+		 * HVC/SMC already have an adjusted PC, which we need
+		 * to correct in order to return to after having
+		 * injected the SError.
+		 */
+		if (hsr_ec == ESR_ELx_EC_HVC32 || hsr_ec == ESR_ELx_EC_HVC64 ||
+		    hsr_ec == ESR_ELx_EC_SMC32 || hsr_ec == ESR_ELx_EC_SMC64) {
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
2.1.4
