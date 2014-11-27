From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 27 Nov 2014 19:40:56 +0100
Subject: [PATCH 1/5] arm/arm64: KVM: Correct KVM_ARM_VCPU_INIT power off option
In-Reply-To: <1417113660-23610-1-git-send-email-christoffer.dall@linaro.org>
References: <1417113660-23610-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1417113660-23610-2-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The implementation of KVM_ARM_VCPU_INIT is currently not doing what
userspace expects, namely making sure that a vcpu which may have been
turned off using PSCI is returned to its initial state, which would be
powered on if userspace does not set the KVM_ARM_VCPU_POWER_OFF flag.

Implment the expected functionality and clarify the ABI.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 Documentation/virtual/kvm/api.txt | 3 ++-
 arch/arm/kvm/arm.c                | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 7610eaa..bb82a90 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2455,7 +2455,8 @@ should be created before this ioctl is invoked.
 
 Possible features:
 	- KVM_ARM_VCPU_POWER_OFF: Starts the CPU in a power-off state.
-	  Depends on KVM_CAP_ARM_PSCI.
+	  Depends on KVM_CAP_ARM_PSCI.  If not set, the CPU will be powered on
+	  and execute guest code when KVM_RUN is called.
 	- KVM_ARM_VCPU_EL1_32BIT: Starts the CPU in a 32bit mode.
 	  Depends on KVM_CAP_ARM_EL1_32BIT (arm64 only).
 	- KVM_ARM_VCPU_PSCI_0_2: Emulate PSCI v0.2 for the CPU.
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 9e193c8..4dcc8c2 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -663,6 +663,8 @@ static int kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu *vcpu,
 	 */
 	if (__test_and_clear_bit(KVM_ARM_VCPU_POWER_OFF, vcpu->arch.features))
 		vcpu->arch.pause = true;
+	else
+		vcpu->arch.pause = false;
 
 	return 0;
 }
-- 
2.1.2.330.g565301e.dirty
