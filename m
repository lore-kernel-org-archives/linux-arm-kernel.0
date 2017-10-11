From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 11 Oct 2017 14:00:58 +0100
Subject: [RFC 3/7] arm64: alternative: Apply alternatives early in boot process
In-Reply-To: <1507726862-11944-1-git-send-email-julien.thierry@arm.com>
References: <1507726862-11944-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1507726862-11944-4-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Thompson <daniel.thompson@linaro.org>

Currently alternatives are applied very late in the boot process (and
a long time after we enable scheduling). Some alternative sequences,
such as those that alter the way CPU context is stored, must be applied
much earlier in the boot sequence.

Introduce apply_alternatives_early() to allow some alternatives to be
applied immediately after we detect the CPU features of the boot CPU.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/alternative.h |  1 +
 arch/arm64/kernel/alternative.c      | 39 +++++++++++++++++++++++++++++++++---
 arch/arm64/kernel/smp.c              |  6 ++++++
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index 6e1cb8c..01792d5 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -19,6 +19,7 @@ struct alt_instr {
 	u8  alt_len;		/* size of new instruction(s), <= orig_len */
 };

+void __init apply_alternatives_early(void);
 void __init apply_alternatives_all(void);
 void apply_alternatives(void *start, size_t length);

diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index 6dd0a3a3..78051d4 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -28,6 +28,18 @@
 #include <asm/sections.h>
 #include <linux/stop_machine.h>

+/*
+ * early-apply features are detected using only the boot CPU and checked on
+ * secondary CPUs startup, even then,
+ * These early-apply features should only include features where we must
+ * patch the kernel very early in the boot process.
+ *
+ * Note that the cpufeature logic *must* be made aware of early-apply
+ * features to ensure they are reported as enabled without waiting
+ * for other CPUs to boot.
+ */
+#define EARLY_APPLY_FEATURE_MASK BIT(ARM64_HAS_SYSREG_GIC_CPUIF)
+
 #define __ALT_PTR(a,f)		((void *)&(a)->f + (a)->f)
 #define ALT_ORIG_PTR(a)		__ALT_PTR(a, orig_offset)
 #define ALT_REPL_PTR(a)		__ALT_PTR(a, alt_offset)
@@ -105,7 +117,8 @@ static u32 get_alt_insn(struct alt_instr *alt, __le32 *insnptr, __le32 *altinsnp
 	return insn;
 }

-static void __apply_alternatives(void *alt_region, bool use_linear_alias)
+static void __apply_alternatives(void *alt_region,  bool use_linear_alias,
+				 unsigned long feature_mask)
 {
 	struct alt_instr *alt;
 	struct alt_region *region = alt_region;
@@ -115,6 +128,9 @@ static void __apply_alternatives(void *alt_region, bool use_linear_alias)
 		u32 insn;
 		int i, nr_inst;

+		if ((BIT(alt->cpufeature) & feature_mask) == 0)
+			continue;
+
 		if (!cpus_have_cap(alt->cpufeature))
 			continue;

@@ -138,6 +154,21 @@ static void __apply_alternatives(void *alt_region, bool use_linear_alias)
 }

 /*
+ * This is called very early in the boot process (directly after we run
+ * a feature detect on the boot CPU). No need to worry about other CPUs
+ * here.
+ */
+void apply_alternatives_early(void)
+{
+	struct alt_region region = {
+		.begin	= (struct alt_instr *)__alt_instructions,
+		.end	= (struct alt_instr *)__alt_instructions_end,
+	};
+
+	__apply_alternatives(&region, true, EARLY_APPLY_FEATURE_MASK);
+}
+
+/*
  * We might be patching the stop_machine state machine, so implement a
  * really simple polling protocol here.
  */
@@ -156,7 +187,9 @@ static int __apply_alternatives_multi_stop(void *unused)
 		isb();
 	} else {
 		BUG_ON(patched);
-		__apply_alternatives(&region, true);
+
+		__apply_alternatives(&region, true, ~EARLY_APPLY_FEATURE_MASK);
+
 		/* Barriers provided by the cache flushing */
 		WRITE_ONCE(patched, 1);
 	}
@@ -177,5 +210,5 @@ void apply_alternatives(void *start, size_t length)
 		.end	= start + length,
 	};

-	__apply_alternatives(&region, false);
+	__apply_alternatives(&region, false, -1);
 }
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 9f7195a..84c6983 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -455,6 +455,12 @@ void __init smp_prepare_boot_cpu(void)
 	 * cpuinfo_store_boot_cpu() above.
 	 */
 	update_cpu_errata_workarounds();
+	/*
+	 * We now know enough about the boot CPU to apply the
+	 * alternatives that cannot wait until interrupt handling
+	 * and/or scheduling is enabled.
+	 */
+	apply_alternatives_early();
 }

 static u64 __init of_get_cpu_mpidr(struct device_node *dn)
--
1.9.1
