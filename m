From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Fri, 24 Jul 2015 10:43:48 +0100
Subject: [RFC PATCH 02/10] arm64: Make the CPU information more clear
In-Reply-To: <1437731037-25795-1-git-send-email-suzuki.poulose@arm.com>
References: <1437731037-25795-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1437731037-25795-3-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

At early boot, we print the CPU version/revision. On a heterogeneous
system, we could have different types of CPUs. Print the CPU info for
all active cpus.

Also, remove the redundant 'revision' information which doesn't
make any sense without the 'variant' field.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/setup.c |    3 +--
 arch/arm64/kernel/smp.c   |    3 ++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index f3067d4..a30cf1d 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -229,8 +229,7 @@ static void __init setup_processor(void)
 	u32 cwg;
 	int cls;
 
-	printk("CPU: AArch64 Processor [%08x] revision %d\n",
-	       read_cpuid_id(), read_cpuid_id() & 15);
+	pr_info("Boot CPU: AArch64 Processor [%08x]\n", read_cpuid_id());
 
 	sprintf(init_utsname()->machine, ELF_PLATFORM);
 	elf_hwcap = 0;
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 50fb469..a121c67 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -144,7 +144,8 @@ asmlinkage void secondary_start_kernel(void)
 	cpumask_set_cpu(cpu, mm_cpumask(mm));
 
 	set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
-	printk("CPU%u: Booted secondary processor\n", cpu);
+	pr_info("CPU%u: Booted secondary processor [%08x]\n",
+					 cpu, read_cpuid_id());
 
 	/*
 	 * TTBR0 is only used for the identity mapping at this stage. Make it
-- 
1.7.9.5
