From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 24 Jul 2014 21:00:15 +0800
Subject: [PATCH 09/19] ARM64 / ACPI: Move the initialization of
 cpu_logical_map(0) before acpi_boot_init()
In-Reply-To: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1406206825-15590-10-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the initialization of cpu_logical_map(0) before acpi_boot_init()
to remove the duplicated initialization of cpu_logical_map(0).

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/kernel/acpi.c  |    3 ---
 arch/arm64/kernel/setup.c |    3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 801e268..ff0f6a0 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -244,9 +244,6 @@ int __init acpi_boot_init(void)
 	if (err)
 		pr_err("Can't find FADT\n");
 
-	/* Get the boot CPU's MPIDR before MADT parsing */
-	cpu_logical_map(0) = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
-
 	err = acpi_parse_madt_gic_cpu_interface_entries();
 
 	return err;
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index e00d40c..17ab98e 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -394,13 +394,14 @@ void __init setup_arch(char **cmdline_p)
 
 	efi_idmap_init();
 
+	/* Get the boot CPU's MPIDR before cpu logical map is built */
+	cpu_logical_map(0) = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
 	acpi_boot_init();
 
 	unflatten_device_tree();
 
 	psci_init();
 
-	cpu_logical_map(0) = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
 	cpu_read_bootcpu_ops();
 #ifdef CONFIG_SMP
 	smp_init_cpus();
-- 
1.7.9.5
