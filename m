From: cdall@linaro.org (Christoffer Dall)
Date: Fri, 27 Oct 2017 10:34:34 +0200
Subject: [PATCH v5 13/20] KVM: arm/arm64: Set VCPU affinity for virt timer irq
In-Reply-To: <1509093281-15225-1-git-send-email-cdall@linaro.org>
References: <1509093281-15225-1-git-send-email-cdall@linaro.org>
Message-ID: <1509093281-15225-14-git-send-email-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we are about to take physical interrupts for the virtual timer on the
host but want to leave those active while running the VM (and let the VM
deactivate them), we need to set the vtimer PPI affinity accordingly.

Signed-off-by: Christoffer Dall <cdall@linaro.org>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/arch_timer.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 93c8973..eac1b3d 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -649,11 +649,20 @@ int kvm_timer_hyp_init(void)
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
2.7.4
