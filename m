From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 21 Dec 2017 14:40:58 +0100
Subject: [PATCH 4/4] ARM: dts: vf610-zii-dev-rev-b: add interrupts for
 88e1545 PHY
In-Reply-To: <CACRpkdas5JJ4KHE4g=sPXag=3vQt4TS5EcZBsy=LRfw8tqcgOw@mail.gmail.com>
References: <20171220231108.GJ10595@n2100.armlinux.org.uk>
 <E1eRnWr-0006VS-1m@rmk-PC.armlinux.org.uk>
 <CACRpkdas5JJ4KHE4g=sPXag=3vQt4TS5EcZBsy=LRfw8tqcgOw@mail.gmail.com>
Message-ID: <20171221134058.GA15416@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 21, 2017 at 01:32:21PM +0100, Linus Walleij wrote:
> On Thu, Dec 21, 2017 at 12:12 AM, Russell King
> <rmk+kernel@armlinux.org.uk> wrote:
> 
> > The 88e1545 PHY has its interrupts wired to the VF610, so we might as
> > well use them.
> >
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> > This is certainly not correct, as all PHYs on this device share the
> > same interrupt line, but we can't specify the pinmux settings
> > individually on each PHY.  How should this be handled?
> 
> I do not know the details of the Marvell switch.

Hi Linus

The 88e1545 is a discreet quad PHY. It is connected to the switch, but
not integrated into the switch. All its interrupt handling is done
with a GPIO onto the Freescale processor, via a GPIO. There is nothing
DSA related here at all with respect to the interrupt. It is just a
normal GPIO interrupt. What is a bit odd is that it one shared
interrupt for all four PHYs.

What you described with an irqchip inside the switch is what we
actually do for the internal PHYs on Marvell devices. And it is what i
recommend for all DSA drivers. Expose standard IRQs, and let phylib
use them in its normal way.

	  Andrew
