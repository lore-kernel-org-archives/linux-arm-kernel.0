From: michael@walle.cc (Michael Walle)
Date: Wed, 14 Dec 2011 00:17:49 +0100
Subject: arm and patch phys offset
In-Reply-To: <alpine.LFD.2.02.1112122256580.2907@xanadu.home>
References: <201112112255.32534.michael@walle.cc>
 <201112130108.25337.michael@walle.cc>
 <alpine.LFD.2.02.1112122256580.2907@xanadu.home>
Message-ID: <201112140017.49567.michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag 13 Dezember 2011, 05:01:30 schrieb Nicolas Pitre:
> > Seems like the l2 cache is enabled after uboot starts the linux kernel.
> > I'll dig deeper into that tomorrow.
> > 
> > For now, i appended
> > 
> >   l2_cache_disable();
> > 
> > to uboots cleanup_before_linux() and all stubs seems to be patched
> > correctly.
> 
> Strange.  Having l2 enabled shouldn't cause such trouble.
There is a similar commit in uboots git tree:
http://git.denx.de/?p=u-
boot.git;a=commit;h=dc7100f4080952798413fb63bb4134b22c57623a

I don't know if this is somehow connected to my problem ;)

> > But i don't know if that is correct way of disabling the cache.
> 
> I don't remember the details, but I wouldn't think it is that simple.
> The Kirkwood manual would tell you.  It is publicly available.
Unfortunately the Functional Specification doesn't mention anything about l2 
caches. It references 'Unified Layer 2 (L2) Cache for Sheeva? CPU Cores 
Addendum, Doc No. MV-S104858-U0', though, which isn't publicly availble i 
guess.

Just for completeness, i'm now using the following to disable the l2 cache.

l2_cache_disable:
	mrc p15, 1, r0, c15, c1, 0  @ marvell extra features register
	bic r0, r0, #0x00400000     @ disable L2 cache
	mcr p15, 1, r0, c15, c1, 0
	mov pc, lr

Google finds some sourcecode for "marvell extra features register". And there 
is of course arch/arm/mm/cache-feroceon-l2.c.

-- 
Michael
