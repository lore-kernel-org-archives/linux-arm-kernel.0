From: oss@buserror.net (Scott Wood)
Date: Fri,  9 Sep 2016 20:03:32 -0500
Subject: [PATCH v5 4/5] arm/arm64: arch_timer: Use archdata to indicate vdso
 suitability
In-Reply-To: <1473469413-11019-1-git-send-email-oss@buserror.net>
References: <1473469413-11019-1-git-send-email-oss@buserror.net>
Message-ID: <1473469413-11019-4-git-send-email-oss@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of comparing the name to a magic string, use archdata to
explicitly communicate whether the arch timer is suitable for
direct vdso access.

Signed-off-by: Scott Wood <oss@buserror.net>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig                     |  1 +
 arch/arm/include/asm/clocksource.h   |  8 ++++++++
 arch/arm/kernel/vdso.c               |  2 +-
 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/clocksource.h |  8 ++++++++
 arch/arm64/kernel/vdso.c             |  2 +-
 drivers/clocksource/arm_arch_timer.c | 11 +++--------
 7 files changed, 23 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/include/asm/clocksource.h
 create mode 100644 arch/arm64/include/asm/clocksource.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a9c4e48..b2113c2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1,6 +1,7 @@
 config ARM
 	bool
 	default y
+	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
diff --git a/arch/arm/include/asm/clocksource.h b/arch/arm/include/asm/clocksource.h
new file mode 100644
index 0000000..0b350a7
--- /dev/null
+++ b/arch/arm/include/asm/clocksource.h
@@ -0,0 +1,8 @@
+#ifndef _ASM_CLOCKSOURCE_H
+#define _ASM_CLOCKSOURCE_H
+
+struct arch_clocksource_data {
+	bool vdso_direct;	/* Usable for direct VDSO access? */
+};
+
+#endif
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index 994e971..a0affd1 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -270,7 +270,7 @@ static bool tk_is_cntvct(const struct timekeeper *tk)
 	if (!IS_ENABLED(CONFIG_ARM_ARCH_TIMER))
 		return false;
 
-	if (strcmp(tk->tkr_mono.clock->name, "arch_sys_counter") != 0)
+	if (!tk->tkr_mono.clock->archdata.vdso_direct)
 		return false;
 
 	return true;
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index bc3f00f..c19a574 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -4,6 +4,7 @@ config ARM64
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ACPI_MCFG if ACPI
+	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
diff --git a/arch/arm64/include/asm/clocksource.h b/arch/arm64/include/asm/clocksource.h
new file mode 100644
index 0000000..0b350a7
--- /dev/null
+++ b/arch/arm64/include/asm/clocksource.h
@@ -0,0 +1,8 @@
+#ifndef _ASM_CLOCKSOURCE_H
+#define _ASM_CLOCKSOURCE_H
+
+struct arch_clocksource_data {
+	bool vdso_direct;	/* Usable for direct VDSO access? */
+};
+
+#endif
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 076312b..2fa7cf5 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -201,7 +201,7 @@ up_fail:
  */
 void update_vsyscall(struct timekeeper *tk)
 {
-	u32 use_syscall = strcmp(tk->tkr_mono.clock->name, "arch_sys_counter");
+	u32 use_syscall = !tk->tkr_mono.clock->archdata.vdso_direct;
 
 	++vdso_data->tb_seq_count;
 	smp_wmb();
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 2526543..36d4ee1 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -606,23 +606,18 @@ static void __init arch_counter_register(unsigned type)
 		else
 			arch_timer_read_counter = arch_counter_get_cntpct;
 
+		clocksource_counter.archdata.vdso_direct = true;
+
 #ifdef CONFIG_FSL_ERRATUM_A008585
 		/*
 		 * Don't use the vdso fastpath if errata require using
 		 * the out-of-line counter accessor.
 		 */
 		if (static_branch_unlikely(&arch_timer_read_ool_enabled))
-			clocksource_counter.name = "arch_sys_counter_ool";
+			clocksource_counter.archdata.vdso_direct = false;
 #endif
 	} else {
 		arch_timer_read_counter = arch_counter_get_cntvct_mem;
-
-		/* If the clocksource name is "arch_sys_counter" the
-		 * VDSO will attempt to read the CP15-based counter.
-		 * Ensure this does not happen when CP15-based
-		 * counter is not available.
-		 */
-		clocksource_counter.name = "arch_mem_counter";
 	}
 
 	start_count = arch_timer_read_counter();
-- 
2.7.4
