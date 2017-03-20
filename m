From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 20 Mar 2017 17:48:26 +0000
Subject: [PATCH v2 15/18] arm64: arch_timer: Enable CNTVCT_EL0 trap if
 workaround is enabled
In-Reply-To: <20170320174829.28182-1-marc.zyngier@arm.com>
References: <20170320174829.28182-1-marc.zyngier@arm.com>
Message-ID: <20170320174829.28182-16-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Userspace being allowed to use read CNTVCT_EL0 anytime (and not
only in the VDSO), we need to enable trapping whenever a cntvct
workaround is enabled on a given CPU.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 42 +++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 70eb42bd6784..eccff0fedf2c 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -83,6 +83,7 @@ static enum ppi_nr arch_timer_uses_ppi = VIRT_PPI;
 static bool arch_timer_c3stop;
 static bool arch_timer_mem_use_virtual;
 static bool arch_counter_suspend_stop;
+static bool vdso_default = true;
 
 static bool evtstrm_enable = IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM);
 
@@ -390,6 +391,17 @@ void arch_timer_enable_workaround(const struct arch_timer_erratum_workaround *wa
 	}
 
 	static_branch_enable(&arch_timer_read_ool_enabled);
+
+	/*
+	 * Don't use the vdso fastpath if errata require using the
+	 * out-of-line counter accessor. We may change our mind pretty
+	 * late in the game (with a per-CPU erratum, for example), so
+	 * change both the default value and the vdso itself.
+	 */
+	if (wa->read_cntvct_el0) {
+		clocksource_counter.archdata.vdso_direct = false;
+		vdso_default = false;
+	}
 }
 
 static void arch_timer_check_ool_workaround(enum arch_timer_erratum_match_type type,
@@ -450,11 +462,19 @@ static void arch_timer_check_ool_workaround(enum arch_timer_erratum_match_type t
 	__val;								\
 })
 
+static bool arch_timer_this_cpu_has_cntvct_wa(void)
+{
+	const struct arch_timer_erratum_workaround *wa;
+
+	wa = __this_cpu_read(timer_unstable_counter_workaround);
+	return wa && wa->read_cntvct_el0;
+}
 #else
 #define arch_timer_check_ool_workaround(t,a)		do { } while(0)
 #define erratum_set_next_event_tval_virt(...)		({BUG(); 0;})
 #define erratum_set_next_event_tval_phys(...)		({BUG(); 0;})
 #define erratum_handler(fn, r, ...)			({false;})
+#define arch_timer_this_cpu_has_cntvct_wa()		({false;})
 #endif /* CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND */
 
 static __always_inline irqreturn_t timer_handler(const int access,
@@ -674,8 +694,15 @@ static void arch_counter_set_user_access(void)
 			| ARCH_TIMER_VIRT_EVT_EN
 			| ARCH_TIMER_USR_PCT_ACCESS_EN);
 
-	/* Enable user access to the virtual counter */
-	cntkctl |= ARCH_TIMER_USR_VCT_ACCESS_EN;
+	/*
+	 * Enable user access to the virtual counter if it doesn't
+	 * need to be workaround. The vdso may have been already
+	 * disabled though.
+	 */
+	if (arch_timer_this_cpu_has_cntvct_wa())
+		pr_info("CPU%d: Trapping CNTVCT access\n", smp_processor_id());
+	else
+		cntkctl |= ARCH_TIMER_USR_VCT_ACCESS_EN;
 
 	arch_timer_set_cntkctl(cntkctl);
 }
@@ -798,16 +825,7 @@ static void __init arch_counter_register(unsigned type)
 		else
 			arch_timer_read_counter = arch_counter_get_cntpct;
 
-		clocksource_counter.archdata.vdso_direct = true;
-
-#ifdef CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND
-		/*
-		 * Don't use the vdso fastpath if errata require using
-		 * the out-of-line counter accessor.
-		 */
-		if (static_branch_unlikely(&arch_timer_read_ool_enabled))
-			clocksource_counter.archdata.vdso_direct = false;
-#endif
+		clocksource_counter.archdata.vdso_direct = vdso_default;
 	} else {
 		arch_timer_read_counter = arch_counter_get_cntvct_mem;
 	}
-- 
2.11.0
