From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 3 Nov 2015 18:50:50 +0000
Subject: [PATCH] arm64: Increase the max granular size
In-Reply-To: <CAMuHMdWk0fPzTSKhoCuS4wsOU1iddhKJb2SOpjo=a_9vCm_KXQ@mail.gmail.com>
References: <1442944788-17254-1-git-send-email-rric@kernel.org>
 <20151028190948.GJ8899@e104818-lin.cambridge.arm.com>
 <CAMuHMdWQygbxMXoOsbwek6DzZcr7J-C23VCK4ubbgUr+zj=giw@mail.gmail.com>
 <20151103120504.GF7637@e104818-lin.cambridge.arm.com>
 <20151103143858.GI7637@e104818-lin.cambridge.arm.com>
 <CAMuHMdWk0fPzTSKhoCuS4wsOU1iddhKJb2SOpjo=a_9vCm_KXQ@mail.gmail.com>
Message-ID: <20151103185050.GJ7637@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 03, 2015 at 03:55:29PM +0100, Geert Uytterhoeven wrote:
> On Tue, Nov 3, 2015 at 3:38 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Tue, Nov 03, 2015 at 12:05:05PM +0000, Catalin Marinas wrote:
> >> On Tue, Nov 03, 2015 at 12:07:06PM +0100, Geert Uytterhoeven wrote:
> >> > On Wed, Oct 28, 2015 at 8:09 PM, Catalin Marinas
> >> > <catalin.marinas@arm.com> wrote:
> >> > > On Tue, Sep 22, 2015 at 07:59:48PM +0200, Robert Richter wrote:
> >> > >> From: Tirumalesh Chalamarla <tchalamarla@cavium.com>
> >> > >>
> >> > >> Increase the standard cacheline size to avoid having locks in the same
> >> > >> cacheline.
> >> > >>
> >> > >> Cavium's ThunderX core implements cache lines of 128 byte size. With
> >> > >> current granulare size of 64 bytes (L1_CACHE_SHIFT=6) two locks could
> >> > >> share the same cache line leading a performance degradation.
> >> > >> Increasing the size fixes that.
> >> > >>
> >> > >> Increasing the size has no negative impact to cache invalidation on
> >> > >> systems with a smaller cache line. There is an impact on memory usage,
> >> > >> but that's not too important for arm64 use cases.
> >> > >>
> >> > >> Signed-off-by: Tirumalesh Chalamarla <tchalamarla@cavium.com>
> >> > >> Signed-off-by: Robert Richter <rrichter@cavium.com>
> >> > >
> >> > > Applied. Thanks.
> >> >
> >> > This patch causes a BUG() on r8a7795/salvator-x, for which support is not
> >> > yet upstream.
> >> >
> >> > My config (attached) uses SLAB. If I switch to SLUB, it works.
> >> > The arm64 defconfig works, even if I switch from SLUB to SLAB.
> >> [...]
> >> > ------------[ cut here ]------------
> >> > kernel BUG at mm/slab.c:2283!
> >> > Internal error: Oops - BUG: 0 [#1] SMP
> >> [...]
> >> > Call trace:
> >> > [<ffffffc00014f9b4>] __kmem_cache_create+0x21c/0x280
> >> > [<ffffffc00068be50>] create_boot_cache+0x4c/0x80
> >> > [<ffffffc00068bed8>] create_kmalloc_cache+0x54/0x88
> >> > [<ffffffc00068bfc0>] create_kmalloc_caches+0x50/0xf4
> >> > [<ffffffc00068db08>] kmem_cache_init+0x104/0x118
> >> > [<ffffffc00067d7d8>] start_kernel+0x218/0x33c
> >>
> >> I haven't managed to reproduce this on a Juno kernel.
> >
> > I now managed to reproduce it with your config (slightly adapted to
> > allow Juno). I'll look into it.
> 
> Good to hear that!
> 
> BTW, I see this:
> 
>         freelist_size = 32
>         cache_line_size() = 64
> 
> It seems like the value returned by cache_line_size() in
> arch/arm64/include/asm/cache.h disagrees with L1_CACHE_SHIFT  == 7:
> 
>         static inline int cache_line_size(void)
>         {
>                 u32 cwg = cache_type_cwg();
>                 return cwg ? 4 << cwg : L1_CACHE_BYTES;
>         }
> 
> Making cache_line_size() always return L1_CACHE_BYTES doesn't help.

(cc'ing Jonsoo and Christoph; summary: slab failure with L1_CACHE_BYTES
of 128 and sizeof(kmem_cache_node) of 152)

If I revert commit 8fc9cf420b36 ("slab: make more slab management
structure off the slab") it works but I still need to figure out how
slab indices are calculated. The size_index[] array is overridden so
that 0..15 are 7 and 16..23 are 8. But the kmalloc_caches[7] has never
been populated, hence the BUG_ON. Another option may be to change
kmalloc_size and kmalloc_index to cope with KMALLOC_MIN_SIZE of 128.

I'll do some more investigation tomorrow.

-- 
Catalin
