From: julien.thierry@arm.com (Julien Thierry)
Date: Mon, 12 Nov 2018 11:57:03 +0000
Subject: [PATCH v6 12/24] arm64: alternative: Allow alternative status
 checking per cpufeature
In-Reply-To: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1542023835-21446-13-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for the application of alternatives at different points
during the boot process, provide the possibility to check whether
alternatives for a feature of interest was already applied instead of
having a global boolean for all alternatives.

Make VHE enablement code check for the VHE feature instead of considering
all alternatives.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>
Cc: Christoffer Dall <Christoffer.Dall@arm.com>
---
 arch/arm64/include/asm/alternative.h |  3 +--
 arch/arm64/kernel/alternative.c      | 21 +++++++++++++++++----
 arch/arm64/kernel/cpufeature.c       |  2 +-
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index 4b650ec..9806a23 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -14,8 +14,6 @@
 #include <linux/stddef.h>
 #include <linux/stringify.h>
 
-extern int alternatives_applied;
-
 struct alt_instr {
 	s32 orig_offset;	/* offset to original instruction */
 	s32 alt_offset;		/* offset to replacement instruction */
@@ -28,6 +26,7 @@ typedef void (*alternative_cb_t)(struct alt_instr *alt,
 				 __le32 *origptr, __le32 *updptr, int nr_inst);
 
 void __init apply_alternatives_all(void);
+bool alternative_is_applied(u16 cpufeature);
 
 #ifdef CONFIG_MODULES
 void apply_alternatives_module(void *start, size_t length);
diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index b5d6039..c947d22 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -32,13 +32,23 @@
 #define ALT_ORIG_PTR(a)		__ALT_PTR(a, orig_offset)
 #define ALT_REPL_PTR(a)		__ALT_PTR(a, alt_offset)
 
-int alternatives_applied;
+static int all_alternatives_applied;
+
+static DECLARE_BITMAP(applied_alternatives, ARM64_NCAPS);
 
 struct alt_region {
 	struct alt_instr *begin;
 	struct alt_instr *end;
 };
 
+bool alternative_is_applied(u16 cpufeature)
+{
+	if (WARN_ON(cpufeature >= ARM64_NCAPS))
+		return false;
+
+	return test_bit(cpufeature, applied_alternatives);
+}
+
 /*
  * Check if the target PC is within an alternative block.
  */
@@ -192,6 +202,9 @@ static void __apply_alternatives(void *alt_region, bool is_module)
 		dsb(ish);
 		__flush_icache_all();
 		isb();
+
+		/* We applied all that was available */
+		bitmap_copy(applied_alternatives, cpu_hwcaps, ARM64_NCAPS);
 	}
 }
 
@@ -208,14 +221,14 @@ static int __apply_alternatives_multi_stop(void *unused)
 
 	/* We always have a CPU 0 at this point (__init) */
 	if (smp_processor_id()) {
-		while (!READ_ONCE(alternatives_applied))
+		while (!READ_ONCE(all_alternatives_applied))
 			cpu_relax();
 		isb();
 	} else {
-		BUG_ON(alternatives_applied);
+		BUG_ON(all_alternatives_applied);
 		__apply_alternatives(&region, false);
 		/* Barriers provided by the cache flushing */
-		WRITE_ONCE(alternatives_applied, 1);
+		WRITE_ONCE(all_alternatives_applied, 1);
 	}
 
 	return 0;
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 1b5b553..dcf5d14 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1068,7 +1068,7 @@ static void cpu_copy_el2regs(const struct arm64_cpu_capabilities *__unused)
 	 * that, freshly-onlined CPUs will set tpidr_el2, so we don't need to
 	 * do anything here.
 	 */
-	if (!alternatives_applied)
+	if (!alternative_is_applied(ARM64_HAS_VIRT_HOST_EXTN))
 		write_sysreg(read_sysreg(tpidr_el1), tpidr_el2);
 }
 #endif
-- 
1.9.1
