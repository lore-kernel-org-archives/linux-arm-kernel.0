From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Fri, 24 Jul 2015 10:43:49 +0100
Subject: [RFC PATCH 03/10] arm64: Delay ELF HWCAP initialisation until all
 CPUs are up
In-Reply-To: <1437731037-25795-1-git-send-email-suzuki.poulose@arm.com>
References: <1437731037-25795-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1437731037-25795-4-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

Delay the ELF HWCAP initialisation untill all the CPUs are up.
This is in preparation for detecting the common features across
the CPUS and creating a consistent ELF HWCAP for the system.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/setup.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index a30cf1d..2a36d27 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -103,6 +103,8 @@ static struct resource mem_res[] = {
 	}
 };
 
+static void setup_processor_features(void);
+
 #define kernel_code mem_res[0]
 #define kernel_data mem_res[1]
 
@@ -212,6 +214,7 @@ static void __init hyp_mode_check(void)
 
 void __init do_post_cpus_up_work(void)
 {
+	setup_processor_features();
 	hyp_mode_check();
 	apply_alternatives_all();
 }
@@ -223,19 +226,12 @@ void __init up_late_init(void)
 }
 #endif /* CONFIG_UP_LATE_INIT */
 
-static void __init setup_processor(void)
+static void __init setup_processor_features(void)
 {
 	u64 features, block;
 	u32 cwg;
 	int cls;
 
-	pr_info("Boot CPU: AArch64 Processor [%08x]\n", read_cpuid_id());
-
-	sprintf(init_utsname()->machine, ELF_PLATFORM);
-	elf_hwcap = 0;
-
-	cpuinfo_store_boot_cpu();
-
 	/*
 	 * Check for sane CTR_EL0.CWG value.
 	 */
@@ -312,6 +308,13 @@ static void __init setup_processor(void)
 #endif
 }
 
+static void __init setup_processor(void)
+{
+	pr_info("Boot CPU: AArch64 Processor [%08x]\n", read_cpuid_id());
+	sprintf(init_utsname()->machine, ELF_PLATFORM);
+	cpuinfo_store_boot_cpu();
+}
+
 static void __init setup_machine_fdt(phys_addr_t dt_phys)
 {
 	void *dt_virt = fixmap_remap_fdt(dt_phys);
-- 
1.7.9.5
