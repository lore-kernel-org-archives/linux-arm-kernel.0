From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 23 Feb 2017 10:26:56 +0000
Subject: [PATCH v2 21/22] arm/arm64: KVM: Use HVC_RESET_VECTORS to reinit HYP
 mode
In-Reply-To: <20170223102657.23100-1-marc.zyngier@arm.com>
References: <20170223102657.23100-1-marc.zyngier@arm.com>
Message-ID: <20170223102657.23100-22-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of trying to compare the value given by __hyp_get_vectors(),
which doesn't offer any real guarantee to be the stub's address, use
HVC_RESET_VECTORS to make sure we're in a sane state to reinstall
KVM across PM events.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/arm.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 7c3abeb49554..c4be9e0400f2 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -53,7 +53,6 @@ __asm__(".arch_extension	virt");
 
 static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
 static kvm_cpu_context_t __percpu *kvm_host_cpu_state;
-static unsigned long hyp_default_vectors;
 
 /* Per-CPU variable containing the currently running vcpu. */
 static DEFINE_PER_CPU(struct kvm_vcpu *, kvm_arm_running_vcpu);
@@ -1105,8 +1104,16 @@ static void cpu_init_hyp_mode(void *dummy)
 	kvm_arm_init_debug();
 }
 
+static void cpu_hyp_reset(void)
+{
+	if (!is_kernel_in_hyp_mode())
+		__hyp_reset_vectors();
+}
+
 static void cpu_hyp_reinit(void)
 {
+	cpu_hyp_reset();
+
 	if (is_kernel_in_hyp_mode()) {
 		/*
 		 * __cpu_init_stage2() is safe to call even if the PM
@@ -1114,17 +1121,10 @@ static void cpu_hyp_reinit(void)
 		 */
 		__cpu_init_stage2();
 	} else {
-		if (__hyp_get_vectors() == hyp_default_vectors)
-			cpu_init_hyp_mode(NULL);
+		cpu_init_hyp_mode(NULL);
 	}
 }
 
-static void cpu_hyp_reset(void)
-{
-	if (!is_kernel_in_hyp_mode())
-		__hyp_reset_vectors();
-}
-
 static void _kvm_arch_hardware_enable(void *discard)
 {
 	if (!__this_cpu_read(kvm_arm_hardware_enabled)) {
@@ -1308,12 +1308,6 @@ static int init_hyp_mode(void)
 		goto out_err;
 
 	/*
-	 * It is probably enough to obtain the default on one
-	 * CPU. It's unlikely to be different on the others.
-	 */
-	hyp_default_vectors = __hyp_get_vectors();
-
-	/*
 	 * Allocate stack pages for Hypervisor-mode
 	 */
 	for_each_possible_cpu(cpu) {
-- 
2.11.0
