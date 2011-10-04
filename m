From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 04 Oct 2011 19:20:57 -0400 (EDT)
Subject: Please help with the OMAP static mapping mess
In-Reply-To: <20111004225424.GA32102@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.02.1110031312480.9106@xanadu.home>
	<20111003205658.GJ6324@atomide.com>
	<alpine.LFD.2.02.1110031744100.9106@xanadu.home>
	<20111003224411.GA19897@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1110041528050.9106@xanadu.home>
	<20111004225424.GA32102@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1110041900590.9106@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Oct 2011, Russell King - ARM Linux wrote:

> On Tue, Oct 04, 2011 at 05:10:36PM -0400, Nicolas Pitre wrote:
> > Which makes me think... with all those architectures intercepting 
> > ioremap calls in order to provide an equivalent static mapping address, 
> > they already get an unexpected domain given that static mappings are 
> > mostly DOMAIN_IO and not DOMAIN_KERNEL as would result from an non 
> > intercepted ioremap call.
> 
> That's a necessary evil - otherwise we have to separate out the
> ioremap from vmalloc.
> 
> Incidentally, how are you dealing with the problem of a static mapping
> setting up a L1 page table entry for DOMAIN_IO, and then a vmalloc
> request coming in, overlapping that L1 page table?
> 
> If this memory then gets accessed with get_user() with set_fs(get_ds()),
> the kernel will oops as we don't switch DOMAIN_IO memory on set_fs().
> (I don't know if this happens in practice, but there's nothing to say
> that it's illegal to do this.)

I suppose that didn't happen so far.  Granted, moving the ioremap 
optimization into core code for all machines will increase the 
possibility for this to happen, even if still small.

With CPU_USE_DOMAINS not set, set_fs() is a no-op anyway, besides 
addr_limit that is.

Is there a strong benefit in having static mappings being DOMAIN_IO 
instead of DOMAIN_KERNEL?


Nicolas
