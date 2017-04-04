From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  4 Apr 2017 18:18:25 +0100
Subject: [PATCH v3 17/18] arm64: arch_timer: Allow erratum matching with ACPI
 OEM information
In-Reply-To: <20170404171826.25030-1-marc.zyngier@arm.com>
References: <20170404171826.25030-1-marc.zyngier@arm.com>
Message-ID: <20170404171826.25030-18-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just as we're able to identify a broken platform using some DT
information, let's enable a way to spot the offenders with ACPI.

The difference is that we can only match on some OEM info instead
of implementation-specific properties. So in order to avoid the
insane multiplication of errata structures, we allow an array
of OEM descriptions to be attached to an erratum structure.

Tested-by: dann frazier <dann.frazier@canonical.com>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/arch_timer.h  |  1 +
 drivers/clocksource/arm_arch_timer.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 6bd1a9a1573a..74d08e44a651 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -41,6 +41,7 @@ extern struct static_key_false arch_timer_read_ool_enabled;
 enum arch_timer_erratum_match_type {
 	ate_match_dt,
 	ate_match_local_cap_id,
+	ate_match_acpi_oem_info,
 };
 
 struct clock_event_device;
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 8459d19a84f5..887f6d00a71d 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -190,6 +190,12 @@ static struct cyclecounter cyclecounter __ro_after_init = {
 	.mask	= CLOCKSOURCE_MASK(56),
 };
 
+struct ate_acpi_oem_info {
+	char oem_id[ACPI_OEM_ID_SIZE + 1];
+	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
+	u32 oem_revision;
+};
+
 #ifdef CONFIG_FSL_ERRATUM_A008585
 /*
  * The number of retries is an arbitrary value well beyond the highest number
@@ -371,6 +377,28 @@ bool arch_timer_check_local_cap_erratum(const struct arch_timer_erratum_workarou
 	return this_cpu_has_cap((uintptr_t)wa->id);
 }
 
+
+static
+bool arch_timer_check_acpi_oem_erratum(const struct arch_timer_erratum_workaround *wa,
+				       const void *arg)
+{
+	static const struct ate_acpi_oem_info empty_oem_info = {};
+	const struct ate_acpi_oem_info *info = wa->id;
+	const struct acpi_table_header *table = arg;
+
+	/* Iterate over the ACPI OEM info array, looking for a match */
+	while (memcmp(info, &empty_oem_info, sizeof(*info))) {
+		if (!memcmp(info->oem_id, table->oem_id, ACPI_OEM_ID_SIZE) &&
+		    !memcmp(info->oem_table_id, table->oem_table_id, ACPI_OEM_TABLE_ID_SIZE) &&
+		    info->oem_revision == table->oem_revision)
+			return true;
+
+		info++;
+	}
+
+	return false;
+}
+
 static const struct arch_timer_erratum_workaround *
 arch_timer_iterate_errata(enum arch_timer_erratum_match_type type,
 			  ate_match_fn_t match_fn,
@@ -431,6 +459,9 @@ static void arch_timer_check_ool_workaround(enum arch_timer_erratum_match_type t
 		match_fn = arch_timer_check_local_cap_erratum;
 		local = true;
 		break;
+	case ate_match_acpi_oem_info:
+		match_fn = arch_timer_check_acpi_oem_erratum;
+		break;
 	default:
 		WARN_ON(1);
 		return;
@@ -1277,6 +1308,9 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 	/* Always-on capability */
 	arch_timer_c3stop = !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
 
+	/* Check for globally applicable workarounds */
+	arch_timer_check_ool_workaround(ate_match_acpi_oem_info, table);
+
 	arch_timer_init();
 	return 0;
 }
-- 
2.11.0
