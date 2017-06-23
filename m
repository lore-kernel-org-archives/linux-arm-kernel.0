From: xiexiuqi@huawei.com (Xie XiuQi)
Date: Fri, 23 Jun 2017 19:13:43 +0800
Subject: [PATCH v4] trace: ras: add ARM processor error information trace event
Message-ID: <1498216423-127868-1-git-send-email-xiexiuqi@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new trace event for ARM processor error information, so that
the user will know what error occurred. With this information the
user may take appropriate action.

These trace events are consistent with the ARM processor error
information table which defined in UEFI 2.6 spec section N.2.4.4.1.

---
v4: use __print_flags instead of __print_symbolic, because ARM_PROC_ERR_FLAGS
    might have more than on bit set.
    setting up default values for __entry to avoid a lot of else branches.
    set flags to 0 by default instead of ~0.
    fix a typo
    rename arm_proc_err to arm_proc_err_event
    remove "ARM Processor Error: " prefix
    rebase on Tyler's patchset v17 "Add UEFI 2.6 and ACPI 6.1 updates for RAS on ARM64"

v3: no change

v2: add trace enabled condition as Steven's suggestion.
    fix a typo.

https://patchwork.kernel.org/patch/9653767/
---

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tyler Baicar <tbaicar@codeaurora.org>
Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
---
 drivers/ras/ras.c       |  8 +++++
 include/linux/cper.h    |  5 ++++
 include/ras/ras_event.h | 79 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+)

diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index 39701a5..785e25d 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -22,7 +22,14 @@ void log_non_standard_event(const uuid_le *sec_type, const uuid_le *fru_id,
 
 void log_arm_hw_error(struct cper_sec_proc_arm *err)
 {
+	int i;
+	struct cper_arm_err_info *err_info;
+
 	trace_arm_event(err);
+
+	err_info = (struct cper_arm_err_info *)(err + 1);
+	for (i = 0; i < err->err_info_num; i++, err_info++)
+		trace_arm_err_info_event(err_info);
 }
 
 static int __init ras_init(void)
@@ -42,6 +49,7 @@ static int __init ras_init(void)
 EXPORT_TRACEPOINT_SYMBOL_GPL(mc_event);
 EXPORT_TRACEPOINT_SYMBOL_GPL(non_standard_event);
 EXPORT_TRACEPOINT_SYMBOL_GPL(arm_event);
+EXPORT_TRACEPOINT_SYMBOL_GPL(arm_err_info_event);
 
 int __init parse_ras_param(char *str)
 {
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 4c671fc..17546bf 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -275,6 +275,11 @@ enum {
 #define CPER_ARM_INFO_FLAGS_PROPAGATED		BIT(2)
 #define CPER_ARM_INFO_FLAGS_OVERFLOW		BIT(3)
 
+#define CPER_ARM_INFO_TYPE_CACHE		0
+#define CPER_ARM_INFO_TYPE_TLB			1
+#define CPER_ARM_INFO_TYPE_BUS			2
+#define CPER_ARM_INFO_TYPE_UARCH		3
+
 /*
  * All tables and structs must be byte-packed to match CPER
  * specification, since the tables are provided by the system BIOS
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index 429f46f..c38a367 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -206,6 +206,85 @@
 		  __entry->running_state, __entry->psci_state)
 );
 
+#define ARM_PROC_ERR_TYPE	\
+	EM ( CPER_ARM_INFO_TYPE_CACHE, "cache error" )	\
+	EM ( CPER_ARM_INFO_TYPE_TLB,  "TLB error" )	\
+	EM ( CPER_ARM_INFO_TYPE_BUS, "bus error" )	\
+	EMe ( CPER_ARM_INFO_TYPE_UARCH, "micro-architectural error" )
+
+/*
+ * First define the enums in MM_ACTION_RESULT to be exported to userspace
+ * via TRACE_DEFINE_ENUM().
+ */
+#undef EM
+#undef EMe
+#define EM(a, b) TRACE_DEFINE_ENUM(a);
+#define EMe(a, b)	TRACE_DEFINE_ENUM(a);
+
+ARM_PROC_ERR_TYPE
+
+/*
+ * Now redefine the EM() and EMe() macros to map the enums to the strings
+ * that will be printed in the output.
+ */
+#undef EM
+#undef EMe
+#define EM(a, b)		{ a, b },
+#define EMe(a, b)	{ a, b }
+
+#define show_proc_err_flags(flags) __print_flags(flags, "|",			\
+	{ CPER_ARM_INFO_FLAGS_FIRST,		"First error captured" },	\
+	{ CPER_ARM_INFO_FLAGS_LAST,		"Last error captured" },	\
+	{ CPER_ARM_INFO_FLAGS_PROPAGATED,	"Propagated" },			\
+	{ CPER_ARM_INFO_FLAGS_OVERFLOW,		"Overflow" })
+
+TRACE_EVENT(arm_err_info_event,
+
+	TP_PROTO(const struct cper_arm_err_info *err),
+
+	TP_ARGS(err),
+
+	TP_STRUCT__entry(
+		__field(u8, type)
+		__field(u16, multiple_error)
+		__field(u8, flags)
+		__field(u64, error_info)
+		__field(u64, virt_fault_addr)
+		__field(u64, physical_fault_addr)
+	),
+
+	TP_fast_assign(
+		__entry->type = err->type;
+		__entry->multiple_error = ~0;
+		memset(&__entry->flags, 0,
+			sizeof(*__entry) - offsetof(typeof(*__entry), flags));
+
+		if (err->validation_bits & CPER_ARM_INFO_VALID_MULTI_ERR)
+			__entry->multiple_error = err->multiple_error;
+
+		if (err->validation_bits & CPER_ARM_INFO_VALID_FLAGS)
+			__entry->flags = err->flags;
+
+		if (err->validation_bits & CPER_ARM_INFO_VALID_ERR_INFO)
+			__entry->error_info = err->error_info;
+
+		if (err->validation_bits & CPER_ARM_INFO_VALID_VIRT_ADDR)
+			__entry->virt_fault_addr = err->virt_fault_addr;
+
+		if (err->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR)
+			__entry->physical_fault_addr = err->physical_fault_addr;
+	),
+
+	TP_printk("type: %s; count: %u; flags: %s;"
+		  " error info: %016llx; virtual address: %016llx;"
+		  " physical address: %016llx",
+		  __print_symbolic(__entry->type, ARM_PROC_ERR_TYPE),
+		  __entry->multiple_error,
+		  show_proc_err_flags(__entry->flags),
+		  __entry->error_info, __entry->virt_fault_addr,
+		  __entry->physical_fault_addr)
+);
+
 /*
  * Non-Standard Section Report
  *
-- 
1.8.3.1
