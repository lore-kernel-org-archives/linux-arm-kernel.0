From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 16 Oct 2014 14:59:56 +0100
Subject: [PATCH 2/3] drivers: cpuidle: add idle-state-name description to ARM
 idle states
In-Reply-To: <1413467997-32131-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1413467997-32131-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1413467997-32131-2-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM machines, where generally speaking the idle state numbering has
no fixed and standard meaning it is useful to provide a description
of the idle state inner workings for benchmarking and monitoring purposes.

This patch adds a property to the idle states bindings that if present
gives platform firmware a means of describing the idle state and export
the string description to user space.

The patch updates the DT parsing code accordingly to take the description,
if present, into consideration.

Cc: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 Documentation/devicetree/bindings/arm/idle-states.txt | 6 ++++++
 drivers/cpuidle/dt_idle_states.c                      | 7 ++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/idle-states.txt b/Documentation/devicetree/bindings/arm/idle-states.txt
index d8ab4b9..6f68718 100644
--- a/Documentation/devicetree/bindings/arm/idle-states.txt
+++ b/Documentation/devicetree/bindings/arm/idle-states.txt
@@ -331,6 +331,12 @@ follows:
 			    If property is not present the idle-state must be
 			    considered operational.
 
+	- idle-state-name:
+		Usage: Optional
+		Value type: <string>
+		Definition: A string used as a descriptive name for the idle
+			    state.
+
 	In addition to the properties listed above, a state node may require
 	additional properties specifics to the entry-method defined in the
 	idle-states node, please refer to the entry-method bindings
diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
index 22840f4..5301912 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -27,6 +27,7 @@ static int init_state_node(struct cpuidle_state *idle_state,
 {
 	int err;
 	const struct of_device_id *match_id;
+	const char *desc;
 
 	match_id = of_match_node(matches, state_node);
 	if (!match_id)
@@ -73,6 +74,10 @@ static int init_state_node(struct cpuidle_state *idle_state,
 		return -EINVAL;
 	}
 
+	err = of_property_read_string(state_node, "idle-state-name", &desc);
+	if (err)
+		desc = state_node->name;
+
 	idle_state->flags = CPUIDLE_FLAG_TIME_VALID;
 	if (of_property_read_bool(state_node, "local-timer-stop"))
 		idle_state->flags |= CPUIDLE_FLAG_TIMER_STOP;
@@ -82,7 +87,7 @@ static int init_state_node(struct cpuidle_state *idle_state,
 	 *	and desc become string pointers
 	 */
 	strncpy(idle_state->name, state_node->name, CPUIDLE_NAME_LEN - 1);
-	strncpy(idle_state->desc, state_node->name, CPUIDLE_DESC_LEN - 1);
+	strncpy(idle_state->desc, desc, CPUIDLE_DESC_LEN - 1);
 	return 0;
 }
 
-- 
2.1.2
