From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 27 Sep 2016 20:05:36 +0200
Subject: [PULL 28/50] arm: KVM: Add HYP async abort handler
In-Reply-To: <20160927180558.14699-1-christoffer.dall@linaro.org>
References: <20160927180558.14699-1-christoffer.dall@linaro.org>
Message-ID: <20160927180558.14699-29-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

If we've exited the guest because it has triggered an asynchronous
abort, a possible course of action is to let it know it screwed up
by giving it a Virtual Abort to chew on.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/handle_exit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/kvm/handle_exit.c b/arch/arm/kvm/handle_exit.c
index 3f1ef0d..863fdf4 100644
--- a/arch/arm/kvm/handle_exit.c
+++ b/arch/arm/kvm/handle_exit.c
@@ -160,6 +160,9 @@ int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		exit_handler = kvm_get_exit_handler(vcpu);
 
 		return exit_handler(vcpu, run);
+	case ARM_EXCEPTION_DATA_ABORT:
+		kvm_inject_vabt(vcpu);
+		return 1;
 	default:
 		kvm_pr_unimpl("Unsupported exception type: %d",
 			      exception_index);
-- 
2.9.0
