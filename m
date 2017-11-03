From: julien.thierry@arm.com (Julien Thierry)
Date: Fri,  3 Nov 2017 11:44:18 +0000
Subject: [PATCH v2 3/3] perf: Fix ftrace builtin when kernel doesn't have
 function_graph
In-Reply-To: <1509709458-44541-1-git-send-email-julien.thierry@arm.com>
References: <1509709458-44541-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1509709458-44541-4-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When linux is built without support for function graph tracer, the ftrace
builtin of perf will fail when trying to reset max_graph_depth because the
file does not exist. This prevents the use of function tracer from perf.

Only try to write the file max_graph_depth file when it exists.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel at vger.kernel.org
---
 tools/perf/builtin-ftrace.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 25a42ac..1abc066 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -14,6 +14,7 @@
 #include <signal.h>
 #include <fcntl.h>
 #include <poll.h>
+#include <sys/stat.h>

 #include "debug.h"
 #include <subcmd/parse-options.h>
@@ -116,6 +117,13 @@ static int append_tracing_file(const char *name, const char *val)
 static int reset_tracing_cpu(void);
 static void reset_tracing_filters(void);

+static inline bool tracing_file_accessible(const char *name)
+{
+	struct stat s;
+
+	return stat(get_tracing_file(name), &s) == 0;
+}
+
 static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
 {
 	if (write_tracing_file("tracing_on", "0") < 0)
@@ -130,8 +138,12 @@ static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
 	if (reset_tracing_cpu() < 0)
 		return -1;

-	if (write_tracing_file("max_graph_depth", "0") < 0)
+	if (!tracing_file_accessible("max_graph_depth")) {
+		if (!strcmp(ftrace->tracer, "function_graph"))
+			return -1;
+	} else if (write_tracing_file("max_graph_depth", "0") < 0) {
 		return -1;
+	}

 	reset_tracing_filters();
 	return 0;
--
1.9.1
