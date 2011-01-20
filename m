From: kauppi@papupata.org (Ari Kauppi)
Date: Thu, 20 Jan 2011 20:57:19 +0200
Subject: [PATCH v2 2/3] oprofile: Provide stubs for oprofile_perf_{init,exit}
In-Reply-To: <1295549840-17809-1-git-send-email-kauppi@papupata.org>
References: <1295549840-17809-1-git-send-email-kauppi@papupata.org>
Message-ID: <1295549840-17809-3-git-send-email-kauppi@papupata.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_HW_PERF_EVENTS is not defined, provide stubs for
oprofile_perf_init and oprofile_perf_exit. Allows cleaning of
architecture specific implementations.

Signed-off-by: Ari Kauppi <kauppi@papupata.org>
---
 include/linux/oprofile.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/include/linux/oprofile.h b/include/linux/oprofile.h
index 54c8382..1ca6411 100644
--- a/include/linux/oprofile.h
+++ b/include/linux/oprofile.h
@@ -16,6 +16,8 @@
 #include <linux/types.h>
 #include <linux/spinlock.h>
 #include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/printk.h>
 #include <asm/atomic.h>
  
 /* Each escaped entry is prefixed by ESCAPE_CODE
@@ -190,6 +192,13 @@ int oprofile_write_commit(struct op_entry *entry);
 int __init oprofile_perf_init(struct oprofile_operations *ops);
 void oprofile_perf_exit(void);
 char *op_name_from_perf_id(void);
+#else
+static inline int __init oprofile_perf_init(struct oprofile_operations *ops)
+{
+	pr_info("oprofile: hardware counters not available\n");
+	return -ENODEV;
+}
+static inline void oprofile_perf_exit(void) { }
 #endif /* CONFIG_HW_PERF_EVENTS */
 
 #endif /* OPROFILE_H */
-- 
1.7.4.rc2.3.g60a2e
