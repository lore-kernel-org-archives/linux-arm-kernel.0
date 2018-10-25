From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 24 Oct 2018 17:09:05 -0700
Subject: [PATCH 2/2] perf tests: Add a test for the ARM 32-bit [vectors] page
In-Reply-To: <20181025000905.6095-1-f.fainelli@gmail.com>
References: <20181025000905.6095-1-f.fainelli@gmail.com>
Message-ID: <20181025000905.6095-3-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

perf on ARM requires CONFIG_KUSER_HELPERS to be turned on to allow some
independance with respect to the ARM CPU being used. Add a test which
tries to locate the [vectors] page, created when CONFIG_KUSER_HELPERS is
turned on to help asses the system's health.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 tools/perf/arch/arm/tests/Build          |  1 +
 tools/perf/arch/arm/tests/arch-tests.c   |  4 ++++
 tools/perf/arch/arm/tests/vectors-page.c | 20 ++++++++++++++++++++
 tools/perf/tests/tests.h                 |  5 +++++
 4 files changed, 30 insertions(+)
 create mode 100644 tools/perf/arch/arm/tests/vectors-page.c

diff --git a/tools/perf/arch/arm/tests/Build b/tools/perf/arch/arm/tests/Build
index 883c57ff0c08..d9ae2733f9cc 100644
--- a/tools/perf/arch/arm/tests/Build
+++ b/tools/perf/arch/arm/tests/Build
@@ -1,4 +1,5 @@
 libperf-y += regs_load.o
 libperf-y += dwarf-unwind.o
+libperf-y += vectors-page.o
 
 libperf-y += arch-tests.o
diff --git a/tools/perf/arch/arm/tests/arch-tests.c b/tools/perf/arch/arm/tests/arch-tests.c
index 5b1543c98022..6848101a855f 100644
--- a/tools/perf/arch/arm/tests/arch-tests.c
+++ b/tools/perf/arch/arm/tests/arch-tests.c
@@ -10,6 +10,10 @@ struct test arch_tests[] = {
 		.func = test__dwarf_unwind,
 	},
 #endif
+	{
+		.desc = "Vectors page",
+		.func = test__vectors_page,
+	},
 	{
 		.func = NULL,
 	},
diff --git a/tools/perf/arch/arm/tests/vectors-page.c b/tools/perf/arch/arm/tests/vectors-page.c
new file mode 100644
index 000000000000..e44223cbf0df
--- /dev/null
+++ b/tools/perf/arch/arm/tests/vectors-page.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <string.h>
+#include <linux/compiler.h>
+
+#include "tests/tests.h"
+#include "util/find-map.c"
+
+#define VECTORS__MAP_NAME "[vectors]"
+
+int test__vectors_page(struct test *test __maybe_unused,
+		       int subtest __maybe_unused)
+{
+	void *start, *end;
+
+	if (find_map(&start, &end, VECTORS__MAP_NAME))
+		return -1;
+
+	return 0;
+}
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index b82f55fcc294..399f18ca71a3 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -119,4 +119,9 @@ int test__arch_unwind_sample(struct perf_sample *sample,
 			     struct thread *thread);
 #endif
 #endif
+
+#if defined(__arm__)
+int test__vectors_page(struct test *test, int subtest);
+#endif
+
 #endif /* TESTS_H */
-- 
2.17.1
