From: cdall@kernel.org (Christoffer Dall)
Date: Tue, 27 Feb 2018 12:34:03 +0100
Subject: [PATCH v5 14/40] KVM: arm64: Remove kern_hyp_va() use in VHE switch
 function
In-Reply-To: <20180227113429.637-1-cdall@kernel.org>
References: <20180227113429.637-1-cdall@kernel.org>
Message-ID: <20180227113429.637-15-cdall@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

VHE kernels run completely in EL2 and therefore don't have a notion of
kernel and hyp addresses, they are all just kernel addresses.  Therefore
don't call kern_hyp_va() in the VHE switch function.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/kvm/hyp/switch.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 1b94ac6a85e6..1e26a81c0a16 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -370,9 +370,7 @@ int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 	bool fp_enabled;
 	u64 exit_code;
 
-	vcpu = kern_hyp_va(vcpu);
-
-	host_ctxt = kern_hyp_va(vcpu->arch.host_cpu_context);
+	host_ctxt = vcpu->arch.host_cpu_context;
 	host_ctxt->__hyp_running_vcpu = vcpu;
 	guest_ctxt = &vcpu->arch.ctxt;
 
-- 
2.14.2
