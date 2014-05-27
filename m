From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 27 May 2014 11:15:42 +0200
Subject: [PATCH RFCv2 1/5] ARM: use write allocate by default on ARMv6+
In-Reply-To: <20140526162643.GB3693@n2100.arm.linux.org.uk>
References: <1400600105-3013-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1400600105-3013-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140526162643.GB3693@n2100.arm.linux.org.uk>
Message-ID: <20140527111542.6a49833f@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Thanks for your review!

On Mon, 26 May 2014 17:26:43 +0100, Russell King - ARM Linux wrote:
> On Tue, May 20, 2014 at 05:35:01PM +0200, Thomas Petazzoni wrote:
> > Currently, the default cache policy for ARMv6+ platform is writeback
> > in UP mode and write allocate in SMP mode
> > 
> > Some platforms that provide hardware I/O coherency capabilities
> > (such as Marvell Armada 370/XP/375/38x) require the cache policy to
> > be write allocate even in UP mode. This is especially true on
> > Armada 370, which is a single core processor, so even with
> > CONFIG_SMP=y, is_smp() returns false and the cache policy remains
> > defined to writeback.
> > 
> > As suggested by Catalin Marinas and Rob Herring, there is in fact no
> > good reason to keep using writeback by default on ARMv6+, and we
> > could switch to write allocate by default for all ARMv6+ platforms
> > instead of special-casing the Marvell platforms.
> 
> Firstly, whether write allocate is beneficial or detrimental depends
> on the workload being executed, and I'm not about to change this
> based on such loose reasoning.

Well, in my case, what's driving the usage of write allocate instead of
write back is not a performance concern. Supporting hardware I/O
coherency on Marvell Armada platforms *requires* having the  write
allocate cache policy. So in my "PATCH RFCv1" I added flags to
machine_desc so that individual machines can tell whether they
absolutely need write allocate or not.

The feedback from Catalin and Rob was that maybe we could simply make
write allocate the default for ARMv6+, which would avoid the need to
make a special case for Marvell Armada platforms.

Maybe Catalin and Rob can detail why they think switching to write
allocate as the default for ARMv6+ makes sense?

> Secondly, we're losing information.  SMP uses write-allocate not due
> to some kind of default, not because of some policy reason, but
> because SMP is *required* architecturally to use write-allocate and
> this must never allowed to be overridden.

Absolutely. Just like it is *required* for hardware I/O coherency on
Marvell Armada platforms, even those that are non-SMP like Armada 370
or Armada 380.

> You break this by allowing SMP to specify writeback read-allocate.

I am certainly not very familiar with the code in mm/mmu.c, but I'm not
sure to see why I allow SMP to specify writeback read-allocate. What
the code does is:

 * Make CPOLICY_WRITEALLOC the default value for "cachepolicy"

 * In early_cachepolicy(), if a specific cachepolicy= argument is
   passed to the kernel, we use it, except for >= ARMv6, where
   CPOLICY_WRITEALLOC is forced.

 * In build_mem_type_table(), we override the cache policy to buffered,
   writethrough or writeback only in < ARMv6 and < ARMv5 situations.

I've grepped again for all places where "cachepolicy" is modified in
mm/mmu.c, and I fail to see where cachepolicy could be set back to
writeback read-allocate in ARMv6+ platforms.

> Thirdly, you remove the possiblity of using writeback write-allocate
> on ARMv5.  There are ARMv5 CPUs which have caches capable of that.

Indeed, with my patch, CPOLICY_WRITEALLOC is no longer allowed on
ARMv5. That's because I wanted to preserve the default of being
CPOLICY_WRITEBACK on ARMv5.

So maybe, I should keep the cachepolicy default value to
CPOLICY_WRITEBACK, and then add a:

	if (cpu_arch >= CPU_ARCH_ARMv6)
		cachepolicy = CPOLICY_WRITEALLOC;

in build_mem_type_table().

Would this work for you?

Thanks for your feedback,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
