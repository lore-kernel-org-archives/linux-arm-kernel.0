From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 13 Oct 2015 18:22:21 +0100
Subject: [PATCH v3 13/24] arm64: Populate cpuinfo after notify_cpu_starting
In-Reply-To: <1444756952-31145-1-git-send-email-suzuki.poulose@arm.com>
References: <1444756952-31145-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1444756952-31145-14-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch delays populating the cpuinfo for a new (hotplugged)
CPU until the notifiers have executed. This will enable us to verify
if the new (hotplugged) CPU has all the capabilities which the system
already has. If it doesn't, we could prevent it from turning online and
also modifying the system wide feature register status.

Also delays advertising that the CPU has booted until we complete
the notifiers, when we are ready to mark it online. This would avoid
confusing the user if the CPU fails to boot due to a missing capability.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/smp.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 3b22e65..4a36eb6 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -145,9 +145,6 @@ asmlinkage void secondary_start_kernel(void)
 	cpumask_set_cpu(cpu, mm_cpumask(mm));
 
 	set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
-	pr_info("CPU%u: Booted secondary processor [%08x]\n",
-					 cpu, read_cpuid_id());
-
 	/*
 	 * TTBR0 is only used for the identity mapping at this stage. Make it
 	 * point to zero page to avoid speculatively fetching new entries.
@@ -163,14 +160,14 @@ asmlinkage void secondary_start_kernel(void)
 		cpu_ops[cpu]->cpu_postboot();
 
 	/*
-	 * Log the CPU info before it is marked online and might get read.
+	 * Enable GIC and timers.
 	 */
-	cpuinfo_store_cpu();
+	notify_cpu_starting(cpu);
 
 	/*
-	 * Enable GIC and timers.
+	 * Log the CPU info before it is marked online and might get read.
 	 */
-	notify_cpu_starting(cpu);
+	cpuinfo_store_cpu();
 
 	smp_store_cpu_info(cpu);
 
@@ -179,6 +176,10 @@ asmlinkage void secondary_start_kernel(void)
 	 * the CPU migration code to notice that the CPU is online
 	 * before we continue.
 	 */
+
+	pr_info("CPU%u: Booted secondary processor [%08x]\n",
+					 cpu, read_cpuid_id());
+
 	set_cpu_online(cpu, true);
 	complete(&cpu_running);
 
-- 
1.7.9.5
