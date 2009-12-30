From: rabin@rab.in (Rabin Vincent)
Date: Wed, 30 Dec 2009 22:28:40 +0530
Subject: [PATCH] ARM: fix "BUG: using smp_processor_id() in preemptible code"
Message-ID: <mailman.114.1262616654.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following warning, which appears when the register dump for a
faulting process is printed in a kernel with SMP, DEBUG_PREEMPT, and
DEBUG_USER (with user_debug=31) enabled:

BUG: using smp_processor_id() in preemptible [00000000] code: init/1
caller is __show_regs+0x18/0x234
Backtrace:
[<c0159e5c>] (dump_backtrace+0x0/0x114) from [<c01faf30>] (dump_stack+0x18/0x1c)
 r6:c781a000 r5:c0157544 r4:00000001 r3:00000000
[<c01faf18>] (dump_stack+0x0/0x1c) from [<c01e5230>] (debug_smp_processor_id+0xc4/0xf8)
[<c01e516c>] (debug_smp_processor_id+0x0/0xf8) from [<c0157544>] (__show_regs+0x18/0x234)
 r6:c781bfb0 r5:00000000 r4:c781bfb0 r3:00000000
[<c015752c>] (__show_regs+0x0/0x234) from [<c01577a0>] (show_regs+0x40/0x50)
[<c0157760>] (show_regs+0x0/0x50) from [<c015c968>] (__do_user_fault+0x5c/0xa4)
 r4:c781c000 r3:00000000
[<c015c90c>] (__do_user_fault+0x0/0xa4) from [<c015cbe0>] (do_page_fault+0x1b4/0x1e4)
 r7:00000000 r6:00010000 r5:c781bfb0 r4:c781c000
[<c015ca2c>] (do_page_fault+0x0/0x1e4) from [<c01554c8>] (do_DataAbort+0x3c/0xa0)
[<c015548c>] (do_DataAbort+0x0/0xa0) from [<c01560c4>] (ret_from_exception+0x0/0x10)

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/kernel/process.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 6730413..ba2adef 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -212,7 +212,8 @@ void __show_regs(struct pt_regs *regs)
 	char buf[64];
 
 	printk("CPU: %d    %s  (%s %.*s)\n",
-		smp_processor_id(), print_tainted(), init_utsname()->release,
+		raw_smp_processor_id(), print_tainted(),
+		init_utsname()->release,
 		(int)strcspn(init_utsname()->version, " "),
 		init_utsname()->version);
 	print_symbol("PC is at %s\n", instruction_pointer(regs));
-- 
1.6.5
