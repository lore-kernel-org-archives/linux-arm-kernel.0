From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 19 Oct 2015 14:00:24 +0100
Subject: [PATCHv4 01/24] arm64: Make the CPU information more clear
In-Reply-To: <1445259647-21541-1-git-send-email-suzuki.poulose@arm.com>
References: <1445259647-21541-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1445259647-21541-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At early boot, we print the CPU version/revision. On a heterogeneous
system, we could have different types of CPUs. Print the CPU info for
all active cpus. Also, the secondary CPUs prints the message only when
they turn online.

Also, remove the redundant 'revision' information which doesn't
make any sense without the 'variant' field.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
Changes since V3:
  - Delay the boot message from secondary CPUs, until they turn online
---
 arch/arm64/kernel/setup.c |    3 +--
 arch/arm64/kernel/smp.c   |    3 ++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 79df79a..1d503e2 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -203,8 +203,7 @@ static void __init setup_processor(void)
 	u32 cwg;
 	int cls;
 
-	printk("CPU: AArch64 Processor [%08x] revision %d\n",
-	       read_cpuid_id(), read_cpuid_id() & 15);
+	pr_info("Boot CPU: AArch64 Processor [%08x]\n", read_cpuid_id());
 
 	sprintf(init_utsname()->machine, ELF_PLATFORM);
 	elf_hwcap = 0;
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index b7a973d..c1d044b 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -144,7 +144,6 @@ asmlinkage void secondary_start_kernel(void)
 	current->active_mm = mm;
 
 	set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
-	printk("CPU%u: Booted secondary processor\n", cpu);
 
 	/*
 	 * TTBR0 is only used for the identity mapping at this stage. Make it
@@ -177,6 +176,8 @@ asmlinkage void secondary_start_kernel(void)
 	 * the CPU migration code to notice that the CPU is online
 	 * before we continue.
 	 */
+	pr_info("CPU%u: Booted secondary processor [%08x]\n",
+					 cpu, read_cpuid_id());
 	set_cpu_online(cpu, true);
 	complete(&cpu_running);
 
-- 
1.7.9.5
