From: robh@kernel.org (Rob Herring)
Date: Tue, 18 Jul 2017 16:43:01 -0500
Subject: [PATCH] firmware: Convert to using %pOF instead of full_name
Message-ID: <20170718214339.7774-21-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a custom printf format specifier, convert users of
full_name to use %pOF instead. This is preparation to remove storing
of the full path string for each node.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/firmware/arm_scpi.c | 2 +-
 drivers/firmware/psci.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 8043e51de897..59190c374696 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -965,7 +965,7 @@ static int scpi_probe(struct platform_device *pdev)

 	count = of_count_phandle_with_args(np, "mboxes", "#mbox-cells");
 	if (count < 0) {
-		dev_err(dev, "no mboxes property in '%s'\n", np->full_name);
+		dev_err(dev, "no mboxes property in '%pOF'\n", np);
 		return -ENODEV;
 	}

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 493a56a4cfc4..d687ca3d5049 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -280,8 +280,8 @@ static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
 					   "arm,psci-suspend-param",
 					   &state);
 		if (ret) {
-			pr_warn(" * %s missing arm,psci-suspend-param property\n",
-				state_node->full_name);
+			pr_warn(" * %pOF missing arm,psci-suspend-param property\n",
+				state_node);
 			of_node_put(state_node);
 			goto free_mem;
 		}
--
2.11.0
