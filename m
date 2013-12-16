From: will.deacon@arm.com (Will Deacon)
Date: Mon, 16 Dec 2013 16:55:22 +0000
Subject: [PATCH 3/6] arm64: lib: Implement optimized memset routine
In-Reply-To: <1386743082-5231-4-git-send-email-zhichang.yuan@linaro.org>
References: <1386743082-5231-1-git-send-email-zhichang.yuan@linaro.org>
 <1386743082-5231-4-git-send-email-zhichang.yuan@linaro.org>
Message-ID: <20131216165522.GG20193@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 06:24:39AM +0000, zhichang.yuan at linaro.org wrote:
> From: "zhichang.yuan" <zhichang.yuan@linaro.org>
> 
> This patch, based on Linaro's Cortex Strings library, improves
> the performance of the assembly optimized memset() function.
> 
> Signed-off-by: Zhichang Yuan <zhichang.yuan@linaro.org>
> Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
> ---
>  arch/arm64/lib/memset.S |  227 +++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 201 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm64/lib/memset.S b/arch/arm64/lib/memset.S
> index 87e4a68..90b973e 100644
> --- a/arch/arm64/lib/memset.S
> +++ b/arch/arm64/lib/memset.S
> @@ -1,13 +1,21 @@
>  /*
>   * Copyright (C) 2013 ARM Ltd.
> + * Copyright (C) 2013 Linaro.
> + *
> + * This code is based on glibc cortex strings work originally authored by Linaro
> + * and re-licensed under GPLv2 for the Linux kernel. The original code can
> + * be found @
> + *
> + * http://bazaar.launchpad.net/~linaro-toolchain-dev/cortex-strings/trunk/
> + * files/head:/src/aarch64/
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the

Why are you changing this?

>   * GNU General Public License for more details.
>   *
>   * You should have received a copy of the GNU General Public License
> @@ -18,7 +26,7 @@
>  #include <asm/assembler.h>
>  
>  /*
> - * Fill in the buffer with character c (alignment handled by the hardware)
> + * Fill in the buffer with character c
>   *
>   * Parameters:
>   *	x0 - buf
> @@ -27,27 +35,194 @@
>   * Returns:
>   *	x0 - buf
>   */
> +
> +/* By default we assume that the DC instruction can be used to zero
> +*  data blocks more efficiently.  In some circumstances this might be
> +*  unsafe, for example in an asymmetric multiprocessor environment with
> +*  different DC clear lengths (neither the upper nor lower lengths are
> +*  safe to use).  The feature can be disabled by defining DONT_USE_DC.
> +*/

We already use DC ZVA for clear_page, so I think we should start off using
it unconditionally. If we need to revisit this later, we can, but adding a
random #ifdef doesn't feel like something we need initially.

For the benefit of anybody else reviewing this; the DC ZVA instruction still
works for normal, non-cacheable memory.

The comments I made on the earlier patch wrt quality of comments and labels
seem to apply to all of the patches in this series.

Will
