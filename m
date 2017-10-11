From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 11 Oct 2017 16:23:45 -0700
Subject: [PATCH 06/11] change memory_is_poisoned_16 for aligned error
In-Reply-To: <20171011082227.20546-7-liuwenliang@huawei.com>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
 <20171011082227.20546-7-liuwenliang@huawei.com>
Message-ID: <20171011162345.f601c29d12c81af85bf38565@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Oct 2017 16:22:22 +0800 Abbott Liu <liuwenliang@huawei.com> wrote:

>  Because arm instruction set don't support access the address which is
>  not aligned, so must change memory_is_poisoned_16 for arm.
> 
> ...
>
> --- a/mm/kasan/kasan.c
> +++ b/mm/kasan/kasan.c
> @@ -149,6 +149,25 @@ static __always_inline bool memory_is_poisoned_2_4_8(unsigned long addr,
>  	return memory_is_poisoned_1(addr + size - 1);
>  }
>  
> +#ifdef CONFIG_ARM
> +static __always_inline bool memory_is_poisoned_16(unsigned long addr)
> +{
> +	u8 *shadow_addr = (u8 *)kasan_mem_to_shadow((void *)addr);
> +
> +	if (unlikely(shadow_addr[0] || shadow_addr[1])) return true;

Coding-style is messed up.  Please use scripts/checkpatch.pl.

> +	else {
> +		/*
> +		 * If two shadow bytes covers 16-byte access, we don't
> +		 * need to do anything more. Otherwise, test the last
> +		 * shadow byte.
> +		 */
> +		if (likely(IS_ALIGNED(addr, KASAN_SHADOW_SCALE_SIZE)))
> +			return false;
> +		return memory_is_poisoned_1(addr + 15);
> +	}
> +}
> +
> +#else
>  static __always_inline bool memory_is_poisoned_16(unsigned long addr)
>  {
>  	u16 *shadow_addr = (u16 *)kasan_mem_to_shadow((void *)addr);
> @@ -159,6 +178,7 @@ static __always_inline bool memory_is_poisoned_16(unsigned long addr)
>  
>  	return *shadow_addr;
>  }
> +#endif

- I don't understand why this is necessary.  memory_is_poisoned_16()
  already handles unaligned addresses?

- If it's needed on ARM then presumably it will be needed on other
  architectures, so CONFIG_ARM is insufficiently general.

- If the present memory_is_poisoned_16() indeed doesn't work on ARM,
  it would be better to generalize/fix it in some fashion rather than
  creating a new variant of the function.
