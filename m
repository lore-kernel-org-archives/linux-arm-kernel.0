From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Aug 2015 12:32:42 -0700
Subject: [PATCH] ARM: Add unwinding to __clear_user_std() conflicts
 (next-20150825)
In-Reply-To: <20150825233051.GA21612@n2100.arm.linux.org.uk>
References: <55dc65d7.040bc20a.609e.6686@mx.google.com>
 <CANMBJr4aeNa3P9bydT1L5KjZ0uH9REd2GXxV1bWAx4gF2++qbQ@mail.gmail.com>
 <20150825233051.GA21612@n2100.arm.linux.org.uk>
Message-ID: <20150826193242.GA28744@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add unwinding annotations so that unwinding from this function
works properly.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

On 08/26, Russell King - ARM Linux wrote:
> 
> Looking at the oops dumps you have, it's really quite annoying that they
> do not contain a proper backtrace.  I also have to ask why your logs
> seem to screw up on the PC/LR values in the oops dumps - they seem to
> be completely missing.
> 

This fixes the stacktrace for me so that it's actually readable.

 CPU: 1 PID: 1 Comm: init Not tainted 4.2.0-rc8-next-20150825-00012-g7b30062de23c-dirty #170
 Hardware name: Qualcomm (Flattened Device Tree)
 task: ee0a8000 ti: ee0b0000 task.ti: ee0b0000
 PC is at __clear_user_std+0x16/0x78
 LR is at padzero+0x47/0x54
 pc : [<c03df522>]    lr : [<c02f103b>]    psr: 60000033
 sp : ee0b1ea8  ip : 00000002  fp : 00000000
 r10: 001de22e  r9 : 00000000  r8 : ee122300
 r7 : ee0b1eb8  r6 : ed8d0300  r5 : 00000000  r4 : 00000051
 r3 : 00000055  r2 : 00000000  r1 : 00000dd2  r0 : 001de22e
 Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA Thumb  Segment none
 Control: 50c5787d  Table: 2d8d806a  DAC: 00000051
 Process init (pid: 1, stack limit = 0xee0b0210)
 Stack: (0xee0b1ea8 to 0xee0b2000)
 1ea0:                   00000dd2 c02f103b ee124200 c02f175b 00001812 000001cd
 1ec0: 001e2a20 00000000 ee122300 00000000 00000000 001e2a20 001de22e 00000001
 1ee0: 00000000 00008000 00008000 001dd870 001de22e 001d5870 00000051 00000055
 1f00: 00000000 ee0b1eb8 beffffde ed8d0300 ef7f7160 c02c1cfb 00000001 c0865324
 1f20: ed8d0300 c0862ca4 fffffff8 00000001 c0852fe0 ed8d0300 00000000 c02c1e7f
 1f40: ee0a8000 ee033000 ee126000 ee0b1f58 00000001 c02c2f1f 00000001 ed8d6038
 1f60: 00000000 ee0a8280 c0851118 00000000 c0852f50 00000000 00000000 00000000
 1f80: 00000000 00000000 00000000 c02c3039 00000000 c02094f5 00000000 c08da000
 1fa0: c059f2b5 c059f2d7 00000000 c020e4d5 00000000 00000000 00000000 00000000
 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
 [<c03df522>] (__clear_user_std) from [<c02f103b>] (padzero+0x47/0x54)
 [<c02f103b>] (padzero) from [<c02f175b>] (load_elf_binary+0x573/0xe74)
 [<c02f175b>] (load_elf_binary) from [<c02c1e7f>] (search_binary_handler+0x4f/0x124)
 [<c02c1e7f>] (search_binary_handler) from [<c02c2f1f>] (do_execveat_common+0x3df/0x4e0)
 [<c02c2f1f>] (do_execveat_common) from [<c02c3039>] (do_execve+0x19/0x1c)
 [<c02c3039>] (do_execve) from [<c059f2d7>] (kernel_init+0x23/0x9c)
 [<c059f2d7>] (kernel_init) from [<c020e4d5>] (ret_from_fork+0x11/0x3c)
 Code: 0c03 d011 f1bc 0f02 (f880) 2000

diff --git a/arch/arm/lib/clear_user.S b/arch/arm/lib/clear_user.S
index 970d6c043774..e936352ccb00 100644
--- a/arch/arm/lib/clear_user.S
+++ b/arch/arm/lib/clear_user.S
@@ -9,6 +9,7 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/unwind.h>
 
 		.text
 
@@ -20,6 +21,8 @@
  */
 ENTRY(__clear_user_std)
 WEAK(arm_clear_user)
+UNWIND(.fnstart)
+UNWIND(.save {r1, lr})
 		stmfd	sp!, {r1, lr}
 		mov	r2, #0
 		cmp	r1, #4
@@ -44,6 +47,7 @@ WEAK(arm_clear_user)
 USER(		strnebt	r2, [r0])
 		mov	r0, #0
 		ldmfd	sp!, {r1, pc}
+UNWIND(.fnend)
 ENDPROC(arm_clear_user)
 ENDPROC(__clear_user_std)
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
