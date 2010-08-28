From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 28 Aug 2010 18:30:05 +0200
Subject: [PATCH 3/3 v2] dmaengine: Add Freescale i.MX SDMA support
In-Reply-To: <20100828161858.GI1473@pengutronix.de>
References: <1281956870-12463-1-git-send-email-s.hauer@pengutronix.de>
	<201008281727.10913.marek.vasut@gmail.com>
	<20100828161858.GI1473@pengutronix.de>
Message-ID: <201008281830.05208.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne So 28. srpna 2010 18:18:58 Sascha Hauer napsal(a):
> On Sat, Aug 28, 2010 at 05:27:10PM +0200, Marek Vasut wrote:
> > Dne So 28. srpna 2010 17:18:17 Linus Walleij napsal(a):
> > > 2010/8/23 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > > >> +     evt = readl(SDMA_H_EVTOVR);
> > > >> +     mcu = readl(SDMA_H_HOSTOVR);
> > > >> +     dsp = readl(SDMA_H_DSPOVR);
> > > > 
> > > > __raw_readl?
> > > 
> > > Sorry I never understood this __raw_[read|write][b|w|l] vs.
> > > plain read[b|w|l] proliferation in some drivers and code.
> > > 
> > > What's the reason for?
> > 
> > Hey,
> > 
> > this trick is, if you create the VA<->PA mapping at the kernel start (eg.
> > see how pxa_map_io() is replacedon some devices for instance), you then
> > use the VA address you specified and use __raw_{read,write}[b,w,l](). So
> > use __raw_{read,write}[b,w,l]() on drivers specific for certain device
> > and use {read,write}[b,w,l]() on ioremap()ed memory areas, aka. in
> > common drivers.
> 
> Nope, this has nothing to do with static mappings vs. ioremap. The
> difference is that read[b,w,l] do little endian accesses suitable for
> PCI whereas the __raw_* functions do accesses in CPU endianess.
> Peripherals integrated into a SoC like the SDMA engine here are
> normally accessible in native endianess and thus need the __raw_*
> functions. An external network controller (for example a LAN9117) will
> probably need the non raw functions. Note that 99% of the arm users use
> little endian only and thus cpu_to_le* is a noop, so both types will work
> for most people.

Sorry, you got me here. Why do we have io{read,write} then btw. ? That's for 
x86's io space, right ?

Thanks, cheers and sorry for the confusion
> 
> Sascha
