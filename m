From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Thu,  9 Feb 2017 22:39:09 -0300
Subject: [PATCH 01/32] perf tools arm64: Add support for generating bpf
 prologue
In-Reply-To: <20170210013940.9998-1-acme@kernel.org>
References: <20170210013940.9998-1-acme@kernel.org>
Message-ID: <20170210013940.9998-2-acme@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: He Kuang <hekuang@huawei.com>

Since HAVE_KPROBES can be enabled in arm64, this patch introduces
regs_query_register_offset() to convert register name to offset for
arm64, so the BPF prologue feature is ready to use.

Signed-off-by: He Kuang <hekuang@huawei.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Bintian Wang <bintian.wang@huawei.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: linux-arm-kernel at lists.infradead.org
Link: http://lkml.kernel.org/r/20170207073412.26983-1-hekuang at huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm64/Makefile          |  1 +
 tools/perf/arch/arm64/util/dwarf-regs.c | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
index 18b13518d8d8..eebe1ec9d2ee 100644
--- a/tools/perf/arch/arm64/Makefile
+++ b/tools/perf/arch/arm64/Makefile
@@ -2,3 +2,4 @@ ifndef NO_DWARF
 PERF_HAVE_DWARF_REGS := 1
 endif
 PERF_HAVE_JITDUMP := 1
+PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
diff --git a/tools/perf/arch/arm64/util/dwarf-regs.c b/tools/perf/arch/arm64/util/dwarf-regs.c
index d49efeb8172e..068b6189157b 100644
--- a/tools/perf/arch/arm64/util/dwarf-regs.c
+++ b/tools/perf/arch/arm64/util/dwarf-regs.c
@@ -10,17 +10,20 @@
 
 #include <stddef.h>
 #include <dwarf-regs.h>
+#include <linux/ptrace.h> /* for struct user_pt_regs */
+#include "util.h"
 
 struct pt_regs_dwarfnum {
 	const char *name;
 	unsigned int dwarfnum;
 };
 
-#define STR(s) #s
 #define REG_DWARFNUM_NAME(r, num) {.name = r, .dwarfnum = num}
 #define GPR_DWARFNUM_NAME(num) \
 	{.name = STR(%x##num), .dwarfnum = num}
 #define REG_DWARFNUM_END {.name = NULL, .dwarfnum = 0}
+#define DWARFNUM2OFFSET(index) \
+	(index * sizeof((struct user_pt_regs *)0)->regs[0])
 
 /*
  * Reference:
@@ -78,3 +81,13 @@ const char *get_arch_regstr(unsigned int n)
 			return roff->name;
 	return NULL;
 }
+
+int regs_query_register_offset(const char *name)
+{
+	const struct pt_regs_dwarfnum *roff;
+
+	for (roff = regdwarfnum_table; roff->name != NULL; roff++)
+		if (!strcmp(roff->name, name))
+			return DWARFNUM2OFFSET(roff->dwarfnum);
+	return -EINVAL;
+}
-- 
2.9.3
