From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 28 Dec 2013 11:15:40 +0000
Subject: [PATCH 08/15] arm/arm64: kvm: Set vcpu->cpu to -1 on vcpu_put
In-Reply-To: <1388229347-24185-1-git-send-email-marc.zyngier@arm.com>
References: <1388229347-24185-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1388229347-24185-9-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

The arch-generic KVM code expects the cpu field of a vcpu to be -1 if
the vcpu is no longer assigned to a cpu.  This is used for the optimized
make_all_cpus_request path and will be used by the vgic code to check
that no vcpus are running.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/arm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index f290b22..b92ff6d3 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -342,6 +342,13 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 {
+	/*
+	 * The arch-generic KVM code expects the cpu field of a vcpu to be -1
+	 * if the vcpu is no longer assigned to a cpu.  This is used for the
+	 * optimized make_all_cpus_request path.
+	 */
+	vcpu->cpu = -1;
+
 	kvm_arm_set_running_vcpu(NULL);
 }
 
-- 
1.8.5.1
