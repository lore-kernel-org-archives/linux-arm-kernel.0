From: will.deacon@arm.com (Will Deacon)
Date: Tue, 30 Sep 2014 12:27:12 +0100
Subject: [PATCH v2] perf tools: fix build breakage on arm64 targets
Message-ID: <1412076432-22045-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Attempting to build the perf tool for an arm64 target results in the
following failure:

arch/arm64/util/unwind-libunwind.c: In function 'libunwind__arch_reg_id':
arch/arm64/util/unwind-libunwind.c:77:3: error: implicit declaration of function 'pr_err'
   pr_err("unwind: invalid reg id %d\n", regnum);
   ^
arch/arm64/util/unwind-libunwind.c:77:3: error: nested extern declaration of 'pr_err'

This is due to commit 84f5d36f4866 ("perf tools: Move pr_* debug macros
into debug object") moving the pr_* macros into a new header file, but
failing to update architectures other than x86.

This patch adds the missing include, and fixes the build again.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Jean Pihet <jean.pihet@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

v1->v2: Rebased onto tip tree, which removed the need for the arch/arm/ hunks.

 tools/perf/arch/arm64/util/unwind-libunwind.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/arm64/util/unwind-libunwind.c b/tools/perf/arch/arm64/util/unwind-libunwind.c
index 436ee43859dc..a87afa91a99e 100644
--- a/tools/perf/arch/arm64/util/unwind-libunwind.c
+++ b/tools/perf/arch/arm64/util/unwind-libunwind.c
@@ -3,6 +3,7 @@
 #include <libunwind.h>
 #include "perf_regs.h"
 #include "../../util/unwind.h"
+#include "../../util/debug.h"
 
 int libunwind__arch_reg_id(int regnum)
 {
-- 
2.1.0
