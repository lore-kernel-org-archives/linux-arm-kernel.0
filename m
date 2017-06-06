From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Tue,  6 Jun 2017 16:08:55 -0500
Subject: [PATCH v8 20/24] drivers/fsi/gpio: Add tracepoints for GPIO master
In-Reply-To: <20170606210859.80431-1-cbostic@linux.vnet.ibm.com>
References: <20170606210859.80431-1-cbostic@linux.vnet.ibm.com>
Message-ID: <20170606210859.80431-21-cbostic@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Kerr <jk@ozlabs.org>

Trace low level input/output GPIO operations.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
---
 drivers/fsi/fsi-master-gpio.c          |  9 +++++
 include/trace/events/fsi_master_gpio.h | 68 ++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100644 include/trace/events/fsi_master_gpio.h

diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index d467e61..a5d6e70 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -61,6 +61,9 @@ struct fsi_master_gpio {
 	struct gpio_desc	*gpio_mux;	/* Mux control */
 };
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/fsi_master_gpio.h>
+
 #define to_fsi_master_gpio(m) container_of(m, struct fsi_master_gpio, master)
 
 struct fsi_gpio_msg {
@@ -126,6 +129,8 @@ static void serial_in(struct fsi_master_gpio *master, struct fsi_gpio_msg *msg,
 		msg->msg |= ~in_bit & 0x1;	/* Data is active low */
 	}
 	msg->bits += num_bits;
+
+	trace_fsi_master_gpio_in(master, num_bits, msg->msg);
 }
 
 static void serial_out(struct fsi_master_gpio *master,
@@ -137,6 +142,8 @@ static void serial_out(struct fsi_master_gpio *master,
 	uint64_t last_bit = ~0;
 	int next_bit;
 
+	trace_fsi_master_gpio_out(master, cmd->bits, cmd->msg);
+
 	if (!cmd->bits) {
 		dev_warn(master->dev, "trying to output 0 bits\n");
 		return;
@@ -458,6 +465,8 @@ static int fsi_master_gpio_break(struct fsi_master *_master, int link)
 	if (link != 0)
 		return -ENODEV;
 
+	trace_fsi_master_gpio_break(master);
+
 	set_sda_output(master, 1);
 	sda_out(master, 1);
 	clock_toggle(master, FSI_PRE_BREAK_CLOCKS);
diff --git a/include/trace/events/fsi_master_gpio.h b/include/trace/events/fsi_master_gpio.h
new file mode 100644
index 0000000..11b36c1
--- /dev/null
+++ b/include/trace/events/fsi_master_gpio.h
@@ -0,0 +1,68 @@
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM fsi_master_gpio
+
+#if !defined(_TRACE_FSI_MASTER_GPIO_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_FSI_MASTER_GPIO_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(fsi_master_gpio_in,
+	TP_PROTO(const struct fsi_master_gpio *master, int bits, uint64_t msg),
+	TP_ARGS(master, bits, msg),
+	TP_STRUCT__entry(
+		__field(int,	master_idx)
+		__field(int,	bits)
+		__field(uint64_t, msg)
+	),
+	TP_fast_assign(
+		__entry->master_idx = master->master.idx;
+		__entry->bits = bits;
+		__entry->msg  = msg & ((1ull<<bits) - 1);
+	),
+	TP_printk("fsi-gpio%d => %0*llx[%d]",
+		__entry->master_idx,
+		(__entry->bits + 3) / 4,
+		__entry->msg,
+		__entry->bits
+	)
+);
+
+TRACE_EVENT(fsi_master_gpio_out,
+	TP_PROTO(const struct fsi_master_gpio *master, int bits, uint64_t msg),
+	TP_ARGS(master, bits, msg),
+	TP_STRUCT__entry(
+		__field(int,	master_idx)
+		__field(int,	bits)
+		__field(uint64_t, msg)
+	),
+	TP_fast_assign(
+		__entry->master_idx = master->master.idx;
+		__entry->bits = bits;
+		__entry->msg  = msg & ((1ull<<bits) - 1);
+	),
+	TP_printk("fsi-gpio%d <= %0*llx[%d]",
+		__entry->master_idx,
+		(__entry->bits + 3) / 4,
+		__entry->msg,
+		__entry->bits
+	)
+);
+
+TRACE_EVENT(fsi_master_gpio_break,
+	TP_PROTO(const struct fsi_master_gpio *master),
+	TP_ARGS(master),
+	TP_STRUCT__entry(
+		__field(int,	master_idx)
+	),
+	TP_fast_assign(
+		__entry->master_idx = master->master.idx;
+	),
+	TP_printk("fsi-gpio%d ----break---",
+		__entry->master_idx
+	)
+);
+
+#endif /* _TRACE_FSI_MASTER_GPIO_H */
+
+#include <trace/define_trace.h>
-- 
1.8.2.2
