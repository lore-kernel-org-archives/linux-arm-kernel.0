From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 23 Feb 2018 17:00:19 +0000
Subject: [RFC PATCH v3 1/3] arm64/kernel: kaslr: reduce module
 randomization range to 4 GB
In-Reply-To: <20180214113645.16793-2-ard.biesheuvel@linaro.org>
References: <20180214113645.16793-1-ard.biesheuvel@linaro.org>
 <20180214113645.16793-2-ard.biesheuvel@linaro.org>
Message-ID: <20180223170019.uubttzhgtqhhxppt@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 14, 2018 at 11:36:43AM +0000, Ard Biesheuvel wrote:
> We currently have to rely on the GCC large code model for KASLR for
> two distinct but related reasons:
> - if we enable full randomization, modules will be loaded very far away
>   from the core kernel, where they are out of range for ADRP instructions,
> - even without full randomization, the fact that the 128 MB module region
>   is now no longer fully reserved for kernel modules means that there is
>   a very low likelihood that the normal bottom-up allocation of other
>   vmalloc regions may collide, and use up the range for other things.
> 
> Large model code is suboptimal, given that each symbol reference involves
> a literal load that goes through the D-cache, reducing cache utilization.
> But more importantly, literals are not instructions but part of .text
> nonetheless, and hence mapped with executable permissions.

I guess that means they pollute the I-caches, too?

How big a difference does this series make to .text size?

I don't really have a strong opinion here. IIRC the idea for randomizing
modules across the whole vmalloc space was to make it harder for module
bugs to leak "real" kernel addresses, but I don't know how much that's
likely to help in practice, and the performance / cache footprint wins
are enticing.

[...]

> @@ -149,21 +151,23 @@ u64 __init kaslr_early_init(u64 dt_phys)
>  		 * vmalloc region, since shadow memory is allocated for each
>  		 * module at load time, whereas the vmalloc region is shadowed
>  		 * by KASAN zero pages. So keep modules out of the vmalloc
> -		 * region if KASAN is enabled.
> +		 * region if KASAN is enabled, and put the kernel well within
> +		 * 4 GB of the module region.
>  		 */
> -		return offset;
> +		return offset % SZ_2G;

I wonder if we can do more here, taking the kernel size into account.

[...]

> diff --git a/include/linux/sizes.h b/include/linux/sizes.h
> index ce3e8150c174..bc621db852d9 100644
> --- a/include/linux/sizes.h
> +++ b/include/linux/sizes.h
> @@ -44,4 +44,6 @@
>  #define SZ_1G				0x40000000
>  #define SZ_2G				0x80000000
>  
> +#define SZ_4G				0x100000000ULL

Some asm includes <linux/sizes.h>, so it'd be nice for this to use
ULL().

Masahiro Yamada had patches moving that to <linux/const.h>.

Thanks,
Mark.
