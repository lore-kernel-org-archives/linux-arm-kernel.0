From: tony@atomide.com (Tony Lindgren)
Date: Wed, 4 May 2011 06:12:15 -0700
Subject: [PATCHv3] ARM:boot:device tree: Allow the device tree binary
	to be appended to zImage
In-Reply-To: <20110504072317.GU2092@atomide.com>
References: <20110421080238.GE13688@atomide.com>
	<20110421124618.GA15060@atomide.com>
	<20110427142306.GI3755@atomide.com>
	<alpine.LFD.2.00.1104271036520.24613@xanadu.home>
	<20110427144335.GK3755@atomide.com>
	<20110429102623.GX3755@atomide.com>
	<alpine.LFD.2.00.1104290909310.24613@xanadu.home>
	<20110429135334.GR5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104291509540.24613@xanadu.home>
	<20110504072317.GU2092@atomide.com>
Message-ID: <20110504131214.GD2092@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [110504 00:20]:
> * Nicolas Pitre <nico@fluxnic.net> [110429 12:11]:
> > > 
> > > Err, no.  Moving stuff around becomes quite expensive when the cache is
> > > not on.  It's far better to work out where to place it first time around
> > > so its not in the way.
> > 
> > I don't think the DT data is that huge, but that's a point in favor of 
> > doing it in the zImage code.  We'll just need to feed the total size of 
> > the uncompressed kernel .bss section to zImage when compiling it.
> 
> One more thing to consider though.. I don't think we want to copy the
> DT data twice. It's not big right now, but could get large if we pass
> all the clocks in it.
> 
> So this should be probably fixed in the original patch.. John got
> any thoughts on that?

Hmm actually the the easy fix is to relocate both the compressed kernel
and DT data with one copy to:

max(inflated_kernel_end + kernel_bss_size - compressed_kernel_size,
	inflated_kernel_end)

So no need to relocate them separately or copy twice.

Tony
