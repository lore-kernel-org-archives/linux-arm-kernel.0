From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 16 Nov 2009 10:46:55 +0000
Subject: [RFC 10/11] ARM: arrange for flush_cache_range() to always
	flush the I-cache
In-Reply-To: <1256838661.6874.67.camel@pc1117.cambridge.arm.com>
References: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
	<12475bd20f82c3a5e78d5b8e9d3cb266914c4727.1256683230.git.rmk+kernel@arm.linux.org.uk>
	<1256745098.27121.48.camel@pc1117.cambridge.arm.com>
	<20091028173709.GC20040@n2100.arm.linux.org.uk>
	<1256838661.6874.67.camel@pc1117.cambridge.arm.com>
Message-ID: <1258368415.6705.20.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Thu, 2009-10-29 at 17:51 +0000, Catalin Marinas wrote:
> On Wed, 2009-10-28 at 17:37 +0000, Russell King - ARM Linux wrote:
> >  I'm not entirely
> > sure what's happening with the other half of the fix (the thread seemed
> > to die before reaching any kind of conclusion) but this is the right
> > solution for the I-cache side of the problem.
> 
> I listed a few solutions there but not many replies. Let's try to sort
> it out in this thread (maybe people got bored and ignored the other
> thread completely :-)).
[...]
> Flush the D-cache during copy_user_highpage()
> 
> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> The I and D caches for copy-on-write pages on processors with
> write-allocate caches become incoherent causing problems on application
> relying on CoW for text pages (dynamic linker relocating symbols in a
> text page). This patch flushes the D-cache for such pages.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm/mm/copypage-v6.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mm/copypage-v6.c b/arch/arm/mm/copypage-v6.c
> index 4127a7b..f19ed4e 100644
> --- a/arch/arm/mm/copypage-v6.c
> +++ b/arch/arm/mm/copypage-v6.c
> @@ -41,6 +41,7 @@ static void v6_copy_user_highpage_nonaliasing(struct page *to,
>  	kfrom = kmap_atomic(from, KM_USER0);
>  	kto = kmap_atomic(to, KM_USER1);
>  	copy_page(kto, kfrom);
> +	__cpuc_flush_dcache_page(kto);
>  	kunmap_atomic(kto, KM_USER1);
>  	kunmap_atomic(kfrom, KM_USER0);
>  }

Any thoughts one getting this merged (maybe in 2.6.33)? It seems that
no-one else has any views on this but the COW text pages problem is
still present.

Thanks.

-- 
Catalin
