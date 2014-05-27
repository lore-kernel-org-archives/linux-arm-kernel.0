From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 27 May 2014 14:37:45 +0200
Subject: [PATCH RFCv2 1/5] ARM: use write allocate by default on ARMv6+
In-Reply-To: <20140527121806.GF3693@n2100.arm.linux.org.uk>
References: <1400600105-3013-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1400600105-3013-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140526162643.GB3693@n2100.arm.linux.org.uk>
 <20140527111542.6a49833f@free-electrons.com>
 <20140527094749.GE3693@n2100.arm.linux.org.uk>
 <20140527135216.7eaf3b3f@free-electrons.com>
 <20140527121806.GF3693@n2100.arm.linux.org.uk>
Message-ID: <20140527143745.386c77d9@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Tue, 27 May 2014 13:18:06 +0100, Russell King - ARM Linux wrote:

> > > whether "any other master" is another CPU or a device.  So, SMP is
> > > just a specific case of the general case, and we should treat the
> > > selection of this as per the generic case.
> > 
> > Right. However, remember that I have to support hardware I/O coherency
> > on processors for which is_smp() returns false, even when CONFIG_SMP=y
> > and CONFIG_SMP_ON_UP=y. The Armada 370 is in this case.
> 
> If is_smp() returns false, that is because CONFIG_SMP was not defined.

No: on CONFIG_SMP=y and CONFIG_SMP_ON_UP=y, the value returned by
is_smp() depends on whether the code in arch/arm/kernel/head.S believes
the processor is a multi-core processor or not. It looks at the MPIDR,
if it's a Cortex-A9 it also looks at the SCU to see how much cores it
advertises. On Armada 370, this test concludes that the processor is
*not* SMP, and therefore even with CONFIG_SMP=y and CONFIG_SMP_ON_UP=y,
is_smp() returns false.

The current code of is_smp() in mainline is:

static inline bool is_smp(void)
{
#ifndef CONFIG_SMP
	return false;
#elif defined(CONFIG_SMP_ON_UP)
	extern unsigned int smp_on_up;
	return !!smp_on_up;
#else
	return true;
#endif
}

So if you have CONFIG_SMP and CONFIG_SMP_ON_UP, the value returned by
is_smp() is the value of smp_on_up, which is decided by the code in
arch/arm/kernel/head.S as decided above.

Also, remember that the problem is a bit more complicated than is_smp()
returning true or false:

 * For Armada 370 (which is single core and seen as UP according to the
   test in arch/arm/kernel/head.S), I want write-allocate policy but
   *NOT* the shareable pages.

 * For Armada 380 (which is single core), I want write-allocate policy
   *AND* the shareable pages.

> In patch 3, you turn this into something which follows smp_on_up when
> SMP_ON_UP is enabled.

Right.

> smp_on_up is true when we have the (currently)
> SMP case instructions in place, rather than the UP case.

If by SMP case instructions you mean ALT_SMP() vs. ALT_UP(), then yes.

> Since you need the SMP case instructions for hardware coherency, the
> effect of patch 3 is that smp_on_up will be true for hardware coherency
> as well.  Hence, is_smp() *will* return true for hardware coherency.

Not for Armada 370, see explanation above.

> So your above statement is wrong with patch 3 applied, and this nicely
> illustrates why this "simple" solution is a problem - we end up with a
> load of things which _appear_ to be only for SMP which *unexpectedly*
> end up being enabled for hardware coherency.

Indeed: the solution of making is_smp() return true for !CONFIG_SMP
configurations is also one of the potential direction that emerged from
the discussion around PATCH RFCv1 of this series.

> > > > > You break this by allowing SMP to specify writeback read-allocate.
> > > > 
> > > > I am certainly not very familiar with the code in mm/mmu.c, but I'm
> > > > not sure to see why I allow SMP to specify writeback read-allocate.
> > > > What the code does is:
> > > 
> > > @@ -408,14 +408,14 @@ static void __init build_mem_type_table(void)
> > >                 if (cachepolicy > CPOLICY_WRITETHROUGH)
> > >                         cachepolicy = CPOLICY_WRITETHROUGH;
> > >  #endif
> > > +               if (cachepolicy > CPOLICY_WRITEBACK)
> > > +                       cachepolicy = CPOLICY_WRITEBACK;
> > >         }
> > > 
> > > and the rest of this hunk.
> > 
> > If specific hunk is inside a:
> > 
> > 	if (cpu_arch < CPU_ARCH_ARMv6) {
> > 
> > and as far as I'm aware, there are no ARMv5 or earlier platforms that
> > are SMP-capable. Are there any?
> 
> First, I said in one of my previous messages, there *are* ARMv5 which
> *do* support write-allocate, so this line *imposes* a *new* restriction
> that we no longer support write-allocate on ARMv5.  So the above quote
> is a problem there.

Right, understood.

> Second, I said "and the rest of this hunk" which is where you remove the
> is_smp() test.

Ok.

> > > >  * In early_cachepolicy(), if a specific cachepolicy= argument is
> > > >    passed to the kernel, we use it, except for >= ARMv6, where
> > > >    CPOLICY_WRITEALLOC is forced.
> > > 
> > > What if you want to run ARMv6 UP (non-coherent) in read-allocate mode
> > > (which is the way it is today?)
> > 
> > That's indeed no longer possible with my patch, but we could allow
> > that with a default on write-allocate, but a possibility of using
> > cachepolicy=writeback to get back the previous default cache policy.
> > Would that work for you?
> 
> There's the problem that the initial page table setup (done by the
> assembly code) must match the page table setup done later in C as far
> as these attributes go, so it's not that easy.

Indeed, that's the main problem here. Once we are in C code, it's a lot
easier to do platform-specific stuff.

> I think if we make the is_smp() thing be a is_hw_coherency() thing, and
> turn the SMP_ON_UP thing to be ARM_HW_COHERENCY (or make ARM_HW_COHERENCY
> a subset of it) then we can address this case in a more maintainable way.

How do we address the problem that Armada 370 has different
requirements than the other I/O coherency SoC ? In RFC PATCHv2, it was
solved by having:

 * Armada 370 needs only write-allocate and does not work with
   shareable pages. Since write-allocate was becoming the default for
   ARMv6+, this requirement was met. And since Armada 370 is recognized
   as non-SMP by the SMP_ON_UP, is_smp() continues to return false, and
   shareable pages are not used.

 * Armada XP/375/38x need both write-allocate and shareable pages.
   Write-allocate is coming from the fact that i was becoming the
   default for ARMv6+. The shareable pages were coming from the fact
   that is_smp() returns true when SMP_ON_UP is enabled.

As you can see, and as I highlighted above, it's not a simple as a
is_hw_coherent() thing: Armada 370 is I/O coherent, but does not want
many of the properties of SMP-capable systems such as shareable pages.

Suggestions?

Thanks,

Thomas Petazzoni
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
