From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 3 Jan 2014 13:50:59 +0100
Subject: [PATCHv8 1/4] pwm: Add Freescale FTM PWM driver support
In-Reply-To: <bb5e14370ddb4ce2921140d147244097@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1388656624-26570-1-git-send-email-Li.Xiubo@freescale.com>
 <3716216.GQHQhxMFvx@wuerfel>
 <bb5e14370ddb4ce2921140d147244097@BY2PR03MB505.namprd03.prod.outlook.com>
Message-ID: <201401031350.59447.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 January 2014, Li.Xiubo at freescale.com wrote:
> > Subject: Re: [PATCHv8 1/4] pwm: Add Freescale FTM PWM driver support
> > 
> > On Thursday 02 January 2014 17:57:01 Xiubo Li wrote:
> > > +static inline u32 ftm_readl(bool big_endian, const void __iomem *addr)
> > > +{
> > > +       u32 val;
> > > +
> > > +       val = __raw_readl(addr);
> > > +
> > > +       if (likely(big_endian))
> > > +               val = be32_to_cpu((__force __be32)val);
> > > +       else
> > > +               val = le32_to_cpu((__force __le32)val);
> > > +       rmb();
> > > +
> > > +       return val;
> > > +}
> > > +
> > > +static inline void ftm_writel(bool big_endian, u32 val, void __iomem *addr)
> > > +{
> > > +       wmb();
> > > +       if (likely(big_endian))
> > > +               val = (__force u32)cpu_to_be32(val);
> > > +       else
> > > +               val = (__force u32)cpu_to_le32(val);
> > > +
> > > +       __raw_writel(val, addr);
> > 
> > These functions definitely need some comments regarding why this is necessary.
> > I assume that after 8 rounds of review (that I did not read) this has been
> > discussed already, so please explain above the functions why you don't just
> > use ioread32be/ioread32 and iowrite32be/iowrite32 here.
> >
> 
> As Thierry has commonts in some days before:
> ----
> A few years ago GregKH commented in response to a patch that ioread*()
> weren't supposed to be used for memory-mapped only devices. The original
> purpose apparently was to allow drivers to work with both I/O and
> memory-mapped devices.
> ----
> I'm not very sure.

Adding Greg here to make sure we have a common understanding in the future.

ioread*() was indeed introduced for devices that can be both I/O and memory
space, and is a bit slowed than readl() on architectures that don't have
memory mapped I/O space (i.e. x86).

However, ioread32be is the only architecture-independent big-endian
accessor function (some architectures have in_be32, but that doesn't
work on ARM), and as mandated by Linus a couple of years ago when
we wanted to take some shortcuts on powerpc, ioread32 has to be
semantically the same as readl when used on pointers returned from
ioremap() rather than ioport_map, and ioread32be is just the
byte-swapped version of it.

We have a couple of drivers using ioread* because of the need for
big-endian data access, and I would continue recommending that unless
I hear a good argument against it.

> The big-endian supports is added at v7~v8 patch series.

Yes, that version looks fine and it avoids the above problem nicely,
but I'd still like to make sure we come to a conclusion on the problem
of big-endian I/O accessors.

	Arnd
