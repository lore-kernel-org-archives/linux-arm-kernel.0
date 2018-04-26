From: dvyukov@google.com (Dmitry Vyukov)
Date: Thu, 26 Apr 2018 17:04:09 +0200
Subject: [PATCH] arm: port KCOV to arm
In-Reply-To: <CACT4Y+b+kHWstEWDDOh6unGSHnetnyJ-Gut1E494XGM1rFozBQ@mail.gmail.com>
References: <20180426130846.130976-1-dvyukov@google.com>
 <20180426134057.4sahhqrbkltwmfsk@lakrids.cambridge.arm.com>
 <CACT4Y+Z35mOAybskjxVhxvW+GrbOZ4c9s2LT+Ca_fE9ZufoiGQ@mail.gmail.com>
 <20180426142948.n74p52esmbvsqrow@lakrids.cambridge.arm.com>
 <CACT4Y+b+kHWstEWDDOh6unGSHnetnyJ-Gut1E494XGM1rFozBQ@mail.gmail.com>
Message-ID: <CACT4Y+ZfQyCd+dBNJEUvVquM8EN51JoOrrENJ+Q7Hpb0wF5xrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2018 at 4:58 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>>> >
>>> > On Thu, Apr 26, 2018 at 03:08:46PM +0200, Dmitry Vyukov wrote:
>>> >> KCOV is code coverage collection facility used, in particular, by syzkaller
>>> >> system call fuzzer. There is some interest in using syzkaller on arm devices.
>>> >> So port KCOV to arm.
>>> >>
>>> >> On implementation level this merely declares that KCOV is supported and
>>> >> disables instrumentation of 3 special cases. Reasons for disabling are
>>> >> commented in code.
>>> >>
>>> >> Tested with qemu-system-arm/vexpress-a15.
>>> >>
>>> >> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
>>> >> Cc: Russell King <linux@armlinux.org.uk>
>>> >> Cc: Mark Rutland <mark.rutland@arm.com>
>>> >> Cc: Abbott Liu <liuwenliang@huawei.com>
>>> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> >> Cc: Koguchi Takuo <takuo.koguchi.sw@hitachi.com>
>>> >> Cc: Atul Prakash <atulp@google.com>
>>> >> Cc: linux at armlinux.org.uk
>>> >> Cc: linux-arm-kernel at lists.infradead.org
>>> >> Cc: syzkaller at googlegroups.com
>>> >> ---
>>> >>  arch/arm/Kconfig                  | 1 +
>>> >>  arch/arm/boot/compressed/Makefile | 3 +++
>>> >>  arch/arm/mm/Makefile              | 4 ++++
>>> >>  arch/arm/vdso/Makefile            | 3 +++
>>> >>  4 files changed, 11 insertions(+)
>>> >
>>> > The hyp code will also need to opt-out of KCOV instrumentation.
>>> >
>>> > i.e. arch/arm/kvm/hyp/Makefile will need:
>>> >
>>> > KCOV_INSTRUMENT := n
>>> >
>>> > ... and we should probably pick up the other bits from the arm64 hyp
>>> > Makefile, i.e. all of:
>>> >
>>> > # KVM code is run at a different exception code with a different map, so
>>> > # compiler instrumentation that inserts callbacks or checks into the code may
>>> > # cause crashes. Just disable it.
>>> > GCOV_PROFILE    := n
>>> > KASAN_SANITIZE  := n
>>> > UBSAN_SANITIZE  := n
>>> > KCOV_INSTRUMENT := n
>>>
>>> I can blindly add them if you wish, but I don't have a way to test it.
>>> I also need an explanatory comment as to why we disable this.
>>> Otherwise I have to say "Mark said so" :)
>>
>> The rationale is that this code runs at hyp, with minimal code/data
>> mapped in its page tables (which are not the usual kernel page tables).
>> Instrumented code may call functions or access data structures which
>> aren't mapped, which will bring down the system.
>>
>>> p.s. KASAN does not exist on arm (yet).
>>
>> Sure. We can drop that line for now, or keep it -- it does no harm.
>>
>> [...]
>>
>>> >> +# Instrumenting fault.c causes infinite recursion between:
>>> >> +# __dabt_svc -> do_DataAbort -> __sanitizer_cov_trace_pc -> __dabt_svc
>>> >> +KCOV_INSTRUMENT_fault.o := n
>>> >
>>> > Why does __sanitizer_cov_trace_pc() cause a data abort?
>>> >
>>> > We don't seem to have this issue on arm64, where our fault handling is
>>> > instrumented, so this seems suspect.
>>>
>>> I don't have an explanation. That's just what me and Takuo observed.
>>> We've seen that it happens when __sanitizer_cov_trace_pc tries to
>>> dereference current to check kcov mode.
>>
>> Huh. The only reason I can imagine that might happen is if the
>> compiler's generating a misaligned access requiring fixup. If your
>> compiler's doing that, it could presumably do that in the fault handling
>> code too, which would be a big problem.
>>
>> If you happen to have a binary around, can you dump the disassembly for
>> your __sanitizer_cov_trace_pc?
>>
>> Using the Linaro 17.05 arm-linux-gnueabhif-gcc 6.3 toolchain I get the
>> following:
>>
>> 00000000 <__sanitizer_cov_trace_pc>:
>>    0:   e52de004        push    {lr}            ; (str lr, [sp, #-4]!)
>>    4:   e1a0300d        mov     r3, sp
>>    8:   e3c33d7f        bic     r3, r3, #8128   ; 0x1fc0
>>    c:   e3a02c01        mov     r2, #256        ; 0x100
>>   10:   e3c3303f        bic     r3, r3, #63     ; 0x3f
>>   14:   e340201f        movt    r2, #31
>>   18:   e5931004        ldr     r1, [r3, #4]
>>   1c:   e1110002        tst     r1, r2
>>   20:   149df004        popne   {pc}            ; (ldrne pc, [sp], #4)
>>   24:   e593300c        ldr     r3, [r3, #12]
>>   28:   e5932508        ldr     r2, [r3, #1288] ; 0x508
>>   2c:   e3520002        cmp     r2, #2
>>   30:   149df004        popne   {pc}            ; (ldrne pc, [sp], #4)
>>   34:   e5932510        ldr     r2, [r3, #1296] ; 0x510
>>   38:   e593150c        ldr     r1, [r3, #1292] ; 0x50c
>>   3c:   e5923000        ldr     r3, [r2]
>>   40:   e2833001        add     r3, r3, #1
>>   44:   e1530001        cmp     r3, r1
>>   48:   3782e103        strcc   lr, [r2, r3, lsl #2]
>>   4c:   35823000        strcc   r3, [r2]
>>   50:   e49df004        pop     {pc}            ; (ldr pc, [sp], #4)
>>
>> ... which looks sane/safe to me.
>
> Here is my disasm:
>
> 801dc1b0 <__sanitizer_cov_trace_pc>:
> 801dc1b0:       e52de004        push    {lr}            ; (str lr, [sp, #-4]!)
> 801dc1b4:       e1a0300d        mov     r3, sp
> 801dc1b8:       e3c33d7f        bic     r3, r3, #8128   ; 0x1fc0
> 801dc1bc:       e3a02c01        mov     r2, #256        ; 0x100
> 801dc1c0:       e3c3303f        bic     r3, r3, #63     ; 0x3f
> 801dc1c4:       e340201f        movt    r2, #31
> 801dc1c8:       e5931004        ldr     r1, [r3, #4]
> 801dc1cc:       e1110002        tst     r1, r2
> 801dc1d0:       149df004        popne   {pc}            ; (ldrne pc, [sp], #4)
> 801dc1d4:       e593300c        ldr     r3, [r3, #12]
> 801dc1d8:       e5932be0        ldr     r2, [r3, #3040] ; 0xbe0
> 801dc1dc:       e3520002        cmp     r2, #2
> 801dc1e0:       149df004        popne   {pc}            ; (ldrne pc, [sp], #4)
> 801dc1e4:       e5932be8        ldr     r2, [r3, #3048] ; 0xbe8
> 801dc1e8:       e5931be4        ldr     r1, [r3, #3044] ; 0xbe4
> 801dc1ec:       e5923000        ldr     r3, [r2]
> 801dc1f0:       e2833001        add     r3, r3, #1
> 801dc1f4:       e1510003        cmp     r1, r3
> 801dc1f8:       8782e103        strhi   lr, [r2, r3, lsl #2]
> 801dc1fc:       85823000        strhi   r3, [r2]
> 801dc200:       e49df004        pop     {pc}            ; (ldr pc, [sp], #4)
>
> Compiler is gcc version 7.2.0 (Debian 7.2.0-7).
>
> I've now rebuilt without that change and will hopefully soon get
> crashes to reconfirm.


Yes, a swarm of assorted crashes now. Here are 4:

buildroot login: Unable to handle kernel paging request at virtual
address c9db963e
pgd = c188b8a2
[c9db963e] *pgd=00000000
Internal error: Oops: 80000005 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 933 Comm: syz-executor3 Not tainted 4.17.0-rc2+ #4
Hardware name: ARM-Versatile Express
PC is at 0xc9db963e
LR is at do_work_pending+0xcc/0xf0
pc : [<c9db963e>]    lr : [<8010e290>]    psr: 80000093
sp : 9785dfb0  ip : 00000000  fp : 00000000
r10: 00000054  r9 : 9785c000  r8 : 00000000
r7 : 10c5387d  r6 : ffffffff  r5 : 20000030  r4 : 00031408
r3 : 9f749980  r2 : 00000000  r1 : 00000000  r0 : 00000000
Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 9786006a  DAC: 00000051
Process syz-executor3 (pid: 933, stack limit = 0xa0d2fc58)
Stack: (0x9785dfb0 to 0x9785e000)
dfa0:                                     0009c308 801dc1ec 60000193 ffffffff
dfc0: 9785e004 9fbd6990 801dc1ec 80101950 abf38000 00040000 abf38000 9f748cc0
dfe0: 80c08408 00000005 abf38000 9785e0d8 9fbd6990 9785e000 9ed5c480 80118a3c
[<8010e290>] (do_work_pending) from [<9fbd6990>] (0x9fbd6990)
Code: bad PC value
---[ end trace 4c3305535d90997d ]---
Kernel panic - not syncing: Fatal exception
CPU1: stopping
CPU: 1 PID: 928 Comm: syz-executor0 Tainted: G      D           4.17.0-rc2+ #4
Hardware name: ARM-Versatile Express
[<80112f64>] (unwind_backtrace) from [<8010ede4>] (show_stack+0x18/0x1c)
[<8010ede4>] (show_stack) from [<807e55d0>] (dump_stack+0xcc/0x110)
[<807e55d0>] (dump_stack) from [<80111758>] (handle_IPI+0x1b0/0x1c0)
[<80111758>] (handle_IPI) from [<804985e8>] (gic_handle_irq+0xbc/0xc0)
[<804985e8>] (gic_handle_irq) from [<801019f0>] (__irq_svc+0x70/0x98)
Exception stack(0x9a6dfd90 to 0x9a6dfdd8)
fd80:                                     9eed1600 00000002 00000000 9ec68000
fda0: 0009b66e 100400fb 9eed1600 9b66e71d 768e5000 00000008 00000000 768e5000
fdc0: 9a6de000 9a6dfde0 8023ad74 801dc1b0 00000013 ffffffff
[<801019f0>] (__irq_svc) from [<801dc1b0>] (__sanitizer_cov_trace_pc+0x0/0x54)
[<801dc1b0>] (__sanitizer_cov_trace_pc) from [<9b66e71d>] (0x9b66e71d)
Rebooting in 86400 seconds..



=============================================================

buildroot login: Unable to handle kernel paging request at virtual
address c641ca60
Unhandled fault: page domain fault (0x81b) at 0x00000055
pgd = 071861d0
[c641ca60] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 954 Comm: syz-executor0 Not tainted 4.17.0-rc2+ #4
Hardware name: ARM-Versatile Express
PC is at trace_hardirqs_off_caller+0x2c/0x164
LR is at __dabt_svc+0x54/0xa0
pc : [<801755b0>]    lr : [<80101934>]    psr: 20000193
sp : 974e8040  ip : 00000051  fp : 97511da4
r10: 9eeacb40  r9 : 974e8000  r8 : 9fbe6990
r7 : 974e807c  r6 : ffffffff  r5 : 20000193  r4 : 801755b0
r3 : ffffe000  r2 : c641c56c  r1 : 00000001  r0 : 80101934
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 9eec006a  DAC: 00000051
Process syz-executor0 (pid: 954, stack limit = 0xadce5611)
Stack: (0x974e8040 to 0x974e8000)
[<801755b0>] (trace_hardirqs_off_caller) from [<80101934>]
(__dabt_svc+0x54/0xa0)
Exception stack(0x974e8048 to 0x974e8090)
8040:                   80101934 00000001 c641c56c ffffe000 801755b0 20000193
8060: ffffffff 974e80d4 9fbe6990 974e8000 9eeacb40 97511da4 00000051 974e8098
8080: 80101934 801755b0 20000193 ffffffff
pgd = 78062a34
[<80101934>] (__dabt_svc) from [<801755b0>]
(trace_hardirqs_off_caller+0x2c/0x164)
[<801755b0>] (trace_hardirqs_off_caller) from [<80101934>]
(__dabt_svc+0x54/0xa0)
Exception stack(0x974e80a0 to 0x974e80e8)
80a0: 80101934 00000001 c641c56c ffffe000 801755b0 20000193 ffffffff 974e812c
80c0: 9fbe6990 974e8000 9eeacb40 97511da4 00000051 974e80f0 80101934 801755b0
80e0: 20000193 ffffffff
[<80101934>] (__dabt_svc) from [<801755b0>]
(trace_hardirqs_off_caller+0x2c/0x164)
[<801755b0>] (trace_hardirqs_off_caller) from [<80101934>]
(__dabt_svc+0x54/0xa0)
Exception stack(0x974e80f8 to 0x974e8140)
80e0:                                                       80101934 00000001
8100: c641c56c ffffe000 801755b0 20000193 ffffffff 974e8184 9fbe6990 974e8000
8120: 9eeacb40 97511da4 00000051 974e8148 80101934 801755b0 20000193 ffffffff
[<80101934>] (__dabt_svc) from [<801755b0>]
(trace_hardirqs_off_caller+0x2c/0x164)
[<801755b0>] (trace_hardirqs_off_caller) from [<80101934>]
(__dabt_svc+0x54/0xa0)
Exception stack(0x974e8150 to 0x974e8198)
8140:                                     80101934 00000001 c641c56c ffffe000
8160: 801755b0 20000193 ffffffff 974e81dc 9fbe6990 974e8000 9eeacb40 97511da4
8180: 00000051 974e81a0 80101934 801755b0 20000193 ffffffff
[<80101934>] (__dabt_svc) from [<801755b0>]
(trace_hardirqs_off_caller+0x2c/0x164)
[<801755b0>] (trace_hardirqs_off_caller) from [<80101934>]
(__dabt_svc+0x54/0xa0)
Exception stack(0x974e81a8 to 0x974e81f0)
81a0:                   80101934 00000001 c641c56c ffffe000 801755b0 20000193
81c0: ffffffff 974e8234 9fbe6990 974e8000 9eeacb40 97511da4 00000051 974e81f8
81e0: 80101934 801755b0 20000193 ffffffff
[<80101934>] (__dabt_svc) from [<801755b0>]
(trace_hardirqs_off_caller+0x2c/0x164)
[<801755b0>] (trace_hardirqs_off_caller) from [<80101934>]
(__dabt_svc+0x54/0xa0)
Exception stack(0x974e8200 to 0x974e8248)
8200: 80101934 00000001 c641c56c ffffe000 801755b0 20000193 ffffffff 974e828c
8220: 9fbe6990 974e8000 9eeacb40 97511da4 00000051 974e8250 80101934 801755b0
8240: 20000193 ffffffff
[<80101934>] (__dabt_svc) from [<801755b0>]
(trace_hardirqs_off_caller+0x2c/0x164)
[<801755b0>] (trace_hardirqs_off_caller) from [<80101934>]
(__dabt_svc+0x54/0xa0)
Exception stack(0x974e8258 to 0x974e82a0)
8240:                                                       80101934 00000001
8260: c641c56c ffffe000 801755b0 20000193 ffffffff 974e82e4 9fbe6990 974e8000
8280: 9eeacb40 97511da4 00000051 974e82a8 80101934 801755b0 20000193 ffffffff
[<80101934>] (__dabt_svc) from [<801755b0>]
(trace_hardirqs_off_caller+0x2c/0x164)
[<801755b0>] (trace_hardirqs_off_caller) from [<80101934>]
(__dabt_svc+0x54/0xa0)
[00000055] *pgd=97443835, *pte=00000000, *ppte=00000000
Internal error: : 81b [#2] SMP ARM
Modules linked in:
CPU: 0 PID: 942 Comm: syz-executor2 Not tainted 4.17.0-rc2+ #4
Exception stack(0x974e82b0 to 0x974e82f8)
82a0:                                     80101934 00000001 c641c56c ffffe000
82c0: 801755b0 20000193 ffffffff 974e833c 9fbe6990 974e8000 9eeacb40 97511da4
82e0: 00000051 974e8300 80101934 801755b0 20000193 ffffffff
[<80101934>] (__dabt_svc) from [<801755b0>]
(trace_hardirqs_off_caller+0x2c/0x164)
Hardware name: ARM-Versatile Express
[<801755b0>] (trace_hardirqs_off_caller) from [<80101934>]
(__dabt_svc+0x54/0xa0)
Exception stack(0x974e8308 to 0x974e8350)
8300:                   80101934 00000001 c641c56c ffffe000 801755b0 20000193
8320: ffffffff 974e8394 9fbe6990 974e8000 9eeacb40 97511da4 00000051 974e8358
8340: 80101934 801755b0 20000193 ffffffff
[<80101934>] (__dabt_svc) from [<801755b0>]
(trace_hardirqs_off_caller+0x2c/0x164)
[<801755b0>] (trace_hardirqs_off_caller) from [<80101934>]
(__dabt_svc+0x54/0xa0)
Exception stack(0x974e8360 to 0x974e83a8)
8360: 80101934 00000001 c641c56c ffffe000 801755b0 20000193 ffffffff 974e83ec
8380: 9fbe6990 974e8000 9eeacb40 97511da4 00000051 974e83b0 80101934 801755b0
83a0: 20000193 ffffffff
[<80101934>] (__dabt_svc) from [<801755b0>]
(trace_hardirqs_off_caller+0x2c/0x164)
[<801755b0>] (trace_hardirqs_off_caller) from [<80101934>]
(__dabt_svc+0x54/0xa0)
Exception stack(0x974e83b8 to 0x974e8400)
83a0:                                                       80101934 00000001
83c0: c641c56c ffffe000 801755b0 20000193 ffffffff 974e8444 9fbe6990 974e8000
83e0: 9eeacb40 97511da4 00000051 974e8408 80101934 801755b0 20000193 ffffffff
[<80101934>] (__dabt_svc) from [<801755b0>]
(trace_hardirqs_off_caller+0x2c/0x164)
[<801755b0>] (trace_hardirqs_off_caller) from [<80101934>]
(__dabt_svc+0x54/0xa0)
Exception stack(0x974e8410 to 0x974e8458)
8400:                                     80101934 00000001 c641c56c ffffe000
8420: 801755b0 20000193 ffffffff 974e849c 9fbe6990 974e8000 9eeacb40 97511da4
8440: 00000051 974e8460 80101934 801755b0 20000193 ffffffff
[<80101934>] (__dabt_svc) from [<801755b0>]
(trace_hardirqs_off_caller+0x2c/0x164)
[<801755b0>] (trace_hardirqs_off_caller) from [<80101934>]
(__dabt_svc+0x54/0xa0)
Exception stack(0x974e8468 to 0x974e84b0)
8460:                   80101934 00000001 c641c56c ffffe000 801755b0 20000193
8480: ffffffff 974e84f4 9fbe6990 974e8000 9eeacb40 97511da4 00000051 974e84b8
84a0: 80101934 801755b0 20000193 ffffffff
[<80101934>] (__dabt_svc) from [<801755b0>]
(trace_hardirqs_off_caller+0x2c/0x164)
[<801755b0>] (trace_hardirqs_off_caller) from [<80101934>]
(__dabt_svc+0x54/0xa0)
Exception stack(0x974e84c0 to 0x974e8508)
84c0: 80101934 00000001 c641c56c ffffe000 801755b0 20000193 ffffffff 974e854c
84e0: 9fbe6990 974e8000 9eeacb40 97511da4 00000051 974e8510 80101934 801755b0
PC is at list_netdevice+0xc4/0x17c
LR is at list_netdevice+0xc4/0x17c
pc : [<806bac14>]    lr : [<806bac14>]    psr: 80000013
sp : 97451e28  ip : 00000000  fp : 00000000
r10: 97451e6c  r9 : 00000000  r8 : 97490ab0
r7 : 9ee27810  r6 : 00000051  r5 : 974909c0  r4 : 9ee27800
r3 : 9f614c80  r2 : 00000000  r1 : 00000201  r0 : 000000d0
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 9745406a  DAC: 00000051
Process syz-executor2 (pid: 942, stack limit = 0xdd0292b9)
Stack: (0x97451e28 to 0x97452000)
8500: 20000193 ffffffff
[<80101934>] (__dabt_svc) from [<801755b0>]
(trace_hardirqs_off_caller+0x2c/0x164)
[<801755b0>] (trace_hardirqs_off_caller) from [<80101934>]
(__dabt_svc+0x54/0xa0)
Exception stack(0x974e8518 to 0x974e8560)
8500:                                                       80101934 00000001
8520: c641c56c ffffe000 801755b0 20000193 ffffffff 974e85a4 9fbe6990 974e8000
8540: 9eeacb40 97511da4 00000051 974e8568 80101934 801755b0 20000193 ffffffff
[<80101934>] (__dabt_svc) from [<801755b0>]
(trace_hardirqs_off_caller+0x2c/0x164)
[<801755b0>] (trace_hardirqs_off_caller) from [<80101934>]
(__dabt_svc+0x54/0xa0)
Exception stack(0x974e8570 to 0x974e85b8)
8560:                                     80101934 00000001 c641c56c ffffe000
8580: 801755b0 20000193 ffffffff 974e85fc 9fbe6990 974e8000 9eeacb40 97511da4
85a0: 00000051 974e85c0 80101934 801755b0 20000193 ffffffff
[<80101934>] (__dabt_svc) from [<801755b0>]
(trace_hardirqs_off_caller+0x2c/0x164)
[<801755b0>] (trace_hardirqs_off_caller) from [<80101934>]
(__dabt_svc+0x54/0xa0)
Exception stack(0x974e85c8 to 0x974e8610)
85c0:                   80101934 00000001 c641c56c ffffe000 801755b0 20000193
85e0: ffffffff 974e8654 9fbe6990 974e8000 9eeacb40 97511da4 00000051 974e8618
8600: 80101934 801755b0 20000193 ffffffff
[<80101934>] (__dabt_svc) from [<801755b0>]
(trace_hardirqs_off_caller+0x2c/0x164)
[<801755b0>] (trace_hardirqs_off_caller) from [<80101934>]
(__dabt_svc+0x54/0xa0)
Exception stack(0x974e8620 to 0x974e8668)
8620: 80101934 00000001 c641c56c ffffe000 801755b0 20000193 ffffffff 974e86ac
8640: 9fbe6990 974e8000 9eeacb40 97511da4 00000051 974e8670 80101934 801755b0
8660: 20000193 ffffffff
[<80101934>] (__dabt_svc) from [<801755b0>]
(trace_hardirqs_off_caller+0x2c/0x164)
[<801755b0>] (trace_hardirqs_off_caller) from [<80101934>]
(__dabt_svc+0x54/0xa0)
Exception stack(0x974e8678 to 0x974e86c0)
8660:                                                       80101934 00000001
8680: c641c56c ffffe000 801755b0 20000193 ffffffff 974e8704 9fbe6990 974e8000
1e20:                   40000013 9ee27800 9ee27800 80c08408 00000000 00000001
86a0: 9eeacb40 97511da4 00000051 974e86c8 80101934 801755b0 20000193 ffffffff
[<80101934>] (__dabt_svc) from [<801755b0>]
(trace_hardirqs_off_caller+0x2c/0x164)
[<801755b0>] (trace_hardirqs_off_caller) from [<80101934>]
(__dabt_svc+0x54/0xa0)
Exception stack(0x974e86d0 to 0x974e8718)
86c0:                                     80101934 00000001 c641c56c ffffe000
86e0: 801755b0 20000193 ffffffff 974e875c 9fbe6990 974e8000 9eeacb40 97511da4
8700: 00000051 974e8720 80101934 801755b0 20000193 ffffffff
[<80101934>] (__dabt_svc) from [<801755b0>]
(trace_hardirqs_off_caller+0x2c/0x164)
[<801755b0>] (trace_hardirqs_off_caller) from [<80101934>]
(__dabt_svc+0x54/0xa0)
Exception stack(0x974e8728 to 0x974e8770)
8720:                   80101934 00000001 c641c56c ffffe000 801755b0 20000193
8740: ffffffff 974e87b4 9fbe6990 974e8000 9eeacb40 97511da4 00000051 974e8778
8760: 80101934 801755b0 20000193 ffffffff
[<80101934>] (__dabt_svc) from [<801755b0>]
(trace_hardirqs_off_caller+0x2c/0x164)
[<801755b0>] (trace_hardirqs_off_caller) from [<80101934>]
(__dabt_svc+0x54/0xa0)
Exception stack(0x974e8780 to 0x974e87c8)
8780: 80101934 00000001 c641c56c ffffe000 801755b0 20000193 ffffffff 974e880c
87a0: 9fbe6990 974e8000 9eeacb40 97511da4 00000051 974e87d0 80101934 801755b0
87c0: 20000193 ffffffff
[<80101934>] (__dabt_svc) from [<801755b0>]
(trace_hardirqs_off_caller+0x2c/0x164)
[<801755b0>] (trace_hardirqs_off_caller) from [<80101934>]
(__dabt_svc+0x54/0xa0)
Exception stack(0x974e87d8 to 0x974e8820)
87c0:                                                       80101934 00000001
87e0: c641c56c ffffe000 801755b0 20000193 ffffffff 974e8864 9fbe6990 974e8000
8800: 9eeacb40 97511da4 00000051 974e8828 80101934 801755b0 20000193 ffffffff
[<80101934>] (__dabt_svc) from [<801755b0>]
(trace_hardirqs_off_caller+0x2c/0x164)
[<801755b0>] (trace_hardirqs_off_caller) from [<80101934>]
(__dabt_svc+0x54/0xa0)
Exception stack(0x974e8830 to 0x974e8878)
8820:                                     80101934 00000001 c641c56c ffffe000
8840: 801755b0 20000193 ffffffff 974e88bc 9fbe6990 974e8000 9eeacb40 97511da4
8860: 00000051 974e8880 80101934 801755b0 20000193 ffffffff
[<80101934>] (__dabt_svc) from [<801755b0>]
(trace_hardirqs_off_caller+0x2c/0x164)
[<801755b0>] (trace_hardirqs_off_caller) from [<80101934>]
(__dabt_svc+0x54/0xa0)
Exception stack(0x974e8888 to 0x974e88d0)
8880:                   80101934 00000001 c641c56c ffffe000 801755b0 20000193
1e40: 00000001 806cbb58 806c2104 00000001 00000000 00000000 00000000 00000000
1e60: 00000000 00000000 00000001 9ee27800 00000000 c9db963e 00000000 9ee27800
1e80: 974909c0 00000000 00000000 97451ee4 80c08408 80c32a80 00000000 806cbc9c
1ea0: 9ee27800 805a5f20 00000001 00000001 805a5ed0 974909c0 00000000 806b35b8
1ec0: 80c27298 974909c0 80c32ae8 00000000 97451ee4 80c08408 80c32a80 806b3cf0
1ee0: 806b524c 97451ee4 97451ee4 c9db963e 00000001 974909c0 80c0fb3c 80c0fa7c
1f00: 9f40f500 00000000 9f5f8e80 00000000 00000000 806b530c 9f422960 80c41fac
1f20: 40000000 80c0fa7c 9f614c80 801519bc 00000015 00000001 80c0fa7c 40000000
1f40: 9f5f8e80 80c0fa7c 97451f80 9f614c80 97450000 80151f2c 00000000 c9db963e
88a0: ffffffff 974e8914 9fbe6990 974e8000 9eeacb40 97511da4 00000051 974e88d8
1f60: 40000000 80c08408 00000000 00000000 00000000 80124ffc 00000000 00000000
1f80: 00000000 c9db963e 00000002 7ef93d1c 00000000 000b0000 00000151 801011c4
1fa0: 97450000 80101000 7ef93d1c 00000000 40000000 7ef93cf8 000001b4 00100000
1fc0: 7ef93d1c 00000000 000b0000 00000151 00000004 00000000 00000000 00000000
1fe0: 00000000 7ef93d0c 00010547 00036578 00000030 40000000 00000000 00000000
[<806bac14>] (list_netdevice) from [<806cbb58>] (register_netdevice+0x5d8/0x6f8)
[<806cbb58>] (register_netdevice) from [<806cbc9c>] (register_netdev+0x24/0x40)
[<806cbc9c>] (register_netdev) from [<805a5f20>] (loopback_net_init+0x50/0xc4)
[<805a5f20>] (loopback_net_init) from [<806b35b8>] (ops_init+0xdc/0x190)
[<806b35b8>] (ops_init) from [<806b3cf0>] (setup_net+0xd8/0x230)
[<806b3cf0>] (setup_net) from [<806b530c>] (copy_net_ns+0x190/0x1e0)
[<806b530c>] (copy_net_ns) from [<801519bc>] (create_new_namespaces+0x118/0x280)
[<801519bc>] (create_new_namespaces) from [<80151f2c>]
(unshare_nsproxy_namespaces+0x8c/0xf8)
[<80151f2c>] (unshare_nsproxy_namespaces) from [<80124ffc>]
(ksys_unshare+0x24c/0x48c)
[<80124ffc>] (ksys_unshare) from [<80101000>] (ret_fast_syscall+0x0/0x28)
Exception stack(0x97451fa8 to 0x97451ff0)
1fa0:                   7ef93d1c 00000000 40000000 7ef93cf8 000001b4 00100000
1fc0: 7ef93d1c 00000000 000b0000 00000151 00000004 00000000 00000000 00000000
1fe0: 00000000 7ef93d0c 00010547 00036578
Code: e3560000 e7827100 0a000001 ebec8566 (e5867004)
---[ end trace 6ace6175b5180e2d ]---
Kernel panic - not syncing: Fatal exception in interrupt
Unhandled fault: page domain fault (0x01b) at 0x00000be0
Unable to handle kernel paging request at virtual address 7087f618
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
SMP: failed to stop secondary CPUs
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unhandled fault: page domain fault (0x01b) at 0x00000be0
Unhandled fault: page domain fault (0x01b) at 0x00000244
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
pgd = ff081c69
[3028ec1f] *pgd=00000000
Rebooting in 86400 seconds..

=============================================





Kernel panic - not syncing: stack-protector: Kernel stack is corrupted
in: do_futex+0xf04/0xf88

CPU: 1 PID: 969 Comm: syz-executor2 Not tainted 4.17.0-rc2+ #4
Hardware name: ARM-Versatile Express
[<80112f64>] (unwind_backtrace) from [<8010ede4>] (show_stack+0x18/0x1c)
[<8010ede4>] (show_stack) from [<807e55d0>] (dump_stack+0xcc/0x110)
[<807e55d0>] (dump_stack) from [<80125dac>] (panic+0x11c/0x2f0)
[<80125dac>] (panic) from [<80125828>] (print_tainted+0x0/0xcc)
[<80125828>] (print_tainted) from [<978fbf68>] (0x978fbf68)
Unhandled fault: page domain fault (0x01b) at 0x000004f5
Unable to handle kernel paging request at virtual address 7414bd10
pgd = 16be7fe8
[7414bd10] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in:
CPU: -1700673763 PID: 0 Comm:  Not tainted 4.17.0-rc2+ #4
Hardware name: ARM-Versatile Express
PC is at console_unlock+0x80/0x6c0
LR is at console_unlock+0x50/0x6c0
pc : [<801867bc>]    lr : [<8018678c>]    psr: a0000193
sp : 978cfde8  ip : 9aa1bc15  fp : 8134b578
r10: 20000193  r9 : 00000000  r8 : 00000000
r7 : 8134b578  r6 : 00000006  r5 : ffffe000  r4 : 00000000
r3 : fcd50e39  r2 : 0000001d  r1 : 80c0842c  r0 : 00000001
Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 9a1cc06a  DAC: 00000051
Process  (pid: 0, stack limit = 0xf7eeb3d2)
Stack: (0x978cfde8 to 0x00002000)
[<801867bc>] (console_unlock) from [<801870cc>] (vprintk_emit+0x2d0/0x510)
[<801870cc>] (vprintk_emit) from [<80187520>] (vprintk_default+0x2c/0x34)
[<80187520>] (vprintk_default) from [<80188b6c>] (vprintk_func+0xc4/0x124)
[<80188b6c>] (vprintk_func) from [<80188364>] (printk+0x34/0x58)
[<80188364>] (printk) from [<80118b34>] (do_DataAbort+0x9c/0xf4)
[<80118b34>] (do_DataAbort) from [<8010193c>] (__dabt_svc+0x5c/0xa0)
Exception stack(0x978cffb0 to 0x978cfff8)
ffa0:                                     80101934 00000001 00000001 ffffe000
ffc0: 801755b0 20000193 ffffffff 978d003c 80c0d1f8 978d0000 9ed36480 978dbd54
ffe0: 80c0d1a8 978d0000 80101934 801755b0 20000193 ffffffff
Code: e203201f b1a03001 e59d102c e1a032c3 (e7913103)
---[ end trace d985f5a16c59cb8d ]---
SMP: failed to stop secondary CPUs
Rebooting in 86400 seconds..

===============================================



buildroot login: ------------[ cut here ]------------
Unable to handle kernel paging request at virtual address 73b23c48
pgd = 27ff7dff
Unable to handle kernel paging request at virtual address e79caeeb
pgd = 27ff7dff
Unable to handle kernel paging request at virtual address e79ccbe3
pgd = 27ff7dff
Unable to handle kernel paging request at virtual address e79ccbe3
pgd = 27ff7dff
Unable to handle kernel paging request at virtual address e79ccbe3
pgd = 27ff7dff
Unable to handle kernel paging request at virtual address e79ccbe3
pgd = 27ff7dff
Unable to handle kernel paging request at virtual address e79ccbe3
pgd = 27ff7dff
Unable to handle kernel paging request at virtual address e79ccbe3
pgd = 27ff7dff
Unable to handle kernel paging request at virtual address e79ccbe3
pgd = 27ff7dff
Unable to handle kernel paging request at virtual address e79ccbe3
pgd = 27ff7dff
Unable to handle kernel paging request at virtual address e79ccbe3
pgd = 27ff7dff
Unable to handle kernel paging request at virtual address e79ccbe3
pgd = 27ff7dff
Unable to handle kernel paging request at virtual address e79ccbe3
pgd = 27ff7dff
Unable to handle kernel paging request at virtual address e79ccbe3
pgd = 27ff7dff
Unable to handle kernel paging request at virtual address e79ccbe3
pgd = 27ff7dff
Unable to handle kernel paging request at virtual address e79ccbe3
pgd = 27ff7dff
Unable to handle kernel paging request at virtual address e79ccbe3
pgd = 27ff7dff
Unable to handle kernel paging request at virtual address e79ccbe3
pgd = 27ff7dff
Unable to handle kernel paging request at virtual address e79ccbe3
pgd = 27ff7dff
Unable to handle kernel paging request at virtual address d20d547a
Unable to handle kernel paging request at virtual address 7087f618
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
Unable to handle kernel paging request at virtual address 3028ec1f
pgd = 1f9b9281
[3028ec1f] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 0 Comm:  Not tainted 4.17.0-rc2+ #4
Hardware name: ARM-Versatile Express
PC is at show_pte+0x28/0xd4
LR is at show_pte+0x28/0xd4
pc : [<801182d8>]    lr : [<801182d8>]    psr: 20000193
sp : 978da0e8  ip : 00000000  fp : 9fbd1510
r10: 8031140e  r9 : 978da000  r8 : 3028ebff
r7 : 00000005  r6 : 00000181  r5 : 3028ec1f  r4 : 3028ebff
r3 : 978da000  r2 : 001f0100  r1 : 9fbd1a2e  r0 : 3028ebff
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 978d006a  DAC: 00000051
Process  (pid: 0, stack limit = 0xc88e92ff)
Stack: (0x978da0e8 to 0x00002000)
[<801182d8>] (show_pte) from [<80118cc0>] (__do_kernel_fault.part.0+0x5c/0x80)
[<80118cc0>] (__do_kernel_fault.part.0) from [<801188ec>] (do_bad_area+0x0/0xa0)
[<801188ec>] (do_bad_area) from [<8491141e>] (0x8491141e)
Code: e34830c1 e1a06aa5 01a04003 eb030fb5 (e5941020)
---[ end trace 5c73d7479f0df7a7 ]---
Kernel panic - not syncing: Fatal exception in interrupt
CPU1: stopping
CPU: 1 PID: 926 Comm: syz-executor1 Tainted: G      D           4.17.0-rc2+ #4
Hardware name: ARM-Versatile Express
[<80112f64>] (unwind_backtrace) from [<8010ede4>] (show_stack+0x18/0x1c)
[<8010ede4>] (show_stack) from [<807e55d0>] (dump_stack+0xcc/0x110)
[<807e55d0>] (dump_stack) from [<80111758>] (handle_IPI+0x1b0/0x1c0)
[<80111758>] (handle_IPI) from [<804985e8>] (gic_handle_irq+0xbc/0xc0)
[<804985e8>] (gic_handle_irq) from [<801019f0>] (__irq_svc+0x70/0x98)
Exception stack(0x98b75f08 to 0x98b75f50)
5f00:                   9edfcbc8 00000000 00000000 00000055 80c08408 00000051
5f20: 7ee32e60 7ee32e60 801011c4 98b74000 00000000 00000000 98b74000 98b75f58
5f40: 8019ec9c 8019ecac 80000013 ffffffff
[<801019f0>] (__irq_svc) from [<8019ecac>] (put_timespec64+0x78/0xcc)
[<8019ecac>] (put_timespec64) from [<801ad904>] (sys_clock_gettime+0x84/0xcc)
[<801ad904>] (sys_clock_gettime) from [<80101000>] (ret_fast_syscall+0x0/0x28)
Exception stack(0x98b75fa8 to 0x98b75ff0)
5fa0:                   00000002 7ee32eb0 00000001 7ee32e60 00000000 00000000
5fc0: 00000002 7ee32eb0 7ee32edc 00000107 0006c8f4 00000000 7ee336c4 00000000
5fe0: 00000107 7ee32e54 0003692f 0001bad6
