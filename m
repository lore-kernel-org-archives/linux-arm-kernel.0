From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Fri, 24 Jul 2015 10:43:56 +0100
Subject: [RFC PATCH 10/10] arm64: Use system-wide safe value of CPU feature
 register
In-Reply-To: <1437731037-25795-1-git-send-email-suzuki.poulose@arm.com>
References: <1437731037-25795-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1437731037-25795-11-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

Now that we track the system-wide safe value of a CPU feature,
make use of that whenever possible, including ELF_HWCAPS.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpuinfo.c        |   18 +++---------------
 arch/arm64/kernel/debug-monitors.c |    6 ++++--
 arch/arm64/kernel/fpsimd.c         |    5 +++--
 arch/arm64/kernel/hw_breakpoint.c  |    5 +++--
 arch/arm64/kvm/reset.c             |    3 ++-
 arch/arm64/kvm/sys_regs.c          |    5 +++--
 6 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 7d140f7..678e7f6 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -241,7 +241,6 @@ static struct arm64_ftr_reg arm64_regs[] = {
  */
 DEFINE_PER_CPU(struct cpuinfo_arm64, cpu_data);
 static struct cpuinfo_arm64 boot_cpu_data;
-static bool mixed_endian_el0 = true;
 
 static char *icache_policy_str[] = {
 	[ICACHE_POLICY_RESERVED] = "RESERVED/UNKNOWN",
@@ -282,17 +281,7 @@ bool cpu_supports_mixed_endian_el0(void)
 
 bool system_supports_mixed_endian_el0(void)
 {
-	return mixed_endian_el0;
-}
-
-static void update_mixed_endian_el0_support(struct cpuinfo_arm64 *info)
-{
-	mixed_endian_el0 &= id_aa64mmfr0_mixed_endian_el0(info->reg_id_aa64mmfr0);
-}
-
-static void update_cpu_features(struct cpuinfo_arm64 *info)
-{
-	update_mixed_endian_el0_support(info);
+	return id_aa64mmfr0_mixed_endian_el0(read_system_cpuid(ID_AA64MMFR0_EL1));
 }
 
 static inline int arm64_boot_cpuinfo_initialised(void)
@@ -576,7 +565,6 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 
 	check_local_cpu_errata();
 	cpuinfo_sanity_check(info);
-	update_cpu_features(info);
 }
 
 void cpuinfo_store_cpu(void)
@@ -617,7 +605,7 @@ void __init setup_processor_features(void)
 	 * The blocks we test below represent incremental functionality
 	 * for non-negative values. Negative values are reserved.
 	 */
-	features = read_cpuid(ID_AA64ISAR0_EL1);
+	features = read_system_cpuid(ID_AA64ISAR0_EL1);
 	block = (features >> 4) & 0xf;
 	if (!(block & 0x8)) {
 		switch (block) {
@@ -648,7 +636,7 @@ void __init setup_processor_features(void)
 	 * ID_ISAR5_EL1 carries similar information as above, but pertaining to
 	 * the Aarch32 32-bit execution state.
 	 */
-	features = read_cpuid(ID_ISAR5_EL1);
+	features = read_system_cpuid(ID_ISAR5_EL1);
 	block = (features >> 4) & 0xf;
 	if (!(block & 0x8)) {
 		switch (block) {
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index b056369..c21de2b 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -26,14 +26,16 @@
 #include <linux/stat.h>
 #include <linux/uaccess.h>
 
-#include <asm/debug-monitors.h>
+
 #include <asm/cputype.h>
+#include <asm/cpu.h>
+#include <asm/debug-monitors.h>
 #include <asm/system_misc.h>
 
 /* Determine debug architecture. */
 u8 debug_monitors_arch(void)
 {
-	return read_cpuid(ID_AA64DFR0_EL1) & 0xf;
+	return read_system_cpuid(ID_AA64DFR0_EL1) & 0xf;
 }
 
 /*
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 44d6f75..d0961c5 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -25,8 +25,9 @@
 #include <linux/signal.h>
 #include <linux/hardirq.h>
 
-#include <asm/fpsimd.h>
+#include <asm/cpu.h>
 #include <asm/cputype.h>
+#include <asm/fpsimd.h>
 
 #define FPEXC_IOF	(1 << 0)
 #define FPEXC_DZF	(1 << 1)
@@ -331,7 +332,7 @@ static inline void fpsimd_hotplug_init(void) { }
  */
 static int __init fpsimd_init(void)
 {
-	u64 pfr = read_cpuid(ID_AA64PFR0_EL1);
+	u64 pfr = read_system_cpuid(ID_AA64PFR0_EL1);
 
 	if (pfr & (0xf << 16)) {
 		pr_notice("Floating-point is not implemented\n");
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 7a1a5da..2f05e3d 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -28,6 +28,7 @@
 #include <linux/ptrace.h>
 #include <linux/smp.h>
 
+#include <asm/cpu.h>
 #include <asm/current.h>
 #include <asm/debug-monitors.h>
 #include <asm/hw_breakpoint.h>
@@ -51,13 +52,13 @@ static int core_num_wrps;
 /* Determine number of BRP registers available. */
 static int get_num_brps(void)
 {
-	return ((read_cpuid(ID_AA64DFR0_EL1) >> 12) & 0xf) + 1;
+	return ((read_system_cpuid(ID_AA64DFR0_EL1) >> 12) & 0xf) + 1;
 }
 
 /* Determine number of WRP registers available. */
 static int get_num_wrps(void)
 {
-	return ((read_cpuid(ID_AA64DFR0_EL1) >> 20) & 0xf) + 1;
+	return ((read_system_cpuid(ID_AA64DFR0_EL1) >> 20) & 0xf) + 1;
 }
 
 int hw_breakpoint_slots(int type)
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 0b43265..92abdc0 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -25,6 +25,7 @@
 
 #include <kvm/arm_arch_timer.h>
 
+#include <asm/cpu.h>
 #include <asm/cputype.h>
 #include <asm/ptrace.h>
 #include <asm/kvm_arm.h>
@@ -52,7 +53,7 @@ static bool cpu_has_32bit_el1(void)
 {
 	u64 pfr0;
 
-	pfr0 = read_cpuid(ID_AA64PFR0_EL1);
+	pfr0 = read_system_cpuid(ID_AA64PFR0_EL1);
 	return !!(pfr0 & 0x20);
 }
 
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index c370b40..80ad47d 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -25,6 +25,7 @@
 #include <linux/uaccess.h>
 
 #include <asm/cacheflush.h>
+#include <asm/cpu.h>
 #include <asm/cputype.h>
 #include <asm/debug-monitors.h>
 #include <asm/esr.h>
@@ -490,8 +491,8 @@ static bool trap_dbgidr(struct kvm_vcpu *vcpu,
 	if (p->is_write) {
 		return ignore_write(vcpu, p);
 	} else {
-		u64 dfr = read_cpuid(ID_AA64DFR0_EL1);
-		u64 pfr = read_cpuid(ID_AA64PFR0_EL1);
+		u64 dfr = read_system_cpuid(ID_AA64DFR0_EL1);
+		u64 pfr = read_system_cpuid(ID_AA64PFR0_EL1);
 		u32 el3 = !!((pfr >> 12) & 0xf);
 
 		*vcpu_reg(vcpu, p->Rt) = ((((dfr >> 20) & 0xf) << 28) |
-- 
1.7.9.5
