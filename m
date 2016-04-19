From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 19 Apr 2016 13:30:11 +0100
Subject: [PATCH v4 3/5] drivers: psci: refactor psci_cpu_init_idle in
 preparation for ACPI LPI support
In-Reply-To: <1461069013-13292-1-git-send-email-sudeep.holla@arm.com>
References: <1461069013-13292-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1461069013-13292-4-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Inorder to accomodate bot DT and ACPI LPI support in psci_cpu_init_idle,
move the device tree specific into psci_dt_cpu_init_idle.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/psci.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 11bfee8b79a9..af6c5c839568 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -250,11 +250,11 @@ static int __init psci_features(u32 psci_func_id)
 #ifdef CONFIG_CPU_IDLE
 static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
 
-static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
+static int psci_dt_cpu_init_idle(unsigned int cpu)
 {
 	int i, ret, count = 0;
 	u32 *psci_states;
-	struct device_node *state_node;
+	struct device_node *state_node, *cpu_node;
 
 	/*
 	 * If the PSCI cpu_suspend function hook has not been initialized
@@ -263,6 +263,10 @@ static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
 	if (!psci_ops.cpu_suspend)
 		return -EOPNOTSUPP;
 
+	cpu_node = of_get_cpu_node(cpu, NULL);
+	if (!cpu_node)
+		return -ENODEV;
+
 	/* Count idle states */
 	while ((state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
 					      count))) {
@@ -303,27 +307,18 @@ static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
 	}
 	/* Idle states parsed correctly, initialize per-cpu pointer */
 	per_cpu(psci_power_state, cpu) = psci_states;
+	of_node_put(cpu_node);
 	return 0;
 
 free_mem:
+	of_node_put(cpu_node);
 	kfree(psci_states);
 	return ret;
 }
 
 int psci_cpu_init_idle(unsigned int cpu)
 {
-	struct device_node *cpu_node;
-	int ret;
-
-	cpu_node = of_get_cpu_node(cpu, NULL);
-	if (!cpu_node)
-		return -ENODEV;
-
-	ret = psci_dt_cpu_init_idle(cpu_node, cpu);
-
-	of_node_put(cpu_node);
-
-	return ret;
+	return psci_dt_cpu_init_idle(cpu);
 }
 
 static int psci_suspend_finisher(unsigned long index)
-- 
1.9.1
