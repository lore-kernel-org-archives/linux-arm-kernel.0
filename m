From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 18 Oct 2018 10:36:01 +0100
Subject: [PATCH] arm: kernel: add support for detecting armv8 cpu cache
 information
In-Reply-To: <1539843407-7439-1-git-send-email-tengfei@codeaurora.org>
References: <1539843407-7439-1-git-send-email-tengfei@codeaurora.org>
Message-ID: <20181018093601.GA25667@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2018 at 02:16:47PM +0800, Teng Fei Fan wrote:
> This patch adds support for cacheinfo on 32bit ARMv8 platform.
> Add support for detecting cpu cache information cpu cache information
> via sysfs for 32bit armv8 platform. And export to sysfs then userspace
> can get from /sys/devices/system/cpu/cpuX/cache.
>
> Signed-off-by: Teng Fei Fan <tengfei@codeaurora.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  arch/arm/include/asm/cachetype.h |  38 ++++++++++++
>  arch/arm/kernel/Makefile         |   3 +-
>  arch/arm/kernel/cacheinfo.c      | 128 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 168 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/kernel/cacheinfo.c
>
> diff --git a/arch/arm/include/asm/cachetype.h b/arch/arm/include/asm/cachetype.h
> index 01509ae..f639c64 100644
> --- a/arch/arm/include/asm/cachetype.h
> +++ b/arch/arm/include/asm/cachetype.h
> @@ -1,6 +1,31 @@
>  #ifndef __ASM_ARM_CACHETYPE_H
>  #define __ASM_ARM_CACHETYPE_H
>
> +/*
> + * NumSets, bits[27:13] - (Number of sets in cache) - 1
> + * Associativity, bits[12:3] - (Associativity of cache) - 1
> + * LineSize, bits[2:0] - (Log2(Number of words in cache line)) - 2
> + */
> +#define CCSIDR_EL1_WRITE_THROUGH	BIT(31)
> +#define CCSIDR_EL1_WRITE_BACK		BIT(30)
> +#define CCSIDR_EL1_READ_ALLOCATE	BIT(29)
> +#define CCSIDR_EL1_WRITE_ALLOCATE	BIT(28)
> +#define CCSIDR_EL1_LINESIZE_MASK	0x7
> +#define CCSIDR_EL1_LINESIZE(x)		((x) & CCSIDR_EL1_LINESIZE_MASK)
> +#define CCSIDR_EL1_ASSOCIATIVITY_SHIFT	3
> +#define CCSIDR_EL1_ASSOCIATIVITY_MASK	0x3ff
> +#define CCSIDR_EL1_ASSOCIATIVITY(x) \
> +	(((x) >> CCSIDR_EL1_ASSOCIATIVITY_SHIFT) \
> +	& CCSIDR_EL1_ASSOCIATIVITY_MASK)
> +#define CCSIDR_EL1_NUMSETS_SHIFT	13
> +#define CCSIDR_EL1_NUMSETS_MASK		0x7fff
> +#define CCSIDR_EL1_NUMSETS(x) \
> +	(((x) >> CCSIDR_EL1_NUMSETS_SHIFT) & CCSIDR_EL1_NUMSETS_MASK)
> +
> +#define CACHE_LINESIZE(x)	(16 << CCSIDR_EL1_LINESIZE(x))
> +#define CACHE_NUMSETS(x)	(CCSIDR_EL1_NUMSETS(x) + 1)
> +#define CACHE_ASSOCIATIVITY(x)	(CCSIDR_EL1_ASSOCIATIVITY(x) + 1)
> +

This was dropped from arm64 via the commit
a8d4636f96ad ("arm64: cacheinfo: Remove CCSIDR-based cache information probing")

So it makes no sense to add CCSIDR based cacheinfo back. If we add this
support, it should be entirely based on DT.

--
Regards,
Sudeep
