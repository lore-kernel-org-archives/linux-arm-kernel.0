From: maninder1.s@samsung.com (Maninder Singh)
Date: Tue, 24 Oct 2017 17:16:42 +0530
Subject: [PATCH 1/1] arm/stacktrace: stop unwinding after an invalid address.
References: <CGME20171024114852epcas5p199ffd8d75fc57e46d46025e12180c156@epcas5p1.samsung.com>
Message-ID: <1508845602-33508-1-git-send-email-maninder1.s@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch stops unwinding backtrace in case of below 2 cases.

(Issue observed while porting stackdepot on ARM, duplicate
entries created in stackdepot
reference patch for workaround in stackdepot:-
https://lkml.org/lkml/2017/10/11/353
).

1. If address belongs to irq/exception code, ignore it.
save_stack+0x40/0xec
 __set_page_owner+0x2c/0x64
....
....
 __handle_domain_irq+0x9c/0x130
 gic_handle_irq+0x40/0x80
 __irq_usr+0x4c/0x60
 0xb6507818
^^^^^^^

2. If address belongs to junk entry, ignore it
 kmem_cache_alloc_trace+0x1e8/0x21c
 rb_allocate_cpu_buffer+0xf0/0x25c
 __ring_buffer_alloc+0xf8/0x1e0
 trace_init+0xe0/0x2cc
 start_kernel+0x30c/0x448
 0x400080a0
^^^^^^^

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
---
 arch/arm/kernel/stacktrace.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index 3a2fa20..80e953e 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -82,6 +82,9 @@ static int save_trace(struct stackframe *frame, void *d)
 		return 0;
 	}
 
+	if (!__kernel_text_address(addr))
+		return 1;
+
 	trace->entries[trace->nr_entries++] = addr;
 
 	if (trace->nr_entries >= trace->max_entries)
@@ -98,12 +101,8 @@ static int save_trace(struct stackframe *frame, void *d)
 	data->last_pc = frame->pc;
 	if (!in_exception_text(addr))
 		return 0;
-
-	regs = (struct pt_regs *)frame->sp;
-
-	trace->entries[trace->nr_entries++] = regs->ARM_pc;
-
-	return trace->nr_entries >= trace->max_entries;
+	else
+		return 1;
 }
 
 /* This must be noinline to so that our skip calculation works correctly */
-- 
1.9.1
