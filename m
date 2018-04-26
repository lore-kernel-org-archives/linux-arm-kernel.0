From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 26 Apr 2018 15:29:48 +0100
Subject: [PATCH] arm: port KCOV to arm
In-Reply-To: <CACT4Y+Z35mOAybskjxVhxvW+GrbOZ4c9s2LT+Ca_fE9ZufoiGQ@mail.gmail.com>
References: <20180426130846.130976-1-dvyukov@google.com>
 <20180426134057.4sahhqrbkltwmfsk@lakrids.cambridge.arm.com>
 <CACT4Y+Z35mOAybskjxVhxvW+GrbOZ4c9s2LT+Ca_fE9ZufoiGQ@mail.gmail.com>
Message-ID: <20180426142948.n74p52esmbvsqrow@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2018 at 03:47:49PM +0200, 'Dmitry Vyukov' via syzkaller wrote:
> On Thu, Apr 26, 2018 at 3:40 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > Hi Dmitry,
> >
> > On Thu, Apr 26, 2018 at 03:08:46PM +0200, Dmitry Vyukov wrote:
> >> KCOV is code coverage collection facility used, in particular, by syzkaller
> >> system call fuzzer. There is some interest in using syzkaller on arm devices.
> >> So port KCOV to arm.
> >>
> >> On implementation level this merely declares that KCOV is supported and
> >> disables instrumentation of 3 special cases. Reasons for disabling are
> >> commented in code.
> >>
> >> Tested with qemu-system-arm/vexpress-a15.
> >>
> >> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> >> Cc: Russell King <linux@armlinux.org.uk>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: Abbott Liu <liuwenliang@huawei.com>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Koguchi Takuo <takuo.koguchi.sw@hitachi.com>
> >> Cc: Atul Prakash <atulp@google.com>
> >> Cc: linux at armlinux.org.uk
> >> Cc: linux-arm-kernel at lists.infradead.org
> >> Cc: syzkaller at googlegroups.com
> >> ---
> >>  arch/arm/Kconfig                  | 1 +
> >>  arch/arm/boot/compressed/Makefile | 3 +++
> >>  arch/arm/mm/Makefile              | 4 ++++
> >>  arch/arm/vdso/Makefile            | 3 +++
> >>  4 files changed, 11 insertions(+)
> >
> > The hyp code will also need to opt-out of KCOV instrumentation.
> >
> > i.e. arch/arm/kvm/hyp/Makefile will need:
> >
> > KCOV_INSTRUMENT := n
> >
> > ... and we should probably pick up the other bits from the arm64 hyp
> > Makefile, i.e. all of:
> >
> > # KVM code is run at a different exception code with a different map, so
> > # compiler instrumentation that inserts callbacks or checks into the code may
> > # cause crashes. Just disable it.
> > GCOV_PROFILE    := n
> > KASAN_SANITIZE  := n
> > UBSAN_SANITIZE  := n
> > KCOV_INSTRUMENT := n
> 
> I can blindly add them if you wish, but I don't have a way to test it.
> I also need an explanatory comment as to why we disable this.
> Otherwise I have to say "Mark said so" :)

The rationale is that this code runs at hyp, with minimal code/data
mapped in its page tables (which are not the usual kernel page tables).
Instrumented code may call functions or access data structures which
aren't mapped, which will bring down the system.

> p.s. KASAN does not exist on arm (yet).

Sure. We can drop that line for now, or keep it -- it does no harm.

[...]

> >> +# Instrumenting fault.c causes infinite recursion between:
> >> +# __dabt_svc -> do_DataAbort -> __sanitizer_cov_trace_pc -> __dabt_svc
> >> +KCOV_INSTRUMENT_fault.o := n
> >
> > Why does __sanitizer_cov_trace_pc() cause a data abort?
> >
> > We don't seem to have this issue on arm64, where our fault handling is
> > instrumented, so this seems suspect.
> 
> I don't have an explanation. That's just what me and Takuo observed.
> We've seen that it happens when __sanitizer_cov_trace_pc tries to
> dereference current to check kcov mode.

Huh. The only reason I can imagine that might happen is if the
compiler's generating a misaligned access requiring fixup. If your
compiler's doing that, it could presumably do that in the fault handling
code too, which would be a big problem.

If you happen to have a binary around, can you dump the disassembly for
your __sanitizer_cov_trace_pc?

Using the Linaro 17.05 arm-linux-gnueabhif-gcc 6.3 toolchain I get the
following:

00000000 <__sanitizer_cov_trace_pc>:
   0:   e52de004        push    {lr}            ; (str lr, [sp, #-4]!)
   4:   e1a0300d        mov     r3, sp
   8:   e3c33d7f        bic     r3, r3, #8128   ; 0x1fc0
   c:   e3a02c01        mov     r2, #256        ; 0x100
  10:   e3c3303f        bic     r3, r3, #63     ; 0x3f
  14:   e340201f        movt    r2, #31
  18:   e5931004        ldr     r1, [r3, #4]
  1c:   e1110002        tst     r1, r2
  20:   149df004        popne   {pc}            ; (ldrne pc, [sp], #4)
  24:   e593300c        ldr     r3, [r3, #12]
  28:   e5932508        ldr     r2, [r3, #1288] ; 0x508
  2c:   e3520002        cmp     r2, #2
  30:   149df004        popne   {pc}            ; (ldrne pc, [sp], #4)
  34:   e5932510        ldr     r2, [r3, #1296] ; 0x510
  38:   e593150c        ldr     r1, [r3, #1292] ; 0x50c
  3c:   e5923000        ldr     r3, [r2]
  40:   e2833001        add     r3, r3, #1
  44:   e1530001        cmp     r3, r1
  48:   3782e103        strcc   lr, [r2, r3, lsl #2]
  4c:   35823000        strcc   r3, [r2]
  50:   e49df004        pop     {pc}            ; (ldr pc, [sp], #4)

... which looks sane/safe to me.

Thanks,
Mark.
