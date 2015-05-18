From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 May 2015 11:38:18 +0100
Subject: [PATCHv2 07/12] arm64: psci: kill psci_power_state
In-Reply-To: <1431945503-6939-1-git-send-email-mark.rutland@arm.com>
References: <1431945503-6939-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1431945503-6939-8-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A PSCI 1.0 implementation may choose to use the new extended StateID
format, the presence of which may be queried via the PSCI_FEATURES call.
The layout of this new StateID format is incompatible with the existing
format, and so to handle both we must abstract attempts to parse the
fields.

In preparation for PSCI 1.0 support, this patch introduces
psci_power_state_loses_context and psci_power_state_is_valid functions
to query information from a PSCI power state, which is no longer
decomposed (and hence the pack/unpack functions are removed). As it is
no longer decomposed, it is now passed round as an opaque u32 token.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/psci.c | 89 ++++++++++++++++++++----------------------------
 1 file changed, 37 insertions(+), 52 deletions(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 3ef677e..4ef9472 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -37,11 +37,19 @@
 #define PSCI_POWER_STATE_TYPE_STANDBY		0
 #define PSCI_POWER_STATE_TYPE_POWER_DOWN	1
 
-struct psci_power_state {
-	u16	id;
-	u8	type;
-	u8	affinity_level;
-};
+static bool psci_power_state_loses_context(u32 state)
+{
+	return !!(state & PSCI_0_2_POWER_STATE_TYPE_MASK);
+}
+
+static bool psci_power_state_is_valid(u32 state)
+{
+	const u32 valid_mask = PSCI_0_2_POWER_STATE_ID_MASK |
+			       PSCI_0_2_POWER_STATE_TYPE_MASK |
+			       PSCI_0_2_POWER_STATE_AFFL_MASK;
+
+	return !(state & ~valid_mask);
+}
 
 /*
  * The CPU any Trusted OS is resident on. The trusted OS may reject CPU_OFF
@@ -57,9 +65,8 @@ static bool psci_tos_resident_on(int cpu)
 }
 
 struct psci_operations {
-	int (*cpu_suspend)(struct psci_power_state state,
-			   unsigned long entry_point);
-	int (*cpu_off)(struct psci_power_state state);
+	int (*cpu_suspend)(u32 state, unsigned long entry_point);
+	int (*cpu_off)(u32 state);
 	int (*cpu_on)(unsigned long cpuid, unsigned long entry_point);
 	int (*migrate)(unsigned long cpuid);
 	int (*affinity_info)(unsigned long target_affinity,
@@ -83,7 +90,7 @@ enum psci_function {
 	PSCI_FN_MAX,
 };
 
-static DEFINE_PER_CPU_READ_MOSTLY(struct psci_power_state *, psci_power_state);
+static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
 
 static u32 psci_function_id[PSCI_FN_MAX];
 
@@ -103,53 +110,28 @@ static int psci_to_linux_errno(int errno)
 	return -EINVAL;
 }
 
-static u32 psci_power_state_pack(struct psci_power_state state)
-{
-	return ((state.id << PSCI_0_2_POWER_STATE_ID_SHIFT)
-			& PSCI_0_2_POWER_STATE_ID_MASK) |
-		((state.type << PSCI_0_2_POWER_STATE_TYPE_SHIFT)
-		 & PSCI_0_2_POWER_STATE_TYPE_MASK) |
-		((state.affinity_level << PSCI_0_2_POWER_STATE_AFFL_SHIFT)
-		 & PSCI_0_2_POWER_STATE_AFFL_MASK);
-}
-
-static void psci_power_state_unpack(u32 power_state,
-				    struct psci_power_state *state)
-{
-	state->id = (power_state & PSCI_0_2_POWER_STATE_ID_MASK) >>
-			PSCI_0_2_POWER_STATE_ID_SHIFT;
-	state->type = (power_state & PSCI_0_2_POWER_STATE_TYPE_MASK) >>
-			PSCI_0_2_POWER_STATE_TYPE_SHIFT;
-	state->affinity_level =
-			(power_state & PSCI_0_2_POWER_STATE_AFFL_MASK) >>
-			PSCI_0_2_POWER_STATE_AFFL_SHIFT;
-}
-
 static u32 psci_get_version(void)
 {
 	return invoke_psci_fn(PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0);
 }
 
-static int psci_cpu_suspend(struct psci_power_state state,
-			    unsigned long entry_point)
+static int psci_cpu_suspend(u32 state, unsigned long entry_point)
 {
 	int err;
-	u32 fn, power_state;
+	u32 fn;
 
 	fn = psci_function_id[PSCI_FN_CPU_SUSPEND];
-	power_state = psci_power_state_pack(state);
-	err = invoke_psci_fn(fn, power_state, entry_point, 0);
+	err = invoke_psci_fn(fn, state, entry_point, 0);
 	return psci_to_linux_errno(err);
 }
 
-static int psci_cpu_off(struct psci_power_state state)
+static int psci_cpu_off(u32 state)
 {
 	int err;
-	u32 fn, power_state;
+	u32 fn;
 
 	fn = psci_function_id[PSCI_FN_CPU_OFF];
-	power_state = psci_power_state_pack(state);
-	err = invoke_psci_fn(fn, power_state, 0, 0);
+	err = invoke_psci_fn(fn, state, 0, 0);
 	return psci_to_linux_errno(err);
 }
 
@@ -194,7 +176,7 @@ static int __maybe_unused cpu_psci_cpu_init_idle(struct device_node *cpu_node,
 						 unsigned int cpu)
 {
 	int i, ret, count = 0;
-	struct psci_power_state *psci_states;
+	u32 *psci_states;
 	struct device_node *state_node;
 
 	/*
@@ -219,13 +201,13 @@ static int __maybe_unused cpu_psci_cpu_init_idle(struct device_node *cpu_node,
 		return -ENOMEM;
 
 	for (i = 0; i < count; i++) {
-		u32 psci_power_state;
+		u32 state;
 
 		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
 
 		ret = of_property_read_u32(state_node,
 					   "arm,psci-suspend-param",
-					   &psci_power_state);
+					   &state);
 		if (ret) {
 			pr_warn(" * %s missing arm,psci-suspend-param property\n",
 				state_node->full_name);
@@ -234,9 +216,13 @@ static int __maybe_unused cpu_psci_cpu_init_idle(struct device_node *cpu_node,
 		}
 
 		of_node_put(state_node);
-		pr_debug("psci-power-state %#x index %d\n", psci_power_state,
-							    i);
-		psci_power_state_unpack(psci_power_state, &psci_states[i]);
+		pr_debug("psci-power-state %#x index %d\n", state, i);
+		if (!psci_power_state_is_valid(state)) {
+			pr_warn("Invalid PSCI power state %#x\n", state);
+			ret = -EINVAL;
+			goto free_mem;
+		}
+		psci_states[i] = state;
 	}
 	/* Idle states parsed correctly, initialize per-cpu pointer */
 	per_cpu(psci_power_state, cpu) = psci_states;
@@ -518,9 +504,8 @@ static void cpu_psci_cpu_die(unsigned int cpu)
 	 * There are no known implementations of PSCI actually using the
 	 * power state field, pass a sensible default for now.
 	 */
-	struct psci_power_state state = {
-		.type = PSCI_POWER_STATE_TYPE_POWER_DOWN,
-	};
+	u32 state = PSCI_POWER_STATE_TYPE_POWER_DOWN <<
+		    PSCI_0_2_POWER_STATE_TYPE_SHIFT;
 
 	ret = psci_ops.cpu_off(state);
 
@@ -559,7 +544,7 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
 
 static int psci_suspend_finisher(unsigned long index)
 {
-	struct psci_power_state *state = __this_cpu_read(psci_power_state);
+	u32 *state = __this_cpu_read(psci_power_state);
 
 	return psci_ops.cpu_suspend(state[index - 1],
 				    virt_to_phys(cpu_resume));
@@ -568,7 +553,7 @@ static int psci_suspend_finisher(unsigned long index)
 static int __maybe_unused cpu_psci_cpu_suspend(unsigned long index)
 {
 	int ret;
-	struct psci_power_state *state = __this_cpu_read(psci_power_state);
+	u32 *state = __this_cpu_read(psci_power_state);
 	/*
 	 * idle state index 0 corresponds to wfi, should never be called
 	 * from the cpu_suspend operations
@@ -576,7 +561,7 @@ static int __maybe_unused cpu_psci_cpu_suspend(unsigned long index)
 	if (WARN_ON_ONCE(!index))
 		return -EINVAL;
 
-	if (state[index - 1].type == PSCI_POWER_STATE_TYPE_STANDBY)
+	if (!psci_power_state_loses_context(state[index - 1]))
 		ret = psci_ops.cpu_suspend(state[index - 1], 0);
 	else
 		ret = __cpu_suspend(index, psci_suspend_finisher);
-- 
1.9.1
