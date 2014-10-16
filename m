From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 16 Oct 2014 14:59:55 +0100
Subject: [PATCH 1/3] drivers: cpuidle: add status property to ARM idle states
Message-ID: <1413467997-32131-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some platforms the device tree bindings must provide the kernel
with a status flag for idle states, that defines whether the idle
state is operational or not in the current configuration.

This patch adds a status property to the ARM idle states compliant
with ePAPR v1.1 and updates the DT parsing code accordingly.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 Documentation/devicetree/bindings/arm/idle-states.txt | 14 ++++++++++++++
 drivers/cpuidle/dt_idle_states.c                      |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/idle-states.txt b/Documentation/devicetree/bindings/arm/idle-states.txt
index 37375c7..d8ab4b9 100644
--- a/Documentation/devicetree/bindings/arm/idle-states.txt
+++ b/Documentation/devicetree/bindings/arm/idle-states.txt
@@ -317,6 +317,20 @@ follows:
 			    In such systems entry-latency-us + exit-latency-us
 			    will exceed wakeup-latency-us by this duration.
 
+	- status:
+		Usage: Optional
+		Value type: <string>
+		Definition: A standard device tree property [5] that indicates
+			    the operational status of an idle-state.
+			    If present, it shall be:
+			    "okay": to indicate that the idle state is
+				    operational.
+			    "disabled": to indicate that the idle state has
+					been disabled in firmware so it is not
+					operational.
+			    If property is not present the idle-state must be
+			    considered operational.
+
 	In addition to the properties listed above, a state node may require
 	additional properties specifics to the entry-method defined in the
 	idle-states node, please refer to the entry-method bindings
diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
index 52f4d11..22840f4 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -169,6 +169,9 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
 		if (!state_node)
 			break;
 
+		if (!of_device_is_available(state_node))
+			continue;
+
 		if (!idle_state_valid(state_node, i, cpumask)) {
 			pr_warn("%s idle state not valid, bailing out\n",
 				state_node->full_name);
-- 
2.1.2
