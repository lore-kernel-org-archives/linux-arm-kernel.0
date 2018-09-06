From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Sep 2018 13:48:11 +0100
Subject: [RESEND PATCH 3/8] ARM: spectre-v1,v1.1: provide helpers for
 address sanitization
In-Reply-To: <1535447316-32187-4-git-send-email-julien.thierry@arm.com>
References: <1535447316-32187-1-git-send-email-julien.thierry@arm.com>
 <1535447316-32187-4-git-send-email-julien.thierry@arm.com>
Message-ID: <20180906124810.GO30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julien,

On Tue, Aug 28, 2018 at 10:08:31AM +0100, Julien Thierry wrote:
> +	.macro uaccess_mask_range_ptr, addr:req, size:req, limit:req, tmp:req
> +#ifdef CONFIG_CPU_SPECTRE
> +	sub	\tmp, \limit, #1
> +	subs	\tmp, \tmp, \addr	@ tmp = limit - 1 - addr
> +	subhss	\tmp, \tmp, \size	@ if (tmp >= 0) tmp = limit - 1 - (addr + size)
> +	movlo	\addr, #0		@ if (tmp < 0) addr = NULL
> +	csdb

I'be been thinking about this and my original code.  This seems to suffer
from a problem in that the last <size> access below the address limit
becomes unaccessible.

Let's take an example.  If limit is 0xbf000000, the 32-bit word at
0xbefffffc should be accessible, so addr=0xbefffffc and size=4.

	sub	\tmp, \limit, #1	tmp = 0xbeffffff
	subs	\tmp, \tmp, \addr	tmp = 0xbeffffff - 0xbefffffc = 3
	subhss	\tmp, \tmp, \size	tmp = 3 - 4 = -1

which means we zero the pointer.  This is obviously incorrect
behaviour, because this word should obviously be accessible - it is
entirely below the limit.

I should point out that the existing code seems to suffer from the
same issue:

	@ r1=addr, r2=size r3=limit
	adds	ip, r1, r2	ip=0xbf000000 C=0
	sub	r3, r3, #1	r3=0xbeffffff
	cmpcc	ip, r3          C=ip >= r3

An obvious solution to your code would be to add the '1' back in, but
realising that fails when addr == 0 and limit=0.

	sub	\tmp, \limit, #1	tmp = 0xffffffff
	subs	\tmp, \tmp, \addr	tmp = 0xffffffff - 0 = 0xffffffff
	add	\tmp, \tmp, #1		tmp = 0
	subhss	\tmp, \tmp, \size	tmp = 0 - 4 = -4

However, that doesn't matter as page 0 should never be mapped, and in
any case, if addr was zero and we then make it zero again, we haven't
changed anything.

> +#endif
> +	.endm
> +
>  	.macro	uaccess_disable, tmp, isb=1
>  #ifdef CONFIG_CPU_SW_DOMAIN_PAN
>  	/*
> diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
> index 2e18b91..9462b8b 100644
> --- a/arch/arm/include/asm/uaccess.h
> +++ b/arch/arm/include/asm/uaccess.h
> @@ -100,6 +100,31 @@ static inline void set_fs(mm_segment_t fs)
>  	__typeof__(__builtin_choose_expr(sizeof(x) > sizeof(0UL), 0ULL, 0UL))
>  
>  /*
> + * Sanitise a uaccess pointer such that it becomes NULL if addr+size
> + * is above the current addr_limit.
> + */
> +#define uaccess_mask_range_ptr(ptr, size)			\
> +	((__typeof__(ptr))__uaccess_mask_range_ptr(ptr, size))
> +static inline void __user *__uaccess_mask_range_ptr(const void __user *ptr,
> +						    size_t size)
> +{
> +	void __user *safe_ptr = (void __user *)ptr;
> +	unsigned long tmp;
> +
> +	asm volatile(
> +	"	sub	%1, %3, #1\n"
> +	"	subs	%1, %1, %0\n"
> +	"	subhss	%1, %1, %2\n"
> +	"	movlo	%0, #0\n"
> +	: "+r" (safe_ptr), "=&r" (tmp)
> +	: "r" (size), "r" (current_thread_info()->addr_limit)
> +	: "cc");
> +
> +	csdb();
> +	return safe_ptr;
> +}
> +
> +/*
>   * Single-value transfer routines.  They automatically use the right
>   * size if we just have the right pointer type.  Note that the functions
>   * which read from user space (*get_*) need to take care not to leak
> diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
> index a826df3..6709a8d 100644
> --- a/arch/arm/lib/copy_from_user.S
> +++ b/arch/arm/lib/copy_from_user.S
> @@ -93,11 +93,7 @@ ENTRY(arm_copy_from_user)
>  #ifdef CONFIG_CPU_SPECTRE
>  	get_thread_info r3
>  	ldr	r3, [r3, #TI_ADDR_LIMIT]
> -	adds	ip, r1, r2	@ ip=addr+size
> -	sub	r3, r3, #1	@ addr_limit - 1
> -	cmpcc	ip, r3		@ if (addr+size > addr_limit - 1)
> -	movcs	r1, #0		@ addr = NULL
> -	csdb
> +	uaccess_mask_range_ptr r1, r2, r3, ip
>  #endif
>  
>  #include "copy_template.S"
> -- 
> 1.9.1
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
