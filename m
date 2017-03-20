From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 20 Mar 2017 17:48:18 +0000
Subject: [PATCH v2 07/18] arm64: arch_timer: Add erratum handler for globally
 defined capability
In-Reply-To: <20170320174829.28182-1-marc.zyngier@arm.com>
References: <20170320174829.28182-1-marc.zyngier@arm.com>
Message-ID: <20170320174829.28182-8-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Should we ever have a workaround for an erratum that is detected using
a capability (and affecting the whole system), it'd be nice to have
a way to probe them directly.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/arch_timer.h  |  1 +
 drivers/clocksource/arm_arch_timer.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 5cd964e90d11..48bd730d568f 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -39,6 +39,7 @@ extern struct static_key_false arch_timer_read_ool_enabled;
 
 enum arch_timer_erratum_match_type {
 	ate_match_dt,
+	ate_match_global_cap_id,
 };
 
 struct arch_timer_erratum_workaround {
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 6a0f0e161a0f..a0b1108a4a24 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -214,6 +214,13 @@ bool arch_timer_check_dt_erratum(const struct arch_timer_erratum_workaround *wa,
 	return of_property_read_bool(np, wa->id);
 }
 
+static
+bool arch_timer_check_global_cap_erratum(const struct arch_timer_erratum_workaround *wa,
+					 const void *arg)
+{
+	return cpus_have_cap((uintptr_t)wa->id);
+}
+
 static const struct arch_timer_erratum_workaround *
 arch_timer_iterate_errata(enum arch_timer_erratum_match_type type,
 			  ate_match_fn_t match_fn,
@@ -252,6 +259,9 @@ static void arch_timer_check_ool_workaround(enum arch_timer_erratum_match_type t
 	case ate_match_dt:
 		match_fn = arch_timer_check_dt_erratum;
 		break;
+	case ate_match_global_cap_id:
+		match_fn = arch_timer_check_global_cap_erratum;
+		break;
 	}
 
 	wa = arch_timer_iterate_errata(type, match_fn, arg);
@@ -1029,6 +1039,7 @@ static int __init arch_timer_of_init(struct device_node *np)
 
 	/* Check for globally applicable workarounds */
 	arch_timer_check_ool_workaround(ate_match_dt, np);
+	arch_timer_check_ool_workaround(ate_match_global_cap_id, NULL);
 
 	/*
 	 * If we cannot rely on firmware initializing the timer registers then
@@ -1185,6 +1196,9 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 	/* Always-on capability */
 	arch_timer_c3stop = !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
 
+	/* Check for globally applicable workarounds */
+	arch_timer_check_ool_workaround(ate_match_global_cap_id, NULL);
+
 	arch_timer_init();
 	return 0;
 }
-- 
2.11.0
