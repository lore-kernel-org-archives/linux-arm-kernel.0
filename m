From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed,  3 Jun 2015 13:53:37 -0700
Subject: [PATCH 1/2] arm64: perf: Don't use of_node after putting it
Message-ID: <1433364818-6682-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's possible, albeit unlikely, that using the of_node here will
reference freed memory. Call of_node_put() after printing the
name to be safe.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm64/kernel/perf_event.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 702591f6180a..8af7784a8e35 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1340,12 +1340,13 @@ static int armpmu_device_probe(struct platform_device *pdev)
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
 	}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
