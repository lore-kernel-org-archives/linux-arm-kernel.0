From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 16 Dec 2013 21:29:57 -0800
Subject: [PATCH v5 06/10] arm/arm64: kvm: Set vcpu->cpu to -1 on vcpu_put
In-Reply-To: <1387258201-8738-1-git-send-email-christoffer.dall@linaro.org>
References: <1387258201-8738-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1387258201-8738-7-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arch-generic KVM code expects the cpu field of a vcpu to be -1 if
the vcpu is no longer assigned to a cpu.  This is used for the optimized
make_all_cpus_request path and will be used by the vgic code to check
that no vcpus are running.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/arm.c | 7 +++++++
 1 file changed, 7 insertions(+)

Changelog[v4]:
 - New in series

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
1.8.5
