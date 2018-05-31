From: rokhanna@nvidia.com (Rohit Khanna)
Date: Thu, 31 May 2018 17:45:11 +0000
Subject: [PATCH] arm64: alternative:flush cache with unpatched code
In-Reply-To: <20180530090044.GA2452@arm.com>
References: <1527617488-5693-1-git-send-email-rokhanna@nvidia.com>,
 <20180530090044.GA2452@arm.com>
Message-ID: <1527788750049.85185@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will, thanks for the comments.
I will push a new patch set.
We want to avoid using __flush_icache_all as much as possible and hence trying to flush cache by range.

Thanks
Rohit
________________________________________
From: Will Deacon <will.deacon@arm.com>
Sent: Wednesday, May 30, 2018 2:00 AM
To: Rohit Khanna
Cc: catalin.marinas at arm.com; robin.murphy at arm.com; mark.rutland at arm.com; Suzuki.Poulose at arm.com; Bo Yan; Alexander Van Brunt; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH] arm64: alternative:flush cache with unpatched code

Hi Rohit,

Please keep me on cc for future versions of this patch. Comments inline.

On Tue, May 29, 2018 at 11:11:28AM -0700, Rohit Khanna wrote:
> In the current implementation,  __apply_alternatives patches
> flush_icache_range and then executes it without invalidating the icache.
> Thus, icache can contain some of the old instructions for
> flush_icache_range. This can cause unpredictable behavior as during
> execution we can get a mix of old and new instructions for
> flush_icache_range.
>
> This patch :
> 1. Adds a new function flush_cache_kernel_range for flushing kernel
> memory range. This function uses non hot-patched code and can be
> safely used to flush cache during code patching.
>
> 2. Modifies __apply_alternatives so that it uses
> flush_cache_kernel_range to flush the cache range after patching code.
>
> Signed-off-by: Rohit Khanna <rokhanna@nvidia.com>
> ---
>  arch/arm64/kernel/alternative.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
> index 5c4bce4ac381..e93cfd26a314 100644
> --- a/arch/arm64/kernel/alternative.c
> +++ b/arch/arm64/kernel/alternative.c
> @@ -122,6 +122,33 @@ static void patch_alternative(struct alt_instr *alt,
>       }
>  }
>
> +/* This is used for flushing kernel memory range after
> + * __apply_alternatives has patched kernel code
> + */
> +static void flush_cache_kernel_range(void *start, void *end)
> +{

How about something like clean_dcache_range_nopatch instead?

> +     u64 d_start, i_start, d_size, i_size;
> +
> +     /* use sanitized value of ctr_el0 rather than raw value from CPU */
> +     d_size = 4 << ((arm64_ftr_reg_ctrel0.sys_val >> 0x10) & 0xF); /* bytes */
> +     i_size = 4 << (arm64_ftr_reg_ctrel0.sys_val & 0xF); /* bytes */

You should be able to use read_sanitised_ftr_reg() and
cpuid_feature_extract_unsigned_field() here.

> +     d_start = (u64)start & ~(d_size - 1);
> +     while (d_start <= (u64)end) {

Please add a comment about the A53 erratum this is handling by using
clean+inv.

> +             asm volatile("dc civac, %0" : : "r" (d_start));
> +             d_start += d_size;
> +     }
> +     dsb(ish);
> +
> +     i_start = (u64)start & ~(i_size - 1);
> +     while (i_start <= (u64)end) {
> +             asm volatile("ic ivau, %0" : : "r" (i_start));
> +             i_start += i_size;
> +     }
> +     dsb(ish);
> +     isb();

As I mentioned before, I think it would be simpler just to avoid doing the
I-cache invalidation by range and instead call __flush_icache_all once we've
exiting the loop in __apply_alternatives.

Will
