From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 26 Sep 2014 15:16:39 +0200
Subject: [PATCH 06/27] KVM: ARM/arm64: return -EFAULT if copy_from_user fails
 in set_timer_reg
In-Reply-To: <1411737420-9063-1-git-send-email-christoffer.dall@linaro.org>
References: <1411737420-9063-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1411737420-9063-7-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

We currently return the number of bytes not copied if set_timer_reg
fails, which is almost certainly not what userspace would like.

This patch returns -EFAULT instead.

Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/guest.c   | 2 +-
 arch/arm64/kvm/guest.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
index 813e492..cc0b787 100644
--- a/arch/arm/kvm/guest.c
+++ b/arch/arm/kvm/guest.c
@@ -163,7 +163,7 @@ static int set_timer_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 
 	ret = copy_from_user(&val, uaddr, KVM_REG_SIZE(reg->id));
 	if (ret != 0)
-		return ret;
+		return -EFAULT;
 
 	return kvm_arm_timer_set_reg(vcpu, reg->id, val);
 }
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 8d1ec28..7679469 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -174,7 +174,7 @@ static int set_timer_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 
 	ret = copy_from_user(&val, uaddr, KVM_REG_SIZE(reg->id));
 	if (ret != 0)
-		return ret;
+		return -EFAULT;
 
 	return kvm_arm_timer_set_reg(vcpu, reg->id, val);
 }
-- 
2.0.0
