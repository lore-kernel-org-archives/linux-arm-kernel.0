From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 May 2015 11:00:42 +0100
Subject: [PATCH 1/1] ARM:r0 is also corrupted after calling __do_div64.
In-Reply-To: <1431412386-1249-1-git-send-email-gangchen@rdamicro.com>
References: <1431412386-1249-1-git-send-email-gangchen@rdamicro.com>
Message-ID: <20150512100042.GN2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 02:33:06PM +0800, Chen Gang wrote:
> R0 is corrupted after calling __do_div64 and compiler is not informed
> about this in macro __do_div_asm. If n is to be used again after this
> macro, r0 is not reloaded and n will contain incorrect value

This isn't going to work if we're building for big endian (__ARMEB__
set) because then we end up telling the compiler that __rem and __n
are both in r0, which is impossible.

> diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
> index a66061a..93a9985 100644
> --- a/arch/arm/include/asm/div64.h
> +++ b/arch/arm/include/asm/div64.h
> @@ -34,13 +34,13 @@
>  	register unsigned long long __n   asm("r0") = n;	\
>  	register unsigned long long __res asm("r2");		\
>  	register unsigned int __rem       asm(__xh);		\

	register unsigned int __rem_xh    asm(__xh);            \
	register unsigned int __rem_xl    asm(__xl);		\

> -	asm(	__asmeq("%0", __xh)				\
> +	asm(	__asmeq("%R0", __xh)				\

	asm(	__asmeq("%0", __xh)				\
		__asmeq("%1", __xl)				\

... and increment each following register %-spec by one...

>  		__asmeq("%1", "r2")				\
>  		__asmeq("%2", "r0")				\
>  		__asmeq("%3", "r4")				\
>  		"bl	__do_div64"				\
> -		: "=r" (__rem), "=r" (__res)			\
> -		: "r" (__n), "r" (__base)			\
> +		: "=r" (__n), "=r" (__res)			\
> +		: "0"(__n), "r" (__base)			\

This is obviously wrong because __rem is left unset, and that's one of
the two values this macro returns.

		: "=r" (__rem_xh), "=r" (__rem_xl), "=r" (__res) \
		: "r" (__n), "r" (__base)			\

>  		: "ip", "lr", "cc");				\
>  	n = __res;						\
>  	__rem;							\

	__rem_xh;

Basically this renames __rem to __rem_xh, and introduces a new __rem_xl
to take the other half of the remainder which we don't use.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
