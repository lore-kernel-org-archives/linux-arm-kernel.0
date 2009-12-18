From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Dec 2009 19:16:26 +0000
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <20091218184518.GE1470@ucw.cz>
References: <4B1CF3ED.9080307@denx.de>
	<309002C0DA137042828828FC53D7A9347E212D150D@IL-MB01.marvell.com>
	<20091207145235.GD19348@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0912071027480.31174@xanadu.home>
	<20091207170546.GB26821@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0912071219100.31174@xanadu.home>
	<20091207175608.GE26821@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A9347E2630EEC2@IL-MB01.marvell.com>
	<20091213120033.GA10698@n2100.arm.linux.org.uk>
	<20091218184518.GE1470@ucw.cz>
Message-ID: <20091218191626.GG5527@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2009 at 07:45:19PM +0100, Pavel Machek wrote:
> But that's pretty unusual situation, right?

It may be uncommon, but it's something that must work - not only is it
a quality of implementation issue, but its also a data corruption issue.
Get it wrong and you silently corrupt files on your filesystems.

As I've said earlier in the thread, we know that db4 does this.  Not
fixing this means that we really don't care about any program which
uses db4, or data contained within a db4 database.

> So what about...
> 
> a) flush L2 on context switch

If you go to that extent, the system will probably perform better with
the L2 cache permanently disabled.

> b) disable L2 when thread has maps one physical address twice

Due to the way the L2 cache works, you have to disable L2 and flush it
when switching to the thread, and re-enable L2 when you switch away.
Merely flushing it when switching away won't work.

In order to disable or enable the L2 cache, the L1 cache must be
flushed and disabled - and that would have to be done with all IRQs
(including FIQs) disabled to ensure that its done atomically.

I don't think this is a sane option.
