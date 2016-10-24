From: dhdang@apm.com (Duc Dang)
Date: Mon, 24 Oct 2016 10:24:19 -0700
Subject: Question about arm64 earlycon
In-Reply-To: <20161024110904.GF15620@leverpostej>
References: <CADaLNDnB3QBjODYNTndBsexGQfnL1rj6DAUPcf1nT9+aJaqCtw@mail.gmail.com>
 <4966376.bRx4fgSjbT@wuerfel> <1f1eeb4a-925a-9fac-d442-fbee503deb0a@arm.com>
 <20161024110904.GF15620@leverpostej>
Message-ID: <CADaLNDk2pYMXQ-EYVw_vM23rsazFAHe_5qcjTajii13tRMD5Ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2016 at 4:09 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Mon, Oct 24, 2016 at 11:17:36AM +0100, Marc Zyngier wrote:
> > On 24/10/16 11:06, Arnd Bergmann wrote:
> > > On Sunday, October 23, 2016 12:26:59 AM CEST Duc Dang wrote:
> > >> Hi Catalin, Marc, Mark, Arnd,
> > >>
> > >> I am testing with 3.12 kernel with earlyprintk enabled and I see some
> > >> garbage characters in the console log right before the message
> > >> indicating that the real console device is initialized:
>
> What exactly are you passing on the command line?

This is what I have:
earlyprintk=uart8250-32bit,0x1c020000

I should be more specific: the early console prints characters just
fine (I see all the early boot log). Only at the moment before
switching to the real console, I occasionally see some garbage
characters.
>
> > >> <some garbage characters here>01c020000.serial: ttyS0 at MMIO
> > >> 0x1c020000 (irq = 108, base_baud = 3125000) is a U6_16550A
> > >> console [ttyS0] enabled, bootconsole disabled
>
> Was the UART already configured by FW? Had the firmware output anything
> at this point?

Yes, UART was already configured by FW (U-Boot) and at this point,
U-Boot is already gone.

>
> Did the firmware's UART rate match that of the kernel? If not, the issue
> might just be that the rate doesn't match; earlycon/earlyprintk won't
> configure that, while the real console will.

The baud-rate does not change between U-Boot and kernel.

>
> Or perhaps we race with some clock configuration...
>
> > >> I looked through early_prink.c file and printk.c file and it looks
> > >> like there is case that some early boot code can touch the UART
> > >> hardware via ealy console driver while the 'real' console driver is
> > >> setting up the same UART port? Please let me know if I missed some
> > >> important piece of code that can prevent this.
> > >
> > > I don't think we every supported earlyprintk on arm64, and
> > > earlycon support may have been added later.
> >
> > We did support some form of earlyprintk for a while (though not in the
> > same way as 32bit ARM does), until Rob introduced earlycon.
>
> Our earlyprintk up until that point was effectively a less general
> earlycon (coming up at a similar time). In fact, in v3.12 we were
> already using earlycon structures in arch/arm64/kernel/early_printk.c.

Yes, early_printk.c for arm64 is supported until Rob removed it and
replaced by earlycon at kernel v3.16

>
> Thanks,
> Mark.
Regards,
Duc Dang.
