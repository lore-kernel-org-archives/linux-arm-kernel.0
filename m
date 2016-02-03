From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  3 Feb 2016 18:00:09 +0000
Subject: [PATCH v3 16/23] arm64: KVM: VHE: Use unified sysreg accessors for
 timer
In-Reply-To: <1454522416-6874-1-git-send-email-marc.zyngier@arm.com>
References: <1454522416-6874-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1454522416-6874-17-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch the timer code to the unified sysreg accessors.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp/timer-sr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/hyp/timer-sr.c b/arch/arm64/kvm/hyp/timer-sr.c
index 1051e5d..f276d9e 100644
--- a/arch/arm64/kvm/hyp/timer-sr.c
+++ b/arch/arm64/kvm/hyp/timer-sr.c
@@ -31,12 +31,12 @@ void __hyp_text __timer_save_state(struct kvm_vcpu *vcpu)
 	u64 val;
 
 	if (kvm->arch.timer.enabled) {
-		timer->cntv_ctl = read_sysreg(cntv_ctl_el0);
-		timer->cntv_cval = read_sysreg(cntv_cval_el0);
+		timer->cntv_ctl = read_sysreg_el0(cntv_ctl);
+		timer->cntv_cval = read_sysreg_el0(cntv_cval);
 	}
 
 	/* Disable the virtual timer */
-	write_sysreg(0, cntv_ctl_el0);
+	write_sysreg_el0(0, cntv_ctl);
 
 	/* Allow physical timer/counter access for the host */
 	val = read_sysreg(cnthctl_el2);
@@ -64,8 +64,8 @@ void __hyp_text __timer_restore_state(struct kvm_vcpu *vcpu)
 
 	if (kvm->arch.timer.enabled) {
 		write_sysreg(kvm->arch.timer.cntvoff, cntvoff_el2);
-		write_sysreg(timer->cntv_cval, cntv_cval_el0);
+		write_sysreg_el0(timer->cntv_cval, cntv_cval);
 		isb();
-		write_sysreg(timer->cntv_ctl, cntv_ctl_el0);
+		write_sysreg_el0(timer->cntv_ctl, cntv_ctl);
 	}
 }
-- 
2.1.4
