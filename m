From: tixy@yxit.co.uk (Tixy)
Date: Sat, 10 Sep 2011 12:05:03 +0100
Subject: [PATCH v2 07/10] ARM: kprobes: Add decoding table self-consistency
	tests
In-Reply-To: <1315652706-2900-1-git-send-email-tixy@yxit.co.uk>
References: <1315652706-2900-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1315652706-2900-8-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

These check that the bitmask and match value used in the decoding tables
are self consistent.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-test.c |  103 ++++++++++++++++++++++++++++++++++++++--
 1 files changed, 99 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/kprobes-test.c b/arch/arm/kernel/kprobes-test.c
index 1e7cdda..74a3a34 100644
--- a/arch/arm/kernel/kprobes-test.c
+++ b/arch/arm/kernel/kprobes-test.c
@@ -443,6 +443,92 @@ static int run_api_tests(long (*func)(long, long))
 
 
 /*
+ * Decoding table self-consistency tests
+ */
+
+static const int decode_struct_sizes[NUM_DECODE_TYPES] = {
+	[DECODE_TYPE_TABLE]	= sizeof(struct decode_table),
+	[DECODE_TYPE_CUSTOM]	= sizeof(struct decode_custom),
+	[DECODE_TYPE_SIMULATE]	= sizeof(struct decode_simulate),
+	[DECODE_TYPE_EMULATE]	= sizeof(struct decode_emulate),
+	[DECODE_TYPE_OR]	= sizeof(struct decode_or),
+	[DECODE_TYPE_REJECT]	= sizeof(struct decode_reject)
+};
+
+static int table_iter(const union decode_item *table,
+			int (*fn)(const struct decode_header *, void *),
+			void *args)
+{
+	const struct decode_header *h = (struct decode_header *)table;
+	int result;
+
+	for (;;) {
+		enum decode_type type = h->type_regs.bits & DECODE_TYPE_MASK;
+
+		if (type == DECODE_TYPE_END)
+			return 0;
+
+		result = fn(h, args);
+		if (result)
+			return result;
+
+		h = (struct decode_header *)
+			((uintptr_t)h + decode_struct_sizes[type]);
+
+	}
+}
+
+static int table_test_fail(const struct decode_header *h, const char* message)
+{
+
+	pr_err("FAIL: kprobes test failure \"%s\" (mask %08x, value %08x)\n",
+					message, h->mask.bits, h->value.bits);
+	return -EINVAL;
+}
+
+struct table_test_args {
+	const union decode_item *root_table;
+	u32			parent_mask;
+	u32			parent_value;
+};
+
+static int table_test_fn(const struct decode_header *h, void *args)
+{
+	struct table_test_args *a = (struct table_test_args *)args;
+	enum decode_type type = h->type_regs.bits & DECODE_TYPE_MASK;
+
+	if (h->value.bits & ~h->mask.bits)
+		return table_test_fail(h, "Match value has bits not in mask");
+
+	if ((h->mask.bits & a->parent_mask) != a->parent_mask)
+		return table_test_fail(h, "Mask has bits not in parent mask");
+
+	if ((h->value.bits ^ a->parent_value) & a->parent_mask)
+		return table_test_fail(h, "Value is inconsistent with parent");
+
+	if (type == DECODE_TYPE_TABLE) {
+		struct decode_table *d = (struct decode_table *)h;
+		struct table_test_args args2 = *a;
+		args2.parent_mask = h->mask.bits;
+		args2.parent_value = h->value.bits;
+		return table_iter(d->table.table, table_test_fn, &args2);
+	}
+
+	return 0;
+}
+
+static int table_test(const union decode_item *table)
+{
+	struct table_test_args args = {
+		.root_table	= table,
+		.parent_mask	= 0,
+		.parent_value	= 0
+	};
+	return table_iter(args.root_table, table_test_fn, &args);
+}
+
+
+/*
  * Framework for instruction set test cases
  */
 
@@ -1117,8 +1203,15 @@ end:
  * Top level test functions
  */
 
-static int run_test_cases(void (*tests)(void))
+static int run_test_cases(void (*tests)(void), const union decode_item *table)
 {
+	int ret;
+
+	pr_info("    Check decoding tables\n");
+	ret = table_test(table);
+	if (ret)
+		return ret;
+
 	pr_info("    Run test cases\n");
 	tests();
 
@@ -1140,7 +1233,7 @@ static int __init run_all_tests(void)
 		goto out;
 
 	pr_info("ARM instruction simulation\n");
-	ret = run_test_cases(kprobe_arm_test_cases);
+	ret = run_test_cases(kprobe_arm_test_cases, kprobe_decode_arm_table);
 	if (ret)
 		goto out;
 
@@ -1162,12 +1255,14 @@ static int __init run_all_tests(void)
 		goto out;
 
 	pr_info("16-bit Thumb instruction simulation\n");
-	ret = run_test_cases(kprobe_thumb16_test_cases);
+	ret = run_test_cases(kprobe_thumb16_test_cases,
+				kprobe_decode_thumb16_table);
 	if (ret)
 		goto out;
 
 	pr_info("32-bit Thumb instruction simulation\n");
-	ret = run_test_cases(kprobe_thumb32_test_cases);
+	ret = run_test_cases(kprobe_thumb32_test_cases,
+				kprobe_decode_thumb32_table);
 	if (ret)
 		goto out;
 #endif
-- 
1.7.2.5
