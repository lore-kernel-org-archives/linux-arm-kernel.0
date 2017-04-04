From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  4 Apr 2017 18:18:15 +0100
Subject: [PATCH v3 07/18] arm64: arch_timer: Add erratum handler for
 CPU-specific capability
In-Reply-To: <20170404171826.25030-1-marc.zyngier@arm.com>
References: <20170404171826.25030-1-marc.zyngier@arm.com>
Message-ID: <20170404171826.25030-8-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Should we ever have a workaround for an erratum that is detected using
a capability and affecting a particular CPU, it'd be nice to have
a way to probe them directly.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/arch_timer.h  |  1 +
 drivers/clocksource/arm_arch_timer.c | 28 ++++++++++++++++++++++++----
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 5cd964e90d11..1b0d7e994e0c 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -39,6 +39,7 @@ extern struct static_key_false arch_timer_read_ool_enabled;
 
 enum arch_timer_erratum_match_type {
 	ate_match_dt,
+	ate_match_local_cap_id,
 };
 
 struct arch_timer_erratum_workaround {
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 5c5c2af74ad9..532e47fa43b3 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -214,6 +214,13 @@ bool arch_timer_check_dt_erratum(const struct arch_timer_erratum_workaround *wa,
 	return of_property_read_bool(np, wa->id);
 }
 
+static
+bool arch_timer_check_local_cap_erratum(const struct arch_timer_erratum_workaround *wa,
+					const void *arg)
+{
+	return this_cpu_has_cap((uintptr_t)wa->id);
+}
+
 static const struct arch_timer_erratum_workaround *
 arch_timer_iterate_errata(enum arch_timer_erratum_match_type type,
 			  ate_match_fn_t match_fn,
@@ -244,14 +251,16 @@ static void arch_timer_check_ool_workaround(enum arch_timer_erratum_match_type t
 {
 	const struct arch_timer_erratum_workaround *wa;
 	ate_match_fn_t match_fn = NULL;
-
-	if (static_branch_unlikely(&arch_timer_read_ool_enabled))
-		return;
+	bool local = false;
 
 	switch (type) {
 	case ate_match_dt:
 		match_fn = arch_timer_check_dt_erratum;
 		break;
+	case ate_match_local_cap_id:
+		match_fn = arch_timer_check_local_cap_erratum;
+		local = true;
+		break;
 	default:
 		WARN_ON(1);
 		return;
@@ -261,8 +270,17 @@ static void arch_timer_check_ool_workaround(enum arch_timer_erratum_match_type t
 	if (!wa)
 		return;
 
+	if (needs_unstable_timer_counter_workaround()) {
+		if (wa != timer_unstable_counter_workaround)
+			pr_warn("Can't enable workaround for %s (clashes with %s\n)",
+				wa->desc,
+				timer_unstable_counter_workaround->desc);
+		return;
+	}
+
 	arch_timer_enable_workaround(wa);
-	pr_info("Enabling global workaround for %s\n", wa->desc);
+	pr_info("Enabling %s workaround for %s\n",
+		local ? "local" : "global", wa->desc);
 }
 
 #else
@@ -522,6 +540,8 @@ static void __arch_timer_setup(unsigned type,
 			BUG();
 		}
 
+		arch_timer_check_ool_workaround(ate_match_local_cap_id, NULL);
+
 		erratum_workaround_set_sne(clk);
 	} else {
 		clk->features |= CLOCK_EVT_FEAT_DYNIRQ;
-- 
2.11.0
