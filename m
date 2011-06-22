From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Jun 2011 16:14:07 +0100
Subject: i.MX consolidation patches
In-Reply-To: <201106221710.39687.arnd@arndb.de>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
	<20110622090321.GO23234@n2100.arm.linux.org.uk>
	<20110622145828.GL6069@pengutronix.de>
	<201106221710.39687.arnd@arndb.de>
Message-ID: <20110622151407.GU23234@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2011 at 05:10:39PM +0200, Arnd Bergmann wrote:
> On Wednesday 22 June 2011, Sascha Hauer wrote:
> > --- a/arch/arm/boot/Makefile
> > +++ b/arch/arm/boot/Makefile
> > @@ -59,6 +59,11 @@ $(obj)/zImage:       $(obj)/compressed/vmlinux FORCE
> >  
> >  endif
> >  
> > +ifneq ($(words $(ZRELADDR)), 1)
> > +$(obj)/uImage: FORCE
> > +       @echo 'Multiple zreladdrs, cannot build uImage'
> > +       exit 1
> > +else
> 
> Failing the build for a possible configuration is not nice, I would
> be happier if this could be prevented in Kconfig. I have recently
> worked on getting all 'randconfig' build working for a bunch of platforms
> (patches will follow), so it would be a shame to have another
> guaranteed failure built into the kernel.

Arnd,

I don't think you're _thinking_.  If you issue 'make uImage', how is the
kernel configuration stuff to know that it should not enable multiple
platforms which would make building a uImage technically impossible
(and lead to the created uImage being non-bootable on some of those
platforms.)

The answer is: you can't.

The best we can do is if the configuration encounters this problem, then
fail to build a uImage.  If that concerns you, then don't ask the kernel
to build an inherently fragile boot loader format in the first place.
