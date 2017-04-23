From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:09:13 +0200
Subject: [PULL 63/79] arm/arm64: KVM: Use HVC_RESET_VECTORS to reinit HYP mode
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-64-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Instead of trying to compare the value given by __hyp_get_vectors(),
which doesn't offer any real guarantee to be the stub's address, use
HVC_RESET_VECTORS to make sure we're in a sane state to reinstall
KVM across PM events.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 arch/arm/kvm/arm.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index c8f4fa6..c378502 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -53,7 +53,6 @@ __asm__(".arch_extension	virt");
 
 static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
 static kvm_cpu_context_t __percpu *kvm_host_cpu_state;
-static unsigned long hyp_default_vectors;
 
 /* Per-CPU variable containing the currently running vcpu. */
 static DEFINE_PER_CPU(struct kvm_vcpu *, kvm_arm_running_vcpu);
@@ -1113,8 +1112,16 @@ static void cpu_init_hyp_mode(void *dummy)
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
@@ -1122,17 +1129,10 @@ static void cpu_hyp_reinit(void)
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
@@ -1316,12 +1316,6 @@ static int init_hyp_mode(void)
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
2.9.0
