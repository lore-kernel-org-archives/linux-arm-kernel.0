From: sgoel@codeaurora.org (Goel, Sameer)
Date: Tue, 31 May 2016 17:30:28 -0600
Subject: [PATCH v3] arm64: Implement optimised IP checksum helpers
In-Reply-To: <4cef631ae5ff455d080cb17c8e0fa918c9a5c067.1464714040.git.robin.murphy@arm.com>
References: <ba9cf5bf84b8adc766f7f7511dda8cb501cd4101.1464693619.git.robin.murphy@arm.com>
 <4cef631ae5ff455d080cb17c8e0fa918c9a5c067.1464714040.git.robin.murphy@arm.com>
Message-ID: <7d5e45a9-6e48-3f67-c633-77a3d50d71e8@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the arm64 checksum file. I saw a 4 fold speedup when 
calculating checksum for a 20 byte buffer on my test platform.

Thanks,
Sameer

On 5/31/2016 11:04 AM, Robin Murphy wrote:
> AArch64 is capable of 128-bit memory accesses without alignment
> restrictions, which makes it both possible and highly practical to slurp
> up a typical 20-byte IP header in just 2 loads. Implement our own
> version of ip_fast_checksum() to take advantage of that, resulting in
> considerably fewer instructions and memory accesses than the generic
> version. We can also get more optimal code generation for csum_fold() by
> defining it a slightly different way round from the generic version, so
> throw that into the mix too.
>
> Suggested-by: Luke Starrett <luke.starrett@broadcom.com>
> Acked-by: Luke Starrett <luke.starrett@broadcom.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>
> v3: Don't generate generic header [James]
> v2: Include types.h, add Luke's ack
>
>  arch/arm64/include/asm/Kbuild     |  1 -
>  arch/arm64/include/asm/checksum.h | 51 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/include/asm/checksum.h
>
> diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
> index cff532a6744e..f43d2c44c765 100644
> --- a/arch/arm64/include/asm/Kbuild
> +++ b/arch/arm64/include/asm/Kbuild
> @@ -1,6 +1,5 @@
>  generic-y += bug.h
>  generic-y += bugs.h
> -generic-y += checksum.h
>  generic-y += clkdev.h
>  generic-y += cputime.h
>  generic-y += current.h
> diff --git a/arch/arm64/include/asm/checksum.h b/arch/arm64/include/asm/checksum.h
> new file mode 100644
> index 000000000000..09f65339d66d
> --- /dev/null
> +++ b/arch/arm64/include/asm/checksum.h
> @@ -0,0 +1,51 @@
> +/*
> + * Copyright (C) 2016 ARM Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#ifndef __ASM_CHECKSUM_H
> +#define __ASM_CHECKSUM_H
> +
> +#include <linux/types.h>
> +
> +static inline __sum16 csum_fold(__wsum csum)
> +{
> +	u32 sum = (__force u32)csum;
> +	sum += (sum >> 16) | (sum << 16);
> +	return ~(__force __sum16)(sum >> 16);
> +}
> +#define csum_fold csum_fold
> +
> +static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
> +{
> +	__uint128_t tmp;
> +	u64 sum;
> +
> +	tmp = *(const __uint128_t *)iph;
> +	iph += 16;
> +	ihl -= 4;
> +	tmp += ((tmp >> 64) | (tmp << 64));
> +	sum = tmp >> 64;
> +	do {
> +		sum += *(const u32 *)iph;
> +		iph += 4;
> +	} while (--ihl);
> +
> +	sum += ((sum >> 32) | (sum << 32));
> +	return csum_fold(sum >> 32);
> +}
> +#define ip_fast_csum ip_fast_csum
> +
> +#include <asm-generic/checksum.h>
> +
> +#endif	/* __ASM_CHECKSUM_H */
>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
