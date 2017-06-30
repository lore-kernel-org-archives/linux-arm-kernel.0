From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 30 Jun 2017 09:45:12 +0100
Subject: [PATCH 56/58] KVM: ARM64: fix phy counter access failure in guest.
In-Reply-To: <20170630084514.6779-1-marc.zyngier@arm.com>
References: <20170630084514.6779-1-marc.zyngier@arm.com>
Message-ID: <20170630084514.6779-57-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hu Huajun <huhuajun@huawei.com>

When reading the cntpct_el0 in guest with VHE (Virtual Host Extension)
enabled in host, the "Unsupported guest sys_reg access" error reported.
The reason is cnthctl_el2.EL1PCTEN is not enabled, which is expected
to be done in kvm_timer_init_vhe(). The problem is kvm_timer_init_vhe
is called by cpu_init_hyp_mode, and which is called when VHE is disabled.
This patch remove the incorrect call to kvm_timer_init_vhe() from
cpu_init_hyp_mode(), and calls kvm_timer_init_vhe() to enable
cnthctl_el2.EL1PCTEN in cpu_hyp_reinit().

Fixes: 488f94d7212b ("KVM: arm64: Access CNTHCTL_EL2 bit fields correctly on VHE systems")
Cc: stable at vger.kernel.org
Signed-off-by: Hu Huajun <huhuajun@huawei.com>
Reviewed-by: Christoffer Dall <cdall@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 virt/kvm/arm/arm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index a265acc53e39..a39a1e161e63 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -1141,9 +1141,6 @@ static void cpu_init_hyp_mode(void *dummy)
 	__cpu_init_hyp_mode(pgd_ptr, hyp_stack_ptr, vector_ptr);
 	__cpu_init_stage2();
 
-	if (is_kernel_in_hyp_mode())
-		kvm_timer_init_vhe();
-
 	kvm_arm_init_debug();
 }
 
@@ -1163,6 +1160,7 @@ static void cpu_hyp_reinit(void)
 		 * event was cancelled before the CPU was reset.
 		 */
 		__cpu_init_stage2();
+		kvm_timer_init_vhe();
 	} else {
 		cpu_init_hyp_mode(NULL);
 	}
-- 
2.11.0
