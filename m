From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 May 2014 13:18:06 +0100
Subject: [PATCH RFCv2 1/5] ARM: use write allocate by default on ARMv6+
In-Reply-To: <20140527135216.7eaf3b3f@free-electrons.com>
References: <1400600105-3013-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1400600105-3013-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140526162643.GB3693@n2100.arm.linux.org.uk>
 <20140527111542.6a49833f@free-electrons.com>
 <20140527094749.GE3693@n2100.arm.linux.org.uk>
 <20140527135216.7eaf3b3f@free-electrons.com>
Message-ID: <20140527121806.GF3693@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 27, 2014 at 01:52:16PM +0200, Thomas Petazzoni wrote:
> Hello Russell,
> 
> On Tue, 27 May 2014 10:47:49 +0100, Russell King - ARM Linux wrote:
> 
> > > Absolutely. Just like it is *required* for hardware I/O coherency on
> > > Marvell Armada platforms, even those that are non-SMP like Armada
> > > 370 or Armada 380.
> > 
> > What this boils down to is this statement:
> > 
> > 	If we require hardware coherency between any other master and
> > 	a CPU, we require the caches to be in write allocate mode.
> > 
> > whether "any other master" is another CPU or a device.  So, SMP is
> > just a specific case of the general case, and we should treat the
> > selection of this as per the generic case.
> 
> Right. However, remember that I have to support hardware I/O coherency
> on processors for which is_smp() returns false, even when CONFIG_SMP=y
> and CONFIG_SMP_ON_UP=y. The Armada 370 is in this case.

If is_smp() returns false, that is because CONFIG_SMP was not defined.
In patch 3, you turn this into something which follows smp_on_up when
SMP_ON_UP is enabled.  smp_on_up is true when we have the (currently)
SMP case instructions in place, rather than the UP case.

Since you need the SMP case instructions for hardware coherency, the
effect of patch 3 is that smp_on_up will be true for hardware coherency
as well.  Hence, is_smp() *will* return true for hardware coherency.

So your above statement is wrong with patch 3 applied, and this nicely
illustrates why this "simple" solution is a problem - we end up with a
load of things which _appear_ to be only for SMP which *unexpectedly*
end up being enabled for hardware coherency.

> > > > You break this by allowing SMP to specify writeback read-allocate.
> > > 
> > > I am certainly not very familiar with the code in mm/mmu.c, but I'm
> > > not sure to see why I allow SMP to specify writeback read-allocate.
> > > What the code does is:
> > 
> > @@ -408,14 +408,14 @@ static void __init build_mem_type_table(void)
> >                 if (cachepolicy > CPOLICY_WRITETHROUGH)
> >                         cachepolicy = CPOLICY_WRITETHROUGH;
> >  #endif
> > +               if (cachepolicy > CPOLICY_WRITEBACK)
> > +                       cachepolicy = CPOLICY_WRITEBACK;
> >         }
> > 
> > and the rest of this hunk.
> 
> If specific hunk is inside a:
> 
> 	if (cpu_arch < CPU_ARCH_ARMv6) {
> 
> and as far as I'm aware, there are no ARMv5 or earlier platforms that
> are SMP-capable. Are there any?

First, I said in one of my previous messages, there *are* ARMv5 which
*do* support write-allocate, so this line *imposes* a *new* restriction
that we no longer support write-allocate on ARMv5.  So the above quote
is a problem there.

Second, I said "and the rest of this hunk" which is where you remove the
is_smp() test.

> > >  * In early_cachepolicy(), if a specific cachepolicy= argument is
> > >    passed to the kernel, we use it, except for >= ARMv6, where
> > >    CPOLICY_WRITEALLOC is forced.
> > 
> > What if you want to run ARMv6 UP (non-coherent) in read-allocate mode
> > (which is the way it is today?)
> 
> That's indeed no longer possible with my patch, but we could allow
> that with a default on write-allocate, but a possibility of using
> cachepolicy=writeback to get back the previous default cache policy.
> Would that work for you?

There's the problem that the initial page table setup (done by the
assembly code) must match the page table setup done later in C as far
as these attributes go, so it's not that easy.

I think if we make the is_smp() thing be a is_hw_coherency() thing, and
turn the SMP_ON_UP thing to be ARM_HW_COHERENCY (or make ARM_HW_COHERENCY
a subset of it) then we can address this case in a more maintainable way.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
