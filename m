From: will.deacon@arm.com (Will Deacon)
Date: Wed, 17 Oct 2012 16:33:43 +0100
Subject: [PATCH 6/7] ARM: perf: return NOTIFY_DONE from cpu notifier when no
 available PMU
In-Reply-To: <1350488024-3224-1-git-send-email-will.deacon@arm.com>
References: <1350488024-3224-1-git-send-email-will.deacon@arm.com>
Message-ID: <1350488024-3224-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When attempting to reset the PMU state for either a NULL PMU or a PMU
implementation without a reset function, return NOTIFY_DONE from the CPU
notifier as we don't care about the hotplug event.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event_cpu.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index 71c824c..db9c6b5 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -165,6 +165,8 @@ static int __cpuinit cpu_pmu_notify(struct notifier_block *b,
 
 	if (cpu_pmu && cpu_pmu->reset)
 		cpu_pmu->reset(cpu_pmu);
+	else
+		return NOTIFY_DONE;
 
 	return NOTIFY_OK;
 }
-- 
1.7.4.1
