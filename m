From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 27 Sep 2016 20:05:44 +0200
Subject: [PULL 36/50] KVM: ARM: cleanup kvm_timer_hyp_init
In-Reply-To: <20160927180558.14699-1-christoffer.dall@linaro.org>
References: <20160927180558.14699-1-christoffer.dall@linaro.org>
Message-ID: <20160927180558.14699-37-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Paolo Bonzini <pbonzini@redhat.com>

Remove two unnecessary labels now that kvm_timer_hyp_init is not
creating its own workqueue anymore.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/arch_timer.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 4309b60..27a1f63 100644
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
2.9.0
