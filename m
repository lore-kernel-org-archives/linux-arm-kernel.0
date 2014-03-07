From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 6 Mar 2014 20:42:51 -0800
Subject: [PATCH v7 2/2] ARM hibernation / suspend-to-disk
In-Reply-To: <1394016605-24120-3-git-send-email-sebastian.capella@linaro.org>
References: <1394016605-24120-1-git-send-email-sebastian.capella@linaro.org>
 <1394016605-24120-3-git-send-email-sebastian.capella@linaro.org>
Message-ID: <20140307044251.GD9985@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/05, Sebastian Capella wrote:
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index 8756e4b..d32adbb 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -291,6 +291,7 @@ static inline void *phys_to_virt(phys_addr_t x)
>   */
>  #define __pa(x)			__virt_to_phys((unsigned long)(x))
>  #define __va(x)			((void *)__phys_to_virt((phys_addr_t)(x)))
> +#define __pa_symbol(x)		__pa((unsigned long)(x))

Thanks for removing RELOC_HIDE, as Russell already stated it's
never been necessary on ARM.

Looking at this definition now it doesn't look right. Isn't
&__nosave_begin a virtual address? Casting it to an unsigned long
isn't going to give you a physical address. Why can't we use
__pa()?

> +extern const void __nosave_begin, __nosave_end;
> +
> +int pfn_is_nosave(unsigned long pfn)
> +{
> +	unsigned long nosave_begin_pfn =
> +			__pa_symbol(&__nosave_begin) >> PAGE_SHIFT;
> +	unsigned long nosave_end_pfn =
> +			PAGE_ALIGN(__pa_symbol(&__nosave_end)) >> PAGE_SHIFT;
> +
> +	return (pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
> +}

Perhaps this code could be:

	unsigned long nosave_begin_pfn = virt_to_pfn(&__nosave_begin);
	unsigned long nosave_end_pfn = virt_to_pfn(&__nosave_end);

	return (pfn >= nosave_begin_pfn) && (pfn <= nosave_end_pfn);

or if virt_to_pfn() doesn't exist on ARM and we can't add it for
some reason:

	unsigned long nosave_begin_pfn = __phys_to_pfn(__pa(&__nosave_begin));
	unsigned long nosave_end_pfn = __phys_to_pfn(__pa(&__nosave_end));

	return (pfn >= nosave_begin_pfn) && (pfn <= nosave_end_pfn);

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
