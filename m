From: maddy@linux.vnet.ibm.com (Madhavan Srinivasan)
Date: Thu,  5 Nov 2015 02:16:18 +0530
Subject: [RFC PATCH  3/3]perf/powerpc: Functions to update arch_misc_regs
In-Reply-To: <1446669978-6366-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1446669978-6366-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-ID: <1446669978-6366-4-git-send-email-maddy@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch adds function to update the arch_misc_reg struct
and an arch specific perf_sample_regs_intr() to hook up
arch_misc_regs to perf_regs pointer. Also makes
perf_sample_regs_intr() in kernel/event/core.c as __weak__
function to make arch specific implementation to replace.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Stephane Eranian <eranian@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 Would really appreciate comments and feedback for the patch

 arch/powerpc/perf/core-book3s.c | 29 +++++++++++++++++++++++++++++
 kernel/events/core.c            |  2 +-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index b0382f3f1095..508c181c163f 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -57,6 +57,7 @@ struct cpu_hw_events {
 	void				*bhrb_context;
 	struct	perf_branch_stack	bhrb_stack;
 	struct	perf_branch_entry	bhrb_entries[BHRB_MAX_ENTRIES];
+	struct arch_misc_regs arch_regs;
 };

 static DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
@@ -1904,6 +1905,28 @@ ssize_t power_events_sysfs_show(struct device *dev,
 	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
 }

+void perf_sample_regs_intr(struct perf_regs *regs_intr, struct pt_regs *regs)
+{
+	struct cpu_hw_events *cpuhw;
+	cpuhw = this_cpu_ptr(&cpu_hw_events);
+
+	regs_intr->regs = regs;
+	regs_intr->arch_regs = &cpuhw->arch_regs;
+	regs_intr->abi  = perf_reg_abi(current);
+}
+
+static void power_arch_misc_regs(struct arch_misc_regs *regs)
+{
+	regs->pmc1 = mfspr(SPRN_PMC1);
+	regs->pmc2 = mfspr(SPRN_PMC2);
+	regs->pmc3 = mfspr(SPRN_PMC3);
+	regs->pmc4 = mfspr(SPRN_PMC4);
+	regs->pmc5 = mfspr(SPRN_PMC5);
+	regs->pmc6 = mfspr(SPRN_PMC6);
+	regs->mmcr0 = mfspr(SPRN_MMCR0);
+	regs->mmcr1 = mfspr(SPRN_MMCR1);
+}
+
 static struct pmu power_pmu = {
 	.pmu_enable	= power_pmu_enable,
 	.pmu_disable	= power_pmu_disable,
@@ -1985,6 +2008,12 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 			data.br_stack = &cpuhw->bhrb_stack;
 		}

+		if (event->attr.sample_type & PERF_SAMPLE_REGS_INTR) {
+			struct cpu_hw_events *cpuhw;
+			cpuhw = this_cpu_ptr(&cpu_hw_events);
+			power_arch_misc_regs(&cpuhw->arch_regs);
+		}
+
 		if (perf_event_overflow(event, &data, regs))
 			power_pmu_stop(event, 0);
 	}
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c04bdad3d365..9567be72da5a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4962,7 +4962,7 @@ static void perf_sample_regs_user(struct perf_regs *regs_user,
 	}
 }

-static void perf_sample_regs_intr(struct perf_regs *regs_intr,
+void __attribute__((weak)) perf_sample_regs_intr(struct perf_regs *regs_intr,
 				  struct pt_regs *regs)
 {
 	regs_intr->regs = regs;
--
1.9.1
