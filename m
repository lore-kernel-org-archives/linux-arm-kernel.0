From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 29 Nov 2017 17:41:10 +0100
Subject: [PATCH v2 10/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_translate
In-Reply-To: <20171129164116.16167-1-christoffer.dall@linaro.org>
References: <20171129164116.16167-1-christoffer.dall@linaro.org>
Message-ID: <20171129164116.16167-11-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move vcpu_load() and vcpu_put() into the architecture specific
implementations of kvm_arch_vcpu_ioctl_translate().

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/powerpc/kvm/booke.c | 2 ++
 arch/x86/kvm/x86.c       | 3 +++
 virt/kvm/kvm_main.c      | 2 --
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index cdf0be0..1b491b8 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1793,7 +1793,9 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 {
 	int r;
 
+	vcpu_load(vcpu);
 	r = kvmppc_core_vcpu_translate(vcpu, tr);
+	vcpu_put(vcpu);
 	return r;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ee357b6..eb70974 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7661,6 +7661,8 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 	gpa_t gpa;
 	int idx;
 
+	vcpu_load(vcpu);
+
 	idx = srcu_read_lock(&vcpu->kvm->srcu);
 	gpa = kvm_mmu_gva_to_gpa_system(vcpu, vaddr, NULL);
 	srcu_read_unlock(&vcpu->kvm->srcu, idx);
@@ -7669,6 +7671,7 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 	tr->writeable = 1;
 	tr->usermode = 0;
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f360005..0a8a490 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2627,9 +2627,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -EFAULT;
 		if (copy_from_user(&tr, argp, sizeof(tr)))
 			goto out;
-		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_translate(vcpu, &tr);
-		vcpu_put(vcpu);
 		if (r)
 			goto out;
 		r = -EFAULT;
-- 
2.7.4
