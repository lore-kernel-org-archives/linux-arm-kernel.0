From: ankgupta@codeaurora.org (Ankit Gupta)
Date: Mon, 22 Jun 2015 16:38:46 -0600
Subject: [PATCH RESEND V3] spmi: add command tracepoints for SPMI
Message-ID: <1435012726-31082-1-git-send-email-ankgupta@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add tracepoints to retrieve information about read, write
and non-data commands. For performance measurement support
tracepoints are added at the beginning and at the end of
transfers. Following is a list showing the new tracepoint
events. The "cmd" parameter here represents the opcode, SID,
and full 16-bit address.

spmi_write_begin: cmd and data buffer.
spmi_write_end  : cmd and return value.
spmi_read_begin : cmd.
spmi_read_end   : cmd, return value and data buffer.
spmi_cmd        : cmd.

The reason that cmd appears at both the beginning and at
the end event is that SPMI drivers can request commands
concurrently. cmd helps in matching the corresponding
events.

SPMI tracepoints can be enabled like:

echo 1 >/sys/kernel/debug/tracing/events/spmi/enable

and will dump messages that can be viewed in
/sys/kernel/debug/tracing/trace that look like:

... spmi_read_begin: opc=56 sid=00 addr=0x0000
... spmi_read_end: opc=56 sid=00 addr=0x0000 ret=0 len=02 buf=0x[01-40]
... spmi_write_begin: opc=48 sid=00 addr=0x0000 len=3 buf=0x[ff-ff-ff]

Suggested-by: Sagar Dharia <sdharia@codeaurora.org>
Acked-by: Steven Rostedt <rostedt@goodmis.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Gilad Avidov <gavidov@codeaurora.org>
Signed-off-by: Ankit Gupta <ankgupta@codeaurora.org>

---
Changes since v2:
- use full names in events: wr->write, rd->read, beg->begin.
- Edited the commit text to reflect full names of event.
---
Changes since V1:
- Change from ':' to "=" in printk in spmi.h.
- Added extra line between declaration and Code in spmi.c.
- Added use and example of spmi dump message in commit text.
---
 drivers/spmi/spmi.c         |  22 +++++++-
 include/trace/events/spmi.h | 135 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 154 insertions(+), 3 deletions(-)
 create mode 100644 include/trace/events/spmi.h

diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index 1d92f51..36fe010 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -21,6 +21,8 @@
 #include <linux/pm_runtime.h>
 
 #include <dt-bindings/spmi/spmi.h>
+#define CREATE_TRACE_POINTS
+#include <trace/events/spmi.h>
 
 static DEFINE_IDA(ctrl_ida);
 
