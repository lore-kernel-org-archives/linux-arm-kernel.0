From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  8 Sep 2016 15:58:44 +0200
Subject: [PATCH] KVM: arm/arm64: arch_timer: remove unused error handling
Message-ID: <20160908135908.1312349-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A cleanup removed the call to create_singlethread_workqueue(), but did not
remove the code that was used in case it failed:

virt/kvm/arm/arch_timer.c: In function 'kvm_timer_hyp_init':
virt/kvm/arm/arch_timer.c:457:1: error: label 'out_free' defined but not used [-Werror=unused-label]

This removes the now dead code too.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 3706feacd007 ("KVM: Remove deprecated create_singlethread_workqueue")
---
 virt/kvm/arm/arch_timer.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 4309b60ebf17..46980a49a3bb 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -453,9 +453,6 @@ int kvm_timer_hyp_init(void)
 	cpuhp_setup_state(CPUHP_AP_KVM_ARM_TIMER_STARTING,
 			  "AP_KVM_ARM_TIMER_STARTING", kvm_timer_starting_cpu,
 			  kvm_timer_dying_cpu);
-	goto out;
-out_free:
-	free_percpu_irq(host_vtimer_irq, kvm_get_running_vcpus());
 out:
 	return err;
 }
-- 
2.9.0
