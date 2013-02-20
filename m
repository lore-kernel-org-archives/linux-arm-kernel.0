From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 20 Feb 2013 20:03:16 +0000 (UTC)
Subject: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod
 dependency
In-Reply-To: <20130220191638.GA25609@arwen.pp.htv.fi>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
 <1360840554-26901-2-git-send-email-balbi@ti.com>
 <20130214171253.GC7144@atomide.com> <20130214175650.GA25891@arwen.pp.htv.fi>
 <20130214181217.GA11806@atomide.com> <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <20130215064429.GA30038@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1302191530190.32069@utopia.booyaka.com>
 <20130220191638.GA25609@arwen.pp.htv.fi>
Message-ID: <alpine.DEB.2.00.1302201917530.10878@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 20 Feb 2013, Felipe Balbi wrote:

> On Wed, Feb 20, 2013 at 05:38:49PM +0000, Paul Walmsley wrote:
> > > > Drivers shouldn't touch their IP block's SYSCONFIG registers.  They don't 
> 
> just now I noticed this fun fact:
> 
> "driver's should touch *their* SYSCONFIG registers"
> 
> You're stating yourself that SYSCONFIG belongs to the IP and the IP is
> fully controlled by its driver. ;-)

Hehe.  I should have used some more convoluted expression :-)

> > Ideally Linux drivers would be as independent as possible from their SoC- 
> > or board-specific integration.  This includes bus integration, etc.  That 
> > way, an IP block like UART, where most or all of the registers are shared 
> > with the common 8250 code, might be able to use a shared driver.
> 
> right, then why did we even bother adding omap-serial ? If the whole
> idea was to hide integration, what was the point in introducing
> omap-serial ?

My distant recollection was that the main impetus at the time was DMA 
support.  Which might be moot, now.  Not really my parish.

> > Also, it should be noted that the TI wrapper isn't necessarily common to 
> > all TI SoCs :-)  The wrapper bits and functions can change from TI SoC to 
> > SoC.
> 
> yeah, that's because of the chassis architecture definition and has
> little value to current discussion ;-)

The point was that we don't want to duplicate that code in each driver for 
each SoC ... rather, it can live in one place, in some separate 
integration layer.

> It does touch the IP block. After the asynchronous PM handshake
> (Ack-Req) is successful the IP block isn't in a usable state.

Usually that's just because the PRCM has cut some clock to the device.
You can chat with Beno?t about this if you want; we had a discussion last 
year about it in relation to the 32K_SYNCTIMER.

> > As far as reset goes, the chip-wide reset bits affect the IP block too, 
> > but we wouldn't put that code into the drivers :-)
> 
> why not ? 

In the OMAP case, the SoC-wide reset bits are in the PRCM somewhere, which 
in turn assert reset for a wide set of IP blocks.  So there's not much 
point to putting code for that in the drivers.

> What happens when drivers need to reset the IP ? For cases
> where we need "reset in runtime", drivers are the best entities to know
> exactly where the IP must be reset.

We might be miscommunicating.  I was mostly referring to SoC-wide reset in 
my (somewhat silly) counterfactual.

So there are at least three kinds of reset in this context, that I think 
about:

1. SoC-level reset
2. Bus-level reset
3. Device-level reset

Ideally these are all independent, even though they might share some of 
the same hardware mechanisms.  The case that's causing us so much hassle 
is bus-level reset.  The problem is that some of the OMAP devices - say, 
7-10% - can't be reset and idled simply with a bus-level reset.  I'd 
consider the exceptions as hardware bugs, but we still have to deal with 
them.

> Also, IMHO reset should always be done during probe() so driver can be
> dead sure that we're starting from a known state. This is even more
> important for the complex IPs which are licensed from RTL vendors and
> are used in different SoCs. While arch/arm/mach-abc/ resets every IP
> pior to probe() being called, we can't be sure that arch/arm/mach-xyz/
> will do the same thing and imposing such requirement is too difficult.
> 
> Problem just gets worse when you consider SoCs from completely different
> architectures (say ARM and Blackfin) using the same IP licensed from
> a particular RTL vendor.

Or if there's no driver for the device at all :-(


- Paul
