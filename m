From: zhang.chunyan@linaro.org (Chunyan Zhang)
Date: Wed, 22 Jun 2016 10:46:52 +0800
Subject: [PATCH V2 3/4] trace: duplicate function pointer to STM
In-Reply-To: <1466563613-31578-1-git-send-email-zhang.chunyan@linaro.org>
References: <1466563613-31578-1-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <1466563613-31578-4-git-send-email-zhang.chunyan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch inserts an output from Ftrace to STM, logs the pointer of
the functions and their parents to STM.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 kernel/trace/trace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8a4bd6b..ed9e1b4 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -41,6 +41,7 @@
 #include <linux/nmi.h>
 #include <linux/fs.h>
 #include <linux/sched/rt.h>
+#include <linux/trace_output_stm.h>
 
 #include "trace.h"
 #include "trace_output.h"
@@ -1884,8 +1885,10 @@ trace_function(struct trace_array *tr,
 	entry->ip			= ip;
 	entry->parent_ip		= parent_ip;
 
-	if (!call_filter_check_discard(call, entry, buffer, event))
+	if (!call_filter_check_discard(call, entry, buffer, event)) {
 		__buffer_unlock_commit(buffer, event);
+		trace_func_to_stm(ip, parent_ip);
+	}
 }
 
 #ifdef CONFIG_STACKTRACE
-- 
1.9.1
