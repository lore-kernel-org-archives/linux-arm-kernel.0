From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 May 2015 16:50:04 +0100
Subject: [PATCH 5/6] ARM: re-implement physical address space switching
In-Reply-To: <20150506153337.GA2974@leverpostej>
References: <20150408173656.GF5977@leverpostej>
 <20150408175533.GN12732@n2100.arm.linux.org.uk>
 <552C14F0.7020006@oracle.com> <20150415120738.GD2866@leverpostej>
 <552E9F9B.2040400@oracle.com> <20150423112449.GB17361@leverpostej>
 <20150506101850.GE2067@n2100.arm.linux.org.uk>
 <20150506103736.GA707@leverpostej>
 <20150506113313.GS2067@n2100.arm.linux.org.uk>
 <20150506153337.GA2974@leverpostej>
Message-ID: <20150506155004.GW2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 06, 2015 at 04:33:38PM +0100, Mark Rutland wrote:
> On Wed, May 06, 2015 at 12:33:13PM +0100, Russell King - ARM Linux wrote:
> > On Wed, May 06, 2015 at 11:37:37AM +0100, Mark Rutland wrote:
> > > Hi Russell,
> > > 
> > > > > It turns out that I was incorrect in my assertion, and the reordering I
> > > > > suggested above can't happen. The ARMv7 ARM states:
> > > > > 
> > > > > 	Any direct write to a system control register is guaranteed not
> > > > > 	to affect any instruction that appears, in program
> > > > > 	order, before the instruction that performed the direct write
> > > > > 
> > > > > Which means that the STMFD cannot be affected by the later cp15 write to
> > > > > the SCTLR, and so the DSB does not need to be moved before the MCR.
> > > > > 
> > > > > I apologise for adding to the confusion there.
> > > > 
> > > > So does this mean this patch gets an ack now?
> > > 
> > > I assumed there was going to be a respin for the CR_W change?
> > > 
> > > There's also the dodginess w.r.t. the page table walkers that I can't
> > > see is solvable short of disabling the MMU prior to the flush, though I
> > > understand you've NAKed that approach.
> > 
> > Why? 
> 
> I was on about the pre-assembly portion:
> 
> 	cr = get_cr();
> 	set_cr(cr & ~(CR_I | CR_C | CR_W));
> 	flush_cache_all();
> 
> With the MMU on at this point the page table walkers can race with the
> set/way maintenance. It also relies on the compiler not making stack
> accesses between the SCTLR write and the completion of flush_cache_all,
> which is likely but not guranteed.

Yes, I suppose you're right, but there's really no other way to do
this other than coding up CPU specific code.

What we'd need to do is to code up a specific assembly routine which
disables the I and C control register flags, flushes the cache, jumps
to the physical alias and then disables the MMU all without touching
memory.  That's far too much effort.  Like I say, maybe we should just
bin Keystone for this crap...

I'm not interested in trying to "fix" this code any further - as I
said earlier, it took quite a while to get this code working on
Keystone, which is really all we care about.  Anyone else who copies
the abortion that TI made in Keystone should be shot. :)

While the community has the luxury of saying "we don't like it, it's
TI's problem" - which is what was done when the problems were first
pointed out by Will, the net result is that this problem became my
problem to try and sort out.

So, if you have a better idea how to fix this, I'm all ears.

What I'm certain of though is that this is an improvement over what's
in the kernel today, and so should go in irrespective of whether it's
totally bullet-proof or not.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
