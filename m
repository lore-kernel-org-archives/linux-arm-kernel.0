From: morgan.wang@huawei.com (Wang Kai)
Date: Thu, 11 Sep 2014 17:02:23 +0800
Subject: [PATCH] ARM:stacktrace: make stacktrace skip always right.
Message-ID: <1410426143-9455-1-git-send-email-morgan.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is for commit 3683f44c42e991d313dc301504ee0fca1aeb8580,
that makes stacktrace NOT begin from stacktrace self function,
which are: __save_stack_trace and save_stack_trace.

But save_stack_trace will NOT have stacktrace information when build
with '-O2', assemble code looks like below:
   00000154 <save_stack_trace>:
    154:   e1a0200d        mov     r2, sp
    158:   e1a01000        mov     r1, r0
    15c:   e3c23d7f        bic     r3, r2, #8128   ; 0x1fc0
    160:   e3a02000        mov     r2, #0
    164:   e3c3303f        bic     r3, r3, #63     ; 0x3f
    168:   e593000c        ldr     r0, [r3, #12]
    16c:   eaffffd0        b       b4 <__save_stack_trace>

In this situation, the "data.skip +=2" operation will skip the last
user call function, make user stacktrace strange/incorrect.

To fix this, we have to make sure save_stack_trace has stacktrace info,
then skip 2 function will be OK.

Signed-off-by: Wang Kai <morgan.wang@huawei.com>
---
 arch/arm/kernel/stacktrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index 6582c4a..1eb1b5ae 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -134,6 +134,7 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 void save_stack_trace(struct stack_trace *trace)
 {
 	__save_stack_trace(current, trace, 0);
+	asm volatile("" : : : "memory");
 }
 EXPORT_SYMBOL_GPL(save_stack_trace);
 #endif
-- 
1.8.5.5
