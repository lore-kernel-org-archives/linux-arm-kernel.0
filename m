From: murzin.v@gmail.com (Vladimir Murzin)
Date: Fri, 22 Feb 2013 20:46:13 +0400
Subject: [PATCH] arm: add check for global exclusive monitor
In-Reply-To: <20130220105957.GV17833@n2100.arm.linux.org.uk>
References: <1361204810-5335-1-git-send-email-murzin.v@gmail.com>
 <20130218164420.GT17833@n2100.arm.linux.org.uk>
 <20130219105534.GA31156@murzin.rnd.samsung.ru>
 <CABV+yWu10D_6QWb3ShJLsxdBtf0=8mM3Lpt6Y2gZfYHwgbq23g@mail.gmail.com>
 <20130220105957.GV17833@n2100.arm.linux.org.uk>
Message-ID: <20130222164608.GA4802@pinguin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 20, 2013 at 10:59:57AM +0000, Russell King - ARM Linux wrote:
> On Wed, Feb 20, 2013 at 08:55:34AM +0400, Vladimir Murzin wrote:
> > Thanks for review Russel!
> > 
> > On Mon, Feb 18, 2013 at 04:44:20PM +0000, Russell King - ARM Linux wrote:
> > > On Mon, Feb 18, 2013 at 08:26:50PM +0400, Vladimir Murzin wrote:
> > > > +void __init check_gmonitor_bugs(void)
> > > > +{
> > > > +   struct page *page;
> > > > +   const char *reason;
> > > > +   unsigned long res = 1;
> > > > +
> > > > +   printk(KERN_INFO "CPU: Testing for global monitor: ");
> > > > +
> > > > +   page = alloc_page(GFP_KERNEL);
> > > > +   if (page) {
> > > > +           unsigned long *p;
> > > > +           pgprot_t prot = __pgprot_modify(PAGE_KERNEL,
> > > > +                                   L_PTE_MT_MASK, L_PTE_MT_UNCACHED);
> > > > +
> > > > +           p = vmap(&page, 1, VM_IOREMAP, prot);
> > >
> > > This is bad practise.  Remapping a page of already mapped kernel memory
> > > using different attributes (in this case, strongly ordered) is _definitely_
> > > a violation of the architecture requirements.  The behaviour you will see
> > > from this are in no way guaranteed.
> > DDI0406C_arm_architecture_reference_manual.pdf (A3-131) says:
> > 
> > A memory location can be marked as having different cacheability
> > attributes, for example when using aliases in a
> > virtual to physical address mapping:
> > * if the attributes differ only in the cache allocation hint this does
> >   not affect the behavior of accesses to that location
> > * for other cases see Mismatched memory attributes on page A3-136.
> > 
> > Isn't L_PTE_MT_UNCACHED about cache allocation hint?
> 
> No.  I've told you above what this gets you.
> 
> > > If you want to do this, it must either come from highmem, or not already
> > > be mapped.
> > >
> > > Moreover, this is absolutely silly - the ARM ARM says:
> > >
> > > "LDREX and STREX operations *must* be performed only on memory with the
> > >  Normal memory attribute."
> > 
> > DDI0406C_arm_architecture_reference_manual.pdf (A3-121) says:
> > 
> > It is IMPLEMENTATION DEFINED whether LDREX and STREX operations can be
> > performed to a memory region with the Device or Strongly-ordered
> > memory attribute. Unless the implementation documentation explicitly
> > states that LDREX and STREX operations to a memory region with the
> > Device or Strongly-ordered attribute are permitted, the effect of such
> > operations is UNPREDICTABLE.
> > 
> > At least it allows to perform operations on memory region with the
> > Strongly-ordered attribute... but still unpredictable.
> 
> And "unpredictable" means that you can't rely on *any* aspect of its
> behaviour.  You can't test for its behaviour and then rely on the
> result of that test telling you how it will behave in future.
> 
> Even if a "ldrex/strex" sequence to a strongly-ordered region succeeds
> or fails, that's no guarantee with "unpredictable" that it will have
> that behaviour next time.
> 
> > > L_PTE_MT_UNCACHED doesn't get you that.  As I say above, that gets you
> > > strongly ordered memory, not "normal memory" as required by the
> > > architecture for use with exclusive types.
> > >
> > > > +
> > > > +           if (p) {
> > > > +                   int temp;
> > > > +
> > > > +                   __asm__ __volatile__(                   \
> > > > +                           "ldrex   %1, [%2]\n"            \
> > > > +                           "strex   %0, %1, [%2]"          \
> > > > +                           : "=&r" (res), "=&r" (temp)     \
> > > > +                           : "r" (p)                       \
> > >
> > > \ character not required for any of the above.  Neither is the __ version
> > > of "asm" and "volatile".
> > Thanks.
> > >
> > > > +                           : "cc", "memory");
> > > > +
> > > > +                           reason = "n\\a (atomic ops may be faulty)";
> > >
> > > "n\\a" ?
> > "not detected"?
> > > So... at the moment this has me wondering - you're testing atomic
> > > operations with a strongly ordered memory region, which ARM already
> > > define this to be outside of the architecture spec.  The behaviour you
> > > see is not defined architecturally.
> > >
> > > And if you're trying to use LDREX/STREX to a strongly ordered or device
> > > memory region, then you're quite right that it'll be unreliable.  It's
> > > not defined to even work.  That's not because they're faulty, it's because
> > > you're abusing them.
> > However, IRL it is not hard to meet this undefined difference. At
> > least I'm able to see it on Tegra2 Harmony and Pandaboard. Moreover,
> > demand on Normal memory attribute breaks up ability to turn caches
> > off. In this case we are not able to boot the system up (seen on
> > Tegra2 harmony). This patch is aimed to highlight the difference in
> > implementation. That's why it has some softering in guessing about
> > faulty. Might be it worth warning about unpredictable effect instead?
> 
> You're soo busy quoting bits of architecture manual back at me that you
> can't see your own errors - errors which I've pointed out already.
> 
> "normal memory" != "uncached".  Normal memory can be uncacheable.
> Asking the kernel for L_PTE_MT_BUFFERABLE will give you "normal memory,
> uncached".

Sorry for delay.

Thanks for pointing the error. It was bad idea to make assumption
about attribute based on the name. I shoul have checked them first.

I'll update the patch soon.

Best wishes
Vladimir
