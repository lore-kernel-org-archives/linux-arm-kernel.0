From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 26 Jul 2016 17:55:43 +0100
Subject: [PATCH v15 04/10] arm64: Kprobes with single stepping support
In-Reply-To: <ce78f577-d14a-7b12-c96f-a6ebd8866283@linaro.org>
References: <1467995754-32508-1-git-send-email-dave.long@linaro.org>
 <1467995754-32508-5-git-send-email-dave.long@linaro.org>
 <578FA238.3050206@arm.com> <5790F960.5050007@linaro.org>
 <57910528.7070902@arm.com> <57911590.50305@linaro.org>
 <20160722101617.GA17821@e104818-lin.cambridge.arm.com>
 <57924104.1080202@linaro.org>
 <20160725171350.GE2423@e104818-lin.cambridge.arm.com>
 <ce78f577-d14a-7b12-c96f-a6ebd8866283@linaro.org>
Message-ID: <20160726165543.GG2423@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2016 at 10:50:08AM +0100, Daniel Thompson wrote:
> On 25/07/16 18:13, Catalin Marinas wrote:
> >On Fri, Jul 22, 2016 at 11:51:32AM -0400, David Long wrote:
> >>On 07/22/2016 06:16 AM, Catalin Marinas wrote:
> >>>On Thu, Jul 21, 2016 at 02:33:52PM -0400, David Long wrote:
> >>>[...]
> >>>The document states: "Up to MAX_STACK_SIZE bytes are copied". That means
> >>>the arch code could always copy less but never more than MAX_STACK_SIZE.
> >>>What we are proposing is that we should try to guess how much to copy
> >>>based on the FP value (caller's frame) and, if larger than
> >>>MAX_STACK_SIZE, skip the probe hook entirely. I don't think this goes
> >>>against the kprobes.txt document but at least it (a) may improve the
> >>>performance slightly by avoiding unnecessary copy and (b) it avoids
> >>>undefined behaviour if we ever encounter a jprobe with arguments passed
> >>>on the stack beyond MAX_STACK_SIZE.
> >>
> >>OK, it sounds like an improvement. I do worry a little about unexpected side
> >>effects.
> >
> >You get more unexpected side effects by not saving/restoring the whole
> >stack. We looked into this on Friday and came to the conclusion that
> >there is no safe way for kprobes to know which arguments passed on the
> >stack should be preserved, at least not with the current API.
> >
> >Basically the AArch64 PCS states that for arguments passed on the stack
> >(e.g. they can't fit in registers), the caller allocates memory for them
> >(on its own stack) and passes the pointer to the callee. Unfortunately,
> >the frame pointer seems to be decremented correspondingly to cover the
> >arguments, so we don't really have a way to tell how much to copy.
> >Copying just the caller's stack frame isn't safe either since a
> >callee/caller receiving such argument on the stack may passed it down to
> >a callee without copying (I couldn't find anything in the PCS stating
> >that this isn't allowed).
> 
> The PCS[1] seems (at least to me) to be pretty clear that "the address of
> the first stacked argument is defined to be the initial value of SP".
> 
> I think it is only the return value (when stacked via the x8 pointer) that
> can be passed through an intermediate function in the way described above.
> Isn't it OK for a jprobe to clobber this memory? The underlying function
> will overwrite whatever the jprobe put there anyway.
> 
> Am I overlooking some additional detail in the PCS?

I'm not sure I fully understand the PCS. I played with some random hacks
to test_kprobes.c (see below) and the address passed for a big struct
didn't look like the bottom of the stack.

diff --git a/kernel/test_kprobes.c b/kernel/test_kprobes.c
index 0dbab6d1acb4..6ed7be02a560 100644
--- a/kernel/test_kprobes.c
+++ b/kernel/test_kprobes.c
@@ -22,14 +22,18 @@
 
 #define div_factor 3
 
+struct dummy {
+	char dummy_array[MAX_STACK_SIZE * 2];
+};
+
 static u32 rand1, preh_val, posth_val, jph_val;
 static int errors, handler_errors, num_tests;
-static u32 (*target)(u32 value);
+static u32 (*target)(u32 value, struct dummy d);
 static u32 (*target2)(u32 value);
 
-static noinline u32 kprobe_target(u32 value)
+static noinline u32 kprobe_target(u32 value, struct dummy d)
 {
-	return (value / div_factor);
+	return (value / div_factor - d.dummy_array[0] + d.dummy_array[1]);
 }
 
 static int kp_pre_handler(struct kprobe *p, struct pt_regs *regs)
@@ -54,9 +58,11 @@ static struct kprobe kp = {
 	.post_handler = kp_post_handler
 };
 
-static int test_kprobe(void)
+static int noinline test_kprobe(void)
 {
 	int ret;
+	static struct dummy dummy;
+	memset(&dummy, 10, sizeof(dummy));
 
 	ret = register_kprobe(&kp);
 	if (ret < 0) {
@@ -64,7 +70,8 @@ static int test_kprobe(void)
 		return ret;
 	}
 
-	ret = target(rand1);
+	ret = target(rand1, dummy);
+	memset(&dummy, 10, sizeof(dummy));
 	unregister_kprobe(&kp);
 
 	if (preh_val == 0) {
@@ -111,6 +118,8 @@ static int test_kprobes(void)
 {
 	int ret;
 	struct kprobe *kps[2] = {&kp, &kp2};
+	struct dummy dummy;
+	memset(&dummy, 10, sizeof(dummy));
 
 	/* addr and flags should be cleard for reusing kprobe. */
 	kp.addr = NULL;
@@ -123,7 +132,7 @@ static int test_kprobes(void)
 
 	preh_val = 0;
 	posth_val = 0;
-	ret = target(rand1);
+	ret = target(rand1, dummy);
 
 	if (preh_val == 0) {
 		pr_err("kprobe pre_handler not called\n");
@@ -154,7 +163,7 @@ static int test_kprobes(void)
 
 }
 
-static u32 j_kprobe_target(u32 value)
+static u32 j_kprobe_target(u32 value, struct dummy d)
 {
 	if (value != rand1) {
 		handler_errors++;
@@ -174,6 +183,8 @@ static struct jprobe jp = {
 static int test_jprobe(void)
 {
 	int ret;
+	struct dummy dummy;
+	memset(&dummy, 10, sizeof(dummy));
 
 	ret = register_jprobe(&jp);
 	if (ret < 0) {
@@ -181,7 +192,7 @@ static int test_jprobe(void)
 		return ret;
 	}
 
-	ret = target(rand1);
+	ret = target(rand1, dummy);
 	unregister_jprobe(&jp);
 	if (jph_val == 0) {
 		pr_err("jprobe handler not called\n");
@@ -200,6 +211,8 @@ static int test_jprobes(void)
 {
 	int ret;
 	struct jprobe *jps[2] = {&jp, &jp2};
+	struct dummy dummy;
+	memset(&dummy, 10, sizeof(dummy));
 
 	/* addr and flags should be cleard for reusing kprobe. */
 	jp.kp.addr = NULL;
@@ -211,7 +224,7 @@ static int test_jprobes(void)
 	}
 
 	jph_val = 0;
-	ret = target(rand1);
+	ret = target(rand1, dummy);
 	if (jph_val == 0) {
 		pr_err("jprobe handler not called\n");
 		handler_errors++;
@@ -262,6 +275,8 @@ static struct kretprobe rp = {
 static int test_kretprobe(void)
 {
 	int ret;
+	struct dummy dummy;
+	memset(&dummy, 10, sizeof(dummy));
 
 	ret = register_kretprobe(&rp);
 	if (ret < 0) {
@@ -269,7 +284,7 @@ static int test_kretprobe(void)
 		return ret;
 	}
 
-	ret = target(rand1);
+	ret = target(rand1, dummy);
 	unregister_kretprobe(&rp);
 	if (krph_val != rand1) {
 		pr_err("kretprobe handler not called\n");
@@ -306,6 +321,8 @@ static int test_kretprobes(void)
 {
 	int ret;
 	struct kretprobe *rps[2] = {&rp, &rp2};
+	struct dummy dummy;
+	memset(&dummy, 10, sizeof(dummy));
 
 	/* addr and flags should be cleard for reusing kprobe. */
 	rp.kp.addr = NULL;
@@ -317,7 +334,7 @@ static int test_kretprobes(void)
 	}
 
 	krph_val = 0;
-	ret = target(rand1);
+	ret = target(rand1, dummy);
 	if (krph_val != rand1) {
 		pr_err("kretprobe handler not called\n");
 		handler_errors++;

-- 
Catalin
