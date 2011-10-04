From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 04 Oct 2011 17:21:01 -0400 (EDT)
Subject: Please help with the OMAP static mapping mess
In-Reply-To: <4E8AAFF9.3090600@ti.com>
References: <alpine.LFD.2.02.1110031312480.9106@xanadu.home>
	<20111003205658.GJ6324@atomide.com>
	<alpine.LFD.2.02.1110031744100.9106@xanadu.home>
	<20111003223824.GK6324@atomide.com> <4E8AAFF9.3090600@ti.com>
Message-ID: <alpine.LFD.2.02.1110041458500.9106@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Oct 2011, Santosh Shilimkar wrote:

> On Tuesday 04 October 2011 04:08 AM, Tony Lindgren wrote:
> > * Nicolas Pitre <nico@fluxnic.net> [111003 14:36]:
> >> On Mon, 3 Oct 2011, Tony Lindgren wrote:
> >>
> >>> Having the SRAM base address move around with different sizes also
> >>> requires the SoC detection.. Otherwise we can end up mapping wrong
> >>> size and end up trying to access secure SRAM that will hang the system.
> >>>
> >>> The way to fix it is to move SRAM init happen much later so we don't
> >>> have to map it early. I guess now we could use ioremap for SRAM,
> >>> although we may not want device attributes for the executable code?
> >>> Got any suggestions here on how we should map SRAM later on?
> >>
> >> You can use a variant of ioremap() such as __arm_ioremap() which let you 
> >> specify the memory attribute.
> > 
> > OK, I'll take a look at that.
> > 
> I have tried __arm_ioremap_pfn() for some DDR mapping and it didn't
> work as expected. The mapping was not getting created.

Did you investigate why it wasn't created?  Must have been a trivial 
issue surely?  But you have to wait until memory management is fully 
initialized to call the real ioremap() though, which happens later 
during the boot.

> Needless to say this can't be an IO memory. I later managed to get 
> around with it by using iotable_init() though downside is I have to 
> pick a static virtual address for the mapping.

You are using either MT_MEMORY or MT_MEMORY_NONCACHED in your map_desc 
entry.  So using e.g. __arm_ioremap(phys_addr, size, MT_MEMORY) should 
give you what you need, given that this is called late enough of course.

> But I agree that SRAM mapping can be moved further down. We
> just need to ensure that it's ready before we initialise SDRC
> and PM code. SDRC reconfigure of DDR needs to be executed from
> SRAM and of-course the PM WFI routine. Today we do SDRC init early
> and that's the reason SRAM is mapped before that. So both of them
> needs to be moved down in the boot to make it work.

Note that it is best not to call iotable_init() outside of the 
mdesc->map_io call path.  So either you reshuffle the initialization 
order so that the static mappings alre always in place before doing the 
ioremap() trick, or you use __arm_ioremap() later on.


Nicolas
