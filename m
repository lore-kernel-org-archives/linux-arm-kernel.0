From: hekuang@huawei.com (He Kuang)
Date: Fri, 3 Feb 2017 11:06:06 +0000
Subject: [PATCH v2 2/3] perf tools: Enable bpf prologue for arm64
In-Reply-To: <20170203110607.97529-1-hekuang@huawei.com>
References: <20170203110607.97529-1-hekuang@huawei.com>
Message-ID: <20170203110607.97529-2-hekuang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since HAVE_KPROBES can be enabled in arm64, this patch introduces
regs_query_register_offset() to convert register name to offset for
arm64, so the BPF prologue feature is ready to use.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: He Kuang <hekuang@huawei.com>
---
 tools/perf/arch/arm64/Makefile          |  1 +
 tools/perf/arch/arm64/util/dwarf-regs.c | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
index 18b1351..eebe1ec 100644
--- a/tools/perf/arch/arm64/Makefile
+++ b/tools/perf/arch/arm64/Makefile
@@ -2,3 +2,4 @@ ifndef NO_DWARF
 PERF_HAVE_DWARF_REGS := 1
 endif
 PERF_HAVE_JITDUMP := 1
+PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
diff --git a/tools/perf/arch/arm64/util/dwarf-regs.c b/tools/perf/arch/arm64/util/dwarf-regs.c
index 090f36b..6d17a31 100644
--- a/tools/perf/arch/arm64/util/dwarf-regs.c
+++ b/tools/perf/arch/arm64/util/dwarf-regs.c
@@ -9,6 +9,8 @@
  */
 
 #include <stddef.h>
+#include <errno.h> /* for EINVAL */
+#include <string.h> /* for strcmp */
 #include <linux/ptrace.h> /* for struct user_pt_regs */
 #include <dwarf-regs.h>
 
@@ -75,3 +77,21 @@ const char *get_arch_regstr(unsigned int n)
 {
 	return (n < ARCH_MAX_REGS) ? regoffset_table[n].name : NULL;
 }
+
+/* Reuse code from arch/arm64/kernel/ptrace.c */
+/**
+ * regs_query_register_offset() - query register offset from its name
+ * @name:	the name of a register
+ *
+ * regs_query_register_offset() returns the offset of a register in struct
+ * user_pt_regs from its name. If the name is invalid, this returns -EINVAL;
+ */
+int regs_query_register_offset(const char *name)
+{
+	const struct pt_regs_offset *roff;
+
+	for (roff = regoffset_table; roff->name != NULL; roff++)
+		if (!strcmp(roff->name, name))
+			return roff->offset;
+	return -EINVAL;
+}
-- 
1.8.5.2
