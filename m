From: goran.cengic@ericsson.com (Goran Cengic)
Date: Wed, 7 Oct 2015 14:19:03 +0000
Subject: gpio-mvebu: patch for separate edge and level mask caches
References: <2F27BCDE355D444CB7EA7E1569D8465028987D43@ESESSMB203.ericsson.se>
 <20151007114054.GI13247@io.lakedaemon.net>
Message-ID: <2F27BCDE355D444CB7EA7E1569D8465028987DF2@ESESSMB203.ericsson.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Updated the patch with correct name in "From:" field. Also, checkpatch.pl says that Signed-Off is not present. Should I sign off or someone of the maintainers?

With kind regards,

	Goran

> -----Original Message-----
> From: Goran Cengic
> Sent: den 7 oktober 2015 13:50
> To: 'Jason Cooper'; Linus Walleij
> Cc: Thomas Petazzoni; Andrew Lunn; Gregory Clement; Sebastian
> Hesselbarth; 'linux-arm-kernel at lists.infradead.org'
> Subject: RE: gpio-mvebu: patch for separate edge and level mask caches
> 
> Including the patch and lakml.
> 
> > -----Original Message-----
> > From: Jason Cooper [mailto:jason at lakedaemon.net]
> > Sent: den 7 oktober 2015 13:41
> > To: Goran Cengic; Linus Walleij
> > Cc: Thomas Petazzoni; Andrew Lunn; Gregory Clement; Sebastian
> > Hesselbarth
> > Subject: Re: gpio-mvebu: patch for separate edge and level mask caches
> >
> > Hello Goran,
> >
> > +Cc: LinusW (gpio maintainer)
> >
> > On Wed, Oct 07, 2015 at 10:36:01AM +0000, Goran Cengic wrote:
> > > Hi again,
> > >
> > > I didn't found who maintains the drivers/gpio/gpio-mvebu.c in the
> > > MAINTAINERS and I've realized that Armada 38x SoC maintainers also
> > > might be relevant for this issue so I've included them here.
> >
> > You're absolutely correct.  Those of us involved with kernel
> > development day-to-day 'just know' that the mvebu maintainers would
> > handle such a driver.  We should update MAINTAINERS.
> >
> >
> > > From: Goran Cengic
> > > Sent: den 5 oktober 2015 20:15
> > > To: 'Thomas Petazzoni'
> > > Subject: gpio-mvebu: patch for separate edge and level mask caches
> > >
> > > Hi Thomas,
> > >
> > > We've encountered a small issue with not being able to mix edge and
> > > level sensitive interrupts. The issue is that gpio-mvebu would
> > > trigger an edge sensitive interrupt even though
> > > mvebu_gpio_level_irq_mask() has been called for the same level
> > > interrupt. The issue is caused by the mask_cache in irq_chip_generic
> > > being shared between the chip_types.
> > >
> > > Here is a summary of what happens. Enable_irq(some level sensitive
> > > interrupt), as configured in dtb, enable_irq(some other edge
> > > sensitive interrupt). At this point the mask_cache is not masking
> > > bot interrupts. Since the same mask_cache is written to the edge
> > > mask register, at the second call to enable_irq(), the level
> > > sensitive interrupt is unmasked in the edge mask register also. Now
> > > as soon as the transition to, say, low level occurs the mvebu gpio
> > > controller registers one in the edge cause register while the data
> > > in is used as level cause register. The irq handling starts and
> > > masks the interrupt using mvebu_gpio_level_irq_mask(), since that
> > > interrupt is configured as level-sensitive. However, the edge cause
> > > register is never mvebu_gpio_irq_ack()'ed and continues to trigger
> > > interrupt handling and locks the processor since the edge mask
> > > register is not masking that bit.
> >
> > Thanks for the bug report, however ...
> >
> > > I've attached a small patch so that you can decide if it's ok for inclusion.
> >
> > hmmm, I don't see it.  Could you please resend with it attached?
> >
> > Please also Cc lakml at linux-arm-kernel at lists.infradead.org.  If you
> > can, then please try to adhere to the list conventions: no html, no legal
> footers, etc.
> >
> > thx,
> >
> > Jason.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-gpio-mvebu-separate-edge-and-level-mask-caches.patch
Type: application/octet-stream
Size: 2178 bytes
Desc: 0001-gpio-mvebu-separate-edge-and-level-mask-caches.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151007/de46b0cc/attachment.obj>
