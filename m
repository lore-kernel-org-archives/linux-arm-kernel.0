From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 28 Sep 2018 14:39:07 +0100
Subject: [RFC PATCH v2 03/23] KVM: arm64: Refactor kvm_arm_num_regs() for
 easier maintenance
In-Reply-To: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
References: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1538141967-15375-4-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kvm_arm_num_regs() adds together various partial register counts in
a freeform sum expression, which makes it harder than necessary to
read diffs that add, modify or remove a single term in the sum
(which is expected to the common case under maintenance).

This patch refactors the code to add the term one per line, for
maximum readability.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
---
 arch/arm64/kvm/guest.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 07256b0..953a5c9 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -205,8 +205,14 @@ static int get_timer_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
  */
 unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu)
 {
-	return num_core_regs() + kvm_arm_num_sys_reg_descs(vcpu)
-		+ kvm_arm_get_fw_num_regs(vcpu)	+ NUM_TIMER_REGS;
+	unsigned long res = 0;
+
+	res += num_core_regs();
+	res += kvm_arm_num_sys_reg_descs(vcpu);
+	res += kvm_arm_get_fw_num_regs(vcpu);
+	res += NUM_TIMER_REGS;
+
+	return res;
 }
 
 /**
-- 
2.1.4
