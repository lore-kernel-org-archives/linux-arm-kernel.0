From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Dec 2009 21:57:13 +0000
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <alpine.LFD.2.00.0912181556270.28241@xanadu.home>
References: <cabda6420912140948t23c07676tb5f44eb4febbc584@mail.gmail.com>
	<alpine.LFD.2.00.0912141503360.23173@xanadu.home>
	<c70ff3ad0912142350v2231938dqc9c0aedc214120bd@mail.gmail.com>
	<cabda6420912150301n2c1a54d6ta7407d89f4d0f9cf@mail.gmail.com>
	<20091215171440.GA15855@n2100.arm.linux.org.uk>
	<cabda6420912160835k714b9de4m7c647da97055f91b@mail.gmail.com>
	<cabda6420912160938m6ea11da5t947c2bf082c430b7@mail.gmail.com>
	<alpine.LFD.2.00.0912181517120.28241@xanadu.home>
	<20091218204455.GK5527@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0912181556270.28241@xanadu.home>
Message-ID: <20091218215713.GL5527@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2009 at 04:23:30PM -0500, Nicolas Pitre wrote:
> On Fri, 18 Dec 2009, Russell King - ARM Linux wrote:
> 
> > On Fri, Dec 18, 2009 at 03:22:34PM -0500, Nicolas Pitre wrote:
> > > Could you please repost your patch, adding CONFIG_CPU_CACHE_VIVT to the 
> > > conditional code flushing the L2 cache in flush_dcache_page()?
> > 
> > No, that's not sufficient as I pointed out earlier.  We really do not
> > want to be doing the L2 cache stuff on things which aren't Feroceon
> > until it's shown that others are affected.
> 
> Aren't we saying the same thing?

Not quite.  You're saying "all VIVT + outer cache will have this fix".
I'm saying "those which have the problem should have the fix".

I believe treating them as being the same is not the right approach.
At the moment, they're the same group of processors, but that doesn't
mean it stays that way, and should it change, finding such hidden
conditions isn't going to be easy.

So I'd like to see something other than CONFIG_CPU_CACHE_VIVT+
CONFIG_OUTER_CACHE in the code - instead, make a new config symbol
which is enabled when both are currently selected, and put a useful
help text with it so people understand what its about.

> > The other annoying thing is that it's touching the same area of code
> > which is currently broken with highpte - and I have changes in the
> > pipeline for fixing that.
> 
> That's a valid concern.  In which case I'd suggest that Christian waits 
> until your changes are visible somewhere for him to rebase his patch on 
> top and retest it before reposting.  The current patch (with my 
> suggested modification) might be worth considering for linux-stable 
> nevertheless.

It'll be a while before my patches are ready - they touch every other
architecture in the kernel because we need access to the kmapped page
table to modify the PTE...

http://ftp.arm.linux.org.uk/git/gitweb.cgi?p=linux-2.6-arm.git;a=shortlog;h=refs/heads/umc

GIT:
http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-2.6-arm.git umc

(or something like that.)
