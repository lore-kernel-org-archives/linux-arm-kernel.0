From: hekuang@huawei.com (He Kuang)
Date: Fri, 3 Feb 2017 11:06:05 +0000
Subject: [PATCH v2 1/3] perf tools: Use offset instead of dwarfnum in register
 table.
Message-ID: <20170203110607.97529-1-hekuang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the 'dwarfnum' to 'offset' in register table, so
the index of array becomes the dwarfnum (the index of each register
defined by DWARF) and the "offset" member means the byte-offset of the
register in (user_)pt_regs. This change makes the code consistent with
x86.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: He Kuang <hekuang@huawei.com>
---
 tools/perf/arch/arm64/util/dwarf-regs.c | 107 ++++++++++++++++----------------
 1 file changed, 52 insertions(+), 55 deletions(-)

diff --git a/tools/perf/arch/arm64/util/dwarf-regs.c b/tools/perf/arch/arm64/util/dwarf-regs.c
index d49efeb..090f36b 100644
--- a/tools/perf/arch/arm64/util/dwarf-regs.c
+++ b/tools/perf/arch/arm64/util/dwarf-regs.c
@@ -9,72 +9,69 @@
  */
 
 #include <stddef.h>
+#include <linux/ptrace.h> /* for struct user_pt_regs */
 #include <dwarf-regs.h>
 
-struct pt_regs_dwarfnum {
+struct pt_regs_offset {
 	const char *name;
-	unsigned int dwarfnum;
+	int offset;
 };
 
-#define STR(s) #s
-#define REG_DWARFNUM_NAME(r, num) {.name = r, .dwarfnum = num}
-#define GPR_DWARFNUM_NAME(num) \
-	{.name = STR(%x##num), .dwarfnum = num}
-#define REG_DWARFNUM_END {.name = NULL, .dwarfnum = 0}
-
 /*
  * Reference:
  * http://infocenter.arm.com/help/topic/com.arm.doc.ihi0057b/IHI0057B_aadwarf64.pdf
  */
-static const struct pt_regs_dwarfnum regdwarfnum_table[] = {
-	GPR_DWARFNUM_NAME(0),
-	GPR_DWARFNUM_NAME(1),
-	GPR_DWARFNUM_NAME(2),
-	GPR_DWARFNUM_NAME(3),
-	GPR_DWARFNUM_NAME(4),
-	GPR_DWARFNUM_NAME(5),
-	GPR_DWARFNUM_NAME(6),
-	GPR_DWARFNUM_NAME(7),
-	GPR_DWARFNUM_NAME(8),
-	GPR_DWARFNUM_NAME(9),
-	GPR_DWARFNUM_NAME(10),
-	GPR_DWARFNUM_NAME(11),
-	GPR_DWARFNUM_NAME(12),
-	GPR_DWARFNUM_NAME(13),
-	GPR_DWARFNUM_NAME(14),
-	GPR_DWARFNUM_NAME(15),
-	GPR_DWARFNUM_NAME(16),
-	GPR_DWARFNUM_NAME(17),
-	GPR_DWARFNUM_NAME(18),
-	GPR_DWARFNUM_NAME(19),
-	GPR_DWARFNUM_NAME(20),
-	GPR_DWARFNUM_NAME(21),
-	GPR_DWARFNUM_NAME(22),
-	GPR_DWARFNUM_NAME(23),
-	GPR_DWARFNUM_NAME(24),
-	GPR_DWARFNUM_NAME(25),
-	GPR_DWARFNUM_NAME(26),
-	GPR_DWARFNUM_NAME(27),
-	GPR_DWARFNUM_NAME(28),
-	GPR_DWARFNUM_NAME(29),
-	REG_DWARFNUM_NAME("%lr", 30),
-	REG_DWARFNUM_NAME("%sp", 31),
-	REG_DWARFNUM_END,
-};
+#define REG_OFFSET_NAME(r, num) {.name = "%" #r,			\
+			.offset = offsetof(struct user_pt_regs, regs[num])}
+#define REG_OFFSET_END {.name = NULL, .offset = 0}
+#define GPR_OFFSET_NAME(r) \
+	{.name = "%x" #r, .offset = offsetof(struct user_pt_regs, regs[r])}
 
-/**
- * get_arch_regstr() - lookup register name from it's DWARF register number
- * @n:	the DWARF register number
- *
- * get_arch_regstr() returns the name of the register in struct
- * regdwarfnum_table from it's DWARF register number. If the register is not
- * found in the table, this returns NULL;
+/* This table is for reverse searching for the offset or register
+ * names in aarch64_regstr_tbl[].
  */
+static const struct pt_regs_offset regoffset_table[] = {
+	GPR_OFFSET_NAME(0),
+	GPR_OFFSET_NAME(1),
+	GPR_OFFSET_NAME(2),
+	GPR_OFFSET_NAME(3),
+	GPR_OFFSET_NAME(4),
+	GPR_OFFSET_NAME(5),
+	GPR_OFFSET_NAME(6),
+	GPR_OFFSET_NAME(7),
+	GPR_OFFSET_NAME(8),
+	GPR_OFFSET_NAME(9),
+	GPR_OFFSET_NAME(10),
+	GPR_OFFSET_NAME(11),
+	GPR_OFFSET_NAME(12),
+	GPR_OFFSET_NAME(13),
+	GPR_OFFSET_NAME(14),
+	GPR_OFFSET_NAME(15),
+	GPR_OFFSET_NAME(16),
+	GPR_OFFSET_NAME(17),
+	GPR_OFFSET_NAME(18),
+	GPR_OFFSET_NAME(19),
+	GPR_OFFSET_NAME(20),
+	GPR_OFFSET_NAME(21),
+	GPR_OFFSET_NAME(22),
+	GPR_OFFSET_NAME(23),
+	GPR_OFFSET_NAME(24),
+	GPR_OFFSET_NAME(25),
+	GPR_OFFSET_NAME(26),
+	GPR_OFFSET_NAME(27),
+	GPR_OFFSET_NAME(28),
+	GPR_OFFSET_NAME(29),
+	REG_OFFSET_NAME(lr, 30),
+	REG_OFFSET_NAME(sp, 31),
+	REG_OFFSET_END,
+};
+
+/* Minus 1 for the ending REG_OFFSET_END */
+#define ARCH_MAX_REGS ((sizeof(regoffset_table) /		\
+			sizeof(regoffset_table[0])) - 1)
+
+/* Return architecture dependent register string (for kprobe-tracer) */
 const char *get_arch_regstr(unsigned int n)
 {
-	const struct pt_regs_dwarfnum *roff;
-	for (roff = regdwarfnum_table; roff->name != NULL; roff++)
-		if (roff->dwarfnum == n)
-			return roff->name;
-	return NULL;
+	return (n < ARCH_MAX_REGS) ? regoffset_table[n].name : NULL;
 }
-- 
1.8.5.2
