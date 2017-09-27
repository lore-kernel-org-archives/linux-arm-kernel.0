From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 27 Sep 2017 14:50:38 +0100
Subject: [PATCH] arm64: consistently log boot/secondary CPU IDs
Message-ID: <1506520238-8306-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we inconsistently log identifying information for the boot CPU
and secondary CPUs. For the boot CPU, we log the MIDR and MPIDR across
separate messages, whereas for the secondary CPUs we only log the MIDR.

In some cases, it would be useful to know the MPIDR of secondary CPUs,
and it would be nice for these messages to be consistent.

This patch ensures that in the primary and secondary boot paths, we log
both the MPIDR and MIDR in a single message, with a consistent format.
the MPIDR is consistently padded to 10 hex characters to cover Aff3 in
bits 39:32, so that IDs can be compared easily.

The newly redundant message in setup_arch() is removed.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Al Stone <ahs3@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/setup.c | 5 ++---
 arch/arm64/kernel/smp.c   | 6 ++++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index d4b7405..819c1d1 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -103,7 +103,8 @@ void __init smp_setup_processor_id(void)
 	 * access percpu variable inside lock_release
 	 */
 	set_my_cpu_offset(0);
-	pr_info("Booting Linux on physical CPU 0x%lx\n", (unsigned long)mpidr);
+	pr_info("Booting Linux on physical CPU 0x%010lx [%08x]\n",
+		(unsigned long)mpidr, read_cpuid_id());
 }
 
 bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
@@ -244,8 +245,6 @@ static void __init request_standard_resources(void)
 
 void __init setup_arch(char **cmdline_p)
 {
-	pr_info("Boot CPU: AArch64 Processor [%08x]\n", read_cpuid_id());
-
 	sprintf(init_utsname()->machine, UTS_MACHINE);
 	init_mm.start_code = (unsigned long) _text;
 	init_mm.end_code   = (unsigned long) _etext;
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 9f7195a..e1f35b4 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -216,6 +216,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
  */
 asmlinkage void secondary_start_kernel(void)
 {
+	u64 mpidr = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
 	struct mm_struct *mm = &init_mm;
 	unsigned int cpu;
 
@@ -265,8 +266,9 @@ asmlinkage void secondary_start_kernel(void)
 	 * the CPU migration code to notice that the CPU is online
 	 * before we continue.
 	 */
-	pr_info("CPU%u: Booted secondary processor [%08x]\n",
-					 cpu, read_cpuid_id());
+	pr_info("CPU%u: Booted secondary processor 0x%010lx [%08x]\n",
+					 cpu, (unsigned long)mpidr,
+					 read_cpuid_id());
 	update_cpu_boot_status(CPU_BOOT_SUCCESS);
 	set_cpu_online(cpu, true);
 	complete(&cpu_running);
-- 
1.9.1
