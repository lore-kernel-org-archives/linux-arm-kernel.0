From: panand@redhat.com (Pratyush Anand)
Date: Mon, 31 Jul 2017 16:10:31 +0530
Subject: [PATCH v3 3/5] register_wide_hw_breakpoint(): modify to accept
 step_needed arg
In-Reply-To: <cover.1501496603.git.panand@redhat.com>
References: <cover.1501496603.git.panand@redhat.com>
Message-ID: <97ca3a2ba258eda5e0c228f5f7dac1c7c0c4482c.1501496603.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch like ARM64 expects 'step_needed = 1'  in order to use default
single step handler. Therefore, modify register_wide_hw_breakpoint()
implementation,so that we can set this field in struct hw_perf_event to
be used later by arch specific code.

Other arch will not have any affect as they do not use it so far.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/x86/kernel/kgdb.c                  | 2 +-
 include/linux/hw_breakpoint.h           | 4 ++--
 kernel/events/hw_breakpoint.c           | 4 +++-
 samples/hw_breakpoint/data_breakpoint.c | 3 ++-
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 8e36f249646e..19b24c50a952 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -674,7 +674,7 @@ void kgdb_arch_late(void)
 	for (i = 0; i < HBP_NUM; i++) {
 		if (breakinfo[i].pev)
 			continue;
-		breakinfo[i].pev = register_wide_hw_breakpoint(&attr, NULL, NULL);
+		breakinfo[i].pev = register_wide_hw_breakpoint(&attr, NULL, NULL, 0);
 		if (IS_ERR((void * __force)breakinfo[i].pev)) {
 			printk(KERN_ERR "kgdb: Could not allocate hw"
 			       "breakpoints\nDisabling the kernel debugger\n");
diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
index b9ac9629bf74..8cbc8ded6d50 100644
--- a/include/linux/hw_breakpoint.h
+++ b/include/linux/hw_breakpoint.h
@@ -71,7 +71,7 @@ register_wide_hw_breakpoint_cpu(struct perf_event_attr *attr,
 extern struct perf_event * __percpu *
 register_wide_hw_breakpoint(struct perf_event_attr *attr,
 			    perf_overflow_handler_t triggered,
-			    void *context);
+			    void *context, int step);
 
 extern int register_perf_hw_breakpoint(struct perf_event *bp);
 extern int __register_perf_hw_breakpoint(struct perf_event *bp);
@@ -110,7 +110,7 @@ register_wide_hw_breakpoint_cpu(struct perf_event_attr *attr,
 static inline struct perf_event * __percpu *
 register_wide_hw_breakpoint(struct perf_event_attr *attr,
 			    perf_overflow_handler_t triggered,
-			    void *context)		{ return NULL; }
+			    void *context, int step)	{ return NULL; }
 static inline int
 register_perf_hw_breakpoint(struct perf_event *bp)	{ return -ENOSYS; }
 static inline int
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 3f8cb1e14588..0dcb175276b2 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -492,13 +492,14 @@ EXPORT_SYMBOL_GPL(unregister_hw_breakpoint);
  * register_wide_hw_breakpoint - register a wide breakpoint in the kernel
  * @attr: breakpoint attributes
  * @triggered: callback to trigger when we hit the breakpoint
+ * @step: tells if framework can use default arch step handler
  *
  * @return a set of per_cpu pointers to perf events
  */
 struct perf_event * __percpu *
 register_wide_hw_breakpoint(struct perf_event_attr *attr,
 			    perf_overflow_handler_t triggered,
-			    void *context)
+			    void *context, int step)
 {
 	struct perf_event * __percpu *cpu_events, *bp;
 	long err = 0;
@@ -512,6 +513,7 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 	for_each_online_cpu(cpu) {
 		bp = perf_event_create_kernel_counter(attr, cpu, NULL,
 						      triggered, context);
+		bp->hw.step_needed = step;
 		if (IS_ERR(bp)) {
 			err = PTR_ERR(bp);
 			break;
diff --git a/samples/hw_breakpoint/data_breakpoint.c b/samples/hw_breakpoint/data_breakpoint.c
index ef7f32291852..f64e59f9fbc6 100644
--- a/samples/hw_breakpoint/data_breakpoint.c
+++ b/samples/hw_breakpoint/data_breakpoint.c
@@ -60,7 +60,8 @@ static int __init hw_break_module_init(void)
 	attr.bp_len = HW_BREAKPOINT_LEN_4;
 	attr.bp_type = HW_BREAKPOINT_W | HW_BREAKPOINT_R;
 
-	sample_hbp = register_wide_hw_breakpoint(&attr, sample_hbp_handler, NULL);
+	sample_hbp = register_wide_hw_breakpoint(&attr, sample_hbp_handler,
+						 NULL, 1);
 	if (IS_ERR((void __force *)sample_hbp)) {
 		ret = PTR_ERR((void __force *)sample_hbp);
 		goto fail;
-- 
2.9.4
