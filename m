From: rshitrit@marvell.com (Ronen Shitrit)
Date: Mon, 7 Dec 2009 09:54:45 +0200
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <20091206141601.GB28932@n2100.arm.linux.org.uk>
References: <4B18F141.7070101@denx.de>
	<20091204131307.GE15887@n2100.arm.linux.org.uk>
	<4B1911B4.7080907@denx.de>
	<20091204154231.GB20386@n2100.arm.linux.org.uk>
	<4B1931B3.90301@denx.de>
	<20091204163850.GC20386@n2100.arm.linux.org.uk>
	<4B194C8B.7070505@denx.de>
	<20091204191349.GG20386@n2100.arm.linux.org.uk>
	<4B196473.2040407@denx.de>
	<309002C0DA137042828828FC53D7A9347E212D1152@IL-MB01.marvell.com>
	<20091206141601.GB28932@n2100.arm.linux.org.uk>
Message-ID: <309002C0DA137042828828FC53D7A9347E212D1338@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just run the test on kernel 2.6.31 and reproduce the failure, 
I will look into it and update...

Regards

-----Original Message-----
From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] 
Sent: Sunday, December 06, 2009 4:16 PM
To: Ronen Shitrit
Cc: hs at denx.de; linux-arm-kernel at lists.infradead.org
Subject: Re: shared memory problem on ARM v5TE using threads

On Sun, Dec 06, 2009 at 03:53:48PM +0200, Ronen Shitrit wrote:
> There isn't any known issues related to working with C=0 B=1 on Kirkwood.
> Can you pls run this test on some other ARMv5 platform and approve it is
> working.

I ran it on an ARM926EJ-S, which is ARMv5 and worked fine.

If there's no problem with C=0 B=1 mappings on Kirkwood, I've no idea
what's going on, and I don't have any suggestion on what to try next.

The log shows that the kernel is doing the right thing: when we detect
two mappings for the same page in the same MM space, we clean and
invalidate any existing cacheable mappings visible in the MM space
(both L1 and L2), and switch all visible mappings to C=0 B=1 mappings.
This makes the area non-cacheable.

That means updates to the area should be visible via any mapping in the
same MM space as soon as they're written to any other mapping.

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of Heiko Schocher
> Sent: Friday, December 04, 2009 9:35 PM
> To: Russell King - ARM Linux
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: shared memory problem on ARM v5TE using threads
> 
> Hello Russell King,
> 
> Russell King - ARM Linux wrote:
> > Well, the kernel messages of relevance from the dump are:
> > 
> > shmtest2:351: c7220140 c72179c0 0 41170000 64a1
> > shmtest2:351: vma c7217968 addr 40961000 pte 064a13cf
> > shmtest2:351: modified 064a13c7
> > shmtest2:351: aliases 1
> > shmtest2:351: vma c72179c0 addr 41170000 pte 064a13cf
> > shmtest2:351: modified 064a13c7

The above is the result of the second mapping of the same physical page
occuring in the current MM space: we switch the mappings at 0x40961000
and 0x41170000 virtual to C=0 B=1 mode.

> > shmtest2:352: c7220140 c7217548 0 4197f000 64a1
> > shmtest2:352: vma c7217968 addr 40961000 pte 064a13c7
> > shmtest2:352: vma c72179c0 addr 41170000 pte 064a13c7
> > shmtest2:352: aliases 2
> > shmtest2:352: vma c7217548 addr 4197f000 pte 064a13cf
> > shmtest2:352: modified 064a13c7

We detect a third mapping, and the previous two mappings are already C=0
B=1 mode, so there's no need to touch them.  The new mapping at 0x4197f000
is modified to C=0 B=1 mode.

> > shmtest2:354: c7220140 c7217650 0 4218e000 64a1
> > shmtest2:354: vma c7217968 addr 40961000 pte 064a13c7
> > shmtest2:354: vma c72179c0 addr 41170000 pte 064a13c7
> > shmtest2:354: vma c7217548 addr 4197f000 pte 064a13c7
> > shmtest2:354: aliases 3
> > shmtest2:354: vma c7217650 addr 4218e000 pte 064a13cf
> > shmtest2:354: modified 064a13c7

And here is the forth mapping, and the previous two mappings are already
C=0 B=1 mode, so there's no need to touch them.  The new mapping at
0x4218e000 is modified to C=0 B=1 mode.
