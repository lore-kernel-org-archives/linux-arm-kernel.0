From: will.deacon@arm.com (Will Deacon)
Date: Thu, 23 Apr 2015 14:50:33 +0100
Subject: [PATCH 4/4] arm64: perf: Fix the pmu node name in warning message
In-Reply-To: <1429797033-3787-1-git-send-email-will.deacon@arm.com>
References: <1429797033-3787-1-git-send-email-will.deacon@arm.com>
Message-ID: <1429797033-3787-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

With commit d5efd9cc9cf2 ("arm64: pmu: add support for interrupt-affinity
property"), we print a warning when we find a PMU SPI with a missing
missing interrupt-affinity property in a pmu node. Unfortunately, we
pass the wrong (NULL) device node to of_node_full_name, resulting in
unhelpful messages such as:

 hw perfevents: Failed to parse <no-node>/interrupt-affinity[0]

This patch fixes the name to that of the pmu node.

Fixes: d5efd9cc9cf2 (arm64: pmu: add support for interrupt-affinity property)
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/perf_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 2a9cbcb61126..23f25acf43a9 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1332,7 +1332,7 @@ static int armpmu_device_probe(struct platform_device *pdev)
 				      i);
 		if (!dn) {
 			pr_warn("Failed to parse %s/interrupt-affinity[%d]\n",
-				of_node_full_name(dn), i);
+				of_node_full_name(pdev->dev.of_node), i);
 			break;
 		}
 
-- 
2.1.4
