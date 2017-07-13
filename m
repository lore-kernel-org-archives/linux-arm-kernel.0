From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Jul 2017 18:35:45 +0100
Subject: Porting a custom interrupt handler from kernel 2.6.25 to 3.16.45
In-Reply-To: <CAHumR2LazFFmmNNKJ=KrEjt7iCgrKewkdzO6ww7RtLU+wWTFoA@mail.gmail.com>
References: <CAHumR2+WR3Fdtft8xrPfcT3-dpKqCL__aaEc6qri3N5-x0yCXw@mail.gmail.com>
 <20170713160625.GB27801@lunn.ch>
 <CAHumR2LazFFmmNNKJ=KrEjt7iCgrKewkdzO6ww7RtLU+wWTFoA@mail.gmail.com>
Message-ID: <20170713173545.GE31807@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 06:32:29PM +0200, Mircea Ciocan wrote:
> I'm still struggle to understand the full purpose of
> the *get_irqnr_preamble* and *get_irqnr_and_base* macros.

get_irqnr_preamble does whatever you need that's common to handling a
set of interrupts read from the hardware.  It can set the two registers
to anything it likes.  Commonly, this is used to get the address of the
top level interrupt controller.  These two registers are passed to the
get_irqnr_and_base and test_for_ipi macros unmodified.

get_irqnr_and_base gets the interrupt number.  This must clear the Z
flag if an interrupt is pending, or set it if there's no interrupt.

test_for_ipi takes all the registers that were given to get_irqnr_and_base
and determines whether an IPI happened and which IPI, otherwise it
has the same behaviour as get_irqnr_and_base.

So it's not complicated - get_irqnr_preamble is basically the common
setup bits and get_irqnr_and_base is called repeatedly in a loop until
it indicates that there are no further pending interrupts.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
