From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:09:25 +0200
Subject: [PULL 75/79] KVM: arm/arm64: fix races in kvm_psci_vcpu_on
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-76-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Jones <drjones@redhat.com>

Fix potential races in kvm_psci_vcpu_on() by taking the kvm->lock
mutex.  In general, it's a bad idea to allow more than one PSCI_CPU_ON
to process the same target VCPU at the same time.  One such problem
that may arise is that one PSCI_CPU_ON could be resetting the target
vcpu, which fills the entire sys_regs array with a temporary value
including the MPIDR register, while another looks up the VCPU based
on the MPIDR value, resulting in no target VCPU found.  Resolves both
races found with the kvm-unit-tests/arm/psci unit test.

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Christoffer Dall <cdall@linaro.org>
Reported-by: Levente Kurusa <lkurusa@redhat.com>
Suggested-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Andrew Jones <drjones@redhat.com>
Cc: stable at vger.kernel.org
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 arch/arm/kvm/psci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index c2b1315..a08d7a9 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -208,9 +208,10 @@ int kvm_psci_version(struct kvm_vcpu *vcpu)
 
 static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
 {
-	int ret = 1;
+	struct kvm *kvm = vcpu->kvm;
 	unsigned long psci_fn = vcpu_get_reg(vcpu, 0) & ~((u32) 0);
 	unsigned long val;
+	int ret = 1;
 
 	switch (psci_fn) {
 	case PSCI_0_2_FN_PSCI_VERSION:
@@ -230,7 +231,9 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
 		break;
 	case PSCI_0_2_FN_CPU_ON:
 	case PSCI_0_2_FN64_CPU_ON:
+		mutex_lock(&kvm->lock);
 		val = kvm_psci_vcpu_on(vcpu);
+		mutex_unlock(&kvm->lock);
 		break;
 	case PSCI_0_2_FN_AFFINITY_INFO:
 	case PSCI_0_2_FN64_AFFINITY_INFO:
@@ -279,6 +282,7 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
 
 static int kvm_psci_0_1_call(struct kvm_vcpu *vcpu)
 {
+	struct kvm *kvm = vcpu->kvm;
 	unsigned long psci_fn = vcpu_get_reg(vcpu, 0) & ~((u32) 0);
 	unsigned long val;
 
@@ -288,7 +292,9 @@ static int kvm_psci_0_1_call(struct kvm_vcpu *vcpu)
 		val = PSCI_RET_SUCCESS;
 		break;
 	case KVM_PSCI_FN_CPU_ON:
+		mutex_lock(&kvm->lock);
 		val = kvm_psci_vcpu_on(vcpu);
+		mutex_unlock(&kvm->lock);
 		break;
 	default:
 		val = PSCI_RET_NOT_SUPPORTED;
-- 
2.9.0
