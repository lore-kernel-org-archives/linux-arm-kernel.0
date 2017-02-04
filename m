From: hekuang@huawei.com (He Kuang)
Date: Sat, 4 Feb 2017 09:03:12 +0000
Subject: [PATCH v3] perf tools arm64: Add support for generating bpf prologue
In-Reply-To: <20170203130026.GF11585@arm.com>
References: <20170203130026.GF11585@arm.com>
Message-ID: <20170204090312.154901-1-hekuang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since HAVE_KPROBES can be enabled in arm64, this patch introduces
regs_query_register_offset() to convert register name to offset for
arm64, so the BPF prologue feature is ready to use.

Signed-off-by: He Kuang <hekuang@huawei.com>
---
 tools/perf/arch/arm64/Makefile          |  1 +
 tools/perf/arch/arm64/util/dwarf-regs.c | 30 +++++++++++++++++++++++-------
 2 files changed, 24 insertions(+), 7 deletions(-)

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
index d49efeb..f2b49bf 100644
--- a/tools/perf/arch/arm64/util/dwarf-regs.c
+++ b/tools/perf/arch/arm64/util/dwarf-regs.c
@@ -10,17 +10,22 @@
 
 #include <stddef.h>
 #include <dwarf-regs.h>
+#include <linux/ptrace.h> /* for struct user_pt_regs */
+#include "util.h"
 
 struct pt_regs_dwarfnum {
 	const char *name;
 	unsigned int dwarfnum;
+	unsigned int ptregs_offset;
 };
 
-#define STR(s) #s
-#define REG_DWARFNUM_NAME(r, num) {.name = r, .dwarfnum = num}
-#define GPR_DWARFNUM_NAME(num) \
-	{.name = STR(%x##num), .dwarfnum = num}
-#define REG_DWARFNUM_END {.name = NULL, .dwarfnum = 0}
+#define REG_DWARFNUM_NAME(r, num)					\
+		{.name = STR(%)STR(r), .dwarfnum = num,			\
+		.ptregs_offset = offsetof(struct user_pt_regs, r)}
+#define GPR_DWARFNUM_NAME(num)						\
+		{.name = STR(%x##num), .dwarfnum = num,		\
+		.ptregs_offset = offsetof(struct user_pt_regs, regs[num])}
+#define REG_DWARFNUM_END {.name = NULL, .dwarfnum = 0, .ptregs_offset = 0}
 
 /*
  * Reference:
@@ -57,8 +62,9 @@ struct pt_regs_dwarfnum {
 	GPR_DWARFNUM_NAME(27),
 	GPR_DWARFNUM_NAME(28),
 	GPR_DWARFNUM_NAME(29),
-	REG_DWARFNUM_NAME("%lr", 30),
-	REG_DWARFNUM_NAME("%sp", 31),
+	{.name = "%lr", .dwarfnum = 30,
+	 .ptregs_offset = offsetof(struct user_pt_regs, regs[30])},
+	REG_DWARFNUM_NAME(sp, 31),
 	REG_DWARFNUM_END,
 };
 
@@ -78,3 +84,13 @@ const char *get_arch_regstr(unsigned int n)
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
+			return roff->ptregs_offset;
+	return -EINVAL;
+}
-- 
1.8.5.2
