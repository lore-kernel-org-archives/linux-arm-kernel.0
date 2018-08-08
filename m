From: markbrand@google.com (Mark Brand)
Date: Wed, 8 Aug 2018 09:09:45 -0700
Subject: [RFC/PoC PATCH 0/3] arm64: basic ROP mitigation
In-Reply-To: <CAKv+Gu_jNh7vLfGEdi2BpA42rPJrNr8qV-Xss_toV2fJzUV5jQ@mail.gmail.com>
References: <20180802132133.23999-1-ard.biesheuvel@linaro.org>
 <7529eedf-af56-2e94-261e-bc5c86abadaa@arm.com>
 <CAKv+Gu9X1CDpy+XvrmbSdjBjMb45eBW7JVsvsK_JQdUt2Dbvgw@mail.gmail.com>
 <b0c974a2-4e81-7855-7d4e-22834c5d8997@arm.com>
 <CAKv+Gu_ZzDbWwHVwOuoheXeN-ta_FjOT4Aj15=r56QZVTUK0FA@mail.gmail.com>
 <CAKv+Gu_wGk2Gdzd6WuOMZqz1tKHAWHL7pWm2Szyt0DZwPTCmOw@mail.gmail.com>
 <31443e6a-56b4-c4fb-82b1-b8eb5d7eebe1@arm.com>
 <CAGXu5jLj=KP038d-c+xzCx=Oogn1prH__oryQjNZZwNaAHaAAw@mail.gmail.com>
 <CAKv+Gu-9M0yO-rSXiREs11feEro0mJFcNN3Wkp_LSOGrKKd5dg@mail.gmail.com>
 <CAGXu5j+Tddmp_VgyvwTd+StEGtx=oGofeY+KpLD4OuPw+2=S2Q@mail.gmail.com>
 <CAKv+Gu-5ERHvqgXHR626QzKCZJPc0Cp5Ktv+gwucep5ZGvu9Vw@mail.gmail.com>
 <CAN+XpFQCO1nr5tQ4oyPPaSfvnQSvwx-=JCtba2xJXrEN+6=LZg@mail.gmail.com>
 <CAKv+Gu_jNh7vLfGEdi2BpA42rPJrNr8qV-Xss_toV2fJzUV5jQ@mail.gmail.com>
Message-ID: <CAN+XpFTbqMXiX=dYpK_ExvctkaJjZL9q=n06goujPht35Bieqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 7, 2018 at 2:22 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On 7 August 2018 at 05:05, Mark Brand <markbrand@google.com> wrote:
> > I think the phrasing of "limit kernel attack surface against ROP attacks" is
> > confusing and misleading. ROP does not describe a class of bugs,
> > vulnerabilities or attacks against the kernel - it's just one of many
> > code-reuse techniques that can be used by an attacker while exploiting a
> > vulnerability. But that's kind of off-topic!
> >
> > I think what this thread is talking about is implementing extremely
> > coarse-grained reverse-edge control-flow-integrity, in that a return can
> > only return to the address following a legitimate call, but it can return to
> > any of those.
> >
>
> Indeed. Apologies for not mastering the lingo, but it is indeed about
> no longer being able to subvert function returns into jumping to
> arbitrary places in the code.
>
> > I suspect there's not much benefit to this, since (as far as I can see) the
> > assumption is that an attacker has the means to direct flow of execution as
> > far as taking complete control of the (el1) stack before executing any ROP
> > payload.
> >
> > At that point, I think it's highly unlikely an attacker needs to chain
> > gadgets through return instructions at all - I suspect there are a few
> > places in the kernel where it is necessary to load the entire register
> > context from a register that is not the stack pointer, and it would likely
> > not be more than a minor inconvenience to an attacker to use these (and
> > chaining through branch register) instructions instead of chaining through
> > return instructions.
> >
> > I'd have to take a closer look at an arm64 kernel image to be sure though -
> > I'll do that when I get a chance and update...
> >
>
> Thanks. Reloading all registers from an arbitrary offset register
> should occur rarely, no? Could we work around that?

 I forgot about the gmail-html-by-default... Hopefully everyone else
