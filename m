From: cdall@linaro.org (Christoffer Dall)
Date: Sat, 23 Sep 2017 02:42:00 +0200
Subject: [PATCH v3 13/20] KVM: arm/arm64: Set VCPU affinity for virt timer irq
In-Reply-To: <20170923004207.22356-1-cdall@linaro.org>
References: <20170923004207.22356-1-cdall@linaro.org>
Message-ID: <20170923004207.22356-14-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we are about to take physical interrupts for the virtual timer on the
host but want to leave those active while running the VM (and let the VM
deactivate them), we need to set the vtimer PPI affinity accordingly.

Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 virt/kvm/arm/arch_timer.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 4254f88..4275f8f 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -650,11 +650,20 @@ int kvm_timer_hyp_init(void)
 		return err;
 	}
 
+	err = irq_set_vcpu_affinity(host_vtimer_irq, kvm_get_running_vcpus());
+	if (err) {
+		kvm_err("kvm_arch_timer: error setting vcpu affinity\n");
+		goto out_free_irq;
+	}
+
 	kvm_info("virtual timer IRQ%d\n", host_vtimer_irq);
 
 	cpuhp_setup_state(CPUHP_AP_KVM_ARM_TIMER_STARTING,
 			  "kvm/arm/timer:starting", kvm_timer_starting_cpu,
 			  kvm_timer_dying_cpu);
+	return 0;
+out_free_irq:
+	free_percpu_irq(host_vtimer_irq, kvm_get_running_vcpus());
 	return err;
 }
 
-- 
2.9.0
