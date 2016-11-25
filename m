From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 25 Nov 2016 19:39:16 +0000
Subject: [RFC PATCH 28/29] arm64: KVM: Treat SVE use by guests as undefined
 instruction execution
In-Reply-To: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
References: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1480102762-23647-29-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't currently support context-switching of Scalable Vector
Extension context between vcpus, and the SVE access exception is
thus left masked by default at EL2 when running a vcpu.

However, there's nothing to stop a guest trying to use SVE.  If it
does, we'll get an SVE access exception to EL2 which will cause KVM
to panic since this exception isn't yet recognised.

This patch adds knowledge to KVM about the SVE access exception,
translating it into an undefined instruction exception injected to
the vcpu.

This prevents a malicious guest from panicking the host by
attempted SVE use.

SVE-enabled guests will still not work properly for now, but they
won't take the host down.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kvm/handle_exit.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index a204adf..f43b6d0 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -125,6 +125,14 @@ static int kvm_handle_guest_debug(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	return ret;
 }
 
+static int handle_sve(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	/* Until SVE is supported for guests: */
+	kvm_inject_undefined(vcpu);
+
+	return 1;
+}
+
 static exit_handle_fn arm_exit_handlers[] = {
 	[ESR_ELx_EC_WFx]	= kvm_handle_wfx,
 	[ESR_ELx_EC_CP15_32]	= kvm_handle_cp15_32,
@@ -137,6 +145,7 @@ static exit_handle_fn arm_exit_handlers[] = {
 	[ESR_ELx_EC_HVC64]	= handle_hvc,
 	[ESR_ELx_EC_SMC64]	= handle_smc,
 	[ESR_ELx_EC_SYS64]	= kvm_handle_sys_reg,
+	[ESR_ELx_EC_SVE]	= handle_sve,
 	[ESR_ELx_EC_IABT_LOW]	= kvm_handle_guest_abort,
 	[ESR_ELx_EC_DABT_LOW]	= kvm_handle_guest_abort,
 	[ESR_ELx_EC_SOFTSTP_LOW]= kvm_handle_guest_debug,
-- 
2.1.4
