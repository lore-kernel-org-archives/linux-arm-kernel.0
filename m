From: dvyukov@google.com (Dmitry Vyukov)
Date: Fri, 27 Apr 2018 15:52:33 +0200
Subject: [PATCH] arm: port KCOV to arm
In-Reply-To: <CACT4Y+b_cAKf80y5a8KaV7P=-KtcB83E7x-SXv-Uq_kxzy_7wA@mail.gmail.com>
References: <20180426130846.130976-1-dvyukov@google.com>
 <20180426134057.4sahhqrbkltwmfsk@lakrids.cambridge.arm.com>
 <CACT4Y+Z35mOAybskjxVhxvW+GrbOZ4c9s2LT+Ca_fE9ZufoiGQ@mail.gmail.com>
 <20180426142948.n74p52esmbvsqrow@lakrids.cambridge.arm.com>
 <CACT4Y+b+kHWstEWDDOh6unGSHnetnyJ-Gut1E494XGM1rFozBQ@mail.gmail.com>
 <CACT4Y+ZfQyCd+dBNJEUvVquM8EN51JoOrrENJ+Q7Hpb0wF5xrA@mail.gmail.com>
 <20180427130643.klvm4rqxhv7w5f2o@lakrids.cambridge.arm.com>
 <CACT4Y+b_cAKf80y5a8KaV7P=-KtcB83E7x-SXv-Uq_kxzy_7wA@mail.gmail.com>
