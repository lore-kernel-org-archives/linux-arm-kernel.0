From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 6 May 2015 17:14:06 +0100
Subject: [PATCH 5/6] ARM: re-implement physical address space switching
In-Reply-To: <20150506155004.GW2067@n2100.arm.linux.org.uk>
References: <20150408175533.GN12732@n2100.arm.linux.org.uk>
 <552C14F0.7020006@oracle.com> <20150415120738.GD2866@leverpostej>
 <552E9F9B.2040400@oracle.com> <20150423112449.GB17361@leverpostej>
 <20150506101850.GE2067@n2100.arm.linux.org.uk>
 <20150506103736.GA707@leverpostej>
 <20150506113313.GS2067@n2100.arm.linux.org.uk>
 <20150506153337.GA2974@leverpostej>
 <20150506155004.GW2067@n2100.arm.linux.org.uk>
Message-ID: <20150506161406.GC2974@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> > 	cr = get_cr();
> > 	set_cr(cr & ~(CR_I | CR_C | CR_W));
> > 	flush_cache_all();
> > 
> > With the MMU on at this point the page table walkers can race with the
> > set/way maintenance. It also relies on the compiler not making stack
> > accesses between the SCTLR write and the completion of flush_cache_all,
> > which is likely but not guranteed.
> 
> Yes, I suppose you're right, but there's really no other way to do
> this other than coding up CPU specific code.
> 
> What we'd need to do is to code up a specific assembly routine which
> disables the I and C control register flags, flushes the cache, jumps
> to the physical alias and then disables the MMU all without touching
> memory.  That's far too much effort.  Like I say, maybe we should just
> bin Keystone for this crap...
> 
> I'm not interested in trying to "fix" this code any further - as I
> said earlier, it took quite a while to get this code working on
> Keystone, which is really all we care about.  Anyone else who copies
> the abortion that TI made in Keystone should be shot. :)
> 
> While the community has the luxury of saying "we don't like it, it's
> TI's problem" - which is what was done when the problems were first
> pointed out by Will, the net result is that this problem became my
> problem to try and sort out.
> 
> So, if you have a better idea how to fix this, I'm all ears.
>
> What I'm certain of though is that this is an improvement over what's
> in the kernel today, and so should go in irrespective of whether it's
> totally bullet-proof or not.

I don't disagree with that. :)

w.r.t. "better" ideas, my initial thought was that we could move the
SCTLR.{C,M} clearing into lpae_pgtables_remap_asm, along with a call to
v7_flush_dcache_all (as it should be in the physical mapping). So long
as the kernel text was initially clean to the PoC I'd expect that to
work, but I understood from your initial reply you'd tried that and
something went wrong.

Perhaps we can look into that later.

Thanks,
Mark.
