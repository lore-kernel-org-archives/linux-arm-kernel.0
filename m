From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Jul 2017 09:48:31 +0100
Subject: Porting a custom interrupt handler from kernel 2.6.25 to 3.16.45
In-Reply-To: <CAHumR2+5qWG5TTqS47PdtrQfu2N+B7x+gtmq85VL5NZj5X2-tA@mail.gmail.com>
References: <CAHumR2+WR3Fdtft8xrPfcT3-dpKqCL__aaEc6qri3N5-x0yCXw@mail.gmail.com>
 <20170713160625.GB27801@lunn.ch>
 <CAHumR2LazFFmmNNKJ=KrEjt7iCgrKewkdzO6ww7RtLU+wWTFoA@mail.gmail.com>
 <20170713173545.GE31807@n2100.armlinux.org.uk>
 <CAHumR2+5qWG5TTqS47PdtrQfu2N+B7x+gtmq85VL5NZj5X2-tA@mail.gmail.com>
Message-ID: <20170714084831.GG31807@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 14, 2017 at 09:58:39AM +0200, Mircea Ciocan wrote:
> On Thu, Jul 13, 2017 at 7:35 PM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > On Thu, Jul 13, 2017 at 06:32:29PM +0200, Mircea Ciocan wrote:
> >> I'm still struggle to understand the full purpose of
> >> the *get_irqnr_preamble* and *get_irqnr_and_base* macros.
> >
> > get_irqnr_preamble does whatever you need that's common to handling a
> > set of interrupts read from the hardware.  It can set the two registers
> > to anything it likes.  Commonly, this is used to get the address of the
> > top level interrupt controller.  These two registers are passed to the
> > get_irqnr_and_base and test_for_ipi macros unmodified.
> >
> > get_irqnr_and_base gets the interrupt number.  This must clear the Z
> > flag if an interrupt is pending, or set it if there's no interrupt.
> >
> > test_for_ipi takes all the registers that were given to get_irqnr_and_base
> > and determines whether an IPI happened and which IPI, otherwise it
> > has the same behaviour as get_irqnr_and_base.
> >
> > So it's not complicated - get_irqnr_preamble is basically the common
> > setup bits and get_irqnr_and_base is called repeatedly in a loop until
> > it indicates that there are no further pending interrupts.
> >
> > --
> > RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> > FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> > according to speedtest.net.
> 
> Hi Russel and thanks for the answer, first thing first, write a book,

First off, please spell my name correctly.  People tend to get upset
when their names are mis-spelt (eg, Diana's get upset if you call
them Diane and Diane's get upset if you call them Diana.)

> seriously, write a book (or minimally a verbose FAQ ;) describing the
> whole Linux kernel ARM architecture, including the deep details,
> something focused on the low level details for avoiding creating a
> class of "specialists" that were following the topic for years and of
> course considers this stuff "elementary", it may be, but the barriers
> for understanding it are pretty high IMHO. and sadly this is why we
> have a lot of ARM SoCs with extraordinary obsolete kernels, because
> everybody is kind of afraid to try to update. If it's a book I will
> definitely buy it.

This particular detail that you've asked about hasn't changed for
about 20 years.  No, I'm not going to write a book, that would take
way too long, and by the time it's complete, it'll be obsolete.

As for a FAQ, most people over the last 20 years have been able to
grasp these two macros, you're the first one to really ask in this
depth about them, so it's hardly a "frequent" question.  Most people
(as is common with much of the Linux code base) read the code where
things are used and existing implementations to augment their
understanding.

That's something even I have to do all the time, and from time to
time I have asked for better documentation, but that's never been
forthcoming.  So it's really a case of "read the code."

Sorry if that offends, but that's the way Linux is.

> Now that the rant part is over, let me summarize what I understand
> form my searches and your explanations, and kindly please confirm if
> it's correct:
> 
> - *get_irqnr_preamble* - it's mostly used to get the top level
> interrupt controller address of if it's a funky controller, to make it
> ready for *get_irqnr_and_base* and  *test_for_ipi* that gets those
> registers as parameters.
> It is used only once.

Correct.

> - *get_irqnr_and_base* gets it's \base register already set by
> *get_irqnr_preamble* and does it have to return the \irqnr or it
> receives the \irqnr already set by *get_irqnr_preamble* ?

Here's how it's used:

        get_irqnr_preamble r6, lr
1:      get_irqnr_and_base r0, r2, r6, lr
        movne   r1, sp
        @
        @ routine called with r0 = irq number, r1 = struct pt_regs *
        @
        badrne  lr, 1b
        bne     asm_do_IRQ

where r0 is "irqnr".  These two questions will help answer yours:

1. Is r0 passed to get_irqnr_preamble?
2. What would it mean if get_irqnr_and_base did not set r0?

Moreover, if the interrupt number _were_ to be only returned by
get_irqnr_preamble, then how could we ever hope to service more than
one interrupt number?

I said in my initial reply "get_irqnr_and_base gets the interrupt
number" which I think also answers your question, and the macro name
also reflects its operation.

> At the end of the macro, is any of the registers value \irqnr,
> \irqstat, \base, \tmp of any significance or strictly only the zero
> flag matters ?

>From what we can see from the above quoted code, asm_do_IRQ is called
with r0 and r1 set.  As the code following the macro sets r1 already,
r0 needs to be set, and r0 is "irqnr".

Some implementations used to also set "base" where they had multiple
interrupt controllers (which is why the macro is named the way it is)
and didn't use get_irqnr_preamble to set the base.

What's required in these two macros is really up to the implementation,
there's no hard and fast rules apart from not using registers that
aren't passed to the macro as arguments.

> In the original custom function I have this gem of a comment, where
> the original developer said:
> 
> "... snip...
> 1001:
>         /* WARNING: These lines override the default behavior, */
>         /* which is to loop back at the start of the macro after the handler */
> 
>         /* set r1 to registers address */
>         movne   r1, sp
> 
>         /* set label 2 as return address */
>         adrne   lr, 2f
>     .endm
> "

That looks like a horrid hack - it's jumping out of the macro, to some
other location, and the only way to know that is to look at the code
in the kernel version that it was created for.  Such hacky code can't
be expected to work from one kernel version to the next, so it's not
surprising that it doesn't work with modern kernels.

If it was supposed to be using the "2" label, then it would be passed
into the macro, to allow the code that calls the macro to be modified
without affecting the implementations.

In general, macros should never jump outside of themselves - that
creates unclean code that is context sensitive, destroys readability,
and creates maintenance problems.

We have the same rule for C code: C preprocessor macros are not allowed
to use "return" because that destroys the readability of the code.

> I believe in the current framework this is an incorrect behavior, is
> there any possible situation where this can offer some advantage ?

I couldn't say, because:
(1) I don't know why it would need such a hack.
(2) I don't know where it is jumping to.
so
(3) I don't know what this code is doing.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
