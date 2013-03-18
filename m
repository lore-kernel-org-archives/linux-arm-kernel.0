From: pavel@denx.de (Pavel Machek)
Date: Mon, 18 Mar 2013 15:24:32 +0100
Subject: [PATCHv1 0/2] ARM: socfpga: Soft reset, hotplug and device
 tree clocks
In-Reply-To: <51471046.1010102@gmail.com>
References: <1363211722-27237-1-git-send-email-dinguyen@altera.com>
 <5141220A.7050008@gmail.com>
 <20130317181343.GB4394@amd.pavel.ucw.cz>
 <51471046.1010102@gmail.com>
Message-ID: <20130318142432.GA4110@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >>> Just 2 patches for mach-socfpga:
> >>>
> >>> 0001: ARM: socfpga: Enable hotplug and soft reset
> >>> 	- Able to hotplug CPU1 by putting it into reset and bringing back online.
> >>>
> >>
> >> Have you seen the discussion on PSCI? There's an ARM doc on it and
> >> Linaro session from last week. Is there a possibility you can use that?
> >> You would need to be able to run in non-secure mode and implement
> >> smc calls.
> > 
> > What would be the advantage?
> 
> It gets rid of some platform code. If you do an A15 part, it abstracts
> out the differences between the cores on entering/exiting coherency. It
> should also save you from writing suspend/resume and cpuidle support for
> your platform.

I don't see how PSCI would be useful at this point. Clock framework is
needed for basic MMC and Ethernet support; PSCI would not help there. 

> > We do not have suitable hypervisor at the moment. Nor I see why it
> > would be good to push power management into it.
> 
> It's not a hypervisor. A minimal implementation is only about 100 lines
> of assembly.

So... we could reduce some complexity of the kernel by inventing
another component, inventing API, and putting the complex code into
the newly invented component... when no other arm32 architecture does
that. (Where would you put the 100 lines? u-boot?)

> > (Plus, the implementation seems pretty incomplete for arm32.).
> 
> That's the point. The linux side is simple. The secure monitor side is
> also simplified somewhat. When you enter secure monitor mode, you are
> automatically running with the cache and mmu off. This avoids the side
> effects of cache allocations while trying to flush the caches.

This is clock framework. It does not touch any caches, and does not
have problems with MMU. Even if we would implement PSCI in future,
this code would stay the same AFAICT.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
