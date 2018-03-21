From: maninder1.s@samsung.com (Maninder Singh)
Date: Wed, 21 Mar 2018 16:40:45 +0530
Subject: [PATCH v2] arm/stacktrace: stop unwinding after an invalid address.
References: <CGME20180321111139epcas5p4d5b75f4e1b572ae4e55aef737cd6d8e9@epcas5p4.samsung.com>
Message-ID: <1521630645-46715-1-git-send-email-maninder1.s@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch stops unwinding backtrace in case address does not
belong to kernel address like below:-

....
__do_fault+0x4c/0xa8
handle_mm_fault+0xb74/0x11c0
do_page_fault+0x29c/0x38c
do_DataAbort+0x40/0xb8
__dabt_usr+0x44/0x60
0xb6748ea4
^^^^^^^^

So this patch discards last junk entry.

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
---
v1->v2: https://lkml.org/lkml/2017/10/24/378
(take care of IRQ taken in SVC mode)

 arch/arm/kernel/stacktrace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index a56e7c8..1aadffc 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -92,6 +92,9 @@ static int save_trace(struct stackframe *frame, void *d)
 
 	regs = (struct pt_regs *)frame->sp;
 
+	if (!__kernel_text_address(regs->ARM_pc))
+		return 1;
+
 	trace->entries[trace->nr_entries++] = regs->ARM_pc;
 
 	return trace->nr_entries >= trace->max_entries;
-- 
1.9.1
