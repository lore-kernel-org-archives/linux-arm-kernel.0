From: jean.pihet@linaro.org (Jean Pihet)
Date: Tue,  6 May 2014 17:55:33 +0200
Subject: [PATCH 3/3] perf tools: Add libdw DWARF post unwind support for ARM64
In-Reply-To: <1399391733-11927-1-git-send-email-jean.pihet@linaro.org>
References: <1399391733-11927-1-git-send-email-jean.pihet@linaro.org>
Message-ID: <1399391733-11927-4-git-send-email-jean.pihet@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding libdw DWARF post unwind support, which is part
of elfutils-devel/libdw-dev package from version 0.158.

Note: the libdw code needs some support for dwarf unwinding
on ARM64, this code is submitted seperately on the elfutils
ML.

The new code is contained in unwin-libdw.c object, and
implements unwind__get_entries unwind interface function.

Signed-off-by: Jean Pihet <jean.pihet@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Corey Ashford <cjashfor@linux.vnet.ibm.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Arnaldo Carvalho de Melo <acme@infradead.org>
Cc: David Ahern <dsahern@gmail.com>
---
 tools/perf/arch/arm64/Makefile            |  5 +++
 tools/perf/arch/arm64/util/unwind-libdw.c | 53 +++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 tools/perf/arch/arm64/util/unwind-libdw.c

diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
index 221f21d..09d6215 100644
--- a/tools/perf/arch/arm64/Makefile
+++ b/tools/perf/arch/arm64/Makefile
@@ -4,6 +4,11 @@ LIB_OBJS += $(OUTPUT)arch/$(ARCH)/util/dwarf-regs.o
 endif
 ifndef NO_LIBUNWIND
 LIB_OBJS += $(OUTPUT)arch/$(ARCH)/util/unwind-libunwind.o
+endif
+ifndef NO_LIBDW_DWARF_UNWIND
+LIB_OBJS += $(OUTPUT)arch/$(ARCH)/util/unwind-libdw.o
+endif
+ifndef NO_DWARF_UNWIND
 LIB_OBJS += $(OUTPUT)arch/$(ARCH)/tests/regs_load.o
 LIB_OBJS += $(OUTPUT)arch/$(ARCH)/tests/dwarf-unwind.o
 endif
diff --git a/tools/perf/arch/arm64/util/unwind-libdw.c b/tools/perf/arch/arm64/util/unwind-libdw.c
new file mode 100644
index 0000000..8d24958
--- /dev/null
+++ b/tools/perf/arch/arm64/util/unwind-libdw.c
@@ -0,0 +1,53 @@
+#include <elfutils/libdwfl.h>
+#include "../../util/unwind-libdw.h"
+#include "../../util/perf_regs.h"
+
+bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
+{
+	struct unwind_info *ui = arg;
+	struct regs_dump *user_regs = &ui->sample->user_regs;
+	Dwarf_Word dwarf_regs[PERF_REG_ARM64_MAX];
+
+#define REG(r) ({						\
+	Dwarf_Word val = 0;					\
+	perf_reg_value(&val, user_regs, PERF_REG_ARM64_##r);	\
+	val;							\
+})
+
+	dwarf_regs[0]  = REG(X0);
+	dwarf_regs[1]  = REG(X1);
+	dwarf_regs[2]  = REG(X2);
+	dwarf_regs[3]  = REG(X3);
+	dwarf_regs[4]  = REG(X4);
+	dwarf_regs[5]  = REG(X5);
+	dwarf_regs[6]  = REG(X6);
+	dwarf_regs[7]  = REG(X7);
+	dwarf_regs[8]  = REG(X8);
+	dwarf_regs[9]  = REG(X9);
+	dwarf_regs[10] = REG(X10);
+	dwarf_regs[11] = REG(X11);
+	dwarf_regs[12] = REG(X12);
+	dwarf_regs[13] = REG(X13);
+	dwarf_regs[14] = REG(X14);
+	dwarf_regs[15] = REG(X15);
+	dwarf_regs[16] = REG(X16);
+	dwarf_regs[17] = REG(X17);
+	dwarf_regs[18] = REG(X18);
+	dwarf_regs[19] = REG(X19);
+	dwarf_regs[20] = REG(X20);
+	dwarf_regs[21] = REG(X21);
+	dwarf_regs[22] = REG(X22);
+	dwarf_regs[23] = REG(X23);
+	dwarf_regs[24] = REG(X24);
+	dwarf_regs[25] = REG(X25);
+	dwarf_regs[26] = REG(X26);
+	dwarf_regs[27] = REG(X27);
+	dwarf_regs[28] = REG(X28);
+	dwarf_regs[29] = REG(X29);
+	dwarf_regs[30] = REG(LR);
+	dwarf_regs[31] = REG(SP);
+	dwarf_regs[32] = REG(PC);
+
+	return dwfl_thread_state_registers(thread, 0, PERF_REG_ARM64_MAX,
+					   dwarf_regs);
+}
-- 
1.7.11.7
