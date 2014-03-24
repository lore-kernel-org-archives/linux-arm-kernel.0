From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Mar 2014 16:42:02 +0100
Subject: [PATCH 4/8] tty/serial: add generic serial earlycon
In-Reply-To: <CAL_JsqJh1R8wxReCvTfE7GecZa0vMaAqnGa0ZoRBMace9qtzvQ@mail.gmail.com>
References: <1395436128-11244-1-git-send-email-robherring2@gmail.com>
 <9368307.RXEGmQia1C@wuerfel>
 <CAL_JsqJh1R8wxReCvTfE7GecZa0vMaAqnGa0ZoRBMace9qtzvQ@mail.gmail.com>
Message-ID: <21117957.8m9iUdR1VN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 March 2014 08:36:46 Rob Herring wrote:
> On Mon, Mar 24, 2014 at 6:29 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Monday 24 March 2014 11:22:03 Catalin Marinas wrote:
> >> On Fri, Mar 21, 2014 at 09:08:44PM +0000, Rob Herring wrote:
> >> > diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> >> > new file mode 100644
> >> > index 0000000..241757a
> >> > --- /dev/null
> >> > +++ b/drivers/tty/serial/earlycon.c
> >> [...]
> >> > +static void __iomem * __init earlycon_map(unsigned long paddr, size_t size)
> >> > +{
> >> > +   void __iomem *base;
> >> > +#ifdef CONFIG_FIX_EARLYCON_MEM
> >> > +   set_fixmap_nocache(FIX_EARLYCON_MEM_BASE, paddr & PAGE_MASK);
> >> > +   base = (void __iomem *)__fix_to_virt(FIX_EARLYCON_MEM_BASE);
> >> > +   base += paddr & ~PAGE_MASK;
> >> > +#else
> >> > +   base = ioremap_nocache(paddr, size);
> >> > +#endif
> >>
> >> Just curious why not set_fixmap_io (and plain ioremap)?
> >
> > Good point. Note that ioremap_nocache() is the same as ioremap()
> > on *all* architectures.
> 
> I investigated this before adding this to arm64. set_fixmap_io and
> set_fixmap_nocache are not the same settings on x86. Whether the
> mapping type really matters on x86 or not, I don't know. So I added
> the nocache variant to arm64 to avoid a change to x86.

My best guess is that it's an x86 bug. ioremap() always uses an uncached
mapping on x86, so it's strange to see early_ioremap() and set_fixmap_io()
use a cached mapping. It probably doesn't matter as long as the mtrr is
set up to treat all MMIO registers as non-cacheable, but I think there
should not be a difference.

	Arnd
