From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 30 Nov 2011 11:34:51 +0000
Subject: [PATCH v3 2/5] ARM: vexpress: Get rid of MMIO_P2V
In-Reply-To: <201111292115.10833.arnd@arndb.de>
References: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
 <1322579473-8804-3-git-send-email-pawel.moll@arm.com>
 <201111292115.10833.arnd@arndb.de>
Message-ID: <1322652891.3164.144.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-11-29 at 21:15 +0000, Arnd Bergmann wrote:
> On Tuesday 29 November 2011, Pawel Moll wrote:
> > @@ -1,6 +1,3 @@
> > -#define __MMIO_P2V(x)  (((x) & 0xfffff) | (((x) & 0x0f000000) >> 4) | 0xf8000000)
> > -#define MMIO_P2V(x)    ((void __iomem *)__MMIO_P2V(x))
> > -
> ...
> > +
> > +/* 2MB large area for motherboard's peripherals static mapping */
> > +#define V2M_PERIPH 0xf8000000
> > +#define V2M_PERIPH_P2V(offset) ((void __iomem *)(V2M_PERIPH | (offset)))
> > +
> > +/* Tile's peripherals static mappings should start here */
> > +#define V2T_PERIPH 0xf8200000
> > +#define V2T_PERIPH_P2V(offset) ((void __iomem *)(V2T_PERIPH | (offset)))
> 
> I think it would be even better if you could express the same with
> pointer arithmetic instead of the macro, like:
> 
> #define V2M_PERIPH ((void __iomem *)0xf8000000)
> #define V2T_PERIPH ((void __iomem *)0xf8200000)
> 
> and then instead of 
> 
> +       gic_init(0, 29, V2T_PERIPH_P2V(A9_MPCORE_GIC_DIST),
> +                V2T_PERIPH_P2V(A9_MPCORE_GIC_CPU));
> 
> do 
> 
> +       gic_init(0, 29, V2T_PERIPH + A9_MPCORE_GIC_DIST,
> +                V2T_PERIPH + A9_MPCORE_GIC_CPU);
> 
> and so on. This ends up being more readable IMHO because it
> means you don't have to know what the macro does.

I wouldn't mind that, it's just that the V2M_PERIPH is also used in the
map_desc:

static struct map_desc v2m_io_desc[] __initdata = {
        {
                .virtual        = V2M_PERIPH,

and as the .virtual is unsigned long I'd need a cast in one place or the
other.

My best hope is that once Nico's "ioremap optimization" is pulled
(http://thread.gmane.org/gmane.linux.ports.arm.kernel/140974), I'll be
able to replace the _P2V macros with ioremap()s.

Cheers!

Pawe?
