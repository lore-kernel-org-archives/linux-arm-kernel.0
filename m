From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Tue,  6 Jun 2017 16:08:51 -0500
Subject: [PATCH v8 16/24] drivers/fsi: Add tracepoints for low-level operations
In-Reply-To: <20170606210859.80431-1-cbostic@linux.vnet.ibm.com>
References: <20170606210859.80431-1-cbostic@linux.vnet.ibm.com>
Message-ID: <20170606210859.80431-17-cbostic@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Kerr <jk@ozlabs.org>

Trace low level read and write FSI bus operations.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
---
v8 - type cast to 'int' to clean up build warnings
---
 drivers/fsi/fsi-core.c     |  27 +++++++---
 include/trace/events/fsi.h | 127 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 148 insertions(+), 6 deletions(-)
 create mode 100644 include/trace/events/fsi.h

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 3681365..db54561 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -23,6 +23,9 @@
 
 #include "fsi-master.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/fsi.h>
+
 #define FSI_SLAVE_CONF_NEXT_MASK	GENMASK(31, 31)
 #define FSI_SLAVE_CONF_SLOTS_MASK	GENMASK(23, 16)
 #define FSI_SLAVE_CONF_SLOTS_SHIFT	16
@@ -542,11 +545,16 @@ static int fsi_master_read(struct fsi_master *master, int link,
 {
 	int rc;
 
+	trace_fsi_master_read(master, link, slave_id, addr, size);
+
 	rc = fsi_check_access(addr, size);
-	if (rc)
-		return rc;
+	if (!rc)
+		rc = master->read(master, link, slave_id, addr, val, size);
+
+	trace_fsi_master_rw_result(master, link, slave_id, addr, size,
+			false, val, rc);
 
-	return master->read(master, link, slave_id, addr, val, size);
+	return rc;
 }
 
 static int fsi_master_write(struct fsi_master *master, int link,
@@ -554,11 +562,16 @@ static int fsi_master_write(struct fsi_master *master, int link,
 {
 	int rc;
 
+	trace_fsi_master_write(master, link, slave_id, addr, size, val);
+
 	rc = fsi_check_access(addr, size);
-	if (rc)
-		return rc;
+	if (!rc)
+		rc = master->write(master, link, slave_id, addr, val, size);
 
-	return master->write(master, link, slave_id, addr, val, size);
+	trace_fsi_master_rw_result(master, link, slave_id, addr, size,
+			true, val, rc);
+
+	return rc;
 }
 
 static int fsi_master_link_enable(struct fsi_master *master, int link)
@@ -574,6 +587,8 @@ static int fsi_master_link_enable(struct fsi_master *master, int link)
  */
 static int fsi_master_break(struct fsi_master *master, int link)
 {
+	trace_fsi_master_break(master, link);
+
 	if (master->send_break)
 		return master->send_break(master, link);
 
diff --git a/include/trace/events/fsi.h b/include/trace/events/fsi.h
new file mode 100644
index 0000000..697ee66
--- /dev/null
+++ b/include/trace/events/fsi.h
@@ -0,0 +1,127 @@
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM fsi
+
+#if !defined(_TRACE_FSI_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_FSI_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(fsi_master_read,
+	TP_PROTO(const struct fsi_master *master, int link, int id,
+			uint32_t addr, size_t size),
+	TP_ARGS(master, link, id, addr, size),
+	TP_STRUCT__entry(
+		__field(int,	master_idx)
+		__field(int,	link)
+		__field(int,	id)
+		__field(__u32,	addr)
+		__field(size_t,	size)
+	),
+	TP_fast_assign(
+		__entry->master_idx = master->idx;
+		__entry->link = link;
+		__entry->id = id;
+		__entry->addr = addr;
+		__entry->size = size;
+	),
+	TP_printk("fsi%d:%02d:%02d %08x[%zd]",
+		__entry->master_idx,
+		__entry->link,
+		__entry->id,
+		__entry->addr,
+		__entry->size
+	)
+);
+
+TRACE_EVENT(fsi_master_write,
+	TP_PROTO(const struct fsi_master *master, int link, int id,
+			uint32_t addr, size_t size, const void *data),
+	TP_ARGS(master, link, id, addr, size, data),
+	TP_STRUCT__entry(
+		__field(int,	master_idx)
+		__field(int,	link)
+		__field(int,	id)
+		__field(__u32,	addr)
+		__field(size_t,	size)
+		__field(__u32,	data)
+	),
+	TP_fast_assign(
+		__entry->master_idx = master->idx;
+		__entry->link = link;
+		__entry->id = id;
+		__entry->addr = addr;
+		__entry->size = size;
+		__entry->data = 0;
+		memcpy(&__entry->data, data, size);
+	),
+	TP_printk("fsi%d:%02d:%02d %08x[%zd] <= {%*ph}",
+		__entry->master_idx,
+		__entry->link,
+		__entry->id,
+		__entry->addr,
+		__entry->size,
+		(int)__entry->size, &__entry->data
+	)
+);
+
+TRACE_EVENT(fsi_master_rw_result,
+	TP_PROTO(const struct fsi_master *master, int link, int id,
+			uint32_t addr, size_t size,
+			bool write, const void *data, int ret),
+	TP_ARGS(master, link, id, addr, size, write, data, ret),
+	TP_STRUCT__entry(
+		__field(int,	master_idx)
+		__field(int,	link)
+		__field(int,	id)
+		__field(__u32,	addr)
+		__field(size_t,	size)
+		__field(bool,	write)
+		__field(__u32,	data)
+		__field(int,	ret)
+	),
+	TP_fast_assign(
+		__entry->master_idx = master->idx;
+		__entry->link = link;
+		__entry->id = id;
+		__entry->addr = addr;
+		__entry->size = size;
+		__entry->write = write;
+		__entry->data = 0;
+		__entry->ret = ret;
+		if (__entry->write || !__entry->ret)
+			memcpy(&__entry->data, data, size);
+	),
+	TP_printk("fsi%d:%02d:%02d %08x[%zd] %s {%*ph} ret %d",
+		__entry->master_idx,
+		__entry->link,
+		__entry->id,
+		__entry->addr,
+		__entry->size,
+		__entry->write ? "<=" : "=>",
+		(int)__entry->size, &__entry->data,
+		__entry->ret
+	)
+);
+
+TRACE_EVENT(fsi_master_break,
+	TP_PROTO(const struct fsi_master *master, int link),
+	TP_ARGS(master, link),
+	TP_STRUCT__entry(
+		__field(int,	master_idx)
+		__field(int,	link)
+	),
+	TP_fast_assign(
+		__entry->master_idx = master->idx;
+		__entry->link = link;
+	),
+	TP_printk("fsi%d:%d",
+		__entry->master_idx,
+		__entry->link
+	)
+);
+
+
+#endif /* _TRACE_FSI_H */
+
+#include <trace/define_trace.h>
-- 
1.8.2.2
