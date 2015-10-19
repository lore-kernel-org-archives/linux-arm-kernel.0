From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 19 Oct 2015 14:24:40 +0100
Subject: [PATCHv4 03/24] arm64: Delay cpuinfo_store_boot_cpu
In-Reply-To: <1445261101-22344-1-git-send-email-suzuki.poulose@arm.com>
References: <1445261101-22344-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1445261101-22344-4-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the moment the boot CPU stores the cpuinfo much before the
PERCPU areas are initialised by the kernel. This could be problematic
as the non-boot CPU data structures might get copied with the data
from the boot CPU, giving us no chance to detect if a particular CPU
updated its cpuinfo. This patch delays the boot cpu store to
smp_prepare_boot_cpu().

Also kills the setup_processor() which no longer does meaningful
work.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/setup.c |   10 ++--------
 arch/arm64/kernel/smp.c   |    1 +
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 4f0408e..47e0051 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -286,13 +286,6 @@ void __init setup_cpu_features(void)
 #endif
 }
 
-static void __init setup_processor(void)
-{
-	pr_info("Boot CPU: AArch64 Processor [%08x]\n", read_cpuid_id());
-	sprintf(init_utsname()->machine, ELF_PLATFORM);
-	cpuinfo_store_boot_cpu();
-}
-
 static void __init setup_machine_fdt(phys_addr_t dt_phys)
 {
 	void *dt_virt = fixmap_remap_fdt(dt_phys);
@@ -404,8 +397,9 @@ u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
 
 void __init setup_arch(char **cmdline_p)
 {
-	setup_processor();
+	pr_info("Boot CPU: AArch64 Processor [%08x]\n", read_cpuid_id());
 
+	sprintf(init_utsname()->machine, ELF_PLATFORM);
 	init_mm.start_code = (unsigned long) _text;
 	init_mm.end_code   = (unsigned long) _etext;
 	init_mm.end_data   = (unsigned long) _edata;
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 77763d9..d1d0049 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -327,6 +327,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
 
 void __init smp_prepare_boot_cpu(void)
 {
+	cpuinfo_store_boot_cpu();
 	set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
 }
 
-- 
1.7.9.5
