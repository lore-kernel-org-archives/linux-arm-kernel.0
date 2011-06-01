From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 1 Jun 2011 16:59:52 +0200
Subject: i.MX consolidation patches
In-Reply-To: <20110601143604.GH23771@pengutronix.de>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
	<20110530075745.GA31492@S2100-06.ap.freescale.net>
	<20110601123522.GE23771@pengutronix.de>
	<20110601134749.GI3660@n2100.arm.linux.org.uk>
	<20110601141847.GG23771@pengutronix.de>
	<20110601142406.GJ3660@n2100.arm.linux.org.uk>
	<20110601143604.GH23771@pengutronix.de>
Message-ID: <20110601145952.GA9907@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Jun 01, 2011 at 04:36:04PM +0200, Sascha Hauer wrote:
> On Wed, Jun 01, 2011 at 03:24:06PM +0100, Russell King - ARM Linux wrote:
> > On Wed, Jun 01, 2011 at 04:18:47PM +0200, Sascha Hauer wrote:
> > > diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
> > > index 9128fdd..e3b6f02 100644
> > > --- a/arch/arm/boot/Makefile
> > > +++ b/arch/arm/boot/Makefile
> > > @@ -59,6 +59,11 @@ $(obj)/zImage:	$(obj)/compressed/vmlinux FORCE
> > >  
> > >  endif
> > >  
> > > +ifeq ($(CONFIG_ARM_PATCH_PHYS_VIRT),y)
> > > +$(obj)/uImage: $(obj)/zImage FORCE
> > > +	@echo 'building uImages is incompatible with CONFIG_ARM_PATCH_PHYS_VIRT'
> > > +	@false
> > 
> > It may be better to drop the zImage dependency too, so that folk don't get
> > the message at the end of an otherwise successful kernel build - they may
> > decide to turn p2v patching off which would result in a rebuild.
> 
> It's not that easy. We have this in arch/arm/Makefile:
> 
> zImage Image xipImage bootpImage uImage: vmlinux
> 	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
> 
> So arch/arm/boot/Makefile gets evaluated after a successful build. We
> have to make the test in arch/arm/Makefile if we want to catch this
> earlier.
> 
> > 
> > Or it could suggest the mkimage command which should be run, but with
> > <LOAD-ADDRESS> inserted into it at the appropriate point - iow something
> > like:
> > 
> >   mkimage -A arm -O linux -T kernel -C none \
> > 	-a <LOAD-ADDRESS> -e <START-ADDRESS> \
> > 	-n 'Linux-$(KERNELRELEASE)' -d arch/arm/boot/zImage uImage.<PLATFORM>
> 
> Ok, it's a good idea to give the user a hint what to do.
Back when I worked on RUNTIME_PHYSOFFSET I addressed that problem. My
patch that you can find in the archives allowed to do:

	make uImage LOAD_ADDRESS=...

even with RUNTIME_PHYSOFFSET=y.

I didn't try to find that patch, though.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
