From: will.deacon@arm.com (Will Deacon)
Date: Wed,  3 Nov 2010 17:22:25 +0000
Subject: [PATCH 1/3] ARM: backtrace: fix calculation of thread stack base
In-Reply-To: <1288804947-21213-1-git-send-email-will.deacon@arm.com>
References: <1288804947-21213-1-git-send-email-will.deacon@arm.com>
Message-ID: <1288804947-21213-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When unwinding stack frames we must take care not to unwind
areas of memory that lie outside of the known extent of the stack.

This patch fixes an incorrect calculation of the stack base where
THREAD_SIZE is added to the stack pointer after it has already
been aligned to this value. Since the ALIGN macro performs this
addition internally, we end up overshooting the base by 8k.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/stacktrace.c |    2 +-
 arch/arm/kernel/unwind.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index 20b7411..c2e112e 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -28,7 +28,7 @@ int notrace unwind_frame(struct stackframe *frame)
 
 	/* only go to a higher address on the stack */
 	low = frame->sp;
-	high = ALIGN(low, THREAD_SIZE) + THREAD_SIZE;
+	high = ALIGN(low, THREAD_SIZE);
 
 	/* check current frame pointer is within bounds */
 	if (fp < (low + 12) || fp + 4 >= high)
diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index 2a16176..d2cb0b3 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -279,7 +279,7 @@ int unwind_frame(struct stackframe *frame)
 
 	/* only go to a higher address on the stack */
 	low = frame->sp;
-	high = ALIGN(low, THREAD_SIZE) + THREAD_SIZE;
+	high = ALIGN(low, THREAD_SIZE);
 
 	pr_debug("%s(pc = %08lx lr = %08lx sp = %08lx)\n", __func__,
 		 frame->pc, frame->lr, frame->sp);
-- 
1.7.0.4
