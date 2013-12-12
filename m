From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 12 Dec 2013 11:55:45 -0800
Subject: [PATCH 06/10] arm/arm64: kvm: Set vcpu->cpu to -1 on vcpu_put
In-Reply-To: <1386878149-13397-1-git-send-email-christoffer.dall@linaro.org>
References: <1386878149-13397-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1386878149-13397-7-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arch-generic KVM code expects the cpu field of a vcpu to be -1 if
the vcpu is no longer assigned to a cpu.  This is used for the optimized
make_all_cpus_request path and will be used by the vgic code to check
that no vcpus are running.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
Changelog[v4]:
 - New in series

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
1.8.4.3
