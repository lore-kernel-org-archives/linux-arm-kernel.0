From: murzin.v@gmail.com (Vladimir Murzin)
Date: Wed, 20 Feb 2013 08:55:34 +0400
Subject: [PATCH] arm: add check for global exclusive monitor
In-Reply-To: <20130219105534.GA31156@murzin.rnd.samsung.ru>
References: <1361204810-5335-1-git-send-email-murzin.v@gmail.com>
 <20130218164420.GT17833@n2100.arm.linux.org.uk>
 <20130219105534.GA31156@murzin.rnd.samsung.ru>
Message-ID: <CABV+yWu10D_6QWb3ShJLsxdBtf0=8mM3Lpt6Y2gZfYHwgbq23g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for review Russel!

On Mon, Feb 18, 2013 at 04:44:20PM +0000, Russell King - ARM Linux wrote:
> On Mon, Feb 18, 2013 at 08:26:50PM +0400, Vladimir Murzin wrote:
> > Since ARMv6 new atomic instructions have been introduced:
> > ldrex/strex. Several implementation are possible based on (1) global
> > and local exclusive monitors and (2) local exclusive monitor and snoop
> > unit.
> >
> > In case of the 2nd option exclusive store operation on uncached
> > region may be faulty.
> >
> > Check for availability of the global monitor to provide some hint about
> > possible issues.
>
> How does this code actually do that?

According to DHT0008A_arm_synchronization_primitives.pdf the global
monitor is introduce to track exclusive accesses to sharable memory
regions. This article also says about some system-wide implication
which should be taken into account:
(1) for systems with coherency management
(2) for systems without coherency management

The first one lay on SCU, L1 data cache and local monitor.  The second
one requires implementation of global monitor if memory regions cannot
be cached.

It set up the behaviour for store-exclusive operations when global
monitor is not available: these operations always fail.

Taking all these into account we can guess about availability of global
monitor by using store-exclusive operation on uncached memory region.

>
> > +void __init check_gmonitor_bugs(void)
> > +{
> > +   struct page *page;
> > +   const char *reason;
> > +   unsigned long res = 1;
> > +
> > +   printk(KERN_INFO "CPU: Testing for global monitor: ");
> > +
> > +   page = alloc_page(GFP_KERNEL);
> > +   if (page) {
> > +           unsigned long *p;
> > +           pgprot_t prot = __pgprot_modify(PAGE_KERNEL,
> > +                                   L_PTE_MT_MASK, L_PTE_MT_UNCACHED);
> > +
> > +           p = vmap(&page, 1, VM_IOREMAP, prot);
>
> This is bad practise.  Remapping a page of already mapped kernel memory
> using different attributes (in this case, strongly ordered) is _definitely_
> a violation of the architecture requirements.  The behaviour you will see
> from this are in no way guaranteed.
DDI0406C_arm_architecture_reference_manual.pdf (A3-131) says:

A memory location can be marked as having different cacheability
attributes, for example when using aliases in a
virtual to physical address mapping:
* if the attributes differ only in the cache allocation hint this does
  not affect the behavior of accesses to that location
* for other cases see Mismatched memory attributes on page A3-136.

Isn't L_PTE_MT_UNCACHED about cache allocation hint?
>
> If you want to do this, it must either come from highmem, or not already
> be mapped.
>
> Moreover, this is absolutely silly - the ARM ARM says:
>
> "LDREX and STREX operations *must* be performed only on memory with the
>  Normal memory attribute."

DDI0406C_arm_architecture_reference_manual.pdf (A3-121) says:

It is IMPLEMENTATION DEFINED whether LDREX and STREX operations can be
performed to a memory region with the Device or Strongly-ordered
memory attribute. Unless the implementation documentation explicitly
states that LDREX and STREX operations to a memory region with the
Device or Strongly-ordered attribute are permitted, the effect of such
operations is UNPREDICTABLE.

At least it allows to perform operations on memory region with the
Strongly-ordered attribute... but still unpredictable.

>
> L_PTE_MT_UNCACHED doesn't get you that.  As I say above, that gets you
> strongly ordered memory, not "normal memory" as required by the
> architecture for use with exclusive types.
>
> > +
> > +           if (p) {
> > +                   int temp;
> > +
> > +                   __asm__ __volatile__(                   \
> > +                           "ldrex   %1, [%2]\n"            \
> > +                           "strex   %0, %1, [%2]"          \
> > +                           : "=&r" (res), "=&r" (temp)     \
> > +                           : "r" (p)                       \
>
> \ character not required for any of the above.  Neither is the __ version
> of "asm" and "volatile".
Thanks.
>
> > +                           : "cc", "memory");
> > +
> > +                           reason = "n\\a (atomic ops may be faulty)";
>
> "n\\a" ?
"not detected"?
> So... at the moment this has me wondering - you're testing atomic
> operations with a strongly ordered memory region, which ARM already
> define this to be outside of the architecture spec.  The behaviour you
> see is not defined architecturally.
>
> And if you're trying to use LDREX/STREX to a strongly ordered or device
> memory region, then you're quite right that it'll be unreliable.  It's
> not defined to even work.  That's not because they're faulty, it's because
> you're abusing them.
However, IRL it is not hard to meet this undefined difference. At
least I'm able to see it on Tegra2 Harmony and Pandaboard. Moreover,
demand on Normal memory attribute breaks up ability to turn caches
off. In this case we are not able to boot the system up (seen on
Tegra2 harmony). This patch is aimed to highlight the difference in
implementation. That's why it has some softering in guessing about
faulty. Might be it worth warning about unpredictable effect instead?

Best wishes
Vladimir
