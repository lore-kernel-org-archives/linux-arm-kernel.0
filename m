From: toddpoynor@google.com (Todd Poynor)
Date: Tue,  8 May 2012 00:49:53 -0700
Subject: [PATCH] ARM: backtrace: avoid crash on large invalid fp value
Message-ID: <1336463393-25397-1-git-send-email-toddpoynor@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wraparound on invalid frame pointer (signed) -4 <= fp <= -1
defeats check for too high.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 arch/arm/kernel/stacktrace.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index 00f79e5..6315162 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -31,7 +31,7 @@ int notrace unwind_frame(struct stackframe *frame)
 	high = ALIGN(low, THREAD_SIZE);
 
 	/* check current frame pointer is within bounds */
-	if (fp < (low + 12) || fp + 4 >= high)
+	if (fp < (low + 12) || fp >= high - 4)
 		return -EINVAL;
 
 	/* restore the registers from the stack frame */
-- 
1.7.7.3
