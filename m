From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Fri, 26 Mar 2010 08:59:00 +0200
Subject: [PATCH] arm: kprobes: fix register corruption with jprobes
Message-ID: <1269586740-12813-1-git-send-email-ext-mika.1.westerberg@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current implementation of jprobes allocates empty pt_regs from the stack which
is then passed to kprobe_handler() and eventually to singlestep(). Now when
instruction being simulated is STMFD (like in normal function prologues without
CONFIG_FRAME_POINTER), stores using SP actually write over top of the fabricated
pt_regs structure.

This can be reproduced for example by using LKDTM module:

    # modprobe lkdtm
    # mount -t debugfs none /sys/kernel/debug
    # echo PANIC > /sys/kernel/debug/provoke-crash/INT_HW_IRQ_EN

after this, it fails with corrupted registers (before the requested crash would
occur):

    lkdtm: Crash point INT_HW_IRQ_EN of type PANIC hit, trigger in 9 rounds
    lkdtm: Crash point INT_HW_IRQ_EN of type PANIC hit, trigger in 8 rounds
    Internal error: Oops - undefined instruction: 0 [#1]
    last sysfs file: /sys/devices/platform/serial8250.0/sleep_timeout
    Modules linked in: lkdtm
    CPU: 0    Not tainted  (2.6.34-rc2 #69)
    PC is at irq_desc+0x1638/0xeeb0
    LR is at 0x25
    pc : [<c050b428>]    lr : [<00000025>]    psr: c80a0013
    sp : ce94bd60  ip : c050b3e8  fp : a0000013
    r10: c0aa453c  r9 : cf5d4000  r8 : ce9a1822
    r7 : c050b424  r6 : 00000025  r5 : c039d8f8  r4 : c050b3e8
    r3 : 00000001  r2 : cf4d0440  r1 : c039d8f8  r0 : 00000020
    Flags: NZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
    Control: 10c5387d  Table: 8e804019  DAC: 00000015
    Process sh (pid: 496, stack limit = 0xce94a2e8)
    Stack: (0xce94bd60 to 0xce94c000)
    bd60: c050b3e8 ce94bd60 00000025 c050b424 ce9a1822 00000025 00000025 ce94be58
    bd80: 0000004a c050ca1c ce9a1822 c002c070 ffffffff fa200000 0000004a c02991e0
    bda0: ce9a1822 e92d41f0 00000000 c039a890 c050c9e0 cfc72e00 0000004a c050ca1c
    bdc0: ce9a1822 cf5d4000 c0aa453c a0000013 00000000 ce94bde8 00000006 c02997c8
    bde0: c80a0013 ffffffff 0000004a cfc72e00 cf4d0440 00000001 c050c9e0 cfc72e00
    be00: 0000004a c050ca1c ce9a1822 cf5d4000 c0aa453c a0000013 c050c9e0 ce94be18
    be20: 0000004a c050ca1c ce9a1822 0000004a 0000004a 00000000 00000022 00000000
    be40: ce9a1822 c002c070 ffffffff fa200000 00000022 c02991e0 00000001 cf4d0810
    be60: 00000002 00004f48 c0aa453c 20000013 00000022 00000000 ce9a1822 cf5d4000
    be80: c0aa453c a0000013 000000d4 ce94bea0 c0074d40 c0299078 20000013 ffffffff
    bea0: 00000000 cfd33338 00000022 c018d8d4 c02b56fc cf4d0440 cf5d4000 ce9a1800
    bec0: 00000022 cf5d4574 cf420680 ce94a000 ce9a1800 c017b2c4 cf5d41f0 cf5d4130
    bee0: 60000013 00000000 cf4d0440 c004e6b8 cf5d4214 cf5d4214 c03a5870 00000022
    bf00: 00000022 00000000 cf5d4000 ce94a000 00000022 00000000 cf420680 c0178b3c
    bf20: cf4d0440 4001e000 c017b070 cf5fd440 00000000 c00aeb5c 00000001 cf420680
    bf40: 4001e000 ce94bf80 00000022 00000022 ce94a000 00000001 bef8a89c c00af3dc
    bf60: cf420680 4001e000 00000000 00000000 cf420680 00000022 4001e000 c00af530
    bf80: 00000000 00000000 00000022 00000000 00000022 4001e000 40185608 00000004
    bfa0: c002caa4 c002c900 00000022 4001e000 00000001 4001e000 00000022 00000000
    bfc0: 00000022 4001e000 40185608 00000004 00000022 00000014 00000001 bef8a89c
    bfe0: 00000000 bef8a880 400c7b88 401176bc 60000010 00000001 80cb0021 80cb0421
    Code: 000002cd 00000000 00000000 00000001 (dead4ead)
    ---[ end trace 2b46d5f2b682f370 ]---
    Kernel panic - not syncing: Fatal exception in interrupt

This patch allocates enough space (2 * sizeof(struct pt_regs)) from the stack to
prevent such corruption.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 arch/arm/kernel/kprobes.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/kprobes.c b/arch/arm/kernel/kprobes.c
index 60c62c3..610e0f5 100644
--- a/arch/arm/kernel/kprobes.c
+++ b/arch/arm/kernel/kprobes.c
@@ -393,6 +393,14 @@ void __kprobes jprobe_return(void)
 		/*
 		 * Setup an empty pt_regs. Fill SP and PC fields as
 		 * they're needed by longjmp_break_handler.
+		 *
+		 * We allocate some slack between the original SP and start of
+		 * our fabricated regs. To be precise we want to have worst case
+		 * covered which is STMFD with all 16 regs so we allocate 2 *
+		 * sizeof(struct_pt_regs)).
+		 *
+		 * This is to prevent any simulated instruction from writing
+		 * over the regs when they are accessing the stack.
 		 */
 		"sub    sp, %0, %1		\n\t"
 		"ldr    r0, ="__stringify(JPROBE_MAGIC_ADDR)"\n\t"
@@ -410,7 +418,7 @@ void __kprobes jprobe_return(void)
 		"ldmia	sp, {r0 - pc}		\n\t"
 		:
 		: "r" (kcb->jprobe_saved_regs.ARM_sp),
-		  "I" (sizeof(struct pt_regs)),
+		  "I" (sizeof(struct pt_regs) * 2),
 		  "J" (offsetof(struct pt_regs, ARM_sp)),
 		  "J" (offsetof(struct pt_regs, ARM_pc)),
 		  "J" (offsetof(struct pt_regs, ARM_cpsr))
-- 
1.5.6.5
