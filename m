From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Dec 2009 17:17:31 +0000
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <alpine.LFD.2.00.0912071048030.31174@xanadu.home>
References: <4B196473.2040407@denx.de>
	<309002C0DA137042828828FC53D7A9347E212D1152@IL-MB01.marvell.com>
	<20091206141601.GB28932@n2100.arm.linux.org.uk>
	<c70ff3ad0912070331y751900dbj62847dddb8521f4d@mail.gmail.com>
	<20091207114218.GA19348@n2100.arm.linux.org.uk>
	<4B1CF3ED.9080307@denx.de>
	<309002C0DA137042828828FC53D7A9347E212D150D@IL-MB01.marvell.com>
	<20091207145235.GD19348@n2100.arm.linux.org.uk>
	<20091207154019.GA26821@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0912071048030.31174@xanadu.home>
Message-ID: <20091207171731.GC26821@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2009 at 10:57:00AM -0500, Nicolas Pitre wrote:
> Last time I checked the Feroceon doc, there was no way to have inner 
> non-cacheable outer write-back behavior.  And as I mentioned in my 
> previous email, while debugging the issue on an XSC3, the TEX=111 CB=00 
> combination didn't appear to behave as expected (no one bothered to 
> verify my findings at the time either).

Probably because either no one cared or no one had the hardware to be
able to check.

> So I concluded that there is no 
> such thing as inner non-cacheable outer write-back on ARMv5.  This was 
> consigned in commit 08e445bd6a.

Well, there is no such thing as L2 cache on ARMv5 architecture.  L2 cache
is present on Xscale3 and Feroceon purely as a CPU vendor addition.

On Xscale3, it was extended to have the TEX bits in the page table.
However, Feroceon, being an independently designed CPU, appears to have
L2 cache but without the TEX bits - which gives us less options to solve
this issue.

However, I don't think tricks like making all shared writable mappings
uncacheable is going to fix it either as I mentioned in my previous
message.

Consider the effect of that kind of fix: take for instance a SHM mapping
between the X server and a client for transferring bitmap data (eg,
mplayer).  Do we really want it marked non-cacheable?  I think you can
say goodbye to video playback on these platforms.
