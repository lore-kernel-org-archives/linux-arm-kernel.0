From: dinggnu@gmail.com (Cong Ding)
Date: Mon, 14 Jan 2013 17:40:55 +0000
Subject: [PATCH v2] arm: kernel/perf_event_cpu.c: remove unnecessary null
 pointer dereference check
In-Reply-To: <1358183933-29160-1-git-send-email-dinggnu@gmail.com>
References: <1358183933-29160-1-git-send-email-dinggnu@gmail.com>
Message-ID: <20130114174055.GB917@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NULL pointer check is not necessary.  cpu_pmu_init() is called
after cpu_pmu has already been dereferenced by its caller:

	cpu_pmu = pmu;
	cpu_pmu->plat_device = pdev;
	cpu_pmu_init(cpu_pmu);

Signed-off-by: Cong Ding <dinggnu@gmail.com>
---
 arch/arm/kernel/perf_event_cpu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index efa5295..43496f6 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -147,7 +147,7 @@ static void cpu_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->free_irq	= cpu_pmu_free_irq;
 
 	/* Ensure the PMU has sane values out of reset. */
-	if (cpu_pmu && cpu_pmu->reset)
+	if (cpu_pmu->reset)
 		on_each_cpu(cpu_pmu->reset, cpu_pmu, 1);
 }
 
-- 
1.7.4.5
