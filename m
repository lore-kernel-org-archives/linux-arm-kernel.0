From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Mar 2014 12:29:07 +0100
Subject: [PATCH 4/8] tty/serial: add generic serial earlycon
In-Reply-To: <20140324112203.GD3850@arm.com>
References: <1395436128-11244-1-git-send-email-robherring2@gmail.com>
 <1395436128-11244-5-git-send-email-robherring2@gmail.com>
 <20140324112203.GD3850@arm.com>
Message-ID: <9368307.RXEGmQia1C@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 March 2014 11:22:03 Catalin Marinas wrote:
> On Fri, Mar 21, 2014 at 09:08:44PM +0000, Rob Herring wrote:
> > diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> > new file mode 100644
> > index 0000000..241757a
> > --- /dev/null
> > +++ b/drivers/tty/serial/earlycon.c
> [...]
> > +static void __iomem * __init earlycon_map(unsigned long paddr, size_t size)
> > +{
> > +	void __iomem *base;
> > +#ifdef CONFIG_FIX_EARLYCON_MEM
> > +	set_fixmap_nocache(FIX_EARLYCON_MEM_BASE, paddr & PAGE_MASK);
> > +	base = (void __iomem *)__fix_to_virt(FIX_EARLYCON_MEM_BASE);
> > +	base += paddr & ~PAGE_MASK;
> > +#else
> > +	base = ioremap_nocache(paddr, size);
> > +#endif
> 
> Just curious why not set_fixmap_io (and plain ioremap)?

Good point. Note that ioremap_nocache() is the same as ioremap()
on *all* architectures.

	Arnd
