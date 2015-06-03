From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed,  3 Jun 2015 13:53:38 -0700
Subject: [PATCH 2/2] arm: perf: Don't use of_node after putting it
In-Reply-To: <1433364818-6682-1-git-send-email-sboyd@codeaurora.org>
References: <1433364818-6682-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1433364818-6682-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's possible, albeit unlikely, that using the of_node here will
reference freed memory. Call of_node_put() after printing the
name to be safe.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/kernel/perf_event.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 357f57ea83f4..54272e0be713 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -818,12 +818,13 @@ static int of_pmu_irq_cfg(struct arm_pmu *pmu)
 			if (arch_find_n_match_cpu_physical_id(dn, cpu, NULL))
 				break;
 
-		of_node_put(dn);
 		if (cpu >= nr_cpu_ids) {
 			pr_warn("Failed to find logical CPU for %s\n",
 				dn->name);
+			of_node_put(dn);
 			break;
 		}
+		of_node_put(dn);
 
 		irqs[i] = cpu;
 		cpumask_set_cpu(cpu, &pmu->supported_cpus);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
