From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 16 Sep 2015 11:41:10 +0100
Subject: [PATCH] arm64: KVM: Fix user access for debug registers
Message-ID: <1442400070-23316-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When setting the debug register from userspace, make sure that
copy_from_user() is called with its parameters in the expected
order. It otherwise doesn't do what you think.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Cc: Alex Benn?e <alex.bennee@linaro.org>
Fixes: 84e690bfbed1 ("KVM: arm64: introduce vcpu->arch.debug_ptr")
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/sys_regs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index b41607d..1d0463e 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -272,7 +272,7 @@ static int set_bvr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 {
 	__u64 *r = &vcpu->arch.vcpu_debug_state.dbg_bvr[rd->reg];
 
-	if (copy_from_user(uaddr, r, KVM_REG_SIZE(reg->id)) != 0)
+	if (copy_from_user(r, uaddr, KVM_REG_SIZE(reg->id)) != 0)
 		return -EFAULT;
 	return 0;
 }
@@ -314,7 +314,7 @@ static int set_bcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 {
 	__u64 *r = &vcpu->arch.vcpu_debug_state.dbg_bcr[rd->reg];
 
-	if (copy_from_user(uaddr, r, KVM_REG_SIZE(reg->id)) != 0)
+	if (copy_from_user(r, uaddr, KVM_REG_SIZE(reg->id)) != 0)
 		return -EFAULT;
 
 	return 0;
@@ -358,7 +358,7 @@ static int set_wvr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 {
 	__u64 *r = &vcpu->arch.vcpu_debug_state.dbg_wvr[rd->reg];
 
-	if (copy_from_user(uaddr, r, KVM_REG_SIZE(reg->id)) != 0)
+	if (copy_from_user(r, uaddr, KVM_REG_SIZE(reg->id)) != 0)
 		return -EFAULT;
 	return 0;
 }
@@ -400,7 +400,7 @@ static int set_wcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 {
 	__u64 *r = &vcpu->arch.vcpu_debug_state.dbg_wcr[rd->reg];
 
-	if (copy_from_user(uaddr, r, KVM_REG_SIZE(reg->id)) != 0)
+	if (copy_from_user(r, uaddr, KVM_REG_SIZE(reg->id)) != 0)
 		return -EFAULT;
 	return 0;
 }
-- 
2.1.4
