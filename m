From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri, 26 Aug 2016 10:23:12 +0100
Subject: [PATCH v2 3/9] arm64: Rearrange CPU errata workaround checks
In-Reply-To: <1472203398-8751-1-git-send-email-suzuki.poulose@arm.com>
References: <1472203398-8751-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1472203398-8751-4-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Right now we run through the work around checks on a CPU
from __cpuinfo_store_cpu. There are some problems with that:

1) We initialise the system wide CPU feature registers only after the
Boot CPU updates its cpuinfo. Now, if a work around depends on the
variance of a CPU ID feature (e.g, check for Cache Line size mismatch),
we have no way of performing it cleanly for the boot CPU.

2) It is out of place, invoked from __cpuinfo_store_cpu() in cpuinfo.c. It
is not an obvious place for that.

This patch rearranges the CPU specific capability(aka work around) checks.

1) At the moment we use verify_local_cpu_capabilities() to check if a new
CPU has all the system advertised features. Use this for the secondary CPUs
to perform the work around check. For that we rename
  verify_local_cpu_capabilities() => check_local_cpu_capabilities()
which:

   If the system wide capabilities haven't been initialised (i.e, the CPU
   is activated at the boot), update the system wide detected work arounds.

   Otherwise (i.e a CPU hotplugged in later) verify that this CPU conforms to the
   system wide capabilities.

2) Boot CPU updates the work arounds from smp_prepare_boot_cpu() after we have
initialised the system wide CPU feature values.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |  4 ++--
 arch/arm64/kernel/cpufeature.c      | 30 ++++++++++++++++++++----------
 arch/arm64/kernel/cpuinfo.c         |  2 --
 arch/arm64/kernel/smp.c             |  8 +++++++-
 4 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index aadd946..692b8d3 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -193,11 +193,11 @@ void __init setup_cpu_features(void);
 void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 			    const char *info);
 void enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps);
+void check_local_cpu_capabilities(void);
+
 void update_cpu_errata_workarounds(void);
 void __init enable_errata_workarounds(void);
-
 void verify_local_cpu_errata_workarounds(void);
-void verify_local_cpu_capabilities(void);
 
 u64 read_system_reg(u32 id);
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index a591c35..fcf87ca 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1005,23 +1005,33 @@ verify_local_cpu_features(const struct arm64_cpu_capabilities *caps)
  * cannot do anything to fix it up and could cause unexpected failures. So
  * we park the CPU.
  */
-void verify_local_cpu_capabilities(void)
+static void verify_local_cpu_capabilities(void)
 {
+	verify_local_cpu_errata_workarounds();
+	verify_local_cpu_features(arm64_features);
+	verify_local_elf_hwcaps(arm64_elf_hwcaps);
+	if (system_supports_32bit_el0())
+		verify_local_elf_hwcaps(compat_elf_hwcaps);
+}
 
+void check_local_cpu_capabilities(void)
+{
+	/*
+	 * All secondary CPUs should conform to the early CPU features
+	 * in use by the kernel based on boot CPU.
+	 */
 	check_early_cpu_features();
 
 	/*
-	 * If we haven't computed the system capabilities, there is nothing
-	 * to verify.
+	 * If we haven't finalised the system capabilities, this CPU gets
+	 * a chance to update the errata work arounds.
+	 * Otherwise, this CPU should verify that it has all the system
+	 * advertised capabilities.
 	 */
 	if (!sys_caps_initialised)
-		return;
-
-	verify_local_cpu_errata_workarounds();
-	verify_local_cpu_features(arm64_features);
-	verify_local_elf_hwcaps(arm64_elf_hwcaps);
-	if (system_supports_32bit_el0())
-		verify_local_elf_hwcaps(compat_elf_hwcaps);
+		update_cpu_errata_workarounds();
+	else
+		verify_local_cpu_capabilities();
 }
 
 static void __init setup_feature_capabilities(void)
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 4fa7b73..b3d5b3e 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -363,8 +363,6 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	}
 
 	cpuinfo_detect_icache_policy(info);
-
-	update_cpu_errata_workarounds();
 }
 
 void cpuinfo_store_cpu(void)
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index d93d433..99d8cc3 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -239,7 +239,7 @@ asmlinkage void secondary_start_kernel(void)
 	 * this CPU ticks all of those. If it doesn't, the CPU will
 	 * fail to come online.
 	 */
-	verify_local_cpu_capabilities();
+	check_local_cpu_capabilities();
 
 	if (cpu_ops[cpu]->cpu_postboot)
 		cpu_ops[cpu]->cpu_postboot();
@@ -439,6 +439,12 @@ void __init smp_prepare_boot_cpu(void)
 	set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
 	cpuinfo_store_boot_cpu();
 	save_boot_cpu_run_el();
+	/*
+	 * Run the errata work around checks on the boot CPU, once we have
+	 * initialised the cpu feature infrastructure from
+	 * cpuinfo_store_boot_cpu() above.
+	 */
+	update_cpu_errata_workarounds();
 }
 
 static u64 __init of_get_cpu_mpidr(struct device_node *dn)
-- 
2.7.4
