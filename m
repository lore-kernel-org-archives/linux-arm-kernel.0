From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  2 Mar 2016 09:27:29 +0000
Subject: [PATCH] arm/arm64: KVM: Fix ioctl error handling
In-Reply-To: <1456910849-16049-1-git-send-email-marc.zyngier@arm.com>
References: <1456910849-16049-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1456910849-16049-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Michael S. Tsirkin" <mst@redhat.com>

Calling return copy_to_user(...) in an ioctl will not
do the right thing if there's a pagefault:
copy_to_user returns the number of bytes not copied
in this case.

Fix up kvm to do
	return copy_to_user(...)) ?  -EFAULT : 0;

everywhere.

Cc: stable at vger.kernel.org
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/guest.c   | 2 +-
 arch/arm64/kvm/guest.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
index 5fa69d7..99361f1 100644
--- a/arch/arm/kvm/guest.c
+++ b/arch/arm/kvm/guest.c
@@ -161,7 +161,7 @@ static int get_timer_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	u64 val;
 
 	val = kvm_arm_timer_get_reg(vcpu, reg->id);
-	return copy_to_user(uaddr, &val, KVM_REG_SIZE(reg->id));
+	return copy_to_user(uaddr, &val, KVM_REG_SIZE(reg->id)) ? -EFAULT : 0;
 }
 
 static unsigned long num_core_regs(void)
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index fcb7788..9e54ad7 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -194,7 +194,7 @@ static int get_timer_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	u64 val;
 
 	val = kvm_arm_timer_get_reg(vcpu, reg->id);
-	return copy_to_user(uaddr, &val, KVM_REG_SIZE(reg->id));
+	return copy_to_user(uaddr, &val, KVM_REG_SIZE(reg->id)) ? -EFAULT : 0;
 }
 
 /**
-- 
2.1.4
