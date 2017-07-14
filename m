From: mirceac@gmail.com (Mircea Ciocan)
Date: Fri, 14 Jul 2017 09:58:39 +0200
Subject: Porting a custom interrupt handler from kernel 2.6.25 to 3.16.45
In-Reply-To: <20170713173545.GE31807@n2100.armlinux.org.uk>
References: <CAHumR2+WR3Fdtft8xrPfcT3-dpKqCL__aaEc6qri3N5-x0yCXw@mail.gmail.com>
 <20170713160625.GB27801@lunn.ch>
 <CAHumR2LazFFmmNNKJ=KrEjt7iCgrKewkdzO6ww7RtLU+wWTFoA@mail.gmail.com>
 <20170713173545.GE31807@n2100.armlinux.org.uk>
Message-ID: <CAHumR2+5qWG5TTqS47PdtrQfu2N+B7x+gtmq85VL5NZj5X2-tA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 7:35 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Thu, Jul 13, 2017 at 06:32:29PM +0200, Mircea Ciocan wrote:
>> I'm still struggle to understand the full purpose of
>> the *get_irqnr_preamble* and *get_irqnr_and_base* macros.
>
> get_irqnr_preamble does whatever you need that's common to handling a
> set of interrupts read from the hardware.  It can set the two registers
> to anything it likes.  Commonly, this is used to get the address of the
> top level interrupt controller.  These two registers are passed to the
> get_irqnr_and_base and test_for_ipi macros unmodified.
>
> get_irqnr_and_base gets the interrupt number.  This must clear the Z
> flag if an interrupt is pending, or set it if there's no interrupt.
>
> test_for_ipi takes all the registers that were given to get_irqnr_and_base
> and determines whether an IPI happened and which IPI, otherwise it
> has the same behaviour as get_irqnr_and_base.
>
> So it's not complicated - get_irqnr_preamble is basically the common
> setup bits and get_irqnr_and_base is called repeatedly in a loop until
> it indicates that there are no further pending interrupts.
>
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.

Hi Russel and thanks for the answer, first thing first, write a book,
seriously, write a book (or minimally a verbose FAQ ;) describing the
whole Linux kernel ARM architecture, including the deep details,
something focused on the low level details for avoiding creating a
class of "specialists" that were following the topic for years and of
course considers this stuff "elementary", it may be, but the barriers
for understanding it are pretty high IMHO. and sadly this is why we
have a lot of ARM SoCs with extraordinary obsolete kernels, because
everybody is kind of afraid to try to update. If it's a book I will
definitely buy it.

Now that the rant part is over, let me summarize what I understand
form my searches and your explanations, and kindly please confirm if
it's correct:

- *get_irqnr_preamble* - it's mostly used to get the top level
interrupt controller address of if it's a funky controller, to make it
ready for *get_irqnr_and_base* and  *test_for_ipi* that gets those
registers as parameters.
It is used only once.

- *get_irqnr_and_base* gets it's \base register already set by
*get_irqnr_preamble* and does it have to return the \irqnr or it
receives the \irqnr already set by *get_irqnr_preamble* ?
At the end of the macro, is any of the registers value \irqnr,
\irqstat, \base, \tmp of any significance or strictly only the zero
flag matters ?
In the original custom function I have this gem of a comment, where
the original developer said:

"... snip...
1001:
        /* WARNING: These lines override the default behavior, */
        /* which is to loop back at the start of the macro after the handler */

        /* set r1 to registers address */
        movne   r1, sp

        /* set label 2 as return address */
        adrne   lr, 2f
    .endm
"
I believe in the current framework this is an incorrect behavior, is
there any possible situation where this can offer some advantage ?

In the end many thanks for the support and hopefully in the future I
will be able to contribute myself something back to the community.

 Best regards,
Mircea
