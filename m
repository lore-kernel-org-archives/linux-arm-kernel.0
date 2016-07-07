From: oss@buserror.net (Scott Wood)
Date: Thu,  7 Jul 2016 02:46:12 -0500
Subject: [PATCH v4 4/4] arm/arm64: arch_timer: Use archdata to indicate vdso
 suitability
In-Reply-To: <1467877572-10817-1-git-send-email-oss@buserror.net>
References: <1467877572-10817-1-git-send-email-oss@buserror.net>
Message-ID: <1467877572-10817-4-git-send-email-oss@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of comparing the name to a magic string, use archdata to
explicitly communicate whether the arch timer is suitable for
direct vdso access.

Signed-off-by: Scott Wood <oss@buserror.net>
---
v4: new patch

I'm putting this after the other patches, in the hopes that if there
are issues with this patch, it doesn't hold up the others.

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
index 90542db..dcdcd78 100644
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
index 5a0a691..24c4b2c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -3,6 +3,7 @@ config ARM64
 	select ACPI_CCA_REQUIRED if ACPI
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
+	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_ELF_RANDOMIZE
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
index 9fefb00..ee107f2 100644
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
index b857027..a5654a4 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -575,23 +575,18 @@ static void __init arch_counter_register(unsigned type)
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
