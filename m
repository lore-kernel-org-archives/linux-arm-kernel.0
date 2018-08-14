From: will.deacon@arm.com (Will Deacon)
Date: Tue, 14 Aug 2018 11:40:42 +0100
Subject: [PATCH] arm64: mm: check for upper PAGE_SHIFT bits in pfn_valid()
In-Reply-To: <20180813193013.236362-1-ghackmann@google.com>
References: <20180813193013.236362-1-ghackmann@google.com>
Message-ID: <20180814104041.GB28664@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On Mon, Aug 13, 2018 at 12:30:11PM -0700, Greg Hackmann wrote:
> ARM64's pfn_valid() shifts away the upper PAGE_SHIFT bits of the input
> before seeing if the PFN is valid.  This leads to false positives when
> some of the upper bits are set, but the lower bits match a valid PFN.
> 
> For example, the following userspace code looks up a bogus entry in
> /proc/kpageflags:
> 
>     int pagemap = open("/proc/self/pagemap", O_RDONLY);
>     int pageflags = open("/proc/kpageflags", O_RDONLY);
>     uint64_t pfn, val;
> 
>     lseek64(pagemap, [...], SEEK_SET);
>     read(pagemap, &pfn, sizeof(pfn));
>     if (pfn & (1UL << 63)) {        /* valid PFN */
>         pfn &= ((1UL << 55) - 1);   /* clear flag bits */
>         pfn |= (1UL << 55);
>         lseek64(pageflags, pfn * sizeof(uint64_t), SEEK_SET);
>         read(pageflags, &val, sizeof(val));
>     }
> 
> On ARM64 this causes the userspace process to crash with SIGSEGV rather
> than reading (1 << KPF_NOPAGE).  kpageflags_read() treats the offset as
> valid, and stable_page_flags() will try to access an address between the
> user and kernel address ranges.
> 
> Signed-off-by: Greg Hackmann <ghackmann@google.com>
> ---
>  arch/arm64/mm/init.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Thanks, this looks like a sensible fix to me. Do you think it warrants a
CC stable?

Will

> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 9abf8a1e7b25..787e27964ab9 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -287,7 +287,11 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>  #ifdef CONFIG_HAVE_ARCH_PFN_VALID
>  int pfn_valid(unsigned long pfn)
>  {
> -	return memblock_is_map_memory(pfn << PAGE_SHIFT);
> +	phys_addr_t addr = pfn << PAGE_SHIFT;
> +
> +	if ((addr >> PAGE_SHIFT) != pfn)
> +		return 0;
> +	return memblock_is_map_memory(addr);
>  }
>  EXPORT_SYMBOL(pfn_valid);
>  #endif
> -- 
> 2.18.0.597.ga71716f1ad-goog
> 
