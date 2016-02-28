From: mst@redhat.com (Michael S. Tsirkin)
Date: Sun, 28 Feb 2016 17:32:07 +0200
Subject: [PATCH for-4.5] arm/kvm: fix ioctl error handling
Message-ID: <1456673397-23625-1-git-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Calling return copy_to_user(...) in an ioctl will not
do the right thing if there's a pagefault:
copy_to_user returns the number of bytes not copied
in this case.

Fix up kvm to do
	return copy_to_user(...)) ?  -EFAULT : 0;

everywhere.

Cc: stable at vger.kernel.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Compiled only.

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
MST
