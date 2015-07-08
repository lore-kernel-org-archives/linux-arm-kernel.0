From: ankgupta@codeaurora.org (Ankit Gupta)
Date: Wed,  8 Jul 2015 16:26:03 -0600
Subject: [PATCH V4] trace/events: add chip name and hwirq to irq entry
 tracepoint
Message-ID: <1436394363-15797-1-git-send-email-ankgupta@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add chip name and hw-irq number to the trace_irq_handler_entry()
tracepoint. When tracing interrupt events the chip-name and hw-irq
numbers are stable and known in advance. This makes them a better
choice as a filtering criteria for the trace buffer dump. On the
flipside, the os-irq numbers are dynamically allocated which makes
them difficult to use for the same purpose.

Dump messages will look like:
...irq_handler_entry: irq=22 name=msm_serial0 chip_name=GIC hwirq=140

Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
Reviewed-by: Andy Gross <agross@codeaurora.org>
Signed-off-by: Gilad Avidov <gavidov@codeaurora.org>
Signed-off-by: Ankit Gupta <ankgupta@codeaurora.org>
---
Changes since V3:
- use field variable in trace structure to assign value for chip name
  and hwirq rather than printing directly to the trace buffer.
---
Changes since V2:
- fixed dump message in commit text to reflect Chip name
  instead of domain.
---
Changes since V1:
- added reviewed by Andy Gross
---
 include/trace/events/irq.h | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/irq.h b/include/trace/events/irq.h
index 3608beb..0898506 100644
--- a/include/trace/events/irq.h
+++ b/include/trace/events/irq.h
@@ -23,6 +23,17 @@ struct softirq_action;
 			 softirq_name(HRTIMER),		\
 			 softirq_name(RCU))
 
+
+#define show_chip_name(irq)					\
+	(irq_get_irq_data(irq)					\
+			 ? irq_get_irq_data(irq)->chip->name	\
+			 : "NULL")
+
+#define show_hwirq(irq)						\
+	(irq_get_irq_data(irq)					\
+			 ? irq_get_irq_data(irq)->hwirq		\
+			 : -ENODEV)
+
 /**
  * irq_handler_entry - called immediately before the irq action handler
  * @irq: irq number
@@ -41,16 +52,21 @@ TRACE_EVENT(irq_handler_entry,
 	TP_ARGS(irq, action),
 
 	TP_STRUCT__entry(
-		__field(	int,	irq		)
-		__string(	name,	action->name	)
+		__field(   int,	          irq	               )
+		__field(   unsigned long, hwirq                )
+		__string(  name,	  action->name	       )
+		__string(  chip,	  show_chip_name(irq)  )
 	),
 
 	TP_fast_assign(
 		__entry->irq = irq;
+		__entry->hwirq = show_hwirq(irq);
 		__assign_str(name, action->name);
+		__assign_str(chip, show_chip_name(irq));
 	),
 
-	TP_printk("irq=%d name=%s", __entry->irq, __get_str(name))
+	TP_printk("irq=%d name=%s chip=%s hwirq=%ld", __entry->irq,
+	  __get_str(name), __get_str(chip), __entry->hwirq)
 );
 
 /**
-- 
1.8.5.2
