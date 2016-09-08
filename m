From: pbonzini@redhat.com (Paolo Bonzini)
Date: Thu,  8 Sep 2016 12:45:59 +0200
Subject: [PATCH] KVM: ARM: cleanup kvm_timer_hyp_init
Message-ID: <1473331560-3103-1-git-send-email-pbonzini@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove two unnecessary labels now that kvm_timer_hyp_init is not
creating its own workqueue anymore.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virt/kvm/arm/arch_timer.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 4309b60ebf17..27a1f6341d41 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -445,7 +445,7 @@ int kvm_timer_hyp_init(void)
 	if (err) {
 		kvm_err("kvm_arch_timer: can't request interrupt %d (%d)\n",
 			host_vtimer_irq, err);
-		goto out;
+		return err;
 	}
 
 	kvm_info("virtual timer IRQ%d\n", host_vtimer_irq);
@@ -453,10 +453,6 @@ int kvm_timer_hyp_init(void)
 	cpuhp_setup_state(CPUHP_AP_KVM_ARM_TIMER_STARTING,
 			  "AP_KVM_ARM_TIMER_STARTING", kvm_timer_starting_cpu,
 			  kvm_timer_dying_cpu);
-	goto out;
-out_free:
-	free_percpu_irq(host_vtimer_irq, kvm_get_running_vcpus());
-out:
 	return err;
 }
 
-- 
1.8.3.1
