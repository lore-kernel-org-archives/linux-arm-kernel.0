From: robh@kernel.org (Rob Herring)
Date: Tue, 18 Jul 2017 16:43:22 -0500
Subject: [PATCH] perf: Convert to using %pOF instead of full_name
Message-ID: <20170718214339.7774-42-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a custom printf format specifier, convert users of
full_name to use %pOF instead. This is preparation to remove storing
of the full path string for each node.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/perf/arm_pmu_platform.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
index 69255f53057a..4eafa7a42e52 100644
--- a/drivers/perf/arm_pmu_platform.c
+++ b/drivers/perf/arm_pmu_platform.c
@@ -131,8 +131,8 @@ static int pmu_parse_irqs(struct arm_pmu *pmu)
 	}

 	if (!pmu_has_irq_affinity(pdev->dev.of_node)) {
-		pr_warn("no interrupt-affinity property for %s, guessing.\n",
-			of_node_full_name(pdev->dev.of_node));
+		pr_warn("no interrupt-affinity property for %pOF, guessing.\n",
+			pdev->dev.of_node);
 	}

 	/*
@@ -211,7 +211,7 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 	}

 	if (ret) {
-		pr_info("%s: failed to probe PMU!\n", of_node_full_name(node));
+		pr_info("%pOF: failed to probe PMU!\n", node);
 		goto out_free;
 	}

@@ -228,8 +228,7 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 out_free_irqs:
 	armpmu_free_irqs(pmu);
 out_free:
-	pr_info("%s: failed to register PMU devices!\n",
-		of_node_full_name(node));
+	pr_info("%pOF: failed to register PMU devices!\n", node);
 	armpmu_free(pmu);
 	return ret;
 }
--
2.11.0
