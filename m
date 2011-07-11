From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Jul 2011 08:52:43 +0100
Subject: [GIT PULL] pxa: features for next
In-Reply-To: <CAMPhdO8=Gsiw_e6mFRi1PM99DSroaQi_SBiH298KAKqHb41rNw@mail.gmail.com>
References: <CAMPhdO8uQR4km9szkuGDjuym-hViE9+zxtie6D2WGJmf1_9rUg@mail.gmail.com>
	<20110711074113.GK4812@n2100.arm.linux.org.uk>
	<CAMPhdO8pxGsEN1EeYwZRBnPvhkN29wOmEzWaaoCh9iqO+VkDrg@mail.gmail.com>
	<20110711074600.GL4812@n2100.arm.linux.org.uk>
	<CAMPhdO8=Gsiw_e6mFRi1PM99DSroaQi_SBiH298KAKqHb41rNw@mail.gmail.com>
Message-ID: <20110711075243.GM4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 03:47:27PM +0800, Eric Miao wrote:
> On Mon, Jul 11, 2011 at 3:46 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Jul 11, 2011 at 03:44:54PM +0800, Eric Miao wrote:
> >> On Mon, Jul 11, 2011 at 3:41 PM, Russell King - ARM Linux
> >> <linux@arm.linux.org.uk> wrote:
> >> > On Mon, Jul 11, 2011 at 03:27:15PM +0800, Eric Miao wrote:
> >> >> ? ? ? ARM: pxa: avoid accessing interrupt registers directly
> >> >> ? ? ? ARM: pxa: introduce {icip,ichp}_handle_irq() to prepare MULTI_IRQ_HANDLER
> >> >
> >> > What happened about the __exception issue with asm_do_IRQ?
> >> >
> >>
> >> I just removed the __exception from the C handler.
> >
> > From asm_do_IRQ ?
> >
> 
> No. From icip_handle_irq() and ichp_handle_irq(). Thought the ability to
> unwind asm_do_IRQ() is more important.

Which means you didn't understand my objection when I reviewed your patch.

The __exception annotation on a function causes this to happen:

[<c002406c>] (asm_do_IRQ+0x6c/0x8c) from [<c0024b84>] (__irq_svc+0x44/0xcc)
Exception stack(0xc3897c78 to 0xc3897cc0)
7c60:                                                       4022d320 4022e000
7c80: 08000075 00001000 c32273c0 c03ce1c0 c2b49b78 4022d000 c2b420b4 00000001
7ca0: 00000000 c3897cfc 00000000 c3897cc0 c00afc54 c002edd8 00000013 ffffffff

Where that stack dump represents the pt_regs for the exception which
happened.  Any function found in while unwinding will cause this to
be printed.

If you insert a C function between the IRQ assembly and asm_do_IRQ, the
dump you get from asm_do_IRQ will be the stack for your function, not
the pt_regs.  That makes the feature useless.
