From: zhang.chunyan@linaro.org (Chunyan Zhang)
Date: Wed,  1 Jun 2016 19:18:58 +0800
Subject: [RFC PATCH 3/4] trace: Duplicate the output of the function trace
 logs to STM
In-Reply-To: <1464779939-24986-1-git-send-email-zhang.chunyan@linaro.org>
References: <1464779939-24986-1-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <1464779939-24986-4-git-send-email-zhang.chunyan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds an output from Ftrace to STM.  That being said,
Function trace messages would also be duplicated to STM buffer when
being stored into ring buffer.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 kernel/trace/trace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8a4bd6b..d613053 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -44,6 +44,7 @@
 
 #include "trace.h"
 #include "trace_output.h"
+#include "trace_output_stm.h"
 
 /*
  * On boot up, the ring buffer is set to the minimum size, so that
@@ -1884,8 +1885,10 @@ trace_function(struct trace_array *tr,
 	entry->ip			= ip;
 	entry->parent_ip		= parent_ip;
 
-	if (!call_filter_check_discard(call, entry, buffer, event))
+	if (!call_filter_check_discard(call, entry, buffer, event)) {
 		__buffer_unlock_commit(buffer, event);
+		ftrace_stm_func(ip, parent_ip);
+	}
 }
 
 #ifdef CONFIG_STACKTRACE
-- 
1.9.1
