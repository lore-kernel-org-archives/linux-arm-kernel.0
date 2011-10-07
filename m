From: tony@atomide.com (Tony Lindgren)
Date: Fri, 7 Oct 2011 12:05:12 -0700
Subject: [PATCH] ARM: mmp: map sram as MT_MEMORY rather than MT_DEVICE
In-Reply-To: <20110822191335.3dbe99b9@debxo>
References: <1313377794-26721-1-git-send-email-leoy@marvell.com>
	<1313377794-26721-2-git-send-email-leoy@marvell.com>
	<20110822164740.5682541b@queued.net>
	<20110823000755.GE3895@n2100.arm.linux.org.uk>
	<20110822191335.3dbe99b9@debxo>
Message-ID: <20111007190512.GL6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Andres Salomon <dilinger@queued.net> [110822 18:40]:
> On Tue, 23 Aug 2011 01:07:55 +0100
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> [...]
> > > @@ -87,7 +88,8 @@ static int __devinit sram_probe(struct
> > > platform_device *pdev) 
> > >  	info->sram_phys   = (phys_addr_t)res->start;
> > >  	info->sram_size   = resource_size(res);
> > > -	info->sram_virt   = ioremap(info->sram_phys,
> > > info->sram_size);
> > > +	info->sram_virt   = __arm_ioremap(info->sram_phys,
> > > info->sram_size,
> > > +					  MT_MEMORY);
> > 
> > Not a good idea fiddling about under the covers like that.  The reason
> > that MT_MEMORY is not in asm/io.h is to stop it being used like this -
> > MT_MEMORY etc are not meant for general purpose use.
> > 
> > It needs to be looked at properly rather than working behind the APIs,
> > and making my life a misery by doing so, preventing me from making
> > changes where necessary by this kind of back-door use.
> > 
> > I guess we need a new ioremap_xxx() variant to cope with this.
> 
> Something like ioremap_exec()?  I have no idea what the related MT_
> entry would be (as someone who's new to the ARM world, it's not
> entirely clear what the semantic distinctions are between the various
> MT_ entries).

Andres, care to ack this patch:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7126/1

Looks like that should do what you want. And after the related
SRAM/map_io fixes for omap, it really seems that we could have
a generic SRAM driver..

Regards,

Tony
