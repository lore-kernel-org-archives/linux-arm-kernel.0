From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 20 Dec 2009 20:51:44 +0100
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <alpine.LFD.2.00.0912181358580.28241@xanadu.home>
References: <309002C0DA137042828828FC53D7A9347E212D150D@IL-MB01.marvell.com>
	<20091207145235.GD19348@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0912071027480.31174@xanadu.home>
	<20091207170546.GB26821@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0912071219100.31174@xanadu.home>
	<20091207175608.GE26821@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A9347E2630EEC2@IL-MB01.marvell.com>
	<20091213120033.GA10698@n2100.arm.linux.org.uk>
	<20091218184518.GE1470@ucw.cz>
	<alpine.LFD.2.00.0912181358580.28241@xanadu.home>
Message-ID: <20091220195143.GE23917@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2009-12-18 14:00:13, Nicolas Pitre wrote:
> On Fri, 18 Dec 2009, Pavel Machek wrote:
> 
> > On Sun 2009-12-13 12:00:33, Russell King - ARM Linux wrote:
> > > On Sun, Dec 13, 2009 at 01:48:48PM +0200, Ronen Shitrit wrote:
> > > > Another idea is to change the shared mapping handling, in case of vivt with pipt L2, so it won't remap the shared area as non-cacheable:
> > > > - make_coherent won't use adjust_pte and leave only the regular flush.
> > > > - Flush L1 for all context switches, also for the case that the new process is using same mm (thread context switch).
> > > 
> > > That doesn't work.
> > > 
> > > Well, with a VIVT L1, we flush the L1 on all MM switches anyway.
> > > Flushing it on any thread switch is not going to help that much.
> > > 
> > > The problem with shared mmaps is that if you have multiple within the
> > > same thread, it is required that they are _all_ coherent with respect
> > > to each other, whether or not a context switch has occurred.
> > 
> > But that's pretty unusual situation, right?
> > 
> > So what about...
> > 
> > a) flush L2 on context switch
> 
> No.  This is too big a performance killer.

Eek?

Alternative is "disable L2". I guess "use L2, but flush it
occasionally" is still better than "disable L2".

Of course, it should be measured. It looks like hardware already is
braindead, so maybe logic does not work there.

(And it may depend if you want max throughput or min latency).
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
