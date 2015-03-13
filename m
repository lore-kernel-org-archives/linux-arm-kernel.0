From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 13 Mar 2015 16:14:37 +0000
Subject: [PATCH 4/4] arm64: log CPU boot modes
In-Reply-To: <1426263277-9827-1-git-send-email-mark.rutland@arm.com>
References: <1426263277-9827-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1426263277-9827-5-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We currently don't log the boot mode for arm64 as we do for arm, and
without KVM the user is provided with no indication as to which mode(s)
CPUs were booted in, which can seriously hinder debugging in some cases.

Add logging to the boot path once all CPUs are up. Where CPUs are
mismatched in violation of the boot protocol, WARN and set a taint (as
we do for CPU other CPU feature mismatches) given that the
firmware/bootloader is buggy and should be fixed.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/setup.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 781f469..1480894 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -62,6 +62,7 @@
 #include <asm/memblock.h>
 #include <asm/psci.h>
 #include <asm/efi.h>
+#include <asm/virt.h>
 
 unsigned int processor_id;
 EXPORT_SYMBOL(processor_id);
@@ -207,8 +208,20 @@ static void __init smp_build_mpidr_hash(void)
 }
 #endif
 
+static void __init hyp_mode_check(void)
+{
+	if (is_hyp_mode_available())
+		pr_info("CPU: All CPU(s) started at EL2\n");
+	else if (is_hyp_mode_mismatched())
+		WARN_TAINT(1, TAINT_CPU_OUT_OF_SPEC,
+			   "CPU: CPUs started in inconsistent modes");
+	else
+		pr_info("CPU: All CPU(s) started at EL1\n");
+}
+
 void __init do_post_cpus_up_work(void)
 {
+	hyp_mode_check();
 	apply_alternatives_all();
 }
 
-- 
1.9.1
