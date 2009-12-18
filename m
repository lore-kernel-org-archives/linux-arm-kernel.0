From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 18 Dec 2009 19:45:19 +0100
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <20091213120033.GA10698@n2100.arm.linux.org.uk>
References: <20091207114218.GA19348@n2100.arm.linux.org.uk>
	<4B1CF3ED.9080307@denx.de>
	<309002C0DA137042828828FC53D7A9347E212D150D@IL-MB01.marvell.com>
	<20091207145235.GD19348@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0912071027480.31174@xanadu.home>
	<20091207170546.GB26821@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0912071219100.31174@xanadu.home>
	<20091207175608.GE26821@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A9347E2630EEC2@IL-MB01.marvell.com>
	<20091213120033.GA10698@n2100.arm.linux.org.uk>
Message-ID: <20091218184518.GE1470@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun 2009-12-13 12:00:33, Russell King - ARM Linux wrote:
> On Sun, Dec 13, 2009 at 01:48:48PM +0200, Ronen Shitrit wrote:
> > Another idea is to change the shared mapping handling, in case of vivt with pipt L2, so it won't remap the shared area as non-cacheable:
> > - make_coherent won't use adjust_pte and leave only the regular flush.
> > - Flush L1 for all context switches, also for the case that the new process is using same mm (thread context switch).
> 
> That doesn't work.
> 
> Well, with a VIVT L1, we flush the L1 on all MM switches anyway.
> Flushing it on any thread switch is not going to help that much.
> 
> The problem with shared mmaps is that if you have multiple within the
> same thread, it is required that they are _all_ coherent with respect
> to each other, whether or not a context switch has occurred.

But that's pretty unusual situation, right?

So what about...

a) flush L2 on context switch

b) disable L2 when thread has maps one physical address twice



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