can read the quotes though :-/.

I took a look and have put together an example rop chain that doesn't
use any return instructions that you could instrument, that will call
an arbitrary kernel function with controlled parameters (at least x0 -
x4, would have to probably mess with some alignment and add a
repetition of the last gadget to get all register control. It assumes
that the attacker has control over the memory pointed to by x0 at the
point where they get control of pc, and that they know where that
memory is located (but it would also work if they just controlled the
memory pointed to by x0, and had another chunk of kernel memory they
control at a known address. Seems like a pretty reasonable starting
assumption, and I'm sure anyone with a little motivation could produce
similar chains for other starting conditions, this just seemed the
"most likely" reasonable conditions to me.

There are two basic principles used here -

(1) chaining through the mempool_free function, I found this really
quickly when searching for useful gadgets based off x0

void mempool_free(void *element, mempool_t *pool)
{
  unsigned long flags;

  if (unlikely(element == NULL))
    return;

  /* snip */
  smp_rmb();

  /* snip */
  if (unlikely(pool->curr_nr < pool->min_nr)) {
    spin_lock_irqsave(&pool->lock, flags);
    if (likely(pool->curr_nr < pool->min_nr)) {
      add_element(pool, element);
      spin_unlock_irqrestore(&pool->lock, flags);
      wake_up(&pool->wait);
      return;
    }
    spin_unlock_irqrestore(&pool->lock, flags);
  }

  pool->free(element, pool->pool_data);
}

Since the callsites for this function usually load the arguments
through some registers, and the function to call gets pulled out of
one of those arguments, it's easy to get a couple of registers loaded
here and then the chain continue.

(2) loading complete register state using kernel_exit macro.

Since the kernel_exit macro actually loads spsr_el1 and elr_el1 from
registers, I think that you can let the eret return to anywhere in el1
without dropping to el0, since the same handler is used for "exiting
the kernel" when a hardware interrupt interrupts the kernel itself. I
didn't fill out the necessary register values in the chain below,
since I don't anyway have a device around to test this on right now.

I'm not sure that you could really robustly protect this eret; I
suppose that you could try and somehow validate the saved register
state, but given that it would be happening on every exception return,
I suspect it would be expensive.

0:dispatch_io + yy (mempool_free gadget, appears in plenty of other places.)
ffffff8008a340d4  084c41a9   ldp     x8, x19, [x0, #0x10]
ffffff8008a340d8  190040f9   ldr     x25, [x0]
ffffff8008a340dc  1a1040f9   ldr     x26, [x0, #0x20]
ffffff8008a340e0  010140f9   ldr     x1, [x8]
ffffff8008a340e4  ed80dd97   bl      mempool_free

  mempool_free:
  ffffff8008194498  f44fbea9   stp     x20, x19, [sp, #-0x20
{__saved_x20} {__saved_x19}]!
  ffffff800819449c  fd7b01a9   stp     x29, x30, [sp, #0x10
{__saved_x29} {__saved_x30}]
  ffffff80081944a0  fd430091   add     x29, sp, #0x10 {__saved_x29}
  ffffff80081944a4  f30301aa   mov     x19, x1
  ffffff80081944a8  f40300aa   mov     x20, x0
  ffffff80081944ac  340100b4   cbz     x20, 0xffffff80081944d0

  ffffff80081944b0  bf3903d5   dmb     ishld
  ffffff80081944b4  68a64029   ldp     w8, w9, [x19, #0x4]
  ffffff80081944b8  3f01086b   cmp     w9, w8
  ffffff80081944bc  0b010054   b.lt    0xffffff80081944dc

  ffffff80081944c0  681640f9   ldr     x8, [x19, #0x28]
  ffffff80081944c4  610e40f9   ldr     x1, [x19, #0x18]
  ffffff80081944c8  e00314aa   mov     x0, x20
  ffffff80081944cc  00013fd6   blr     x8

  ffffff80081944d0  fd7b41a9   ldp     x29, x30, [sp, #0x10
{__saved_x29} {__saved_x30}]
  ffffff80081944d4  f44fc2a8   ldp     x20, x19, [sp {__saved_x20}
{__saved_x19}], #0x20
  ffffff80081944d8  c0035fd6   ret

ffffff8008a340e8  e00319aa   mov     x0, x25
ffffff8008a340ec  e1031aaa   mov     x1, x26
ffffff8008a340f0  60023fd6   blr     x19

1:el1_irq + xx - (x1, x26) -> sp control
ffffff800808314c  5f030091   mov     sp, x26
ffffff8008083150  fd4fbfa9   stp     x29, x19, [sp, #-0x10]! {__saved_x0}
ffffff8008083154  fd030091   mov     x29, sp
ffffff8008083158  20003fd6   blr     x1

2:ipc_log_extract + xx (sp, x19) -> survival
ffffff800817c35c  e0c30091   add     x0, sp, #0x30 {var_170}
ffffff800817c360  e1430091   add     x1, sp, #0x10 {var_190}
ffffff800817c364  60023fd6   blr     x19

3:dispatch_io + xx (mempool_free gadget, appears in plenty of other places.)
ffffff8008a342cc  084c41a9   ldp     x8, x19, [x0, #0x10]
ffffff8008a342d0  140040f9   ldr     x20, [x0]
ffffff8008a342d4  151040f9   ldr     x21, [x0, #0x20]
ffffff8008a342d8  010140f9   ldr     x1, [x8]
ffffff8008a342dc  6f80dd97   bl      mempool_free

  mempool_free:
  ffffff8008194498  f44fbea9   stp     x20, x19, [sp, #-0x20
{__saved_x20} {__saved_x19}]!
  ffffff800819449c  fd7b01a9   stp     x29, x30, [sp, #0x10
{__saved_x29} {__saved_x30}]
  ffffff80081944a0  fd430091   add     x29, sp, #0x10 {__saved_x29}
  ffffff80081944a4  f30301aa   mov     x19, x1
  ffffff80081944a8  f40300aa   mov     x20, x0
  ffffff80081944ac  340100b4   cbz     x20, 0xffffff80081944d0

  ffffff80081944b0  bf3903d5   dmb     ishld
  ffffff80081944b4  68a64029   ldp     w8, w9, [x19, #0x4]
  ffffff80081944b8  3f01086b   cmp     w9, w8
  ffffff80081944bc  0b010054   b.lt    0xffffff80081944dc

  ffffff80081944c0  681640f9   ldr     x8, [x19, #0x28]
  ffffff80081944c4  610e40f9   ldr     x1, [x19, #0x18]
  ffffff80081944c8  e00314aa   mov     x0, x20
  ffffff80081944cc  00013fd6   blr     x8

  ffffff80081944d0  fd7b41a9   ldp     x29, x30, [sp, #0x10
{__saved_x29} {__saved_x30}]
  ffffff80081944d4  f44fc2a8   ldp     x20, x19, [sp {__saved_x20}
{__saved_x19}], #0x20
  ffffff80081944d8  c0035fd6   ret

ffffff8008a342e0  e00314aa   mov     x0, x20
ffffff8008a342e4  e10315aa   mov     x1, x21
ffffff8008a342e8  60023fd6   blr     x19

4:bus_sort_breadthfirst + xx - (x26)
ffffff8008683cc8  561740f9   ldr     x22, [x26, #0x28]
ffffff8008683ccc  e00315aa   mov     x0, x21
ffffff8008683cd0  e10316aa   mov     x1, x22
ffffff8008683cd4  80023fd6   blr     x20

5:kernel_exit (macro) - (x21, x22, sp) -> full register control & pc control
ffffff8008082f64  354018d5   msr     elr_el1, x21
ffffff8008082f68  164018d5   msr     spsr_el1, x22
ffffff8008082f6c  e00740a9   ldp     x0, x1, [sp {var_130} {var_128}]
ffffff8008082f70  e20f41a9   ldp     x2, x3, [sp, #0x10 {var_120} {var_118}]
ffffff8008082f74  e41742a9   ldp     x4, x5, [sp, #0x20 {var_110} {var_108}]
ffffff8008082f78  e61f43a9   ldp     x6, x7, [sp, #0x30 {var_100} {var_f8}]
ffffff8008082f7c  e82744a9   ldp     x8, x9, [sp, #0x40 {var_f0} {var_e8}]
ffffff8008082f80  ea2f45a9   ldp     x10, x11, [sp, #0x50 {var_e0} {var_d8}]
ffffff8008082f84  ec3746a9   ldp     x12, x13, [sp, #0x60 {var_d0} {var_c8}]
ffffff8008082f88  ee3f47a9   ldp     x14, x15, [sp, #0x70 {var_c0} {var_b8}]
ffffff8008082f8c  f04748a9   ldp     x16, x17, [sp, #0x80 {var_b0} {var_a8}]
ffffff8008082f90  f24f49a9   ldp     x18, x19, [sp, #0x90 {var_a0} {var_98}]
ffffff8008082f94  f4574aa9   ldp     x20, x21, [sp, #0xa0 {var_90} {var_88}]
ffffff8008082f98  f65f4ba9   ldp     x22, x23, [sp, #0xb0 {var_80} {var_78}]
ffffff8008082f9c  f8674ca9   ldp     x24, x25, [sp, #0xc0 {var_70} {var_68}]
ffffff8008082fa0  fa6f4da9   ldp     x26, x27, [sp, #0xd0 {var_60} {var_58}]
ffffff8008082fa4  fc774ea9   ldp     x28, x29, [sp, #0xe0 {var_50} {var_48}]
ffffff8008082fa8  fe7b40f9   ldr     x30, [sp, #0xf0 {var_40}]
ffffff8008082fac  ffc30491   add     sp, sp, #0x130
ffffff8008082fb0  e0039fd6   eret


ptr = 0000414100000000 = initial x0

0000: 2525252525252525 ; (0:40d8) x25
0008: 0000414100000030 ; (0:40e0) x1
0010: 0000414100000000 ; (0:40d4) x8
0018: ffffff8008a342cc ; (0:40d4) x19 -> branch target (2:c364)
0020: 0000414100000070 ; (0:40dc) x26 -> sp (1:314c)
0028:
0030: 8888888899999999 ; (0:44b4) w8, w9
0038:
0040:
0048: ffffff800817c35c ; (0:44c4) x1 -> branch target (1:3158)
0050:
0058: ffffff800808314c ; (0:44c0) x8 -> branch target (0:44c4)
0060: xxxxxxxxxxxxxxxx ; saved x29                               <-- sp@(1:3154)
0068: xxxxxxxxxxxxxxxx ; saved x19
0070:                  ;                                         <--
sp@(1:314c), (5:2f64)
0078:
0080:
0088:
0090:
0098: 2222222222222222 ; (4:3cc8) x22 -> spsr_el1
00a0: ffffff8008082f64 ; (3:42d0) x20 -> branch target (4:3cd4)  <-- x0@(2:c35c)
00a8: 00004141000000d0 ; (3:42d8) x1
00b0: 00004141000000a0 ; (3:42cc) x8
00b8: 1919191919191919 ; (3:42cc) x19
00c0: 2121212121212121 ; (3:42d4) x21 -> elr_el1
00c8:
00d0: 8888888899999999 ; (3:44b4) w8, w9
00d8:
00e0:
00e8: 1111111111111111 ; (3:44c4) x1
00f0:
00f8: ffffff800808314c ; (3:44c0) x8 -> branch target (3:44c4)
>
> > On Mon, 6 Aug 2018 at 19:28, Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > wrote:
> >>
> >> On 6 August 2018 at 21:50, Kees Cook <keescook@chromium.org> wrote:
> >> > On Mon, Aug 6, 2018 at 12:35 PM, Ard Biesheuvel
> >> > <ard.biesheuvel@linaro.org> wrote:
> >> >> On 6 August 2018 at 20:49, Kees Cook <keescook@chromium.org> wrote:
> >> >>> On Mon, Aug 6, 2018 at 10:45 AM, Robin Murphy <robin.murphy@arm.com>
> >> >>> wrote:
> >> >>>> I guess what I'm getting at is that if the protection mechanism is
> >> >>>> "always
> >> >>>> return with SP outside TTBR1", there seems little point in going
> >> >>>> through the
> >> >>>> motions if SP in TTBR0 could still be valid and allow an attack to
> >> >>>> succeed
> >> >>>> anyway; this is basically just me working through a justification for
> >> >>>> saying
> >> >>>> the proposed scheme needs "depends on ARM64_PAN ||
> >> >>>> ARM64_SW_TTBR0_PAN",
> >> >>>> making it that much uglier for v8.0 CPUs...
> >> >>>
> >> >>> I think anyone with v8.0 CPUs interested in this mitigation would also
> >> >>> very much want PAN emulation. If a "depends on" isn't desired, what
> >> >>> about "imply" in the Kconfig?
> >> >>>
> >> >>
> >> >> Yes, but actually, using bit #0 is maybe a better alternative in any
> >> >> case. You can never dereference SP with bit #0 set, regardless of
> >> >> whether the address points to user or kernel space, and my concern
> >> >> about reloading sp from x29 doesn't really make sense, given that x29
> >> >> is always assigned from sp right after pushing x29 and x30 in the
> >> >> function prologue, and sp only gets restored from x29 in the epilogue
> >> >> when there is a stack frame to begin with, in which case we add #1 to
> >> >> sp again before returning from the function.
> >> >
> >> > Fair enough! :)
> >> >
> >> >> The other code gets a lot cleaner as well.
> >> >>
> >> >> So for the return we'll have
> >> >>
> >> >>   ldp     x29, x30, [sp], #nn
> >> >>>>add     sp, sp, #0x1
> >> >>   ret
> >> >>
> >> >> and for the function call
> >> >>
> >> >>   bl      <foo>
> >> >>>>mov      x30, sp
> >> >>>>bic     sp, x30, #1
> >> >>
> >> >> The restore sequence in entry.s:96 (which has no spare registers) gets
> >> >> much simpler as well:
> >> >>
> >> >> --- a/arch/arm64/kernel/entry.S
> >> >> +++ b/arch/arm64/kernel/entry.S
> >> >> @@ -95,6 +95,15 @@ alternative_else_nop_endif
> >> >>          */
> >> >>         add     sp, sp, x0      // sp' = sp + x0
> >> >>         sub     x0, sp, x0      // x0' = sp' - x0 = (sp + x0) - x0 = sp
> >> >> +#ifdef CONFIG_ARM64_ROP_SHIELD
> >> >> +       tbnz    x0, #0, 1f
> >> >> +       .subsection     1
> >> >> +1:     sub     x0, x0, #1
> >> >> +       sub     sp, sp, #1
> >> >> +       b       2f
> >> >> +       .previous
> >> >> +2:
> >> >> +#endif
> >> >>         tbnz    x0, #THREAD_SHIFT, 0f
> >> >>         sub     x0, sp, x0      // x0'' = sp' - x0' = (sp + x0) - sp =
> >> >> x0
> >> >>         sub     sp, sp, x0      // sp'' = sp' - x0 = (sp + x0) - x0 =
> >> >> sp
> >> >
> >> > I get slightly concerned about "add" vs "clear bit", but I don't see a
> >> > real way to chain a lot of "add"s to get to avoid the unaligned
> >> > access. Is "or" less efficient than "add"?
> >> >
> >>
> >> Yes. The stack pointer is special on arm64, and can only be used with
> >> a limited set of ALU instructions. So orring #1 would involve 'mov
> >> <reg>, sp ; orr sp, <reg>, #1' like in the 'bic' case above, which
> >> requires a scratch register as well.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 4849 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180808/fa400226/attachment-0001.p7s>
