From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 Jun 2010 10:36:03 +0100
Subject: [PATCH 2/2] ARM: perf probe: Add ARM DWARF register number mappings
In-Reply-To: <1277285763-16213-2-git-send-email-will.deacon@arm.com>
References: <1277285763-16213-1-git-send-email-will.deacon@arm.com>
	<1277285763-16213-2-git-send-email-will.deacon@arm.com>
Message-ID: <1277285763-16213-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds mappings from DWARF register numbers to the register
names used by the ARM `Regs and Stack Access API'.

Cc: Jamie Iles <jamie.iles@picochip.com>
Cc: Jean Pihet <jpihet@mvista.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 tools/perf/arch/arm/Makefile          |    4 ++
 tools/perf/arch/arm/util/dwarf-regs.c |   64 +++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 0 deletions(-)
 create mode 100644 tools/perf/arch/arm/Makefile
 create mode 100644 tools/perf/arch/arm/util/dwarf-regs.c

diff --git a/tools/perf/arch/arm/Makefile b/tools/perf/arch/arm/Makefile
new file mode 100644
index 0000000..15130b5
--- /dev/null
+++ b/tools/perf/arch/arm/Makefile
@@ -0,0 +1,4 @@
+ifndef NO_DWARF
+PERF_HAVE_DWARF_REGS := 1
+LIB_OBJS += $(OUTPUT)arch/$(ARCH)/util/dwarf-regs.o
+endif
diff --git a/tools/perf/arch/arm/util/dwarf-regs.c b/tools/perf/arch/arm/util/dwarf-regs.c
new file mode 100644
index 0000000..fff6450
--- /dev/null
+++ b/tools/perf/arch/arm/util/dwarf-regs.c
@@ -0,0 +1,64 @@
+/*
+ * Mapping of DWARF debug register numbers into register names.
+ *
+ * Copyright (C) 2010 Will Deacon, ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <libio.h>
+#include <dwarf-regs.h>
+
+struct pt_regs_dwarfnum {
+	const char *name;
+	unsigned int dwarfnum;
+};
+
+#define STR(s) #s
+#define REG_DWARFNUM_NAME(r, num) {.name = r, .dwarfnum = num}
+#define GPR_DWARFNUM_NAME(num) \
+	{.name = STR(%r##num), .dwarfnum = num}
+#define REG_DWARFNUM_END {.name = NULL, .dwarfnum = 0}
+
+/*
+ * Reference:
+ * http://infocenter.arm.com/help/topic/com.arm.doc.ihi0040a/IHI0040A_aadwarf.pdf
+ */
+static const struct pt_regs_dwarfnum regdwarfnum_table[] = {
+	GPR_DWARFNUM_NAME(0),
+	GPR_DWARFNUM_NAME(1),
+	GPR_DWARFNUM_NAME(2),
+	GPR_DWARFNUM_NAME(3),
+	GPR_DWARFNUM_NAME(4),
+	GPR_DWARFNUM_NAME(5),
+	GPR_DWARFNUM_NAME(6),
+	GPR_DWARFNUM_NAME(7),
+	GPR_DWARFNUM_NAME(8),
+	GPR_DWARFNUM_NAME(9),
+	GPR_DWARFNUM_NAME(10),
+	REG_DWARFNUM_NAME("%fp", 11),
+	REG_DWARFNUM_NAME("%ip", 12),
+	REG_DWARFNUM_NAME("%sp", 13),
+	REG_DWARFNUM_NAME("%lr", 14),
+	REG_DWARFNUM_NAME("%pc", 15),
+	REG_DWARFNUM_END,
+};
+
+/**
+ * get_arch_regstr() - lookup register name from it's DWARF register number
+ * @n:	the DWARF register number
+ *
+ * get_arch_regstr() returns the name of the register in struct
+ * regdwarfnum_table from it's DWARF register number. If the register is not
+ * found in the table, this returns NULL;
+ */
+const char *get_arch_regstr(unsigned int n)
+{
+	const struct pt_regs_dwarfnum *roff;
+	for (roff = regdwarfnum_table; roff->name != NULL; roff++)
+		if (roff->dwarfnum == n)
+			return roff->name;
+	return NULL;
+}
-- 
1.6.3.3
