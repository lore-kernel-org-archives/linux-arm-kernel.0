From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 May 2011 22:00:27 +0100
Subject: IrDA driver fails on PXA255
In-Reply-To: <alpine.DEB.2.00.1105311253510.5646@chino.kir.corp.google.com>
References: <20110528205701.GA1788@doriath.ww600.siemens.net>
	<alpine.DEB.2.00.1105281628480.9934@chino.kir.corp.google.com>
	<BANLkTim9YdhjY75CzMsSOCVKZWi-WKZ5wA@mail.gmail.com>
	<alpine.DEB.2.00.1105291410450.9658@chino.kir.corp.google.com>
	<20110529215656.GA5576@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1105302202510.18793@chino.kir.corp.google.com>
	<20110531072650.GC21382@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1105311253510.5646@chino.kir.corp.google.com>
Message-ID: <20110531210027.GA3660@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2011 at 01:03:03PM -0700, David Rientjes wrote:
> The problem certainly isn't being ignored in this thread, or in the patch 
> that I sent to fix Dmitry's issue by default, so that doesn't seem to be 
> the case.  What would be ignored, though, is if it just emitted a 
> WARN_ON() without failing the allocation so everything works perfectly.

Sorry, you did not send a patch to fix it.  You sent a *bodge* to enable
the DMA zone.  As long as you insist that's a valid fix, you're going
to carry zero credibility with me.

The fact is that this driver should not be using GFP_DMA to allocate
things which aren't even DMA buffers, and its use of GFP_DMA should be
removed.  But rather than look at that and work it out, and then produce
a patch to sort that out, the only thing you can do is come up with
bodge to enable the DMA zone, and continue to insist that's the right
solution.

I repeat, enabling the DMA zone for this driver is a pure and utter
bodge, and the change to make these allocations fail _will_ and _has_
caused regressions.

Your whinge that we should re-enable the DMA zone which has been
disabled for quite a long time now to work around this new restriction
is extremely idiotic.

Do the right thing.  Make allocations to GFP_DMA zones _warn_ first for
a cycle so that affected drivers can be fixed.  Then for the next cycle,
make it a hard failure.
