From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 10 Mar 2017 11:04:48 +0000
Subject: [PATCH 11/14] arm64: add function to get a cpu's MADT GICC table
In-Reply-To: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
References: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1489143891-11596-12-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the ACPI parking protocol code needs to parse each CPU's MADT
GICC table to extract the mailbox address and so on. Each time we parse
a GICC table, we call back to the parking protocol code to parse it.

This has been fine so far, but we're about to have more code that needs
to extract data from the GICC tables, and adding a callback for each
user is going to get unwieldy.

Instead, this patch ensures that we stash a copy of each CPU's GICC
table at boot time, such that anything needing to parse it can later
request it. This will allow for other parsers of GICC, and for
simplification to the ACPI parking protocol code. Note that we must
store a copy, rather than a pointer, since the core ACPI code
temporarily maps/unmaps tables while iterating over them.

Since we parse the MADT before we know how many CPUs we have (and hence
before we setup the percpu areas), we must use an NR_CPUS sized array.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/acpi.h |  2 ++
 arch/arm64/kernel/smp.c       | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index c1976c0..0e99978 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -85,6 +85,8 @@ static inline bool acpi_has_cpu_in_madt(void)
 	return true;
 }
 
+struct acpi_madt_generic_interrupt *acpi_cpu_get_madt_gicc(int cpu);
+
 static inline void arch_fix_phys_package_id(int num, u32 slot) { }
 void __init acpi_init_cpus(void);
 
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index ef1caae..390c277 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -518,6 +518,13 @@ static int __init smp_cpu_setup(int cpu)
 static unsigned int cpu_count = 1;
 
 #ifdef CONFIG_ACPI
+static struct acpi_madt_generic_interrupt cpu_madt_gicc[NR_CPUS];
+
+struct acpi_madt_generic_interrupt *acpi_cpu_get_madt_gicc(int cpu)
+{
+	return &cpu_madt_gicc[cpu];
+}
+
 /*
  * acpi_map_gic_cpu_interface - parse processor MADT entry
  *
@@ -552,6 +559,7 @@ static int __init smp_cpu_setup(int cpu)
 			return;
 		}
 		bootcpu_valid = true;
+		cpu_madt_gicc[0] = *processor;
 		early_map_cpu_to_node(0, acpi_numa_get_nid(0, hwid));
 		return;
 	}
@@ -562,6 +570,8 @@ static int __init smp_cpu_setup(int cpu)
 	/* map the logical cpu id to cpu MPIDR */
 	cpu_logical_map(cpu_count) = hwid;
 
+	cpu_madt_gicc[cpu_count] = *processor;
+
 	/*
 	 * Set-up the ACPI parking protocol cpu entries
 	 * while initializing the cpu_logical_map to
-- 
1.9.1
