From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 19 Aug 2016 17:13:12 +0100
Subject: [RFC PATCH v3 4/7] arm64: alternative: Apply alternatives early in
 boot process
In-Reply-To: <1471623195-7829-1-git-send-email-daniel.thompson@linaro.org>
References: <1471623195-7829-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1471623195-7829-5-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently alternatives are applied very late in the boot process (and
a long time after we enable scheduling). Some alternative sequences,
such as those that alter the way CPU context is stored, must be applied
much earlier in the boot sequence.

Introduce apply_alternatives_early() to allow some alternatives to be
applied immediately after we detect the CPU features of the boot CPU.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm64/include/asm/alternative.h |  1 +
 arch/arm64/kernel/alternative.c      | 36 +++++++++++++++++++++++++++++++++---
 arch/arm64/kernel/smp.c              |  7 +++++++
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index 8746ff6abd77..2eee073668eb 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -19,6 +19,7 @@ struct alt_instr {
 	u8  alt_len;		/* size of new instruction(s), <= orig_len */
 };
 
+void __init apply_alternatives_early(void);
 void __init apply_alternatives_all(void);
 void apply_alternatives(void *start, size_t length);
 
diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index d2ee1b21a10d..9c623b7f69f8 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -27,6 +27,18 @@
 #include <asm/insn.h>
 #include <linux/stop_machine.h>
 
+/*
+ * early-apply features can be detected using only the boot CPU (i.e.
+ * no need to check capability of any secondary CPUs) and, even then,
+ * should only include features where we must patch the kernel very
+ * early in the boot process.
+ *
+ * Note that the cpufeature logic *must* be made aware of early-apply
+ * features to ensure they are reported as enabled without waiting
+ * for other CPUs to boot.
+ */
+#define EARLY_APPLY_FEATURE_MASK BIT(ARM64_HAS_SYSREG_GIC_CPUIF)
+
 #define __ALT_PTR(a,f)		(u32 *)((void *)&(a)->f + (a)->f)
 #define ALT_ORIG_PTR(a)		__ALT_PTR(a, orig_offset)
 #define ALT_REPL_PTR(a)		__ALT_PTR(a, alt_offset)
@@ -85,7 +97,7 @@ static u32 get_alt_insn(struct alt_instr *alt, u32 *insnptr, u32 *altinsnptr)
 	return insn;
 }
 
-static void __apply_alternatives(void *alt_region)
+static void __apply_alternatives(void *alt_region, unsigned long feature_mask)
 {
 	struct alt_instr *alt;
 	struct alt_region *region = alt_region;
@@ -95,6 +107,9 @@ static void __apply_alternatives(void *alt_region)
 		u32 insn;
 		int i, nr_inst;
 
+		if ((BIT(alt->cpufeature) & feature_mask) == 0)
+			continue;
+
 		if (!cpus_have_cap(alt->cpufeature))
 			continue;
 
@@ -117,6 +132,21 @@ static void __apply_alternatives(void *alt_region)
 }
 
 /*
+ * This is called very early in the boot process (directly after we run
+ * a feature detect on the boot CPU). No need to worry about other CPUs
+ * here.
+ */
+void apply_alternatives_early(void)
+{
+	struct alt_region region = {
+		.begin	= __alt_instructions,
+		.end	= __alt_instructions_end,
+	};
+
+	__apply_alternatives(&region, EARLY_APPLY_FEATURE_MASK);
+}
+
+/*
  * We might be patching the stop_machine state machine, so implement a
  * really simple polling protocol here.
  */
@@ -135,7 +165,7 @@ static int __apply_alternatives_multi_stop(void *unused)
 		isb();
 	} else {
 		BUG_ON(patched);
-		__apply_alternatives(&region);
+		__apply_alternatives(&region, ~EARLY_APPLY_FEATURE_MASK);
 		/* Barriers provided by the cache flushing */
 		WRITE_ONCE(patched, 1);
 	}
@@ -156,5 +186,5 @@ void apply_alternatives(void *start, size_t length)
 		.end	= start + length,
 	};
 
-	__apply_alternatives(&region);
+	__apply_alternatives(&region, -1);
 }
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 99f607f0fa97..c49e8874fba8 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -441,6 +441,13 @@ void __init smp_prepare_boot_cpu(void)
 	set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
 	cpuinfo_store_boot_cpu();
 	save_boot_cpu_run_el();
+
+	/*
+	 * We now know enough about the boot CPU to apply the
+	 * alternatives that cannot wait until interrupt handling
+	 * and/or scheduling is enabled.
+	 */
+	apply_alternatives_early();
 }
 
 static u64 __init of_get_cpu_mpidr(struct device_node *dn)
-- 
2.7.4
