From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 23 Sep 2009 10:13:24 +0100
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <4AB9BA3E.20602@googlemail.com>
References: <20090919224022.GA738@n2100.arm.linux.org.uk>
	<1253435940.498.15.camel@pc1117.cambridge.arm.com>
	<20090920093139.GA1704@n2100.arm.linux.org.uk>
	<20090920190227.GB5413@n2100.arm.linux.org.uk>
	<4AB6B0AB.8040307@arm.com> <20090921083109.GC20006@shareable.org>
	<1253522944.1541.3.camel@pc1117.cambridge.arm.com>
	<20090921085425.GC27357@n2100.arm.linux.org.uk>
	<1253526263.1541.32.camel@pc1117.cambridge.arm.com>
	<20090921100751.GF27357@n2100.arm.linux.org.uk>
	<20090921213802.GH30821@n2100.arm.linux.org.uk>
	<1253614753.14049.47.camel@pc1117.cambridge.arm.com>
	<1253639843.14049.95.camel@pc1117.cambridge.arm.com>
	<4AB9BA3E.20602@googlemail.com>
Message-ID: <1253697204.23370.22.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2009-09-23 at 08:03 +0200, Dirk Behme wrote:
> Catalin Marinas wrote:
> > On Tue, 2009-09-22 at 11:19 +0100, Catalin Marinas wrote:
> >> Yet another idea - add a generic flush_cache_range_for_mprotect()
> >> function with a specific implementation for ARM (called via
> >> change_protection).
> 
> Catalin and Russell: First many thanks for all the discussion and help 
> about this!
> 
> > The patch below looks like the best option in my opinion but requires
> > some generic kernel changes (minimal though). The patch contains the
> > ARM-specific code as well but can be split in two for pushing upstream.
> > 
> > Apart from this patch, I ran some lmbench tests and my workaround
> 
> If you talk about "workaround", do you mean patch below or patch in
> 
> http://lists.arm.linux.org.uk/lurker/message/20090817.172516.3100340a.en.html

The patch at the link above. It implements flush_cache_range with a
check for VM_EXEC but as Russell pointed out, that's set all the time,
so the mmap performance is affected. Whether this is on a critical path,
I can't say.

> > affects mmap tests quite a lot because of the read-implies-exec forcing
> > flush_cache_range() in several places. Russell's patch 
> 
> Is Russell's patch available publically somewhere? Sorry if I missed it.

It's not but just add a __cpuc_flush_dcache_page() to the
copy_to_user_highpage() function (I don't think it needs the coherent
flush since the page was first mapped with RX and update_mmu_cache()
should have taken care of the I-cache invalidation). Something like
below:

diff --git a/arch/arm/mm/copypage-v6.c b/arch/arm/mm/copypage-v6.c
index 4127a7b..f19ed4e 100644
--- a/arch/arm/mm/copypage-v6.c
+++ b/arch/arm/mm/copypage-v6.c
@@ -41,6 +41,7 @@ static void v6_copy_user_highpage_nonaliasing(struct page *to,
 	kfrom = kmap_atomic(from, KM_USER0);
 	kto = kmap_atomic(to, KM_USER1);
 	copy_page(kto, kfrom);
+	__cpuc_flush_dcache_page(kto);
 	kunmap_atomic(kto, KM_USER1);
 	kunmap_atomic(kfrom, KM_USER0);
 }

After running some benchmarks, my preference for a fix is:

     1. The patch I just posted which introduces flush_prot_range(). It
        affects generic code but if people here agree with the idea, I'm
        happy to try to push for it upstream. It allows mprotect(rx) to
        flush the caches as some people might expect and doesn't affect
        the fork or mmap performance
     2. Russell's (unposted) patch (or the one above) for flushing the
        D-cache during CoW (no I-cache invalidation necessary). There
        would be a (probably slight) performance drop for applications
        using intensive forking (apache?) but it shouldn't be that
        different from read-allocate caches. The common fork+exec
        combination shouldn't do much CoW so I don't expect this to be
        affected
     3. My initial patch for flush_cache_range but it would be better to
        disable read-implies-exec
     4. Handle the prefetch abort for exec permission and only to the
        flushing there (this patch would be a bit more complicated)

For now, I would say to go with 2 for the -rc releases (and maybe try to
convince upstream people of 1). If option 1 isn't acceptable upstream,
we tell people that mprotect(rx) does not flush the caches, so
sys_cacheflush() should be used instead.

-- 
Catalin
