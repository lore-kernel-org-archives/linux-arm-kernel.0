From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Jul 2017 18:15:41 +0100
Subject: [PATCH 15/16] clocksource/arm_arch_timer: Add helper to disable VDSO
 fastpath
In-Reply-To: <20170721171542.27639-1-marc.zyngier@arm.com>
References: <20170721171542.27639-1-marc.zyngier@arm.com>
Message-ID: <20170721171542.27639-16-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we are going to add more paths where we have to disable the
counter access in the VDSO, let's add a helper that does exactly that.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index aae87c4c546e..4f4633157978 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -188,6 +188,22 @@ struct ate_acpi_oem_info {
 	u32 oem_revision;
 };
 
+static void __maybe_unused disable_vdso(void)
+{
+	/*
+	 * Don't use the vdso fastpath if errata require using the
+	 * out-of-line counter accessor and/or trap its access. We may
+	 * change our mind pretty late in the game (with a per-CPU
+	 * erratum, for example), so change both the default value and
+	 * the vdso itself.
+	 */
+	if (vdso_default) {
+		pr_info("Disabling VDSO direct access\n");
+		clocksource_counter.archdata.vdso_direct = false;
+		vdso_default = false;
+	}
+}
+
 #ifdef CONFIG_FSL_ERRATUM_A008585
 /*
  * The number of retries is an arbitrary value well beyond the highest number
@@ -457,16 +473,8 @@ void arch_timer_enable_workaround(const struct arch_timer_erratum_workaround *wa
 
 	static_branch_enable(&arch_timer_read_ool_enabled);
 
-	/*
-	 * Don't use the vdso fastpath if errata require using the
-	 * out-of-line counter accessor. We may change our mind pretty
-	 * late in the game (with a per-CPU erratum, for example), so
-	 * change both the default value and the vdso itself.
-	 */
-	if (wa->read_cntvct_el0) {
-		clocksource_counter.archdata.vdso_direct = false;
-		vdso_default = false;
-	}
+	if (wa->read_cntvct_el0)
+		disable_vdso();
 }
 
 static void arch_timer_check_ool_workaround(enum arch_timer_erratum_match_type type,
-- 
2.11.0
