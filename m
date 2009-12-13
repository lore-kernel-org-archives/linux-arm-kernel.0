From: rshitrit@marvell.com (Ronen Shitrit)
Date: Sun, 13 Dec 2009 17:42:54 +0200
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <20091213120615.GB10698@n2100.arm.linux.org.uk>
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
	<20091213120615.GB10698@n2100.arm.linux.org.uk>
Message-ID: <309002C0DA137042828828FC53D7A9347E2630EFF3@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is another possible solution we are looking into:
1) Force all NC writes to go through L2: 
If there is a hit in the L2, the write will update the L2 together with the DRAM.
If there is a miss, the write will continue to the DRAM only.
2) Force all NC reads to wait till L2 write buffer is drained, to avoid any racing with above...
3) Set L2 in WT mode.

I still can't determine if this solution is valid from HW point of view, but I will really appreciate any comment on this.
Any thoughts? Any pitfalls this solution is missing?

Thanks

-----Original Message-----
From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] 
Sent: Sunday, December 13, 2009 2:06 PM
To: Ronen Shitrit
Cc: hs at denx.de; saeed bishara; linux-arm-kernel at lists.infradead.org; Nicolas Pitre
Subject: Re: shared memory problem on ARM v5TE using threads

On Sun, Dec 13, 2009 at 12:00:33PM +0000, Russell King - ARM Linux wrote:
> I'm afraid to say that the only solution I can see to this problem is to
> disable the L2 cache outright on these CPUs - the choice seems to be
> between correct system behaviour and lower performance, or performance
> but buggy system behaviour in certain cases leading to data corruption.

BTW, if no one can come up with a solution for this, we need to consider
making the kernel by default disable L2 cache on Feroceon, and display a
warning message if L2 is to be enabled.

We really can not have a known data corrupting issue like this exist
silently in the system - it's not fair for users nor developers to waste
time trying to work out why their data is being corrupted.
