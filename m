From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 2 Mar 2015 22:24:44 +0800
Subject: [RFC PATCH v4 06/34] early kprobes: enable kprobe smoke test for
 early kprobes.
In-Reply-To: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1425306312-3437-7-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let kprobe smoke test code behavior differently depending on
kprobes_is_early(). Following patches will test kprobes twice, one for
early kprobes, another for normal kprobes.

Since this test will be executed more than once, before real test
we should first init the ?probe structures to avoid garbage data in
previous round trigger problem. For example, register_kprobe() denies
to process struct kprobe with both addr and symbol_name set, but itself
fills them both.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 kernel/test_kprobes.c | 58 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 13 deletions(-)

diff --git a/kernel/test_kprobes.c b/kernel/test_kprobes.c
index 0dbab6d..cce4536 100644
--- a/kernel/test_kprobes.c
+++ b/kernel/test_kprobes.c
@@ -22,6 +22,20 @@
 
 #define div_factor 3
 
+#define init_probe(src)	memcpy(&src, &_##src, sizeof(src))
+#define init_probes_pair(a)		\
+	do { 				\
+		init_probe(a);		\
+		init_probe(a##2);	\
+	} while(0)
+
+#define init_all_probes()		\
+	do {				\
+		init_probes_pair(kp);		\
+		init_probes_pair(jp);		\
+		init_probes_pair(rp);		\
+	} while(0)
+
 static u32 rand1, preh_val, posth_val, jph_val;
 static int errors, handler_errors, num_tests;
 static u32 (*target)(u32 value);
@@ -48,11 +62,12 @@ static void kp_post_handler(struct kprobe *p, struct pt_regs *regs,
 	posth_val = preh_val + div_factor;
 }
 
-static struct kprobe kp = {
+static struct kprobe _kp = {
 	.symbol_name = "kprobe_target",
 	.pre_handler = kp_pre_handler,
 	.post_handler = kp_post_handler
 };
+static struct kprobe kp;
 
 static int test_kprobe(void)
 {
@@ -101,11 +116,12 @@ static void kp_post_handler2(struct kprobe *p, struct pt_regs *regs,
 	posth_val = preh_val + div_factor;
 }
 
-static struct kprobe kp2 = {
+static struct kprobe _kp2 = {
 	.symbol_name = "kprobe_target2",
 	.pre_handler = kp_pre_handler2,
 	.post_handler = kp_post_handler2
 };
+static struct kprobe kp2;
 
 static int test_kprobes(void)
 {
@@ -166,10 +182,11 @@ static u32 j_kprobe_target(u32 value)
 	return 0;
 }
 
-static struct jprobe jp = {
+static struct jprobe _jp = {
 	.entry		= j_kprobe_target,
 	.kp.symbol_name = "kprobe_target"
 };
+static struct jprobe jp;
 
 static int test_jprobe(void)
 {
@@ -191,10 +208,11 @@ static int test_jprobe(void)
 	return 0;
 }
 
-static struct jprobe jp2 = {
+static struct jprobe _jp2 = {
 	.entry          = j_kprobe_target,
 	.kp.symbol_name = "kprobe_target2"
 };
+static struct jprobe jp2;
 
 static int test_jprobes(void)
 {
@@ -253,11 +271,12 @@ static int return_handler(struct kretprobe_instance *ri, struct pt_regs *regs)
 	return 0;
 }
 
-static struct kretprobe rp = {
+static struct kretprobe _rp = {
 	.handler	= return_handler,
 	.entry_handler  = entry_handler,
 	.kp.symbol_name = "kprobe_target"
 };
+static struct kretprobe rp;
 
 static int test_kretprobe(void)
 {
@@ -296,11 +315,12 @@ static int return_handler2(struct kretprobe_instance *ri, struct pt_regs *regs)
 	return 0;
 }
 
-static struct kretprobe rp2 = {
+static struct kretprobe _rp2 = {
 	.handler	= return_handler2,
 	.entry_handler  = entry_handler,
 	.kp.symbol_name = "kprobe_target2"
 };
+static struct kretprobe rp2;
 
 static int test_kretprobes(void)
 {
@@ -337,15 +357,24 @@ static int test_kretprobes(void)
 int init_test_probes(void)
 {
 	int ret;
+	char *early_str;
+
+	init_all_probes();
 
 	target = kprobe_target;
 	target2 = kprobe_target2;
 
-	do {
-		rand1 = prandom_u32();
-	} while (rand1 <= div_factor);
+	if (!kprobes_is_early()) {
+		do {
+			rand1 = prandom_u32();
+		} while (rand1 <= div_factor);
+		early_str = "";
+	} else {
+		rand1 = 123456789;
+		early_str = "(early) ";
+	}
 
-	pr_info("started\n");
+	pr_info("%sstarted\n", early_str);
 	num_tests++;
 	ret = test_kprobe();
 	if (ret < 0)
@@ -366,6 +395,8 @@ int init_test_probes(void)
 	if (ret < 0)
 		errors++;
 
+	if (kprobes_is_early())
+		goto out;
 #ifdef CONFIG_KRETPROBES
 	num_tests++;
 	ret = test_kretprobe();
@@ -378,12 +409,13 @@ int init_test_probes(void)
 		errors++;
 #endif /* CONFIG_KRETPROBES */
 
+out:
 	if (errors)
-		pr_err("BUG: %d out of %d tests failed\n", errors, num_tests);
+		pr_err("%sBUG: %d out of %d tests failed\n", early_str, errors, num_tests);
 	else if (handler_errors)
-		pr_err("BUG: %d error(s) running handlers\n", handler_errors);
+		pr_err("%sBUG: %d error(s) running handlers\n", early_str, handler_errors);
 	else
-		pr_info("passed successfully\n");
+		pr_info("%spassed successfully\n", early_str);
 
 	return 0;
 }
-- 
1.8.4