@@ -95,28 +97,42 @@ EXPORT_SYMBOL_GPL(spmi_device_remove);
 static inline int
 spmi_cmd(struct spmi_controller *ctrl, u8 opcode, u8 sid)
 {
+	int ret;
+
 	if (!ctrl || !ctrl->cmd || ctrl->dev.type != &spmi_ctrl_type)
 		return -EINVAL;
 
-	return ctrl->cmd(ctrl, opcode, sid);
+	ret = ctrl->cmd(ctrl, opcode, sid);
+	trace_spmi_cmd(opcode, sid, ret);
+	return ret;
 }
 
 static inline int spmi_read_cmd(struct spmi_controller *ctrl, u8 opcode,
 				u8 sid, u16 addr, u8 *buf, size_t len)
 {
+	int ret;
+
 	if (!ctrl || !ctrl->read_cmd || ctrl->dev.type != &spmi_ctrl_type)
 		return -EINVAL;
 
-	return ctrl->read_cmd(ctrl, opcode, sid, addr, buf, len);
+	trace_spmi_read_begin(opcode, sid, addr);
+	ret = ctrl->read_cmd(ctrl, opcode, sid, addr, buf, len);
+	trace_spmi_read_end(opcode, sid, addr, ret, len, buf);
+	return ret;
 }
 
 static inline int spmi_write_cmd(struct spmi_controller *ctrl, u8 opcode,
 				 u8 sid, u16 addr, const u8 *buf, size_t len)
 {
+	int ret;
+
 	if (!ctrl || !ctrl->write_cmd || ctrl->dev.type != &spmi_ctrl_type)
 		return -EINVAL;
 
-	return ctrl->write_cmd(ctrl, opcode, sid, addr, buf, len);
+	trace_spmi_write_begin(opcode, sid, addr, len, buf);
+	ret = ctrl->write_cmd(ctrl, opcode, sid, addr, buf, len);
+	trace_spmi_write_end(opcode, sid, addr, ret);
+	return ret;
 }
 
 /**
diff --git a/include/trace/events/spmi.h b/include/trace/events/spmi.h
new file mode 100644
index 0000000..62f005e
--- /dev/null
+++ b/include/trace/events/spmi.h
@@ -0,0 +1,135 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM spmi
+
+#if !defined(_TRACE_SPMI_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_SPMI_H
+
+#include <linux/spmi.h>
+#include <linux/tracepoint.h>
+
+/*
+ * drivers/spmi/spmi.c
+ */
+
+TRACE_EVENT(spmi_write_begin,
+	TP_PROTO(u8 opcode, u8 sid, u16 addr, u8 len, const u8 *buf),
+	TP_ARGS(opcode, sid, addr, len, buf),
+
+	TP_STRUCT__entry(
+		__field		( u8,         opcode    )
+		__field		( u8,         sid       )
+		__field		( u16,        addr      )
+		__field		( u8,         len       )
+		__dynamic_array	( u8,   buf,  len + 1   )
+	),
+
+	TP_fast_assign(
+		__entry->opcode = opcode;
+		__entry->sid    = sid;
+		__entry->addr   = addr;
+		__entry->len    = len + 1;
+		memcpy(__get_dynamic_array(buf), buf, len + 1);
+	),
+
+	TP_printk("opc=%d sid=%02d addr=0x%04x len=%d buf=0x[%*phD]",
+		  (int)__entry->opcode, (int)__entry->sid,
+		  (int)__entry->addr, (int)__entry->len,
+		  (int)__entry->len, __get_dynamic_array(buf))
+);
+
+TRACE_EVENT(spmi_write_end,
+	TP_PROTO(u8 opcode, u8 sid, u16 addr, int ret),
+	TP_ARGS(opcode, sid, addr, ret),
+
+	TP_STRUCT__entry(
+		__field		( u8,         opcode    )
+		__field		( u8,         sid       )
+		__field		( u16,        addr      )
+		__field		( int,        ret       )
+	),
+
+	TP_fast_assign(
+		__entry->opcode = opcode;
+		__entry->sid    = sid;
+		__entry->addr   = addr;
+		__entry->ret    = ret;
+	),
+
+	TP_printk("opc=%d sid=%02d addr=0x%04x ret=%d",
+		  (int)__entry->opcode, (int)__entry->sid,
+		  (int)__entry->addr, __entry->ret)
+);
+
+TRACE_EVENT(spmi_read_begin,
+	TP_PROTO(u8 opcode, u8 sid, u16 addr),
+	TP_ARGS(opcode, sid, addr),
+
+	TP_STRUCT__entry(
+		__field		( u8,         opcode    )
+		__field		( u8,         sid       )
+		__field		( u16,        addr      )
+	),
+
+	TP_fast_assign(
+		__entry->opcode = opcode;
+		__entry->sid    = sid;
+		__entry->addr   = addr;
+	),
+
+	TP_printk("opc=%d sid=%02d addr=0x%04x",
+		  (int)__entry->opcode, (int)__entry->sid,
+		  (int)__entry->addr)
+);
+
+TRACE_EVENT(spmi_read_end,
+	TP_PROTO(u8 opcode, u8 sid, u16 addr, int ret, u8 len, const u8 *buf),
+	TP_ARGS(opcode, sid, addr, ret, len, buf),
+
+	TP_STRUCT__entry(
+		__field		( u8,         opcode    )
+		__field		( u8,         sid       )
+		__field		( u16,        addr      )
+		__field		( int,        ret       )
+		__field		( u8,         len       )
+		__dynamic_array	( u8,   buf,  len + 1   )
+	),
+
+	TP_fast_assign(
+		__entry->opcode = opcode;
+		__entry->sid    = sid;
+		__entry->addr   = addr;
+		__entry->ret    = ret;
+		__entry->len    = len + 1;
+		memcpy(__get_dynamic_array(buf), buf, len + 1);
+	),
+
+	TP_printk("opc=%d sid=%02d addr=0x%04x ret=%d len=%02d buf=0x[%*phD]",
+		  (int)__entry->opcode, (int)__entry->sid,
+		  (int)__entry->addr, __entry->ret, (int)__entry->len,
+		  (int)__entry->len, __get_dynamic_array(buf))
+);
+
+TRACE_EVENT(spmi_cmd,
+	TP_PROTO(u8 opcode, u8 sid, int ret),
+	TP_ARGS(opcode, sid, ret),
+
+	TP_STRUCT__entry(
+		__field		( u8,         opcode    )
+		__field		( u8,         sid       )
+		__field		( int,        ret       )
+	),
+
+	TP_fast_assign(
+		__entry->opcode = opcode;
+		__entry->sid    = sid;
+		__entry->ret    = ret;
+	),
+
+	TP_printk("opc=%d sid=%02d ret=%d", (int)__entry->opcode,
+		  (int)__entry->sid, ret)
+);
+
+#endif /* _TRACE_SPMI_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
1.8.5.2
