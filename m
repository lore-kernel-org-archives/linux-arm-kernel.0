From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 18 Dec 2009 16:23:30 -0500 (EST)
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <20091218204455.GK5527@n2100.arm.linux.org.uk>
References: <cabda6420912140513k40a998b7k8cf56c35cc535cfb@mail.gmail.com>
	<309002C0DA137042828828FC53D7A9347E2630F364@IL-MB01.marvell.com>
	<cabda6420912140948t23c07676tb5f44eb4febbc584@mail.gmail.com>
	<alpine.LFD.2.00.0912141503360.23173@xanadu.home>
	<c70ff3ad0912142350v2231938dqc9c0aedc214120bd@mail.gmail.com>
	<cabda6420912150301n2c1a54d6ta7407d89f4d0f9cf@mail.gmail.com>
	<20091215171440.GA15855@n2100.arm.linux.org.uk>
	<cabda6420912160835k714b9de4m7c647da97055f91b@mail.gmail.com>
	<cabda6420912160938m6ea11da5t947c2bf082c430b7@mail.gmail.com>
	<alpine.LFD.2.00.0912181517120.28241@xanadu.home>
	<20091218204455.GK5527@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.0912181556270.28241@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Dec 2009, Russell King - ARM Linux wrote:

> On Fri, Dec 18, 2009 at 03:22:34PM -0500, Nicolas Pitre wrote:
> > Could you please repost your patch, adding CONFIG_CPU_CACHE_VIVT to the 
> > conditional code flushing the L2 cache in flush_dcache_page()?
> 
> No, that's not sufficient as I pointed out earlier.  We really do not
> want to be doing the L2 cache stuff on things which aren't Feroceon
> until it's shown that others are affected.

Aren't we saying the same thing?

As I said earlier already, this is concerning only L2 equipped VIVT 
processor models.  There are very few of those in existence, namely some 
Feroceons and XSC3s.

On both Feroceon and XSC3, there used to be some issues with DB4 when 
creating two shared writable mappings in the same process.  This was 
fixed in commit 08e445bd.  Both processors used to fail and both were 
happy with the change.  And according to the tests I've made and the 
conclusion I've consigned in that commit, none of those processors could 
support L1 uncacheable L2 cacheable.

This didn't cover all cases but we apparently have a solution for those 
now. So by surrounding the code with #if defined(CONFIG_CPU_CACHE_VIVT) 
&& defined(CONFIG_OUTER_CACHE) we actually affect only the same 
processor models i.e. Feroceon (proven to need it) and XSC3 (unproven).

So, even if XSC3 is included while it might potentially not need it, I'd 
cover it anyway given past track records with similar issues to be on 
the safe side, at least until someone with the hardware is able to 
confirm the fix is not needed there (and I doubt it will ever happen).  
We're talking about some seriously rare occurrences anyway, so this is 
not like if this would impose a significant useless performance killing 
overhead on an XSC3.

> The other annoying thing is that it's touching the same area of code
> which is currently broken with highpte - and I have changes in the
> pipeline for fixing that.

That's a valid concern.  In which case I'd suggest that Christian waits 
until your changes are visible somewhere for him to rebase his patch on 
top and retest it before reposting.  The current patch (with my 
suggested modification) might be worth considering for linux-stable 
nevertheless.


Nicolas
