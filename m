From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed,  3 Dec 2014 22:18:37 +0100
Subject: [PATCH v2 1/6] arm/arm64: KVM: Don't clear the VCPU_POWER_OFF flag
In-Reply-To: <1417641522-29056-1-git-send-email-christoffer.dall@linaro.org>
References: <1417641522-29056-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1417641522-29056-2-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a VCPU was originally started with power off (typically to be brought
up by PSCI in SMP configurations), there is no need to clear the
POWER_OFF flag in the kernel, as this flag is only tested during the
init ioctl itself.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 9e193c8..b160bea 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -661,7 +661,7 @@ static int kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu *vcpu,
 	/*
 	 * Handle the "start in power-off" case by marking the VCPU as paused.
 	 */
-	if (__test_and_clear_bit(KVM_ARM_VCPU_POWER_OFF, vcpu->arch.features))
+	if (test_bit(KVM_ARM_VCPU_POWER_OFF, vcpu->arch.features))
 		vcpu->arch.pause = true;
 
 	return 0;
-- 
2.1.2.330.g565301e.dirty
