From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 22 Feb 2012 16:45:57 -0800
Subject: [PATCH 1/2] Documentation/gpio.txt: Explain expected pinctrl
 interaction
In-Reply-To: <CACRpkdb+Vtyhsxi7L0ttDk_8Ra2-Kfh8H9esD7P_FC_=c4-=Mw@mail.gmail.com>
References: <1329719263-18971-1-git-send-email-swarren@nvidia.com>
 <20120220073941.GC22562@n2100.arm.linux.org.uk>
 <CACRpkdbMFN3=XTSg1oE310eTHecrs6XaMz+DCNYJzwOg8JEEiQ@mail.gmail.com>
 <20120221110618.GJ22562@n2100.arm.linux.org.uk>
 <CACRpkdYzRu4VPKPgxuttuvSDCpfHjvBGGq1rFEDExv1PsoLG=w@mail.gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC3A1@HQMAIL01.nvidia.com>
 <CACRpkdb+Vtyhsxi7L0ttDk_8Ra2-Kfh8H9esD7P_FC_=c4-=Mw@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC882@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote at Tuesday, February 21, 2012 11:01 PM:
> On Tue, Feb 21, 2012 at 8:14 PM, Stephen Warren <swarren@nvidia.com> wrote:
> > Ignoring WARs like we're discussing, it's typically true that a given pin
> > should either be a special function or a GPIO for any given board. If
> > we do allow a pin to be owned/used by both, then how do we indicate, on
> > a per-board rather than per-SoC basis, which pins we should allow both
> > gpio_request() and pinmux usage?
> 
> I was thinking about making this a property of the physical pin i.e.
> struct pin_desc and not of the board data.
> 
> It seems to me like this arbitration has to be very close to the driver,
> since not all or even many controllers will support it (AFAICT).

Well, there are two aspects:

a) Can the pin controller do it, which is something per-SoC/driver?
b) Does it make sense for the board, given what each pin is connected to?

So unless we decide to ignore (b) (which may be perfectly fine but as I
mentioned I'd just like to explicitly decide this), there needs to be some
per-SoC way of representing this capability, /and/ some per-board way.

> > The following considerations exist:
> > a) On Tegra, a pin group might include 10 pins that are mux'd as a group,
> > hence all owned e.g. by a NAND driver. If a few of those aren't used on a
> > particular board due to the way the NAND is hooked up and the driver
> > configured, do we only allow gpio_request() only on those pins we know the
> > NAND driver isn't actually using, to prevent someone using unexpected
> > pins as GPIO? We'd need a per-GPIO per-board way to represent this if
> > we care about this level of error-checking.
> 
> In this case I would strive not to present unused pins to the functions
> in the first place. But maybe this collides with the new paradigm to
> assign aquire all possible pins on pinctrl_get() time?

The pins are part of the pin group in HW. It doesn't make sense to say
that they aren't, and indeed the SoC driver has no board knowledge and
couldn't exclude them anyway.

-- 
nvpublic
