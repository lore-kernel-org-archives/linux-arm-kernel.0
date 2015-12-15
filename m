From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 15 Dec 2015 17:33:44 +0900
Subject: [PATCH v7 6/6] arm64: ftrace: add a test of function prologue analyzer
In-Reply-To: <1450168424-10010-1-git-send-email-takahiro.akashi@linaro.org>
References: <1450168424-10010-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1450168424-10010-7-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch ("arm64: ftrace: add arch-specific stack tracer") introduced
a function prologue analyzer.

Given that there is no fixed template for a function prologue, at least
on gcc for aarch64, a function prologue analyzer may be rather heuristic.

So this patch allows us to run a basic test in boot time by executing
an analyzer against all the *traceable* functions. The test can be turned
on and off with a kernel command line option,
function_prologue_analyzer_test.

For function_prologue_analyzer_test=2, the output looks like:

       po sp    fp       symbol
       == ==    ==       ======
    0: 0  0x040 0x000 OK gic_handle_irq+0x20/0xa4
    1: 0  0x040 0x000 OK gic_handle_irq+0x34/0x114
    2: 0  0x030 0x000 OK run_init_process+0x14/0x48
    3: 0  0x020 0x000 OK try_to_run_init_process+0x14/0x58
    4: 0  0x080 0x000 OK do_one_initcall+0x1c/0x194
    ...
22959: 0  0x020 0x000 OK tty_lock_slave+0x14/0x3c
22960: 0  0x020 0x000 OK tty_unlock_slave+0x14/0x3c
function prologue analyzer test: 0 errors

Here,
    pos = analyze_function_prologue(unsigned long pc,
				    unsigned long *size,
				    unsigned long *size2);
	pos   -> "po"
	size  -> "sp"
	size2 -> "fp"

and the last line shows the number of possible errors in the result.

For function_prologue_analyzer_test=1, only the last line will be shown.

Reviewed-by: Jungseok Lee <jungseoklee85@gmail.com>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/stacktrace.c |   59 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 1d18bc4..acbca22 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/ftrace.h>
+#include <linux/kallsyms.h>
 #include <linux/sched.h>
 #include <linux/stacktrace.h>
 
@@ -101,7 +102,7 @@ static int analyze_function_prologue(unsigned long pc,
 			/* exiting a basic block */
 			goto out;
 
-		if (aarch64_insn_decode_add_sub_imm(insn, &dst, &src,
+		if (!aarch64_insn_extract_add_sub_imm(insn, &dst, &src,
 					&imm, &variant, &adsb_type)) {
 			if ((adsb_type == AARCH64_INSN_ADSB_SUB) &&
 				(dst == AARCH64_INSN_REG_SP) &&
@@ -129,7 +130,7 @@ static int analyze_function_prologue(unsigned long pc,
 
 				break;
 			}
-		} else if (aarch64_insn_decode_load_store_pair(insn,
+		} else if (!aarch64_insn_extract_load_store_pair(insn,
 					&reg1, &reg2, &base, &imm,
 					&variant, &ldst_type)) {
 			if ((ldst_type ==
@@ -146,7 +147,7 @@ static int analyze_function_prologue(unsigned long pc,
 				pos = 3;
 				*size += -imm;
 			} else if ((ldst_type ==
-				AARCH64_INSN_LDST_STORE_PAIR) &&
+				AARCH64_INSN_LDST_STORE_PAIR_REG_OFFSET) &&
 			    (reg1 == AARCH64_INSN_REG_29) &&
 			    (reg2 == AARCH64_INSN_REG_30) &&
 			    (base == AARCH64_INSN_REG_SP)) {
@@ -348,5 +349,57 @@ void save_stack_trace_sp(struct stack_trace *trace,
 {
 	__save_stack_trace_tsk(current, trace, stack_dump_sp);
 }
+
+static int start_analyzer_test __initdata;
+
+static int __init enable_analyzer_test(char *str)
+{
+	get_option(&str, &start_analyzer_test);
+	return 0;
+}
+early_param("function_prologue_analyzer_test", enable_analyzer_test);
+
+static void __init do_test_function_prologue_analyzer(void)
+{
+	extern unsigned long __start_mcount_loc[];
+	extern unsigned long __stop_mcount_loc[];
+	unsigned long count, i, errors;
+	int print_once;
+
+	count = __stop_mcount_loc - __start_mcount_loc;
+	errors = print_once = 0;
+	for (i = 0; i < count; i++) {
+		unsigned long addr, sp_off, fp_off;
+		int pos;
+		bool check;
+		char buf[60];
+
+		addr = __start_mcount_loc[i];
+		pos = analyze_function_prologue(addr, &sp_off, &fp_off);
+		check = ((pos != 0) || !sp_off || (sp_off <= fp_off));
+		if (check)
+			errors++;
+		if (check || (start_analyzer_test > 1)) {
+			if (!print_once) {
+				pr_debug("       po sp    fp       symbol\n");
+				pr_debug("       == ==    ==    == ======\n");
+				print_once++;
+			}
+			sprint_symbol(buf, addr);
+			pr_debug("%5ld: %d  0x%03lx 0x%03lx %s %s\n",
+					i, pos, sp_off, fp_off,
+					check ? "NG" : "OK", buf);
+		}
+	}
+	pr_debug("function prologue analyzer test: %ld errors\n", errors);
+}
+
+static int __init test_function_prologue_analyzer(void)
+{
+	if (start_analyzer_test)
+		do_test_function_prologue_analyzer();
+	return 0;
+}
+late_initcall(test_function_prologue_analyzer);
 #endif /* CONFIG_STACK_TRACER */
 #endif
-- 
1.7.9.5
