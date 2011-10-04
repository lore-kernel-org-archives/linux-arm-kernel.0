From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 4 Oct 2011 23:54:24 +0100
Subject: Please help with the OMAP static mapping mess
In-Reply-To: <alpine.LFD.2.02.1110041528050.9106@xanadu.home>
References: <alpine.LFD.2.02.1110031312480.9106@xanadu.home>
	<20111003205658.GJ6324@atomide.com>
	<alpine.LFD.2.02.1110031744100.9106@xanadu.home>
	<20111003224411.GA19897@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1110041528050.9106@xanadu.home>
Message-ID: <20111004225424.GA32102@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 04, 2011 at 05:10:36PM -0400, Nicolas Pitre wrote:
> Which makes me think... with all those architectures intercepting 
> ioremap calls in order to provide an equivalent static mapping address, 
> they already get an unexpected domain given that static mappings are 
> mostly DOMAIN_IO and not DOMAIN_KERNEL as would result from an non 
> intercepted ioremap call.

That's a necessary evil - otherwise we have to separate out the
ioremap from vmalloc.

Incidentally, how are you dealing with the problem of a static mapping
setting up a L1 page table entry for DOMAIN_IO, and then a vmalloc
request coming in, overlapping that L1 page table?

If this memory then gets accessed with get_user() with set_fs(get_ds()),
the kernel will oops as we don't switch DOMAIN_IO memory on set_fs().
(I don't know if this happens in practice, but there's nothing to say
that it's illegal to do this.)