Message-ID: <CACT4Y+ZTn4BGicNQzfhzHygdSNf88ytqQj1HQjiKnrJOTw1XaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2018 at 3:51 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Fri, Apr 27, 2018 at 3:06 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> On Thu, Apr 26, 2018 at 05:04:09PM +0200, Dmitry Vyukov wrote:
>>> On Thu, Apr 26, 2018 at 4:58 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>>> >>> > On Thu, Apr 26, 2018 at 03:08:46PM +0200, Dmitry Vyukov wrote:
>>
>>> >>> >> +# Instrumenting fault.c causes infinite recursion between:
>>> >>> >> +# __dabt_svc -> do_DataAbort -> __sanitizer_cov_trace_pc -> __dabt_svc
>>> >>> >> +KCOV_INSTRUMENT_fault.o := n
>>> >>> >
>>> >>> > Why does __sanitizer_cov_trace_pc() cause a data abort?
>>> >>> >
>>> >>> > We don't seem to have this issue on arm64, where our fault handling is
>>> >>> > instrumented, so this seems suspect.
>>> >>>
>>> >>> I don't have an explanation. That's just what me and Takuo observed.
>>> >>> We've seen that it happens when __sanitizer_cov_trace_pc tries to
>>> >>> dereference current to check kcov mode.
>>> >>
>>> >> Huh. The only reason I can imagine that might happen is if the
>>> >> compiler's generating a misaligned access requiring fixup. If your
>>> >> compiler's doing that, it could presumably do that in the fault handling
>>> >> code too, which would be a big problem.
>>> >>
>>> >> If you happen to have a binary around, can you dump the disassembly for
>>> >> your __sanitizer_cov_trace_pc?
>>> >>
>>> >> Using the Linaro 17.05 arm-linux-gnueabhif-gcc 6.3 toolchain I get the
>>> >> following:
>>> >>
>>> >> 00000000 <__sanitizer_cov_trace_pc>:
>>> >>    0:   e52de004        push    {lr}            ; (str lr, [sp, #-4]!)
>>> >>    4:   e1a0300d        mov     r3, sp
>>> >>    8:   e3c33d7f        bic     r3, r3, #8128   ; 0x1fc0
>>> >>    c:   e3a02c01        mov     r2, #256        ; 0x100
>>> >>   10:   e3c3303f        bic     r3, r3, #63     ; 0x3f
>>> >>   14:   e340201f        movt    r2, #31
>>> >>   18:   e5931004        ldr     r1, [r3, #4]
>>> >>   1c:   e1110002        tst     r1, r2
>>> >>   20:   149df004        popne   {pc}            ; (ldrne pc, [sp], #4)
>>> >>   24:   e593300c        ldr     r3, [r3, #12]
>>> >>   28:   e5932508        ldr     r2, [r3, #1288] ; 0x508
>>> >>   2c:   e3520002        cmp     r2, #2
>>> >>   30:   149df004        popne   {pc}            ; (ldrne pc, [sp], #4)
>>> >>   34:   e5932510        ldr     r2, [r3, #1296] ; 0x510
>>> >>   38:   e593150c        ldr     r1, [r3, #1292] ; 0x50c
>>> >>   3c:   e5923000        ldr     r3, [r2]
>>> >>   40:   e2833001        add     r3, r3, #1
>>> >>   44:   e1530001        cmp     r3, r1
>>> >>   48:   3782e103        strcc   lr, [r2, r3, lsl #2]
>>> >>   4c:   35823000        strcc   r3, [r2]
>>> >>   50:   e49df004        pop     {pc}            ; (ldr pc, [sp], #4)
>>> >>
>>> >> ... which looks sane/safe to me.
>>> >
>>> > Here is my disasm:
>>> >
>>> > 801dc1b0 <__sanitizer_cov_trace_pc>:
>>> > 801dc1b0:       e52de004        push    {lr}            ; (str lr, [sp, #-4]!)
>>> > 801dc1b4:       e1a0300d        mov     r3, sp
>>> > 801dc1b8:       e3c33d7f        bic     r3, r3, #8128   ; 0x1fc0
>>> > 801dc1bc:       e3a02c01        mov     r2, #256        ; 0x100
>>> > 801dc1c0:       e3c3303f        bic     r3, r3, #63     ; 0x3f
>>> > 801dc1c4:       e340201f        movt    r2, #31
>>> > 801dc1c8:       e5931004        ldr     r1, [r3, #4]
>>> > 801dc1cc:       e1110002        tst     r1, r2
>>> > 801dc1d0:       149df004        popne   {pc}            ; (ldrne pc, [sp], #4)
>>> > 801dc1d4:       e593300c        ldr     r3, [r3, #12]
>>> > 801dc1d8:       e5932be0        ldr     r2, [r3, #3040] ; 0xbe0
>>> > 801dc1dc:       e3520002        cmp     r2, #2
>>> > 801dc1e0:       149df004        popne   {pc}            ; (ldrne pc, [sp], #4)
>>> > 801dc1e4:       e5932be8        ldr     r2, [r3, #3048] ; 0xbe8
>>> > 801dc1e8:       e5931be4        ldr     r1, [r3, #3044] ; 0xbe4
>>
>> These offsets for task_struct::{kcov_area,kcov_size} are *much* larger
>> than mine. Can you share your kernel config?
>
> Attached. It's pretty much vexpress_defconfig with few minor
> additions. Here is full description of what I am doing:
> https://github.com/google/syzkaller/blob/master/docs/linux/setup_linux-host_qemu-vm_arm-kernel.md
>
> FWIW when I do "KCOV_INSTRUMENT_fault.o := n" everything works and I
> see reasonable coverage.
>
>>> > 801dc1ec:       e5923000        ldr     r3, [r2]
>>> > 801dc1f0:       e2833001        add     r3, r3, #1
>>> > 801dc1f4:       e1510003        cmp     r1, r3
>>> > 801dc1f8:       8782e103        strhi   lr, [r2, r3, lsl #2]
>>> > 801dc1fc:       85823000        strhi   r3, [r2]
>>> > 801dc200:       e49df004        pop     {pc}            ; (ldr pc, [sp], #4)
>>> >
>>> > Compiler is gcc version 7.2.0 (Debian 7.2.0-7).
>>
>> I also tried with the Linaro 17.11 GCC 7.2.1, and see codegen
>> to yours above, modulo the task_struct offsets.
>>
>>> > I've now rebuilt without that change and will hopefully soon get
>>> > crashes to reconfirm.
>>
>> Just to check, do you see this when starting userspace? i.e. without
>> opening any kcov files?
>>
>> I can't reproduce the issue on real hardware atop of v4.17-rc2, when
>> booting and running a standard ARMv7 buildroot userspace. So the kcov
>> mode check seems fine to me.
>
> It happens after brief fuzzing with syzkaller. So it's both kcov
> opened and some weird syscall workload. Again, here is everything what
> I am doing:
> https://github.com/google/syzkaller/blob/master/docs/linux/setup_linux-host_qemu-vm_arm-kernel.md
>
>
>>> Yes, a swarm of assorted crashes now. Here are 4:
>>>
>>> buildroot login: Unable to handle kernel paging request at virtual
>>> address c9db963e
>>> pgd = c188b8a2
>>> [c9db963e] *pgd=00000000
>>> Internal error: Oops: 80000005 [#1] SMP ARM
>>> Modules linked in:
>>> CPU: 0 PID: 933 Comm: syz-executor3 Not tainted 4.17.0-rc2+ #4
>>> Hardware name: ARM-Versatile Express
>>> PC is at 0xc9db963e
>>
>> That PC is the faulting address, which doesn't look like a valid kernel
>> image address given it's ~1G above the valid LR value down at
>> 0x8010e290.
>>
>>> LR is at do_work_pending+0xcc/0xf0
>>
>> Assuming your GCC's codegen is the same as mine, that's the LR set up by
>> the call to task_work_run(), immediately before we branch back to the
>> start of the loop. So either we blew up in task_work_run(), or we've
>> returned to the top of the loop.
>>
>> At the top of the loop my GCC has a bl to __sanitizer_cov_trace_pc(),
>> which should setup the LR.
>>
>> My task_work_run() doesn't tail-call to anything, so I don't currently
>> see how we could end up in this state. That could be down to text
>> corruption, or corruption of the state of an interrupted context.
>>
>> If you don't already have STRICT_KERNEL_RWX enabled, could you try
>> turning it on?
>
>
> Trying.

It is enabled in my config.
