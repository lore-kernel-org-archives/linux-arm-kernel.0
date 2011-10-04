From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 04 Oct 2011 17:10:36 -0400 (EDT)
Subject: Please help with the OMAP static mapping mess
In-Reply-To: <20111003224411.GA19897@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.02.1110031312480.9106@xanadu.home>
	<20111003205658.GJ6324@atomide.com>
	<alpine.LFD.2.02.1110031744100.9106@xanadu.home>
	<20111003224411.GA19897@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1110041528050.9106@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 3 Oct 2011, Russell King - ARM Linux wrote:

> On Mon, Oct 03, 2011 at 06:09:57PM -0400, Nicolas Pitre wrote:
> > On Mon, 3 Oct 2011, Tony Lindgren wrote:
> > > Having the SRAM base address move around with different sizes also
> > > requires the SoC detection.. Otherwise we can end up mapping wrong
> > > size and end up trying to access secure SRAM that will hang the system.
> > > 
> > > The way to fix it is to move SRAM init happen much later so we don't
> > > have to map it early. I guess now we could use ioremap for SRAM,
> > > although we may not want device attributes for the executable code?
> > > Got any suggestions here on how we should map SRAM later on?
> > 
> > You can use a variant of ioremap() such as __arm_ioremap() which let you 
> > specify the memory attribute.
> 
> Just be aware that __arm_ioremap() always ends up with stuff in the
> kernel domain, but that's not what you end up with using create_mapping().
> So I'd prefer it if you didn't suggest that __arm_ioremap() should be used
> with types not listed in asm/io.h.

Well, here we're talking about MT_MEMORY and MT_MEMORY_NONCACHED, and 
they are using DOMAIN_KERNEL already.  So no difference there.

Which makes me think... with all those architectures intercepting 
ioremap calls in order to provide an equivalent static mapping address, 
they already get an unexpected domain given that static mappings are 
mostly DOMAIN_IO and not DOMAIN_KERNEL as would result from an non 
intercepted ioremap call.


Nicolas
