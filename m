From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 28 Feb 2014 14:53:49 +0100
Subject: [PATCH 1/3] PCI: designware: add legacy PCI interrupt mapping
In-Reply-To: <6315058.94ydMC9ka8@wuerfel>
References: <1393550394-11071-1-git-send-email-tharvey@gateworks.com>
 <5728262.sMhnqxGTXH@wuerfel>
 <1393589374.5225.9.camel@weser.hi.pengutronix.de>
 <6315058.94ydMC9ka8@wuerfel>
Message-ID: <1393595629.5225.12.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 28.02.2014, 13:27 +0100 schrieb Arnd Bergmann:
> On Friday 28 February 2014 13:09:34 Lucas Stach wrote:
> > Am Freitag, den 28.02.2014, 12:37 +0100 schrieb Arnd Bergmann:
> > > On Friday 28 February 2014 12:27:36 Lucas Stach wrote:
> > > The interrupt-map doesn't even look well-formed, since it refers to
> > > a gic that has #interrupt-cells=<3>, but only has one cell with the
> > > value. This clearly cannot work at all. It should probably be
> > > 
> > >       interrupt-map = <0x0 0 &gic GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> > > 
> > > Note that '53' is the IRQ number that is commonly assigned to
> > > SPI interrupt 21, since SPI starts at number 32 on GIC.
> > > 
> > Ah, I see. Thanks for the explanation. So we have a bogus Exynos DT,
> > which will break existing systems once the kernel starts to do the right
> > thing. This is starting to look great. 
>  
> It seems tegra and r-car have the same bug. We can probably fix it
> in a backwards-compatible way by changing the function to call
> the generic helper first and if that fails call printk_once()
> to emit a warning and return the hardwired IRQ number.
> 

Yes, seems like the way to go. I'll prepare some patches for that. It
seems of_irq_parse_and_map_pci() already emits an error message if it
can't find a valid mapping. This should be enough to get people to fix
their DTs.

Regards,
Lucas 

-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
