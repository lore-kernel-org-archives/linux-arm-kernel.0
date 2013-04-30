From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Tue, 30 Apr 2013 07:49:36 -0700
Subject: [PATCH 15/15] ARM: KVM: iterate over all CPUs for CPU compatibility
 check
In-Reply-To: <1367333376-30983-1-git-send-email-cdall@cs.columbia.edu>
References: <1367333376-30983-1-git-send-email-cdall@cs.columbia.edu>
Message-ID: <1367333376-30983-16-git-send-email-cdall@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@linaro.org>

kvm_target_cpus() checks the compatibility of the used CPU with
KVM, which is currently limited to ARM Cortex-A15 cores.
However by calling it only once on any random CPU it assumes that
all cores are the same, which is not necessarily the case (for example
in Big.Little).

[ I cut some of the commit message and changed the formatting of the
  code slightly to pass checkpatch and look more like the rest of the
  kvm/arm init code - Christoffer ]

Signed-off-by: Andre Przywara <andre.przywara@linaro.org>
Signed-off-by: Christoffer Dall <cdall@cs.columbia.edu>
---
 arch/arm/kvm/arm.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 089c0a4..5bc99b4 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -947,21 +947,30 @@ out_err:
 	return err;
 }
 
+static void check_kvm_target_cpu(void *ret)
+{
+	*(int *)ret = kvm_target_cpu();
+}
+
 /**
  * Initialize Hyp-mode and memory mappings on all CPUs.
  */
 int kvm_arch_init(void *opaque)
 {
 	int err;
+	int ret, cpu;
 
 	if (!is_hyp_mode_available()) {
 		kvm_err("HYP mode not available\n");
 		return -ENODEV;
 	}
 
-	if (kvm_target_cpu() < 0) {
-		kvm_err("Target CPU not supported!\n");
-		return -ENODEV;
+	for_each_online_cpu(cpu) {
+		smp_call_function_single(cpu, check_kvm_target_cpu, &ret, 1);
+		if (ret < 0) {
+			kvm_err("Error, CPU %d not supported!\n", cpu);
+			return -ENODEV;
+		}
 	}
 
 	err = init_hyp_mode();
-- 
1.7.9.5
