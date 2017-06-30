From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 30 Jun 2017 09:44:33 +0100
Subject: [PATCH 17/58] KVM: arm/arm64: timer: remove request-less vcpu kick
In-Reply-To: <20170630084514.6779-1-marc.zyngier@arm.com>
References: <20170630084514.6779-1-marc.zyngier@arm.com>
Message-ID: <20170630084514.6779-18-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Jones <drjones@redhat.com>

The timer work is only scheduled for a VCPU when that VCPU is
blocked. This means we only need to wake it up, not kick (IPI)
it. While calling kvm_vcpu_kick() would just do the wake up,
and not kick, anyway, let's change this to avoid request-less
vcpu kicks, as they're generally not a good idea (see
"Request-less VCPU Kicks" in
Documentation/virtual/kvm/vcpu-requests.rst)

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 virt/kvm/arm/arch_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 5976609ef27c..7933b1f8f7b7 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -95,7 +95,7 @@ static void kvm_timer_inject_irq_work(struct work_struct *work)
 	 * If the vcpu is blocked we want to wake it up so that it will see
 	 * the timer has expired when entering the guest.
 	 */
-	kvm_vcpu_kick(vcpu);
+	kvm_vcpu_wake_up(vcpu);
 }
 
 static u64 kvm_timer_compute_delta(struct arch_timer_context *timer_ctx)
-- 
2.11.0
