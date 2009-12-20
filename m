From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 20 Dec 2009 20:56:15 +0100
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <20091218191626.GG5527@n2100.arm.linux.org.uk>
References: <309002C0DA137042828828FC53D7A9347E212D150D@IL-MB01.marvell.com>
	<20091207145235.GD19348@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0912071027480.31174@xanadu.home>
	<20091207170546.GB26821@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0912071219100.31174@xanadu.home>
	<20091207175608.GE26821@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A9347E2630EEC2@IL-MB01.marvell.com>
	<20091213120033.GA10698@n2100.arm.linux.org.uk>
	<20091218184518.GE1470@ucw.cz>
	<20091218191626.GG5527@n2100.arm.linux.org.uk>
Message-ID: <20091220195615.GF23917@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2009-12-18 19:16:26, Russell King - ARM Linux wrote:
> On Fri, Dec 18, 2009 at 07:45:19PM +0100, Pavel Machek wrote:
> > But that's pretty unusual situation, right?
> 
> It may be uncommon, but it's something that must work - not only is it
> a quality of implementation issue, but its also a data corruption issue.
> Get it wrong and you silently corrupt files on your filesystems.
> 
> As I've said earlier in the thread, we know that db4 does this.  Not
> fixing this means that we really don't care about any program which
> uses db4, or data contained within a db4 database.

I'm not trying to argue it does not need to be fixed; I'm trying to
say that performance penalty in unusual case may be ok.

> > So what about...
> > 
> > a) flush L2 on context switch
> 
> If you go to that extent, the system will probably perform better with
> the L2 cache permanently disabled.

Are you sure? Context switches are not that common (3 times a second
in number-crunching cases?) and L2 cache should help performance quite
a lot. 

> > b) disable L2 when thread has maps one physical address twice
> 
> Due to the way the L2 cache works, you have to disable L2 and flush it
> when switching to the thread, and re-enable L2 when you switch away.
> Merely flushing it when switching away won't work.
> 
> In order to disable or enable the L2 cache, the L1 cache must be
> flushed and disabled - and that would have to be done with all IRQs
> (including FIQs) disabled to ensure that its done atomically.
> 
> I don't think this is a sane option.

Well, it sounds slow and it will not be easy to implement. It really
depends how much L2 cache helps on those systems. (I'd guess PC with
L2 disabled would run at half a speed. If performance penalty for L2
disabled is similar on those systems, extra complexity may be worth
it.)

So I guess someone with affected system needs to do some benchmarking.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
