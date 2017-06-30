From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 30 Jun 2017 09:44:28 +0100
Subject: [PATCH 12/58] KVM: arm/arm64: use vcpu requests for power_off
In-Reply-To: <20170630084514.6779-1-marc.zyngier@arm.com>
References: <20170630084514.6779-1-marc.zyngier@arm.com>
Message-ID: <20170630084514.6779-13-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Jones <drjones@redhat.com>

System shutdown is currently using request-less VCPU kicks. This
leaves open a tiny race window, as it doesn't ensure the state
change to power_off is seen by a VCPU just about to enter guest
mode. VCPU requests, OTOH, are guaranteed to be seen (see "Ensuring
Requests Are Seen" of Documentation/virtual/kvm/vcpu-requests.rst)
This patch applies the EXIT request used by pause to power_off,
fixing the race.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 virt/kvm/arm/psci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/arm/psci.c b/virt/kvm/arm/psci.c
index f68be2cc6256..f189d0ad30d5 100644
--- a/virt/kvm/arm/psci.c
+++ b/virt/kvm/arm/psci.c
@@ -179,10 +179,9 @@ static void kvm_prepare_system_event(struct kvm_vcpu *vcpu, u32 type)
 	 * after this call is handled and before the VCPUs have been
 	 * re-initialized.
 	 */
-	kvm_for_each_vcpu(i, tmp, vcpu->kvm) {
+	kvm_for_each_vcpu(i, tmp, vcpu->kvm)
 		tmp->arch.power_off = true;
-		kvm_vcpu_kick(tmp);
-	}
+	kvm_make_all_cpus_request(vcpu->kvm, KVM_REQ_VCPU_EXIT);
 
 	memset(&vcpu->run->system_event, 0, sizeof(vcpu->run->system_event));
 	vcpu->run->system_event.type = type;
-- 
2.11.0
