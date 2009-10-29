From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 29 Oct 2009 17:51:01 +0000
Subject: [RFC 10/11] ARM: arrange for flush_cache_range() to always
	flush the I-cache
In-Reply-To: <20091028173709.GC20040@n2100.arm.linux.org.uk>
References: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
	<12475bd20f82c3a5e78d5b8e9d3cb266914c4727.1256683230.git.rmk+kernel@arm.linux.org.uk>
	<1256745098.27121.48.camel@pc1117.cambridge.arm.com>
	<20091028173709.GC20040@n2100.arm.linux.org.uk>
Message-ID: <1256838661.6874.67.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2009-10-28 at 17:37 +0000, Russell King - ARM Linux wrote:
> On Wed, Oct 28, 2009 at 03:51:38PM +0000, Catalin Marinas wrote:
> > On Sun, 2009-10-25 at 14:12 +0000, Russell King wrote:
> > > Dirk Behme reported instability on ARM11 SMP (VIPT non-aliasing cache)
> > > caused by the dynamic linker changing protection on text pages to write
> > > GOT entries.  The problem is due to an interaction between the write
> > > faulting code providing new anonymous pages (which haven't had their
> > > I-cache cleaned due to no VM_EXEC) and change_protection() not doing
> > > any kind of I-cache maintainence.
> > > 
> > > Work around this by flushing the I-cache in flush_cache_range() for
> > > VM_EXEC VMAs (which is what we have when the region is being made
> > > executable again.)  This ensures that the I-cache will be up to date
> > > with the new COW'd pages.
> > 
> > Are you sure this fixes the problem? IIRC this is mainly caused by the
> > write-allocate D-cache and that copy_to_user_highpage() doesn't flush
> > the D-cache. Just an I-cache invalidation wouldn't help much.
> 
> Not on its own (sorry, should've made that clear). 

I actually got the opposite from the patch description - "I-cache will
be up to date with the new COW'd pages".

>  I'm not entirely
> sure what's happening with the other half of the fix (the thread seemed
> to die before reaching any kind of conclusion) but this is the right
> solution for the I-cache side of the problem.

I listed a few solutions there but not many replies. Let's try to sort
it out in this thread (maybe people got bored and ignored the other
thread completely :-)).

As I see it, we either fix the mprotect(RX) to do full coherency or
ensure that the COW mechanism flushes the (I-cache? and) D-cache (or a
combination of these two).

Assuming that we won't get COW for mprotect(RWX) pages (apps seem to do
mprotect(RW) follow by mprotect(RX)), your patch handles the I-cache
side.

On ARM11MPCore, cache operations aren't broadcast and there is a small
risk of thread migration between COW and mprotect(RX), so flushing the
D-cache in mprotect(RX) may not always work (Cortex-A9 is different). In
this case, the only place to do the D-cache flushing is in
copy_user_highpage().

The patch below should do it (you suggested it but never posted a
patch):


Flush the D-cache during copy_user_highpage()

From: Catalin Marinas <catalin.marinas@arm.com>

The I and D caches for copy-on-write pages on processors with
write-allocate caches become incoherent causing problems on application
relying on CoW for text pages (dynamic linker relocating symbols in a
text page). This patch flushes the D-cache for such pages.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/copypage-v6.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

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


-- 
Catalin
