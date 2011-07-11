From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 11 Jul 2011 18:07:56 +0800
Subject: [GIT PULL] pxa: features for next
In-Reply-To: <20110711084026.GN4812@n2100.arm.linux.org.uk>
References: <CAMPhdO8uQR4km9szkuGDjuym-hViE9+zxtie6D2WGJmf1_9rUg@mail.gmail.com>
	<20110711074113.GK4812@n2100.arm.linux.org.uk>
	<CAMPhdO8pxGsEN1EeYwZRBnPvhkN29wOmEzWaaoCh9iqO+VkDrg@mail.gmail.com>
	<20110711074600.GL4812@n2100.arm.linux.org.uk>
	<CAMPhdO8=Gsiw_e6mFRi1PM99DSroaQi_SBiH298KAKqHb41rNw@mail.gmail.com>
	<20110711075243.GM4812@n2100.arm.linux.org.uk>
	<CAMPhdO-zR_=i_01KSTx_TzRFEOgygHc=kkUB68bke62_nzO=8Q@mail.gmail.com>
	<20110711084026.GN4812@n2100.arm.linux.org.uk>
Message-ID: <CAMPhdO84i1v1ibzBnJ4BPkF67cRpQ74o+=Es_rW2t8PStN-jbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 4:40 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jul 11, 2011 at 04:31:04PM +0800, Eric Miao wrote:
>> On Mon, Jul 11, 2011 at 3:52 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Mon, Jul 11, 2011 at 03:47:27PM +0800, Eric Miao wrote:
>> >> On Mon, Jul 11, 2011 at 3:46 PM, Russell King - ARM Linux
>> >> <linux@arm.linux.org.uk> wrote:
>> >> > On Mon, Jul 11, 2011 at 03:44:54PM +0800, Eric Miao wrote:
>> >> >> On Mon, Jul 11, 2011 at 3:41 PM, Russell King - ARM Linux
>> >> >> <linux@arm.linux.org.uk> wrote:
>> >> >> > On Mon, Jul 11, 2011 at 03:27:15PM +0800, Eric Miao wrote:
>> >> >> >> ? ? ? ARM: pxa: avoid accessing interrupt registers directly
>> >> >> >> ? ? ? ARM: pxa: introduce {icip,ichp}_handle_irq() to prepare MULTI_IRQ_HANDLER
>> >> >> >
>> >> >> > What happened about the __exception issue with asm_do_IRQ?
>> >> >> >
>> >> >>
>> >> >> I just removed the __exception from the C handler.
>> >> >
>> >> > From asm_do_IRQ ?
>> >> >
>> >>
>> >> No. From icip_handle_irq() and ichp_handle_irq(). Thought the ability to
>> >> unwind asm_do_IRQ() is more important.
>> >
>> > Which means you didn't understand my objection when I reviewed your patch.
>> >
>> > The __exception annotation on a function causes this to happen:
>> >
>> > [<c002406c>] (asm_do_IRQ+0x6c/0x8c) from [<c0024b84>] (__irq_svc+0x44/0xcc)
>> > Exception stack(0xc3897c78 to 0xc3897cc0)
>> > 7c60: ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 4022d320 4022e000
>> > 7c80: 08000075 00001000 c32273c0 c03ce1c0 c2b49b78 4022d000 c2b420b4 00000001
>> > 7ca0: 00000000 c3897cfc 00000000 c3897cc0 c00afc54 c002edd8 00000013 ffffffff
>> >
>> > Where that stack dump represents the pt_regs for the exception which
>> > happened. ?Any function found in while unwinding will cause this to
>> > be printed.
>> >
>> > If you insert a C function between the IRQ assembly and asm_do_IRQ, the
>> > dump you get from asm_do_IRQ will be the stack for your function, not
>> > the pt_regs. ?That makes the feature useless.
>> >
>>
>> Sorry for my stupidity, but I think I still don't get it quite correctly.
>> When both functions are prefixed with __exception_irq_entry, if
>> unwind works correctly, both stacks will be dumped, how would
>> the asm_do_IRQ will be stack for the function inserted?
>
> When __irq_svc - or any of the other exception handling assembly code -
> calls the C code, the stack pointer will be pointing at the pt_regs
> structure.
>
> All the entry points into C code from the exception handling code are
> marked with __exception or __exception_irq_enter to indicate that they
> are one of the functions which has pt_regs above them.
>
> Normally, when you've entered asm_do_IRQ() you will have this stack
> layout (higher address towards top):
>
> ? ? ? ?pt_regs
> ? ? ? ?asm_do_IRQ frame
>
> If you insert a C function between the exception assembly code and
> asm_do_IRQ, you end up with this stack layout instead:
>
> ? ? ? ?pt_regs
> ? ? ? ?your function frame
> ? ? ? ?asm_do_IRQ frame
>
> This means when we unwind, we'll get to asm_do_IRQ, and rather than
> dumping out the pt_regs, we'll dump out your functions stack frame
> instead, because that's what is above the asm_do_IRQ stack frame
> rather than the expected pt_regs structure.
>

Ah now I see the problem. So it's actually in dump_backtrace_entry(),
where the if (in_exception_text(where)) dump_mem(...) has this
assumption.

One way to solve this from my humble opinion is to mandate
__exception for the C function (stack version) of handle_arch_irq,
and when MULTI_IRQ defined, remove __exception from asm_do_IRQ(),
so the assumption in dump_backtrace_entry() still holds true.

Or do we have a gcc extension to tell the compiler a simple function
doesn't need to use the stack?
