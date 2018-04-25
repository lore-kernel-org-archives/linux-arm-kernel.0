From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 25 Apr 2018 17:13:40 +0100
Subject: [PATCH 1/3] arm64: fix possible spectre-v1 in ptrace_hbp_get_event()
In-Reply-To: <20180425161342.38133-1-mark.rutland@arm.com>
References: <20180425161342.38133-1-mark.rutland@arm.com>
Message-ID: <20180425161342.38133-2-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's possible for userspace to control idx. Sanitize idx when using it
as an array index.

Found by smatch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/ptrace.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 71d99af24ef2..49830b5586b4 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -25,6 +25,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/task_stack.h>
 #include <linux/mm.h>
+#include <linux/nospec.h>
 #include <linux/smp.h>
 #include <linux/ptrace.h>
 #include <linux/user.h>
@@ -249,15 +250,20 @@ static struct perf_event *ptrace_hbp_get_event(unsigned int note_type,
 
 	switch (note_type) {
 	case NT_ARM_HW_BREAK:
-		if (idx < ARM_MAX_BRP)
-			bp = tsk->thread.debug.hbp_break[idx];
+		if (idx >= ARM_MAX_BRP)
+			goto out;
+		idx = array_index_nospec(idx, ARM_MAX_BRP);
+		bp = tsk->thread.debug.hbp_break[idx];
 		break;
 	case NT_ARM_HW_WATCH:
-		if (idx < ARM_MAX_WRP)
-			bp = tsk->thread.debug.hbp_watch[idx];
+		if (idx >= ARM_MAX_WRP)
+			goto out;
+		idx = array_index_nospec(idx, ARM_MAX_WRP);
+		bp = tsk->thread.debug.hbp_watch[idx];
 		break;
 	}
 
+out:
 	return bp;
 }
 
-- 
2.11.0
