From: tixy@yxit.co.uk (Tixy)
Date: Sat, 10 Sep 2011 12:05:04 +0100
Subject: [PATCH v2 08/10] ARM: kprobes: Add decoding table test coverage
	analysis
In-Reply-To: <1315652706-2900-1-git-send-email-tixy@yxit.co.uk>
References: <1315652706-2900-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1315652706-2900-9-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

This is used to verify that all combinations of CPU instructions
described by the kprobes decoding tables have a test case.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-test.c |  261 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 261 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-test.c b/arch/arm/kernel/kprobes-test.c
index 74a3a34..89758a8 100644
--- a/arch/arm/kernel/kprobes-test.c
+++ b/arch/arm/kernel/kprobes-test.c
@@ -178,6 +178,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 #include <linux/kprobes.h>
 
 #include "kprobes.h"
@@ -529,6 +530,250 @@ static int table_test(const union decode_item *table)
 
 
 /*
+ * Decoding table test coverage analysis
+ *
+ * coverage_start() builds a coverage_table which contains a list of
+ * coverage_entry's to match each entry in the specified kprobes instruction
+ * decoding table.
+ *
+ * When test cases are run, coverage_add() is called to process each case.
+ * This looks up the corresponding entry in the coverage_table and sets it as
+ * being matched, as well as clearing the regs flag appropriate for the test.
+ *
+ * After all test cases have been run, coverage_end() is called to check that
+ * all entries in coverage_table have been matched and that all regs flags are
+ * cleared. I.e. that all possible combinations of instructions described by
+ * the kprobes decoding tables have had a test case executed for them.
+ */
+
+bool coverage_fail;
+
+#define MAX_COVERAGE_ENTRIES 256
+
+struct coverage_entry {
+	const struct decode_header	*header;
+	unsigned			regs;
+	unsigned			nesting;
+	char				matched;
+};
+
+struct coverage_table {
+	struct coverage_entry	*base;
+	unsigned		num_entries;
+	unsigned		nesting;
+};
+
+struct coverage_table coverage;
+
+#define COVERAGE_ANY_REG	(1<<0)
+#define COVERAGE_SP		(1<<1)
+#define COVERAGE_PC		(1<<2)
+#define COVERAGE_PCWB		(1<<3)
+
+static const char coverage_register_lookup[16] = {
+	[REG_TYPE_ANY]		= COVERAGE_ANY_REG | COVERAGE_SP | COVERAGE_PC,
+	[REG_TYPE_SAMEAS16]	= COVERAGE_ANY_REG,
+	[REG_TYPE_SP]		= COVERAGE_SP,
+	[REG_TYPE_PC]		= COVERAGE_PC,
+	[REG_TYPE_NOSP]		= COVERAGE_ANY_REG | COVERAGE_SP,
+	[REG_TYPE_NOSPPC]	= COVERAGE_ANY_REG | COVERAGE_SP | COVERAGE_PC,
+	[REG_TYPE_NOPC]		= COVERAGE_ANY_REG | COVERAGE_PC,
+	[REG_TYPE_NOPCWB]	= COVERAGE_ANY_REG | COVERAGE_PC | COVERAGE_PCWB,
+	[REG_TYPE_NOPCX]	= COVERAGE_ANY_REG,
+	[REG_TYPE_NOSPPCX]	= COVERAGE_ANY_REG | COVERAGE_SP,
+};
+
+unsigned coverage_start_registers(const struct decode_header *h)
+{
+	unsigned regs = 0;
+	int i;
+	for (i = 0; i < 20; i += 4) {
+		int r = (h->type_regs.bits >> (DECODE_TYPE_BITS + i)) & 0xf;
+		regs |= coverage_register_lookup[r] << i;
+	}
+	return regs;
+}
+
+static int coverage_start_fn(const struct decode_header *h, void *args)
+{
+	struct coverage_table *coverage = (struct coverage_table *)args;
+	enum decode_type type = h->type_regs.bits & DECODE_TYPE_MASK;
+	struct coverage_entry *entry = coverage->base + coverage->num_entries;
+
+	if (coverage->num_entries == MAX_COVERAGE_ENTRIES - 1) {
+		pr_err("FAIL: Out of space for test coverage data");
+		return -ENOMEM;
+	}
+
+	++coverage->num_entries;
+
+	entry->header = h;
+	entry->regs = coverage_start_registers(h);
+	entry->nesting = coverage->nesting;
+	entry->matched = false;
+
+	if (type == DECODE_TYPE_TABLE) {
+		struct decode_table *d = (struct decode_table *)h;
+		int ret;
+		++coverage->nesting;
+		ret = table_iter(d->table.table, coverage_start_fn, coverage);
+		--coverage->nesting;
+		return ret;
+	}
+
+	return 0;
+}
+
+static int coverage_start(const union decode_item *table)
+{
+	coverage.base = kmalloc(MAX_COVERAGE_ENTRIES *
+				sizeof(struct coverage_entry), GFP_KERNEL);
+	coverage.num_entries = 0;
+	coverage.nesting = 0;
+	return table_iter(table, coverage_start_fn, &coverage);
+}
+
+static void
+coverage_add_registers(struct coverage_entry *entry, kprobe_opcode_t insn)
+{
+	int regs = entry->header->type_regs.bits >> DECODE_TYPE_BITS;
+	int i;
+	for (i = 0; i < 20; i += 4) {
+		enum decode_reg_type reg_type = (regs >> i) & 0xf;
+		int reg = (insn >> i) & 0xf;
+		int flag;
+
+		if (!reg_type)
+			continue;
+
+		if (reg == 13)
+			flag = COVERAGE_SP;
+		else if (reg == 15)
+			flag = COVERAGE_PC;
+		else
+			flag = COVERAGE_ANY_REG;
+		entry->regs &= ~(flag << i);
+
+		switch (reg_type) {
+
+		case REG_TYPE_NONE:
+		case REG_TYPE_ANY:
+		case REG_TYPE_SAMEAS16:
+			break;
+
+		case REG_TYPE_SP:
+			if (reg != 13)
+				return;
+			break;
+
+		case REG_TYPE_PC:
+			if (reg != 15)
+				return;
+			break;
+
+		case REG_TYPE_NOSP:
+			if (reg == 13)
+				return;
+			break;
+
+		case REG_TYPE_NOSPPC:
+		case REG_TYPE_NOSPPCX:
+			if (reg == 13 || reg == 15)
+				return;
+			break;
+
+		case REG_TYPE_NOPCWB:
+			if (!is_writeback(insn))
+				break;
+			if (reg == 15) {
+				entry->regs &= ~(COVERAGE_PCWB << i);
+				return;
+			}
+			break;
+
+		case REG_TYPE_NOPC:
+		case REG_TYPE_NOPCX:
+			if (reg == 15)
+				return;
+			break;
+		}
+
+	}
+}
+
+static void coverage_add(kprobe_opcode_t insn)
+{
+	struct coverage_entry *entry = coverage.base;
+	struct coverage_entry *end = coverage.base + coverage.num_entries;
+	bool matched = false;
+	unsigned nesting = 0;
+
+	for (; entry < end; ++entry) {
+		const struct decode_header *h = entry->header;
+		enum decode_type type = h->type_regs.bits & DECODE_TYPE_MASK;
+
+		if (entry->nesting > nesting)
+			continue; /* Skip sub-table we didn't match */
+
+		if (entry->nesting < nesting)
+			break; /* End of sub-table we were scanning */
+
+		if (!matched) {
+			if ((insn & h->mask.bits) != h->value.bits)
+				continue;
+			entry->matched = true;
+		}
+
+		switch (type) {
+
+		case DECODE_TYPE_TABLE:
+			++nesting;
+			break;
+
+		case DECODE_TYPE_CUSTOM:
+		case DECODE_TYPE_SIMULATE:
+		case DECODE_TYPE_EMULATE:
+			coverage_add_registers(entry, insn);
+			return;
+
+		case DECODE_TYPE_OR:
+			matched = true;
+			break;
+
+		case DECODE_TYPE_REJECT:
+		default:
+			return;
+		}
+
+	}
+}
+
+static void coverage_end(void)
+{
+	struct coverage_entry *entry = coverage.base;
+	struct coverage_entry *end = coverage.base + coverage.num_entries;
+
+	for (; entry < end; ++entry) {
+		u32 mask = entry->header->mask.bits;
+		u32 value = entry->header->value.bits;
+
+		if (entry->regs) {
+			pr_err("FAIL: Register test coverage missing for %08x %08x (%05x)\n",
+				mask, value, entry->regs);
+			coverage_fail = true;
+		}
+		if (!entry->matched) {
+			pr_err("FAIL: Test coverage entry missing for %08x %08x\n",
+				mask, value);
+			coverage_fail = true;
+		}
+	}
+
+	kfree(coverage.base);
+}
+
+
+/*
  * Framework for instruction set test cases
  */
 
@@ -1039,6 +1284,8 @@ static uintptr_t __used kprobes_test_case_start(const char *title, void *stack)
 		}
 	}
 
+	coverage_add(current_instruction);
+
 	if (end_arg->flags & ARG_FLAG_UNSUPPORTED) {
 		if (register_test_probe(&test_case_probe) < 0)
 			goto pass;
@@ -1213,8 +1460,13 @@ static int run_test_cases(void (*tests)(void), const union decode_item *table)
 		return ret;
 
 	pr_info("    Run test cases\n");
+	ret = coverage_start(table);
+	if (ret)
+		return ret;
+
 	tests();
 
+	coverage_end();
 	return 0;
 }
 
@@ -1274,6 +1526,15 @@ static int __init run_all_tests(void)
 		goto out;
 	}
 
+#if __LINUX_ARM_ARCH__ >= 7
+	/* We are able to run all test cases so coverage should be complete */
+	if (coverage_fail) {
+		pr_err("FAIL: Test coverage checks failed\n");
+		ret = -EINVAL;
+		goto out;
+	}
+#endif
+
 out:
 	if (ret == 0)
 		pr_info("Finished kprobe tests OK\n");
-- 
1.7.2.5
