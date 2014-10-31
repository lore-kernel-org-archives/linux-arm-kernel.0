From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 31 Oct 2014 21:00:31 +0000
Subject: [PATCH 1/3] ARM: Add default SPARSEMEM settings
In-Reply-To: <1410488562-21863-1-git-send-email-cernekee@gmail.com>
References: <1410488562-21863-1-git-send-email-cernekee@gmail.com>
Message-ID: <20141031210031.GV27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 07:22:40PM -0700, Kevin Cernekee wrote:
> We can still override these settings via mach/memory.h, but let's provide
> sensible defaults so that SPARSEMEM is available in the multiplatform
> kernels.
> 
> Two platforms currently use SECTION_SIZE_BITS < 28, but are expected to
> work with 28 (albeit slightly less efficiently if not all banks are
> populated):
> 
>  - mach-rpc: uses 26 bits.  Based on mach/hardware.h it looks like this
>    platform puts RAM at 0x1000_0000 - 0x1fff_ffff, and I/O below
>    0x1000_0000.
> 
>  - mach-sa1100: uses 27 bits.  mach/memory.h indicates that RAM occupies
>    the entire range of 0xc000_0000 - 0xdfff_ffff.
> 
> Several platforms need MAX_PHYSMEM_BITS >= 36 so we'll pick that as the
> minimum.  Anything higher and we'll fail the SECTIONS_WIDTH + NODES_WIDTH +
> ZONES_WIDTH test in <linux/mm.h>.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
>  arch/arm/include/asm/sparsemem.h |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/include/asm/sparsemem.h b/arch/arm/include/asm/sparsemem.h
> index 0009861..73e5e85 100644
> --- a/arch/arm/include/asm/sparsemem.h
> +++ b/arch/arm/include/asm/sparsemem.h
> @@ -15,10 +15,11 @@
>   * Eg, if you have 2 banks of up to 64MB at 0x80000000, 0x84000000,
>   * then MAX_PHYSMEM_BITS is 32, SECTION_SIZE_BITS is 26.
>   *
> - * Define these in your mach/memory.h.
> + * These can be overridden in your mach/memory.h.
>   */
> -#if !defined(SECTION_SIZE_BITS) || !defined(MAX_PHYSMEM_BITS)
> -#error Sparsemem is not supported on this platform
> +#if !defined(MAX_PHYSMEM_BITS) || !defined(SECTION_SIZE_BITS)
> +#define MAX_PHYSMEM_BITS	36
> +#define SECTION_SIZE_BITS	28

I think this is fine in as far as it goes - this means we end up with
256 entries in the mem_section array which means it occupies one page,
which I think is acceptable overhead.

The other thing to be aware of here is the obvious:

#if (MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS
#error Allocator MAX_ORDER exceeds SECTION_SIZE
#endif

Which means that with 28 bits of section, that's a maximum allocator
order of 16.  We appear to allow FORCE_MAX_ZONEORDER to be set up to
64 in the case of shmobile, which doesn't seem like a sensible upper
limit - and certainly isn't when sparsemem is enabled.

Given this, I think that FORCE_MAX_ZONEORDER's help, and the
dependencies probably could do with some improvement to make the
issues more transparent.

Apart from that, I think this patch is fine.  It just would've been
nice to have seen some analysis of the impact (like the above) of
spreading these parameters over everything.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
