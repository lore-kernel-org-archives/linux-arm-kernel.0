From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 19 Oct 2016 20:10:31 +0100
Subject: [PATCH 07/10] arm64: smp: prepare for smp_processor_id() rework
In-Reply-To: <1476904234-9511-1-git-send-email-mark.rutland@arm.com>
References: <1476904234-9511-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1476904234-9511-8-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Subsequent patches will make smp_processor_id() use a percpu variable.
This will make smp_processor_id() dependent on the percpu offset, and
thus we cannot use smp_processor_id() to figure out what to initialise
the offset to.

Prepare for this by initialising the percpu offset based on
current::cpu, which will work regardless of how smp_processor_id() is
implemented. Also, make this relationship obvious by placing this code
together at the start of secondary_start_kernel().

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/smp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index d3f151c..7af46bf 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -208,7 +208,10 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 asmlinkage void secondary_start_kernel(void)
 {
 	struct mm_struct *mm = &init_mm;
-	unsigned int cpu = smp_processor_id();
+	unsigned int cpu;
+
+	cpu = task_cpu(current);
+	set_my_cpu_offset(per_cpu_offset(cpu));
 
 	/*
 	 * All kernel threads share the same mm context; grab a
@@ -217,8 +220,6 @@ asmlinkage void secondary_start_kernel(void)
 	atomic_inc(&mm->mm_count);
 	current->active_mm = mm;
 
-	set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
-
 	/*
 	 * TTBR0 is only used for the identity mapping at this stage. Make it
 	 * point to zero page to avoid speculatively fetching new entries.
-- 
1.9.1
