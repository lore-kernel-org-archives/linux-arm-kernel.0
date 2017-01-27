From: jintack@cs.columbia.edu (Jintack Lim)
Date: Thu, 26 Jan 2017 20:05:00 -0500
Subject: [RFC v2 10/10] KVM: arm/arm64: Emulate the EL1 phys timer register
 access
In-Reply-To: <1485479100-4966-1-git-send-email-jintack@cs.columbia.edu>
References: <1485479100-4966-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1485479100-4966-11-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Emulate read and write operations to CNTP_TVAL, CNTP_CVAL and CNTP_CTL.
Now VMs are able to use the EL1 physical timer.

Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 arch/arm64/kvm/sys_regs.c    | 32 +++++++++++++++++++++++++++++---
 include/kvm/arm_arch_timer.h |  2 ++
 virt/kvm/arm/arch_timer.c    |  2 +-
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index fd9e747..adf009f 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -824,7 +824,14 @@ static bool access_cntp_tval(struct kvm_vcpu *vcpu,
 		struct sys_reg_params *p,
 		const struct sys_reg_desc *r)
 {
-	kvm_inject_undefined(vcpu);
+	struct arch_timer_context *ptimer = vcpu_ptimer(vcpu);
+	u64 now = kvm_phys_timer_read();
+
+	if (p->is_write)
+		ptimer->cnt_cval = p->regval + now;
+	else
+		p->regval = ptimer->cnt_cval - now;
+
 	return true;
 }
 
@@ -832,7 +839,20 @@ static bool access_cntp_ctl(struct kvm_vcpu *vcpu,
 		struct sys_reg_params *p,
 		const struct sys_reg_desc *r)
 {
-	kvm_inject_undefined(vcpu);
+	struct arch_timer_context *ptimer = vcpu_ptimer(vcpu);
+
+	if (p->is_write) {
+		/* ISTATUS bit is read-only */
+		ptimer->cnt_ctl = p->regval & ~ARCH_TIMER_CTRL_IT_STAT;
+	} else {
+		u64 now = kvm_phys_timer_read();
+
+		p->regval = ptimer->cnt_ctl;
+		/* Set ISTATUS bit if it's expired */
+		if (ptimer->cnt_cval <= now)
+			p->regval |= ARCH_TIMER_CTRL_IT_STAT;
+	}
+
 	return true;
 }
 
@@ -840,7 +860,13 @@ static bool access_cntp_cval(struct kvm_vcpu *vcpu,
 		struct sys_reg_params *p,
 		const struct sys_reg_desc *r)
 {
-	kvm_inject_undefined(vcpu);
+	struct arch_timer_context *ptimer = vcpu_ptimer(vcpu);
+
+	if (p->is_write)
+		ptimer->cnt_cval = p->regval;
+	else
+		p->regval = ptimer->cnt_cval;
+
 	return true;
 }
 
diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
index a364593..fec99f2 100644
--- a/include/kvm/arm_arch_timer.h
+++ b/include/kvm/arm_arch_timer.h
@@ -74,6 +74,8 @@ bool kvm_timer_should_fire(struct kvm_vcpu *vcpu,
 void kvm_timer_schedule(struct kvm_vcpu *vcpu);
 void kvm_timer_unschedule(struct kvm_vcpu *vcpu);
 
+u64 kvm_phys_timer_read(void);
+
 void kvm_timer_vcpu_put(struct kvm_vcpu *vcpu);
 
 void kvm_timer_init_vhe(void);
diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index b366bb2..9eec063 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -40,7 +40,7 @@ void kvm_timer_vcpu_put(struct kvm_vcpu *vcpu)
 	vcpu_vtimer(vcpu)->active_cleared_last = false;
 }
 
-static u64 kvm_phys_timer_read(void)
+u64 kvm_phys_timer_read(void)
 {
 	return timecounter->cc->read(timecounter->cc);
 }
-- 
1.9.1
