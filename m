From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 3 Nov 2015 15:55:29 +0100
Subject: [PATCH] arm64: Increase the max granular size
In-Reply-To: <20151103143858.GI7637@e104818-lin.cambridge.arm.com>
References: <1442944788-17254-1-git-send-email-rric@kernel.org>
 <20151028190948.GJ8899@e104818-lin.cambridge.arm.com>
 <CAMuHMdWQygbxMXoOsbwek6DzZcr7J-C23VCK4ubbgUr+zj=giw@mail.gmail.com>
 <20151103120504.GF7637@e104818-lin.cambridge.arm.com>
 <20151103143858.GI7637@e104818-lin.cambridge.arm.com>
Message-ID: <CAMuHMdWk0fPzTSKhoCuS4wsOU1iddhKJb2SOpjo=a_9vCm_KXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Tue, Nov 3, 2015 at 3:38 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Tue, Nov 03, 2015 at 12:05:05PM +0000, Catalin Marinas wrote:
>> On Tue, Nov 03, 2015 at 12:07:06PM +0100, Geert Uytterhoeven wrote:
>> > On Wed, Oct 28, 2015 at 8:09 PM, Catalin Marinas
>> > <catalin.marinas@arm.com> wrote:
>> > > On Tue, Sep 22, 2015 at 07:59:48PM +0200, Robert Richter wrote:
>> > >> From: Tirumalesh Chalamarla <tchalamarla@cavium.com>
>> > >>
>> > >> Increase the standard cacheline size to avoid having locks in the same
>> > >> cacheline.
>> > >>
>> > >> Cavium's ThunderX core implements cache lines of 128 byte size. With
>> > >> current granulare size of 64 bytes (L1_CACHE_SHIFT=6) two locks could
>> > >> share the same cache line leading a performance degradation.
>> > >> Increasing the size fixes that.
>> > >>
>> > >> Increasing the size has no negative impact to cache invalidation on
>> > >> systems with a smaller cache line. There is an impact on memory usage,
>> > >> but that's not too important for arm64 use cases.
>> > >>
>> > >> Signed-off-by: Tirumalesh Chalamarla <tchalamarla@cavium.com>
>> > >> Signed-off-by: Robert Richter <rrichter@cavium.com>
>> > >
>> > > Applied. Thanks.
>> >
>> > This patch causes a BUG() on r8a7795/salvator-x, for which support is not
>> > yet upstream.
>> >
>> > My config (attached) uses SLAB. If I switch to SLUB, it works.
>> > The arm64 defconfig works, even if I switch from SLUB to SLAB.
>> [...]
>> > ------------[ cut here ]------------
>> > kernel BUG at mm/slab.c:2283!
>> > Internal error: Oops - BUG: 0 [#1] SMP
>> [...]
>> > Call trace:
>> > [<ffffffc00014f9b4>] __kmem_cache_create+0x21c/0x280
>> > [<ffffffc00068be50>] create_boot_cache+0x4c/0x80
>> > [<ffffffc00068bed8>] create_kmalloc_cache+0x54/0x88
>> > [<ffffffc00068bfc0>] create_kmalloc_caches+0x50/0xf4
>> > [<ffffffc00068db08>] kmem_cache_init+0x104/0x118
>> > [<ffffffc00067d7d8>] start_kernel+0x218/0x33c
>>
>> I haven't managed to reproduce this on a Juno kernel.
>
> I now managed to reproduce it with your config (slightly adapted to
> allow Juno). I'll look into it.

Good to hear that!

BTW, I see this:

        freelist_size = 32
        cache_line_size() = 64

It seems like the value returned by cache_line_size() in
arch/arm64/include/asm/cache.h disagrees with L1_CACHE_SHIFT  == 7:

        static inline int cache_line_size(void)
        {
                u32 cwg = cache_type_cwg();
                return cwg ? 4 << cwg : L1_CACHE_BYTES;
        }

Making cache_line_size() always return L1_CACHE_BYTES doesn't help.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
